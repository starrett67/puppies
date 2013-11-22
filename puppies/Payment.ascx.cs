using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PayPal;
using PayPal.Api.Payments;
using Newtonsoft;
using log4net;

namespace puppies
{
    public partial class Payment : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String[] CardTypes = { "Visa", "MasterCard", "American Express", "Chase" };
            for (int i = 0; i < CardTypes.Length; i++)
            {
                CardType.Items.Add(CardTypes[i]);
            }
            for (int i = 1; i < 13; i++)
            {
                ExpMonth.Items.Add("" + i);
            }
            for (int i = 13; i < 25; i++)
            {
                ExpYear.Items.Add("20" + i);
            }
            if (!Page.IsPostBack)
            {
            }
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            if (ValidateFields())
            {
                //good to go attempt paypal verification
                createPaypalPayment();
            }
            else 
            {
                Error.Visible = true;
                //Fields arent valid
            }

        }

        private bool ValidateFields()
        {
            bool success = true;
            if (String.IsNullOrEmpty(Amount.Value))
            {
                success = false;
                Error.Text = "Err: Was not able to retrieve amount.";
                return success;
            }
            if (String.IsNullOrEmpty(FirstName.Text))
            {
                success = false;
                Error.Text = "Err: Please give us your first name.";
                return success;
            }
            if (String.IsNullOrEmpty(LastName.Text))
            {
                success = false;
                Error.Text = "Err: Please give us your last name.";
                return success;
            }
            if (String.IsNullOrEmpty(CardNumber.Text))
            {
                success = false;
                Error.Text = "Err: Please give us your card number.";
                return success;
            }
            if (String.IsNullOrEmpty(CvvCode.Text))
            {
                success = false;
                Error.Text = "Err: Please give us your cvv code.";
                return success;
            }
            if (String.IsNullOrEmpty(Address.Text))
            {
                success = false;
                Error.Text = "Err: Please give us your billing address.";
                return success;
            }
            if (String.IsNullOrEmpty(City.Text))
            {
                success = false;
                Error.Text = "Err: Please input the city you live in.";
                return success;
            }
            if (String.IsNullOrEmpty(Zip.Text))
            {
                success = false;
                Error.Text = "Err: Please give us your zip code.";
                return success;
            }
            if (String.IsNullOrEmpty(State.Text) || State.Text.Length > 2)
            {
                success = false;
                Error.Text = "Err: State code invalid or empty. Ex: GA";
                return success;
            }
            if (String.IsNullOrEmpty(Country.Text) || Country.Text.Length > 4)
            {
                success = false;
                Error.Text = "Err: Country code invalid or empty. Ex: US";
                return success;
            }

            return success;
        }

        public bool createPaypalPayment()
        {
            bool success = false;
            String ClientID = "ATBTSxBIPTdaG_61_1waSimujWIDYHceqjlTFqwF7cu8Fuf6vBkq3tDGLDyp";//todo get from drew
            String Secret = "EMRGvBC0nnC1NxAtgOYXU_rKsfP_pZcG4ymjIiNzpO71zXWN1vvGwiax1b5Y"; //todo get from drew
            CreditCard creditCard = new CreditCard();
            Address bAddress = new Address();
            Amount amount = new Amount();
            AmountDetails amountDetails = new AmountDetails();
            Payer payer = new Payer();
            PayPal.Api.Payments.Payment payment = new PayPal.Api.Payments.Payment();
            List<Transaction> transactions = new List<Transaction>();
            Transaction transaction = new Transaction();
            List<FundingInstrument> fundingInstruments = new List<FundingInstrument>();
            FundingInstrument fundingInstrument = new FundingInstrument();
            OAuthTokenCredential tokenCredentials = new OAuthTokenCredential(ClientID, Secret);

            var SubTotal = Amount.Value;
            var tax = (Double.Parse(Amount.Value) * .06).ToString();
            var shipping = "4.00";
            var total = (Double.Parse(SubTotal) + Double.Parse(tax) + Double.Parse(shipping)).ToString();

            String accessToken = tokenCredentials.GetAccessToken();

            //billing address info
            bAddress.line1 = Address.Text;
            bAddress.city = City.Text;
            bAddress.country_code = Country.Text;
            bAddress.postal_code = Zip.Text;
            bAddress.state = State.Text;

            //Credit card info
            creditCard.number = CardNumber.Text;
            creditCard.type = CardType.SelectedItem.Text;
            creditCard.expire_month = ExpMonth.SelectedItem.Text;
            creditCard.expire_year = ExpYear.SelectedItem.Text;
            creditCard.cvv2 = CvvCode.Text;
            creditCard.first_name = FirstName.Text;
            creditCard.last_name = LastName.Text;
            creditCard.billing_address = bAddress;
            
            //Amount Details
            amountDetails.subtotal = SubTotal;
            amountDetails.tax = tax;
            amountDetails.shipping = shipping;

            //Amount info
            amount.total = total;
            amount.currency = "USD";
            amount.details = amountDetails;

            //transaction info
            transaction.amount = amount;
            transaction.description = "Puppyrus purchase";
            transactions.Add(transaction);

            //funding info
            fundingInstrument.credit_card = creditCard;
            fundingInstruments.Add(fundingInstrument);

            //payer info
            payer.funding_instruments = fundingInstruments;
            payer.payment_method = "credit_card";

            //payment info
            payment.intent = "sale";
            payment.payer = payer;
            payment.transactions = transactions;

            PayPal.Api.Payments.Payment createdPayment = payment.Create(accessToken);
            if (createdPayment.state.Equals("approved"))
            {
                Error.Text = "approved";
            }
            else
            {
                Error.Text = "Failed";
            }
            return success;
        }
    }
}

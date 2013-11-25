using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using PayPal;
using PayPal.Api.Payments;
using Newtonsoft;

namespace puppies
{
    public partial class Payment : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String[] CardTypes = { "visa", "masterCard", "american express", "discover" };
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
            //if (String.IsNullOrEmpty(Amount.Value))
            //{
            //    success = false;
            //    Error.Text = "Err: Was not able to retrieve amount.";
            //    return success;
            //}
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
            var SubTotal = Amount.Value;
            var tax = (Double.Parse(Amount.Value) * .06).ToString();
            var shipping = "4.00";
            var total = (Double.Parse(SubTotal) + Double.Parse(tax) + Double.Parse(shipping)).ToString();
            String CreditNumber, CreditType, Cvv2, FName, LName, BillingZip,
                BillingLine, BillingCity, BillingCountry, BillingState, Description;
            int CardExpMonth, CardExpYear;
            CreditNumber = CardNumber.Text;
            CreditType = CardType.Text;
            CardExpMonth = Int32.Parse(ExpMonth.Text);
            CardExpYear = Int32.Parse(ExpYear.Text);
            FName = FirstName.Text;
            LName = LastName.Text;
            BillingLine = Address.Text;
            BillingCity = City.Text;
            BillingCountry = Country.Text;
            Cvv2 = CvvCode.Text;
            BillingZip = Zip.Text;
            BillingState = State.Text;
            Description = "Puppiesrus Transaction";

            String CreditCardInfo = CreditType + " " + CreditNumber + " " + CardExpMonth + " " + CardExpYear + " " + Cvv2 + " " +
                FName + " " + LName;
            String BillingAddress = BillingLine + " " + BillingCity + " " + BillingState + " " + BillingZip + " " + BillingCountry;
            String AmountInfo = total + " " + SubTotal + " " + tax + " " + shipping;

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CreatePayPalPayment", "CreatePayPalPayment(" + CreditCardInfo + ", " + 
                BillingAddress + ", " + AmountInfo + ", " + ClientID + ", " + Secret + ");", true);
            /*CreditCard creditCard = new CreditCard();
            Address bAddress = new Address();
            Amount amount = new Amount();
            Details amountDetails = new Details();
            Payer payer = new Payer();
            PayPal.Api.Payments.Payment payment = new PayPal.Api.Payments.Payment();
            List<Transaction> transactions = new List<Transaction>();
            Transaction transaction = new Transaction();
            List<FundingInstrument> fundingInstruments = new List<FundingInstrument>();
            FundingInstrument fundingInstrument = new FundingInstrument();
            Dictionary<string, string> payPalConfig = new Dictionary<string, string>();
            payPalConfig.Add("mode", "sandbox");
            OAuthTokenCredential token = new OAuthTokenCredential(ClientID, Secret, payPalConfig);
            token.GetAccessToken();

            //var SubTotal = Amount.Value;
            var SubTotal = "400.00";
            //var tax = (Double.Parse(Amount.Value) * .06).ToString();
            var tax = "3.00";
            var shipping = "4.00";
            var total = (Double.Parse(SubTotal) + Double.Parse(tax) + Double.Parse(shipping)).ToString();
            APIContext apiContext = new APIContext();
            apiContext.Config = payPalConfig;

            //billing address info
            bAddress.line1 = Address.Text;
            bAddress.city = City.Text;
            bAddress.country_code = Country.Text;
            bAddress.postal_code = Zip.Text;
            bAddress.state = State.Text;

            //Credit card info
            creditCard.number = CardNumber.Text;
            creditCard.type = CardType.SelectedItem.Text;
            creditCard.expire_month = Int32.Parse(ExpMonth.SelectedItem.Text);
            creditCard.expire_year = Int32.Parse(ExpYear.SelectedItem.Text);
            creditCard.cvv2 = CvvCode.Text;
            creditCard.first_name = FirstName.Text;
            creditCard.last_name = LastName.Text;
            creditCard.billing_address = bAddress;
            
            //Amount Details
            amountDetails.subtotal = SubTotal;
            amountDetails.tax = tax;
            amountDetails.shipping = shipping;

            //Amount info
            amount.total = total + ".00";
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
            PayPal.Api.Payments.Payment createdPayment = null;
            try
            {
                createdPayment = payment.Create(apiContext);
            }
            catch (PayPal.Exception.PayPalException ex)
            {
                Response.Redirect("ValidationFailed.aspx", true);
                if (ex.InnerException is PayPal.Exception.ConnectionException)
                {
                    Console.Out.WriteLine(((PayPal.Exception.PayPalException)ex.InnerException).Message);
                }
                else
                {
                    Console.Out.WriteLine(ex.Message);
                }
            }
            if (createdPayment.state.Equals("approved"))
            {
                Response.Redirect("ValidationSuccess.aspx", true);
            }
            else
            {
                Response.Redirect("ValidationFailed.aspx", true);
            }*/
            return success;
        }
    }
}

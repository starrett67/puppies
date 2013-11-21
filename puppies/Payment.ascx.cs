using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            if (ValidateFields())
            {
                //good to go attempt paypal verification
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
                Error.Text += "Err: Please give us your card number.";
                return success;
            }
            if (String.IsNullOrEmpty(CvvCode.Text))
            {
                success = false;
                Error.Text += "Err: Please give us your cvv code.";
                return success;
            }
            if (String.IsNullOrEmpty(Address.Text))
            {
                success = false;
                Error.Text += "Err: Please give us your billing address.";
                return success;
            }
            if (String.IsNullOrEmpty(City.Text))
            {
                success = false;
                Error.Text += "Err: Please input the city you live in.";
                return success;
            }
            if (String.IsNullOrEmpty(Zip.Text))
            {
                success = false;
                Error.Text += "Err: Please give us your zip code.";
                return success;
            }
            if (String.IsNullOrEmpty(State.Text) || State.Text.Length > 2)
            {
                success = false;
                Error.Text += "Err: State code invalid or empty. Ex: GA";
                return success;
            }
            if (String.IsNullOrEmpty(Country.Text) || Country.Text.Length > 4)
            {
                success = false;
                Error.Text += "Err: Country code invalid or empty. Ex: US";
                return success;
            }

            return success;
        }
    }
}
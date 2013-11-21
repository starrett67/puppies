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
    }
}
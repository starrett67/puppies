<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Payment.ascx.cs" Inherits="puppies.Payment" %>
<script type="text/javascript">
    var Headers = {};
    Headers['Accept'] = 'application/json; version=0';
    Headers['Accept-Language'] ="en_US";
    getAmount();

    function CreatePaypalPayment(CardInfo, BillingAddress, Amount, ClientId, Secret) {
        var Id = ClientId;
        Headers[Id] = Secret;
        var PaymentInfo = {
            "intent": "sale",
            "payer": {
                "payment_method": "credit_card",
                "funding_instruments": [{
                    "credit_card": {
                        "type": CardInfo[0],
                        "number": CardInfo[1],
                        "expire_month": CardInfo[2],
                        "expire_year": CardInfo[3],
                        "cvv2": CardInfo[5],
                        "first_name": CardInfo[6],
                        "last_name": CardInfo[7],
                        "billing_address": {
                            "line1": BillingAddress[0],
                            "city": BillingAddress[1],
                            "state": BillingAddress[2],
                            "postal_code": BillingAddress[3],
                            "country_code": BillingAddress[4]
                        }
                    }
                }]
            },
            "transactions": [{
                "amount": {
                    "total": Amount[0],
                    "currency": "USD",
                    "details": {
                        "subtotal": Amount[1],
                        "tax": Amount[2],
                        "shipping": Amount[3]
                    }
                },
                "description": Description
            }]
        };
        console.log(PaymentInfo);
        $.ajax({
            url: 'https://api.sandbox.paypal.com/v1/oauth2/token',
            headers: Headers, //set the headers
            type: "POST",
            data: { "grant_type": "client_credentials" },
            async: false,
            success: function (data) {
                console.log(data);
            },
            error: function (e, message, type) {
                console.log(e);
            }
        });
    }

    function getAmount() {
        var field = document.getElementById("<%= Amount.ClientID %>");
        if (field) {
            field.value = GlobalAmount;
        }
        console.log(GlobalAmount);
    }
</script> 
<form id="PaymentInfo" runat="server">
    <asp:HiddenField ID="Amount" runat="server" />
    <table>
        <tr>
            <td>
                First Name:
                <asp:TextBox ID="FirstName" runat="server"></asp:TextBox>
            </td>
            <td>
                Last Name:
                <asp:TextBox ID="LastName" runat="server"></asp:TextBox>
            </td>
            <td>
                Card Type:
                <asp:DropDownList ID="CardType" runat="server">
                </asp:DropDownList>
                
            </td>
        </tr>
        <tr>
            <td>
                Card Number:
                <asp:TextBox ID="CardNumber" runat="server"></asp:TextBox>
            </td>
            <td>
                Experation Date:
                <asp:DropDownList ID="ExpMonth" runat="server">
                </asp:DropDownList>
                <asp:DropDownList ID="ExpYear" runat="server">
                </asp:DropDownList>
            </td>
            <td>
                CvvCode:
                <asp:TextBox ID="CvvCode" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Address:
                <asp:TextBox ID="Address" runat="server"></asp:TextBox>
            </td>
            <td>
                City:
                <asp:TextBox ID="City" runat="server"></asp:TextBox>
            </td>
            <td>
                ZIP Code:
                <asp:TextBox ID="Zip" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                State Code:
                <asp:TextBox ID="State" runat="server"></asp:TextBox>
            </td>
            <td>
                Country Code
                <asp:TextBox ID="Country" runat="server"></asp:TextBox>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <asp:Label ID="Error" runat="server" ForeColor="Red" ClientIDMode="Static" Visible="false"></asp:Label>
    <br />
    <asp:Button ID="Submit" runat="server" Text="Confirm" ClientIDMode="Static" onclick="Submit_Click" />
</form>
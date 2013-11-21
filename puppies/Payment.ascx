<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Payment.ascx.cs" Inherits="puppies.Payment" %>
<script type="text/javascript">
    $('#Submit').click(function( event ) {
        if( $('#Error').val != "")
        {
            event.preventDefault();
        }
    }
</script>
<form id="PaymentInfo" runat="server">
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
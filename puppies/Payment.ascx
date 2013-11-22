<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Payment.ascx.cs" Inherits="puppies.Payment" %>
<script type="text/javascript">
    var publicKeyHeader = 'X-StackMob-API-Key-ae924762-6432-41d7-88ca-5f034661e46b';
    var requestHeaders = {};
    requestHeaders['Accept'] = 'application/vnd.stackmob+json; version=0';
    requestHeaders[publicKeyHeader] = 1;
    requestHeaders['Range'] = 'objects=0-49'; //set pagination to first 10
    getAmount();
    /*window.fbAsyncInit = function () {
        FB.init({
            appId: '655072947848872', // App ID
            channelUrl: '//puppiesrus.azurewebsites.net/channel.html', // Channel File
            status: true, // check login status
            cookie: true, // enable cookies to allow the server to access the session
            xfbml: true  // parse XFBML
        });

        // Here we subscribe to the auth.authResponseChange JavaScript event. This event is fired
        // for any authentication related change, such as login, logout or session refresh. This means that
        // whenever someone who was previously logged out tries to log in again, the correct case below 
        // will be handled. 
        FB.Event.subscribe('auth.authResponseChange', function (response) {
            // Here we specify what we do with the response anytime this event occurs. 
            if (response.status === 'connected') {
                // The response object is returned with a status field that lets the app know the current
                // login status of the person. In this case, we're handling the situation where they 
                // have logged in to the app.
                getAmount();
            } else if (response.status === 'not_authorized') {
                // In this case, the person is logged into Facebook, but not into the app, so we call
                // FB.login() to prompt them to do so. 
                // In real-life usage, you wouldn't want to immediately prompt someone to login 
                // like this, for two reasons:
                // (1) JavaScript created popup windows are blocked by most browsers unless they 
                // result from direct interaction from people using the app (such as a mouse click)
                // (2) it is a bad experience to be continually prompted to login upon page load.
                console.log(response.status);
                FB.login(function (response) {
                    // handle the response
                }, { scope: 'email' });
            } else {
                // In this case, the person is not logged into Facebook, so we call the login() 
                // function to prompt them to do so. Note that at this stage there is no indication
                // of whether they are logged into the app. If they aren't then they'll see the Login
                // dialog right after they log in to Facebook. 
                // The same caveats as above apply to the FB.login() call here.
                console.log(response.status);
                FB.login(function (response) {
                    // handle the response
                }, { scope: 'email' });
            }
        });
    };
    // Load the SDK asynchronously
    (function (d) {
        var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement('script'); js.id = id; js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        ref.parentNode.insertBefore(js, ref);
    } (document));*/

    function getAmount() {
        /*FB.api('/me', function (response) {
            console.log(response);
            console.log(GlobalAmount);
            $.ajax({
                url: 'https://api.stackmob.com/orders',
                headers: requestHeaders, //set the headers
                type: 'GET',
                async: false,
                success: function (data, textStatus, xhr) {
                    var amount = Math.abs(0);
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].user_id == response.id && !data[i].purchased) {
                            amount += Math.abs(data[i].amount);
                        }
                    }
                    var field = document.getElementById("<%= Amount.ClientID %>");
                    if (field) {
                        field.value = amount;
                    }
                    console.log(amount);
                },
                error: function (error) {
                    console.log(error);
                }
            });

        });*/
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
    <asp:HyperLink ID="Submit" runat="server" Text="Confirm" ClientIDMode="Static" onclick="Submit_Click" />
</form>
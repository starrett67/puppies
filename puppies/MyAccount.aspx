<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
<script>
    window.fbAsyncInit = function () {
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
                fillForm();
            } else if (response.status === 'not_authorized') {
                // In this case, the person is logged into Facebook, but not into the app, so we call
                // FB.login() to prompt them to do so. 
                // In real-life usage, you wouldn't want to immediately prompt someone to login 
                // like this, for two reasons:
                // (1) JavaScript created popup windows are blocked by most browsers unless they 
                // result from direct interaction from people using the app (such as a mouse click)
                // (2) it is a bad experience to be continually prompted to login upon page load.
                document.getElementById("ErrorMessage").innerHTML += "<br>Please log in to facebook first";
            } else {
                // In this case, the person is not logged into Facebook, so we call the login() 
                // function to prompt them to do so. Note that at this stage there is no indication
                // of whether they are logged into the app. If they aren't then they'll see the Login
                // dialog right after they log in to Facebook. 
                // The same caveats as above apply to the FB.login() call here.
                document.getElementById("ErrorMessage").innerHTML += "<br>Please log in to facebook first";
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
    } (document));

    // Here we run a very simple test of the Graph API after login is successful. 
    // This testAPI() function is only called in those cases. 
    function fillForm() {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function (response) {
            console.log('Good to see you, ' + response.name + '.');
            var resp = response;
            var name = response.name;
            var firstandlast = name.split(" ");
            document.getElementById("fName").value = firstandlast[0];
            document.getElementById("lName").value = firstandlast[1];
            document.getElementById("Age").value = response.age;
            document.getElementById("PhoneNumber").value = response.phonenumber;
            document.getElementById("Email").value = response.email;

        });
    }
</script>
    <table>
        <tr>
            <td>
                First Name:
            </td>
            <td>
                <input id="fName" type="text" />
            </td>
        </tr>
        <tr>
            <td>
                Last Name:
            </td>
            <td>
                <input id="lName" type="text" />
            </td>
        </tr>
        <tr>
            <td>
                Age:
            </td>
            <td>
                <input id="Age" type="text" />
            </td>
        </tr>
        <tr>
            <td>
                Email:
            </td>
            <td>
                <input id="Email" type="text" />
            </td>
        </tr>
        <tr>
            <td>
                Phone Number:
            </td>
            <td>
                <input id="Phone Number" type="text" />
            </td>
        </tr>
    </table>
    <font color="red">
    <p id="ErrorMessage">
    </p>
    </font>
</asp:Content>

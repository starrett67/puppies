﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
<script>
    var publicKeyHeader = 'X-StackMob-API-Key-ae924762-6432-41d7-88ca-5f034661e46b';
    var requestHeaders = {};
    requestHeaders['Accept'] = 'application/vnd.stackmob+json; version=0';
    requestHeaders[publicKeyHeader] = 1;
    requestHeaders['Range'] = 'objects=0-49'; //set pagination to first 10


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
            console.log(response.status);
            if (response.status === 'connected') {
                // The response object is returned with a status field that lets the app know the current
                // login status of the person. In this case, we're handling the situation where they 
                // have logged in to the app.
                UpdateDatabase();
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
    console.log(document.getElementById("fName"));
    if (document.getElementById("fName") == null) {
        //document.getElementById("AccountContainer").innerHTML += "<font color='red'><h2>Please login first</h2></font>";  fix this
    }
    // Load the SDK asynchronously
    (function (d) {
        var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement('script'); js.id = id; js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        ref.parentNode.insertBefore(js, ref);
    } (document));

    function UpdateDatabase() {
        FB.api('/me', function (response) {
            var purchasedIds = [];
            var deleteId = [];
            var amount = parseFloat("0.00");
            var userId;
            userId = parseInt(response.id);
            $.ajax({
                url: 'https://api.stackmob.com/orders',
                headers: requestHeaders, //set the headers
                type: 'GET',
                async: false,
                success: function (data, textStatus, xhr) {
                    console.debug(data);
                    var bFirstOrderFound = false;
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].user_id == response.id && !data[i].purchased) {
                            purchasedIds.push(data[i].products_purchased[0]);
                            deleteId.push(data[i].orders_id);
                            amount = parseFloat(Math.abs(amount + data[i].amount));
                        }
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
            for (var i = 0; i < deleteId.length; i++) {
                $.ajax({
                    url: 'https://api.stackmob.com/orders?orders_id=' + deleteId[i],
                    headers: requestHeaders, //set the headers
                    type: 'DELETE',
                    async: false,
                    success: function (data, textStatus, xhr) {
                        console.log("delete Success");
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }

            var requestBody = { "amount": amount, "products_purchased": purchasedIds, "user_id": userId, "purchased": true };
            console.log(requestBody);
            $.ajax({
                url: 'https://api.stackmob.com/orders',
                headers: requestHeaders, //set the headers
                type: 'POST',
                async: false,
                data: JSON.stringify(requestBody),
                success: function (data, textStatus, xhr) {
                    console.debug(data);
                },
                error: function (error) {
                    console.log(error);
                }
            });

        });
    }
</script>
    <div class="jumbotron hero-spacer">
        <h1>Your order is complete</h1>    
    </div>
</asp:Content>

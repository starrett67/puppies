<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
<script type="text/javascript">

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
            if (response.status === 'connected') {
                // The response object is returned with a status field that lets the app know the current
                // login status of the person. In this case, we're handling the situation where they 
                // have logged in to the app.
                fillOrdersTable();
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
    } (document));



    function fillOrdersTable() {
        FB.api('/me', function (response) {
            console.log('Good to see you, ' + response.name + '.');
            console.log(response);
            document.getElementById("OrdersHeader").innerHTML = response.name + " Orders: ";
            var OrderNumbers = [];
            var OrderDescription = [];
            var OrderAmount = [];
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
                            //User has an order
                            OrderNumbers.push(data[i].orders_id);
                            //ZOMG AJAX IN A AJAX
                            $.ajax({
                                url: 'https://api.stackmob.com/Products',
                                headers: requestHeaders, //set the headers
                                type: 'GET',
                                async: false,
                                success: function (resp, textStatus, xhr) {
                                    //ZOMG A LOOP IN A LOOP
                                    var productsOrdered = "";
                                    for (var k = 0; k < resp.length; k++) {
                                        //ZOMG A LOOP IN A LOOP IN A LOOP
                                        for (var j = 0; j < data[i].products_purchased.length; j++) {
                                            if (data[i].products_purchased[j] == resp[k].products_id) {
                                                console.log("found a match");
                                                if (productsOrdered != "") {
                                                    productsOrdered += ", ";
                                                }
                                                productsOrdered += resp[k].Name + '[$' + resp[k].Price + ']';
                                            }
                                        }
                                    }
                                    OrderDescription.push(productsOrdered);
                                },
                                error: function (xhr, textStatus, error) {
                                    console.log(error);
                                }
                            });
                            OrderAmount.push(data[i].amount);
                        }
                    }
                    //TODO: markup the products dynamicly by looping through returned object
                    //and putting into the page as html
                },
                error: function (xhr, textStatus, error) {
                    console.debug(error);
                }
            });
            console.log(OrderNumbers);
            console.log(OrderDescription);
            console.log(OrderAmount);
            var total = 0;
            document.getElementById("OrdersList").innerHTML += '<tbody>';
            for (var i = 0; i < OrderNumbers.length; i++) {
                total = Math.abs(total + OrderAmount[i]);
                document.getElementById("OrdersList").innerHTML += '<tr> <td class="field-label col-xs-2 active"> <label> ' +
                'Order Number: ' + OrderNumbers[i] + '</label> </td> <td class="col-md-9"> ' + OrderDescription[i] +
                ' </td> <td class="col-md-1"> $' + OrderAmount[i] + ' </td> </tr>';
            }
            document.getElementById("OrdersList").innerHTML += '</tbody>';
            document.getElementById("TableHolder").innerHTML += '<hr /> <table class="table table-striped"> <thread>';
            document.getElementById("TableHolder").innerHTML += '<tr> <th class="field-label col-xs-2 active"> <label> ' +
                'Total: ' + total + '</label> </th> <th class="col-md-9"> </th> <th class="col-md-1"> <a href="#" class="btn btn-primary">Purchase</a> ' +
                '</th> </tr> </thread> </table>';
        });
    }
    function getPuppiesOrdered(arrOfIds) {
        var productString = ""
        $.ajax({
            url: 'https://api.stackmob.com/Products',
            headers: requestHeaders, //set the headers
            type: 'GET',
            success: function (data, textStatus, xhr) {
                for (var i = 0; i < data.length; i++) {
                    for (var j = 0; j < arrOfIds.length; j++) {
                        if (arrOfIds[j] == data[i].products_id) {
                            console.log("found a match");
                            productString += data[i].Name + '\n';
                        }
                    }
                }
                console.log(productString)
                return productString;
            },
            error: function (xhr, textStatus, error) {
                console.log(error);
            }
        });
    }

</script>
<div id="CheckoutContainer" class="container">
        <div class="row" style="height: 60px;">
        </div>
    <div class="row">
                <div id="TableHolder" style="margin: 10px;" class="col-lg-12 well">
                    <h2 id="OrdersHeader">
                        Your Orders:</h2>
                    <table id="OrdersList" class="table table-striped">
                        <thead>
                            <tr>
                                <th class="field-label col-xs-2 active">
                                    <label>
                                        Order #</label>
                                </th>
                                <th class="col-md-9">
                                    <label>
                                        Order Details</label>
                                </th>
                                <th class="col-md-1">
                                    Amount
                                </th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
            </div>
</asp:Content>

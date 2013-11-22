<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
    <script src="/Scripts/YoutubeAuth.js" type="text/javascript"></script>
    <script src="/Scripts/YoutubeSearch.js" type="text/javascript"></script>
    <script src="https://apis.google.com/js/client.js?onload=googleApiClientReady" type="text/javascript"></script>
    <script type="text/javascript">

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
                } else if (response.status === 'not_authorized') {
                    // In this case, the person is logged into Facebook, but not into the app, so we call
                    // FB.login() to prompt them to do so. 
                    // In real-life usage, you wouldn't want to immediately prompt someone to login 
                    // like this, for two reasons:
                    // (1) JavaScript created popup windows are blocked by most browsers unless they 
                    // result from direct interaction from people using the app (such as a mouse click)
                    // (2) it is a bad experience to be continually prompted to login upon page load.
                } else {
                    // In this case, the person is not logged into Facebook, so we call the login() 
                    // function to prompt them to do so. Note that at this stage there is no indication
                    // of whether they are logged into the app. If they aren't then they'll see the Login
                    // dialog right after they log in to Facebook. 
                    // The same caveats as above apply to the FB.login() call here.
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
     /*
     We want to prepare the Request headers we're going to send to StackMob.  It should look like:

     {
     'Accept': application/vnd.stackmob+json; version=0',
     'X-StackMob-API-Key-dc0e228a-ccd3-4799-acd5-819f6c074ace': 1,
     'Range': 'objects=0-9'  //this is optional, but I did it here to show pagination and extra header fields
     }

     You can actually have the public key in the header as:

     'X-StackMob-API-Key': dc0e228a-ccd3-4799-acd5-819f6c074ace

     OR

     'X-StackMob-API-Key-dc0e228a-ccd3-4799-acd5-819f6c074ace': 1

     The first is our original format.  The reason why I chose the latter is because of this specific example.  I'm making cross domain requests jsfiddle.net to api.stackmob.com, which the browser doesn't allow UNLESS we use CORS (cross origin resource sharing).  StackMob servers support CORS, but it needs the latter header format to do so.  (it was introduced later).  iOS and Android SDKs use the first format.

     Node.js should be able to use the first format because it doesn't restrict cross domain calls.

     The "1" value in the latter format is arbitrary.  IE just doesn't allow the value of a header to be empty, so we filled it with "1".
     */
     var publicKeyHeader = 'X-StackMob-API-Key-ae924762-6432-41d7-88ca-5f034661e46b';
     var requestHeaders = {};
     requestHeaders['Accept'] = 'application/vnd.stackmob+json; version=0';
     requestHeaders[publicKeyHeader] = 1;
     requestHeaders['Range'] = 'objects=0-20'; //set pagination to first 10
     fillStorePage();

     function buyPuppy(productId, price) {
         var productsPurchase = [];
         productsPurchase.push(productId);
         FB.api('/me', function (response) {

             var requestBody = { "amount": price, "products_purchased": productsPurchase, "user_id": response.id }
             console.log(requestBody);
             $.ajax({
                 url: 'https://api.stackmob.com/orders',
                 headers: requestHeaders,
                 type: 'POST',
                 data: JSON.stringify(requestBody),
                 success: function (data) {
                     console.log(data);
                 },
                 error: function (error) {
                     console.log(error)
                 }

             });
         });     
     }

     function fillStorePage() {
         $.ajax({
             url: 'https://api.stackmob.com/Products',
             headers: requestHeaders, //set the headers
             type: 'GET',
             success: function (data, textStatus, xhr) {
                 console.log(data);
                 for (var i = 0; i < data.length; i++) {
                     var length = Math.abs(data.length);
                     var Name = data[i].Name;
                     var description = data[i].description;
                     var price = data[i].Price;
                     var imgSource = data[i].pic_url;
                     var temp = Name.split(' ');
                     var jName = "";
                     for (var j = 0; j < temp.length; j++) {
                         jName += temp[j];
                     }
                     var Javascript = "Javascript:search('" + jName + "', 'SearchResults" + jName + "');";
                     var buyJavascript = "Javascript:buyPuppy('" + data[i].products_id + "', '" + price + "');";
                     console.log(Javascript);
                     if (i % 4 == 0 || i == 0) {
                         //need a new row
                         document.getElementById("container").innerHTML += '<div class="row text-center">';
                     }
                     document.getElementById("container").innerHTML += '<div class="col-lg-3 col-md-6 hero-feature"><div class="thumbnail">' +
                        '<img src="' + imgSource + '" /><div class="caption"><h3>' + Name + ' - $' + price + '</h3><p>' + description + '<p id="' + Name + '">' +
                        '<a href="' + buyJavascript + '" class="btn btn-primary">Buy Now!</a> <a href="' + Javascript + '" class="btn btn-default"> Youtube </a>' +
                        '<div id="SearchResults' + jName + '"></div></div></div>'
                     if (((i + 1) % 4 == 0 && i >= 3) || (i + 1) == data.length) {
                         document.getElementById("container").innerHTML += '</div>';
                     }
                 }
                 //TODO: markup the products dynamicly by looping through returned object
                 //and putting into the page as html
             },
             error: function (xhr, textStatus, error) {
                 console.debug(error);
             }
         });
         console.log("exit");
     }
 
    </script>
    <div id="container" class="container">
        <div class="row" style="height: 60px;">
        </div>
        <div class="row">
            <div class="col-lg-12">
                <h3>
                    Popular Dogs</h3>
            </div>
        </div>
        <!-- /.row -->
        <div id="divLogin-link">
            <a href="#" id="login-link">please login first</a>
        </div>
        <div class="row text-center">
            <!--    <div class="col-lg-3 col-md-6 hero-feature">
             <div class="thumbnail">
                 <img src="http://farm5.staticflickr.com/4081/4883281674_8428f07e53_z.jpg" alt="">
                 <div class="caption">
                     <h3>
                         Brown Puppy</h3>
                     <p>
                         This would be a great dog to have!</p>
                     <p id="BrownPuppy">
                         <a href="#" class="btn btn-primary">Buy Now!</a> <a href="javascript:search('Brown Puppy', 'SearchResultsBrownPuppy');" class="btn btn-default">
                             More Info</a>
                     </p>
                     <div id="SearchResultsBrownPuppy">
                             </div>
                 </div>
             </div>
         </div>
         <div class="col-lg-3 col-md-6 hero-feature">
             <div class="thumbnail">
                 <img src="http://farm4.staticflickr.com/3465/3717404335_90ed081ca8_z.jpg" alt="">
                 <div class="caption">
                     <h3>
                         Harry Puppie</h3>
                     <p>
                         This would be a great dog that will shed everywhere! LOL JK</p>
                     <p>
                         <a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">
                             More Info</a></p>
                 </div>
             </div>
         </div>
         <div class="col-lg-3 col-md-6 hero-feature">
             <div class="thumbnail">
                 <img src="http://farm4.staticflickr.com/3225/5774362254_3bda643abb_z.jpg" alt="">
                 <div class="caption">
                     <h3>
                         Sitting Dog</h3>
                     <p>
                         This would be a great Dog to play with!</p>
                     <p>
                         <a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">
                             More Info</a></p>
                 </div>
             </div>
         </div>
         <div class="col-lg-3 col-md-6 hero-feature">
             <div class="thumbnail">
                 <img src="http://farm1.staticflickr.com/128/410071337_3a38fecae3_z.jpg?zz=1" alt="">
                 <div class="caption">
                     <h3>
                         Lassie</h3>
                     <p>
                         This would be a great dog to help the fight in WW1!</p>
                     <p>
                         <a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">
                             More Info</a></p>
                 </div>
             </div>
         </div> -->
        </div>
        <!-- /.row -->
        <hr />
        <!--<div class="row text-center">
         <div class="col-lg-3 col-md-6 hero-feature">
             <div class="thumbnail">
                 <img src="http://farm5.staticflickr.com/4081/4883281674_8428f07e53_z.jpg" alt="">
                 <div class="caption">
                     <h3>
                         Brown Puppy</h3>
                     <p>
                         This would be a great dog to have!</p>
                     <p>
                         <a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">
                             More Info</a></p>
                 </div>
             </div>
         </div>
         <div class="col-lg-3 col-md-6 hero-feature">
             <div class="thumbnail">
                 <img src="http://farm4.staticflickr.com/3465/3717404335_90ed081ca8_z.jpg" alt="">
                 <div class="caption">
                     <h3>
                         Harry Puppie</h3>
                     <p>
                         This would be a great dog that will shed everywhere! LOL JK</p>
                     <p>
                         <a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">
                             More Info</a></p>
                 </div>
             </div>
         </div>
         <div class="col-lg-3 col-md-6 hero-feature">
             <div class="thumbnail">
                 <img src="http://farm4.staticflickr.com/3225/5774362254_3bda643abb_z.jpg" alt="">
                 <div class="caption">
                     <h3>
                         Sitting Dog</h3>
                     <p>
                         This would be a great Dog to play with!</p>
                     <p>
                         <a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">
                             More Info</a></p>
                 </div>
             </div>
         </div>
         <div class="col-lg-3 col-md-6 hero-feature">
             <div class="thumbnail">
                 <img src="http://farm1.staticflickr.com/128/410071337_3a38fecae3_z.jpg?zz=1" alt="">
                 <div class="caption">
                     <h3>
                         Lassie</h3>
                     <p>
                         This would be a great dog to help the fight in WW1!</p>
                     <p>
                         <a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">
                             More Info</a></p>
                 </div>
             </div>
         </div>
     </div>-->
        <!-- /.row -->
    </div>
</asp:Content>

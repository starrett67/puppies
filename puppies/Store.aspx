<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
 <script>
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

     var publicKeyHeader = 'X-StackMob-API-Key-dc0e228a-ccd3-4799-acd5-819f6c074ace';
     var requestHeaders = {};
     requestHeaders['Accept'] = 'application/vnd.stackmob+json; version=0';
     requestHeaders[publicKeyHeader] = 1;
     requestHeaders['Range'] = 'objects=0-9'; //set pagination to first 10

     $.ajax({
         url: 'https://api.stackmob.com/item',
         headers: requestHeaders, //set the headers
         type: 'GET',
         success: function (data, textStatus, xhr) {
             console.debug(data);
         },
         error: function (xhr, textStatus, error) {
             console.debug(error);
         }
     });
 
 </script>
 <div class="container">
        <div class="row" style="height: 60px;">
        </div>
     <div class="row">
         <div class="col-lg-12">
             <h3>
                 Popular Dogs</h3>
         </div>
     </div>
     <!-- /.row -->
     <div class="row text-center">
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
     </div>
     <!-- /.row -->
     <hr />
     <div class="row text-center">
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
     </div>
     <!-- /.row -->
     </div>
</asp:Content>

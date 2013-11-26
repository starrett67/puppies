<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
    <div class="container">
         <div class="row" style="height: 50px;">
        </div>
     <div class="row">
 
      <div class="container">
      <div class="row text-center">
        <h1>These puppies all went to good homes...will yours?</h1>
      </div> </div> </div> </div>
     <div class="row" style="height: 50px;"> </div>
   <script type="text/javascript">
       // Instantiate an empty object.
       var Instagram = {};

       // Small object for holding important configuration data.
       Instagram.Config = {
           clientID: 'f8c344c3cdb14f0a84e9ce2c0ecd67fc',
           apiHost: 'https://api.instagram.com'
       };


       // ************************
       // ** Main Application Code
       // ************************
       (function () {
           var photoTemplate, resource;

           function init() {
               bindEventHandlers();
               photoTemplate = _.template($('#photo-template').html());
           }

           function toTemplate(photo) {
               photo = {
                   count: photo.likes.count,
                   avatar: photo.user.profile_picture,
                   photo: photo.images.low_resolution.url,
                   url: photo.link
               };

               return photoTemplate(photo);
           }

           function toScreen(photos) {
               var photos_html = '';

               $('.paginate a').attr('data-max-tag-id', photos.pagination.next_max_id)
                    .fadeIn();

               $.each(photos.data, function (index, photo) {
                   photos_html += toTemplate(photo);
               });

               $('div#photos-wrap').append(photos_html);
           }

           function generateResource(tag) {
               var config = Instagram.Config, url;

               if (typeof tag === 'undefined') {
                   throw new Error("Resource requires a tag. Try searching for cats.");
               } else {
                   // Make sure tag is a string, trim any trailing/leading whitespace and take only the first 
                   // word, if there are multiple.
                   tag = String(tag).trim().split(" ")[0];
               }

               url = config.apiHost + "/v1/tags/" + tag + "/media/recent?callback=?&client_id=" + config.clientID;

               return function (max_id) {
                   var next_page;
                   if (typeof max_id === 'string' && max_id.trim() !== '') {
                       next_page = url + "&max_id=" + max_id;
                   }
                   return next_page || url;
               };
           }

           function paginate(max_id) {
               $.getJSON(generateUrl(tag), toScreen);
           }

           function search(tag) {
               resource = generateResource(tag);
               $('.paginate a').hide();
               $('#photos-wrap *').remove();
               fetchPhotos();
           }

           function fetchPhotos(max_id) {
               $.getJSON(resource(max_id), toScreen);
           }

           function bindEventHandlers() {
               $('body').on('click', '.paginate a.btn', function () {
                   var tagID = $(this).attr('data-max-tag-id');
                   fetchPhotos(tagID);
                   return false;
               });

               // Bind an event handler to the `submit` event on the form
               $('form').on('submit', function (e) {

                   // Stop the form from fulfilling its destinty.
                   e.preventDefault();

                   // Extract the value of the search input text field.
                   var tag = $('input.search-tag').val().trim();

                   // Invoke `search`, passing `tag` (unless tag is an empty string).
                   if (tag) {
                       search(tag);
                   };

               });

           }

           function showPhoto(p) {
               $(p).fadeIn();
           }

           // Public API
           Instagram.App = {
               search: search,
               showPhoto: showPhoto,
               init: init
           };
       } ());

       $(function () {
           Instagram.App.init();

           // Start with a search on cats; we all love cats.
           Instagram.App.search('puppies');

       });

   </script>
  <div class='container'>
    <div class='row'>
      <div class='span12'>
        <form id='search'>
          <div class="input-append">
            <input class='search-tag' type='text' tabindex='1' value='puppies' />
            <button class="btn" id="search-button" dir="ltr" tabindex="2" type="submit">
              <i class='icon-search'></i>
            </button>
          </div>
        </form>

        <div id='photos-wrap'>
        </div>

        <div class='paginate'>
          <a class='btn'  style='display:none;' data-max-tag-id='' href='#'>View More...</a>
        </div>
      </div>
    </div>
  </div>

  <script type="text/template" id="photo-template">
  <div class='photo'>
    <a href='<%= url %>' target='_blank'>
      <img class='main' src='<%= photo %>' width='250' height='250' style='display:none;' onload='Instagram.App.showPhoto(this);' />
    </a>
    <img class='avatar' width='40' height='40' src='<%= avatar %>' />
    <span class='heart'><strong><%= count %></strong></span>
  </div>
  </script>

</asp:Content>















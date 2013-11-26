<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
   <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
    <script src="/Scripts/YoutubeAuth.js" type="text/javascript"></script>
    <script src="/Scripts/YoutubeSearch.js" type="text/javascript"></script>
    <script src="https://apis.google.com/js/client.js?onload=googleApiClientReady" type="text/javascript"></script>
    <script type="text/javascript">


    <!--https://developers.google.com/blogger/docs/3.0/using#RetrievingPostsForABlog-->
    
    <div class="container">
         <div class="row" style="height: 100px;">
        </div>
     <div class="row">
 
      <div class="container">
      <div class="row text-center">
        <h1>Puppies on the Web!</h1>
        <p>Look at all the cuteness! You're head will explode!</p>
      </div>
      </div>

      <div class="row" style="height: 50px;"></div>

        <div class="col-md-1">
          <!--<p><i class="fa fa-camera fa-4x"></i></p> -->
          <p>May 24, 2013</p>
        </div>
        <div class="col-md-5">
          <a href="Home.aspx"><img src="http://farm5.staticflickr.com/4081/4883281674_8428f07e53_z.jpg" class="img-responsive"></a>
        </div>
        <div class="col-md-6">
          <h3><a href="blog-post.html">A Blog Home Template for Bootstrap 3</a></h3>
          <p>by <a href="#">Start Bootstrap</a></p>
          <p>This is a very basic starter template for a blog homepage. It makes use of Font Awesome icons that are built into the 'Modern Business' template, and it makes use of the Bootstrap 3 pager at the bottom of the page.</p>
          <a class="btn btn-primary" href="Home.aspx">Read More <i class="fa fa-angle-right"></i></a>
        </div>

      </div>
 
      <div class="row">

        <ul class="pager">
          <li class="previous"><a href="#">&larr; Older</a></li>
          <li class="next"><a href="#">Newer &rarr;</a></li>
        </ul>
        
      </div><!--/.container-->

    </asp:Content>
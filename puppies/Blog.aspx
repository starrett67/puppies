﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
    <!--https://developers.google.com/blogger/docs/3.0/using#RetrievingPostsForABlog-->
    
    <div class="container">
         <div class="row" style="height: 100px;">
        </div>
     <div class="row">
 
      <div class="container">
        <h3>Puppies on the Web!</h3>
        <p>Look at all the cuteness! You're head will explode!</p>
      </div>

      <div class="row" style="height: 50px;">
        </div>

        <div class="col-md-1">
          <!--<p><i class="fa fa-camera fa-4x"></i></p> -->
          <p>May 24, 2013</p>
        </div>
        <div class="col-md-5">
          <a href="puppiesrus.azurewebsites.net/Home.aspx"><img src="http://placehold.it/600x300" class="img-responsive"></a>
        </div>
        <div class="col-md-6">
          <h3><a href="blog-post.html">A Blog Home Template for Bootstrap 3</a></h3>
          <p>by <a href="#">Start Bootstrap</a></p>
          <p>This is a very basic starter template for a blog homepage. It makes use of Font Awesome icons that are built into the 'Modern Business' template, and it makes use of the Bootstrap 3 pager at the bottom of the page.</p>
          <a class="btn btn-primary" href="puppiesrus.azurewebsites.net/Home.aspx">Read More <i class="fa fa-angle-right"></i></a>
        </div>

      </div>
 
      <div class="row">

        <ul class="pager">
          <li class="previous"><a href="#">&larr; Older</a></li>
          <li class="next"><a href="#">Newer &rarr;</a></li>
        </ul>
        
      </div><!--/.container-->

    </asp:Content>
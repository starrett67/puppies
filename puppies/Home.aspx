<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h1>
                    Welcome to puppiesrus!</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <h3>We Sell the best puppies!</h3>
                <center><button class="btn btn-large btn-primary" ><a href="Store.aspx">Click here to start Shopping</a></button><br /></center>
                <center><img  style="max-width:100%" src="http://1.bp.blogspot.com/__82348puvBM/TACA7PXeDNI/AAAAAAAAAB4/DnVPw_0wnjw/s1600/golden-retriever-puppies.jpg" /></center>
                <br>
                <div id="Carousel" class="carousel slide">
                    <ol class="carousel-indicators">
                        <li data-target="#Carousel" data-slide-to="0" class="active"></li>
                        <li data-target="#Carousel" data-slide-to="1"></li>
                        <li data-target="#Carousel" data-slide-to="2"></li>
                    </ol>
                    <!-- Carousel items -->
                    <div class="carousel-inner">
                        <div class="active item">
                        <!--<img src="http://howtopottytrainapuppydog.net/wp-content/uploads/2012/02/puppy-vinegar-water-training.jpg" />-->
                        <div class="carousel-caption">
                        <p>stuff heres s</p>
                        </div>
                           </div>
                        <div class="item">
                        <img src="http://www.wired.com/images_blogs/photos/uncategorized/2008/03/04/puppy.jpg" />
                        <div class="carousel-caption">
                        <p>stuff</p>
                        </div>
                            </div>
                        <div class="item">
                        <img src=""https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScIJOQcBJn_OGO5hoNGO9uSIWlZtNRqMXq9b2BbHNbCnjIWTYtwg />
                        <div class="carousel-caption">
                        <p>stuf here</p>
                        </div>
                           </div>
                    </div>
                    <!-- Carousel nav -->
                    <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                    <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
                </div>
                
            </div>
        </div>
    </div>
</asp:Content>

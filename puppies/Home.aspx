<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
    <div class="container">
     <div class="row" style="height: 60px;">
        </div>
     <div class="row">
        <div class="col-lg-4 ">
            <left><a class="twitter-timeline" href="https://twitter.com/ASPCA" data-widget-id="405205603703734272">Tweets by @ASPCA</a>
            <script>    !function (d, s, id) { var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/.test(d.location) ? 'http' : 'https'; if (!d.getElementById(id)) { js = d.createElement(s); js.id = id; js.src = p + "://platform.twitter.com/widgets.js"; fjs.parentNode.insertBefore(js, fjs); } } (document, "script", "twitter-wjs");</script></ left>
        <div class="col-lg-8 "
            <div class="jumbotron hero-spacer">
                <h1>Puppies R US!</h1>
                <p>We sell the best, Healthiest, and Friendliest Dogs around!  See Our most popular selections below</p>
            </div>
        </div>
    </div>
      </div>
      
      <hr>
      
      <div class="row">
        <div class="col-lg-12">
           <h3>Popular Dogs</h3>
        </div>
      </div><!-- /.row -->
      
      <div class="row text-center">

        <div class="col-lg-3 col-md-6 hero-feature">
          <div class="thumbnail">
            <img src="http://farm5.staticflickr.com/4081/4883281674_8428f07e53_z.jpg" alt="">
            <div class="caption">
              <h3>Brown Puppy</h3>
              <p>This would be a great dog to have!</p>
              <p><a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">More Info</a></p>
            </div>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 hero-feature">
          <div class="thumbnail">
            <img src="http://farm4.staticflickr.com/3465/3717404335_90ed081ca8_z.jpg" alt="">
            <div class="caption">
              <h3>Harry Puppie</h3>
              <p>This would be a great dog that will shed everywhere! LOL JK</p>
              <p><a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">More Info</a></p>
            </div>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 hero-feature">
          <div class="thumbnail">
            <img src="http://farm4.staticflickr.com/3225/5774362254_3bda643abb_z.jpg" alt="">
            <div class="caption">
              <h3>Sitting Dog</h3>
              <p>This would be a great Dog to play with!</p>
              <p><a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">More Info</a></p>
            </div>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 hero-feature">
          <div class="thumbnail">
            <img src="http://farm1.staticflickr.com/128/410071337_3a38fecae3_z.jpg?zz=1" alt="">
            <div class="caption">
              <h3>Lassie</h3>
              <p>This would be a great dog to help the fight in WW1!</p>
              <p><a href="#" class="btn btn-primary">Buy Now!</a> <a href="#" class="btn btn-default">More Info</a></p>
            </div>
          </div>
        </div>


      </div><!-- /.row -->
      <hr>
  </div><!-- /.row -->
      
      <hr>

      <footer>
        <div class="row">
          <div class="col-lg-12">
            <p>Copyright &copy; PuppiesRUS 2013 &middot;</p>
          </div>
        </div>
      </footer>
      
    </div><!-- /.container -->
</asp:Content>

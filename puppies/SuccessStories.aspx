<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
    <script type="text/javascript">
        var feed = new Instafeed({
            get: 'tagged',
            tagName: 'puppies',
            clientId: 'f8c344c3cdb14f0a84e9ce2c0ecd67fc'
        });
        feed.run();
            </script>
    <div class="container">
         <div class="row" style="height: 50px;">
        </div>
     <div class="row">
 
      <div class="container">
      <div class="row text-center">
        <h1>These puppies all went to good homes...will yours?</h1>
        <div id="instafeed"></div>
      </div> </div> </div> </div>
     <div class="row" style="height: 50px;"> </div>
   
        
    
</asp:Content>















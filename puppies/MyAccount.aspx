<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
    <script>
        fillForm();
        function fillForm() {
            console.log('Welcome!  Fetching your information.... ');
            FB.api('/me', function (response) {
                console.log('Good to see you, ' + response.name + '.');
                var resp = response;
                console.log(resp)
                document.getElementById("fName").value = response.first_name;
                document.getElementById("lName").value = response.last_name;
                document.getElementById("UserName").value = response.username;
                document.getElementById("Location").value = response.location.name;
                document.getElementById("Email").value = response.email;
                var pic_url = "https://graph.facebook.com/" + response.username + "/picture?type=large";
                console.log(pic_url);
                document.getElementById("profile-pic").innerHTML = '<center><img src="' + pic_url + '"/></center>';

            });
        }
    </script>
    <div class="container">
        <div class="row" style="height: 60px;">
        </div>
        <div class="row">
            <div style="margin: 10px;" class="col-lg-3">
                <table style="text-align:right">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        First Name:
                                    </td>
                                    <td style="margin-left: 20px;">
                                        <input id="fName" type="text" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Last Name:
                                    </td>
                                    <td style="margin-left: 20px;">
                                        <input id="lName" type="text" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        UserName:
                                    </td>
                                    <td style="margin-left: 20px;">
                                        <input id="UserName" type="text" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Email:
                                    </td>
                                    <td style="margin-left: 20px;">
                                        <input id="Email" type="text" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Location:
                                    </td>
                                    <td style="margin-left: 20px;">
                                        <input id="Location" type="text" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <div style="margin: 10px;" id="profile-pic" class="col-lg-3">
                            </div>
                        </td>
                    </tr>
                </table>
                <font color="red">
                    <p id="ErrorMessage">
                    </p>
                </font>
            </div>
        </div>
        <hr />
        <div class="row">
            <div style="margin: 10px;" class="col-lg-12 well">
                <h2>
                    Your Orders:</h2>
                <table class="table table-striped">
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
                    <tbody>
                        <tr>
                            <td class="field-label col-xs-2 active">
                                <label>
                                    Order 1:</label>
                            </td>
                            <td class="col-md-9">
                                Value 1
                            </td>
                            <td class="col-md-1">
                                $20
                            </td>
                        </tr>
                        <tr>
                            <td class="field-label col-xs-2 active">
                                <label>
                                    Order 2:</label>
                            </td>
                            <td class="col-md-9">
                                Value 2
                            </td>
                            <td class="col-md-1">
                                $20
                            </td>
                        </tr>
                        <tr>
                            <td class="field-label col-xs-2 active">
                                <label>
                                    Order 3:</label>
                            </td>
                            <td class="col-md-9">
                                Value 3
                            </td>
                            <td class="col-md-1">
                                $20
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

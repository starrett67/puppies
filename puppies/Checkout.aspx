<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PuppyContent" runat="server">
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
</asp:Content>

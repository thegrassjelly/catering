<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Admin_Booking_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-plus"></i>Add Booking
    
    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery.min.js") %>'></script>
    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery-ui.min.js") %>'></script>

    <script type="text/javascript">
        $(document).ready(function () {
            SearchUser();
        });
        // if you use jQuery, you can load them when dom is read.
        $(document).ready(function () {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_initializeRequest(InitializeRequest);
            prm.add_endRequest(EndRequest);

        });

        function InitializeRequest(sender, args) {
        }

        function EndRequest(sender, args) {
            // after update occur on UpdatePanel re-init the Autocomplete
            SearchUser();
        }

        function SearchUser() {
            $("#<%=txtName.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Add.aspx/GetName",
                        data: "{'prefixText':'" + request.term + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('/vn/')[0],
                                    val: item.split('/vn/')[1]
                                }
                            }))
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                },
                select: function (e, i) {
                    $("#<%=hfName.ClientID %>").val(i.item.val);
                },
                minLength: 2
            });
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="form-group">
                    <div class="col-lg-2">
                        <asp:DropDownList ID="ddlClientHist" runat="server" CssClass="form-control"
                            OnSelectedIndexChanged="ddlClientHist_OnSelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem>Old Client</asp:ListItem>
                            <asp:ListItem>New Client</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="row">
                    <div class="col-lg-5">
                        <div id="pnlNewClient" runat="server">
                            <div class="panel panel-midnightblue">
                                <div class="panel-heading">
                                    Add Client
                                </div>
                                <div class="panel-body">
                                    <div id="pnlAddedClient" runat="server" visible="false">
                                        <div class="alert alert-success">
                                            <b>Client successfully added</b>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">First Name</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtNewFN" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Last Name</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtNewLN" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Email</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtNewEmail" runat="server" TextMode="Email"
                                                         class="form-control" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Mobile No.</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtNewMob" class="form-control" runat="server"
                                                         TextMode="Number" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Address</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtNewAddr" class="form-control" runat="server"
                                                         TextMode="Multiline" Style="max-width: 100%;" />
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <div class="pull-right">
                                        <asp:Button ID="btnAdd" class="btn btn-success" runat="server" Text="Add" 
                                                    OnClick="btnAdd_OnClick" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="pnlOldClient" runat="server">
                            <div class="panel panel-midnightblue">
                                <div class="panel-heading">
                                    Search Client
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Search Name</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtName" class="form-control" runat="server" required />
                                        </div>
                                        <div class="col-lg-2">
                                            <asp:LinkButton ID="btnUser" runat="server" OnClick="btnUser_OnClick" CssClass="btn btn-success"> 
                                                <i class="fa fa-refresh"></i></asp:LinkButton>
                                        </div>
                                        <asp:HiddenField runat="server" Value="0" ID="hfName" />
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">First Name</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtFN" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Last Name</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtLN" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Email</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
                                                         class="form-control" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Mobile No.</label>
                                        <div class="col-lg-5">
                                            <asp:TextBox ID="txtMNo" class="form-control" runat="server"
                                                         TextMode="Number" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Address</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtAddr" class="form-control" runat="server"
                                                         TextMode="Multiline" Style="max-width: 100%;" disabled />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <div class="panel panel-midnightblue">
                            <div class="panel-heading">
                                Booking Details
                            </div>
                            <div class="panel-body">
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>


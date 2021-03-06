﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manage_Users.aspx.cs" Inherits="media.benbarton.me.Manage_Users" %>
<%@ Register Src="~/Custom_Controls/Admin/AdminMenu.ascx" TagPrefix="adminControls" TagName="adminMenu" %>
<%@ Register Src="~/Custom_Controls/Uac/AdminUserForm.ascx" TagPrefix="admin" TagName="AdminUserForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- GOOGLE FONTS: Nunito -->
    <link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
    <!-- iPhone FAVICONS -->
    <link rel="apple-touch-icon" sizes="114×114" href="Resources/Favicons/apple-icon-114×114.png" />
    <link rel="apple-touch-icon" sizes="72×72" href="Resources/Favicons/apple-icon-72x72.png" />
    <link rel="apple-touch-icon" href="Resources/Favicons/apple-icon.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>

    <script src="../Javascript/UsefulFunctions.js"></script>
    <link id="link_style" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="Css/SharedStyle.css" />
    <script src="../Javascript/ApplyStyle.js"></script>

    <title>Manage Users</title>
</head>
<body style="padding-bottom:2.5%; padding-top:4%">
    <form runat="server">
        <div class="container">
            <!-- Alerts -->
            <div class="alert alert-danger alert-dismissible" runat="server" style="display:none" id="Error">
                 <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                 <asp:Label runat="server" ID="ErrorText"></asp:Label>
            </div>
            <div class="alert alert-warning alert-dismissible" runat="server" style="display:none" id="Warning">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <asp:Label runat="server" ID="WarningText"></asp:Label>
            </div>
            <div class="alert alert-success alert-dismissible" runat="server" style="display:none" id="Success">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <asp:Label runat="server" ID="SuccessText"></asp:Label>
            </div>

            <div class="jumbotron">
                <h1 class="display-4">Users</h1>
                <p class="lead">Create & edit media.benbarton.me users</p>
                <hr class="my-4" />
                <p><adminControls:adminMenu runat="server" id="adminMenu1" /></p>
            </div>   
           
            <label>Select a user:</label>
            <asp:DropDownList ID="selectUser" runat="server" AutoPostBack="True" CssClass="form-control" 
                onselectedindexchanged="SelectUser_Changed">
            </asp:DropDownList>
            <admin:AdminUserForm runat="server" ID="UserForm" />
            <asp:Button runat="server" ID="Button_Action" OnClick="Button_Action_Click" CssClass="btn btn-primary" Text="Action"></asp:Button>
            <asp:Button runat="server" ID="Button_Delete"  CssClass="btn btn-primary" Text="Delete" Visible="false" data-toggle="modal" data-target="#confirmDelete" OnClientClick="return false;"></asp:Button>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="confirmDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Confirm Delete</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure that you want to DELETE this user?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" class="btn btn-primary" ID="Button_DeleteConfirm" OnClick="Button_DeleteConfirm_Click" Text="Confirm"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>



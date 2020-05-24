﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="ParsnipWebsite.Admin" %>
<%@ Register Src="~/Custom_Controls/Admin/AdminMenu.ascx" TagPrefix="adminControls" TagName="adminMenu" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://fonts.googleapis.com/css?family=Nunito|Pacifico&display=swap" rel="stylesheet">
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

    <title>Admin</title>
</head>

<body style="padding-bottom:2.5%; padding-top:4%">
    <form runat="server">
        <div class="container">
            <div class="jumbotron">
                <h1 class="display-4">Admin</h1>
                <p class="lead">Manage theparsnip.co.uk</p>
                <hr class="my-4" />
                <p><adminControls:adminMenu runat="server" id="adminMenu" /></p>
            </div>
            <div class="input-group">
                <asp:TextBox runat="server"  CssClass="form-control" ID="TextBox_MOTD"></asp:TextBox>
                <span class="input-group-btn">
                    <asp:Button runat="server" ID="Button_SaveMOTD"  CssClass="btn btn-primary" Text="Save" OnClick="Button_UploadDataId_Click" />
                </span>
            </div>
            <br />
            <asp:Label runat="server" ID="Label_ParsnipWebsiteVersion"></asp:Label>
            <br />
            <asp:Label runat="server" ID="Label_ParsnipDataVersion"></asp:Label>
        </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="media.benbarton.me.Home" %>
<%@ Register Src="~/Custom_Controls/Menu/Menu.ascx" TagPrefix="menuControls" TagName="Menu" %>
<%@ Register Src="~/Custom_Controls/Media/UploadMediaControl.ascx" TagPrefix="mediaControls" TagName="UploadMediaControl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://fonts.googleapis.com/css?family=Nunito|Pacifico&display=swap" rel="stylesheet">
    <!-- iPhone FAVICONS -->
    <link rel="apple-touch-icon" sizes="114×114" href="Resources/Favicons/apple-icon-114×114.png" />
    <link rel="apple-touch-icon" sizes="72×72" href="Resources/Favicons/apple-icon-72x72.png" />
    <link rel="apple-touch-icon" href="Resources/Favicons/apple-icon.png" />
    <!-- BOOTSTRAP START -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" 
        integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" 
        integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous">
    </script>

    <!-- BOOTSTRAP END -->

    <script src="../Javascript/UsefulFunctions.js"></script>
    <link id="link_style" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="Css/SharedStyle.css" />
    <script src="../Javascript/ApplyStyle.js"></script>
    <script src="Javascript/IntersectionObserver.js"></script>
    <title>Home</title>
</head>
<body class="fade0p5" id="body" style="text-align:center">
    <label class="censored" id="pageId">home.html</label>
    
    <menuControls:Menu runat="server" ID="Menu" />
    <div runat="server" ID="MOTD_div" class="media-control-text" style="margin: auto; font-family: 'Pacifico', cursive; color:black; font-size:40px; padding-bottom:10px">
            "Message of the day!"
        </div>
    <div class="padded-text center_div">
        <asp:Label runat="server" ID="WelcomeLabel"></asp:Label>
    </div>
    <form runat="server">
        <label runat="server" id="PleaseLogin" visible="false">Please <a href="login">login</a> to upload media</label>
        <h2 id="MyMediaTitle" runat="server" visible="false"><b>My Media</b></h2>
        <mediaControls:UploadMediaControl runat="server" ID="UploadMediaControl" />
        <div runat="server" id="DynamicMediaDiv">
        </div>
    </form> 
    <script src="../Javascript/FocusImage.js"></script>
    <script src="../Javascript/Youtube.js"></script>
    <script src="Javascript/LazyImages.js"></script>
    <script>
        var url_string = window.location.href
        var url = new URL(url_string);
        var error = url.searchParams.get("error");
        if (error !== "" && error !== null)
        {
            if (error === "video")
            {
                document.getElementById("VideoError").style = "display:block";
            }
            else
            {
                document.getElementById("AccessWarning").style = "display:block";
            }
        }
    </script>
</body>
</html>

﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="media.benbarton.me.View_Image" %>
<%@ Register Src="~/Custom_Controls/Menu/Menu.ascx" TagPrefix="menuControls" TagName="Menu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- GOOGLE FONTS: Nunito -->
    <link href="https://fonts.googleapis.com/css?family=Nunito&display=swap" rel="stylesheet">
    <!-- iPhone FAVICONS -->
    <link rel="apple-touch-icon" sizes="114×114" href="Resources/Favicons/apple-icon-114×114.png" />
    <link rel="apple-touch-icon" sizes="72×72" href="Resources/Favicons/apple-icon-72x72.png" />
    <link rel="apple-touch-icon" href="Resources/Favicons/apple-icon.png" />
    <!-- BOOTSTRAP START -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>
    <!-- BOOTSTRAP END -->
    <script src="../Javascript/UsefulFunctions.js"></script>
    <link id="link_style" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="Css/SharedStyle.css" />
    <script src="../Javascript/ApplyStyle.js"></script>
    <script src="Javascript/IntersectionObserver.js"></script>
    <title>View Image</title>
</head>
<body class="fade0p5" id="body" style="text-align:center">
    <menuControls:Menu runat="server" ID="Menu" />
    <div runat="server" class="alert alert-danger alert-dismissible parsnip-alert" Visible="false" id="ShareUserSuspendedError">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Error:</strong> Could not access image. The image has been deleted or the person who shared this image has been suspended!
    </div>
    <div runat="server" class="alert alert-danger alert-dismissible parsnip-alert" Visible="false" id="UploadUserSuspendedError">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Error:</strong> Could not access image. The image has been deleted or the person who uploaded the image has been suspended!
    </div>
    <button type="button" class="btn btn-link" data-toggle="modal" data-target="#exampleModalCenter" style="padding:0px; position:fixed; top: 1px; right: 3px; z-index:2147483646">
            <img src="../../Resources/Media/Images/Web_Media/Share_White.svg" style="height:40px" />
    </button>
        <div runat="server" id="MediaContainer" class="background-lightest" style="display:inline-block; padding-top:8px; padding-bottom:5px">
            <h3 class="media-viewer-title"><b runat="server" id="ImageTitle"></b></h3>
            <img runat="server" id="ImagePreview" class="media-viewer" />
            <div runat="server" id="youtube_video_container" class="media-viewer" style="margin:auto" visible="false">
                <div runat="server" id="youtube_video" class="youtube-player" />
            </div>
            <video runat="server" id="video_container" controls="controls" class="video-viewer" style="display:inline-block; object-fit:contain; margin-bottom:0px" preload="none" visible="false" >
                <source runat="server" id="VideoSource" type="video/mp4" />
                Your browser does not support HTML5 video.
            </video>
            <br />
        </div>
    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content" style="margin:0px; padding:0px">
                <div runat="server" id="ShareLinkContainer" class="input-group" style="margin:0px; padding:0px">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroup-sizing-default">Link</span>
                    </div>
                    <input runat="server" type="text" id="ShareLink" class="form-control" 
                        onclick="this.setSelectionRange(0, this.value.length)" />
                </div>
            </div>
        </div>
    </div>
    <script>
        (function () {
            var v = document.getElementsByClassName("youtube-player");
            var p = document.getElementById("youtube_video");
            var iframe = document.createElement("iframe");
            //https://developers.google.com/youtube/player_parameters
            var playbackParameters;
            if (isMobile()) {
                playbackParameters = "?autoplay=0&controls=0&enablejsapi=1";
            }
            else {
                playbackParameters = "?autoplay=1&controls=1&enablejsapi=0";
            }
            playbackParameters += "modestbranding=1&mute=0&playsinline=0&fs=1"
            iframe.setAttribute("src", "//www.youtube.com/embed/" + v[0].dataset.id + playbackParameters);
            iframe.setAttribute("frameborder", "0");
            iframe.setAttribute("allowfullscreen", "allowfullscreen")
            iframe.setAttribute("id", "youtube-iframe");
            p.appendChild(iframe);
        })()
    </script>
</body>
</html>




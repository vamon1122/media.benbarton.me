﻿using ParsnipData.Accounts;
using ParsnipData.Logging;
using ParsnipData.Media;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using media.benbarton.me.Custom_Controls.Media;

namespace media.benbarton.me
{
    public partial class View_Image : System.Web.UI.Page
    {
        User myUser;
        ParsnipData.Media.Media myImage;
        ParsnipData.Media.Video myVideo;
        ParsnipData.Media.Youtube myYoutubeVideo;
        public Media MyMedia { get {

                if (myImage != null)
                    return myImage;
                if (myVideo != null)
                    return myVideo;
                if (myYoutubeVideo != null)
                    return myYoutubeVideo;
                return null;
            } }
        MediaShare myMediaShare;
        MediaShareId shareId;

        protected void Page_Load(object sender, EventArgs e)
        {
            //If there is an access token, get the token & it's data.
            //If there is no access token, check that the user is logged in.
            var accessToken = Request.QueryString["share"];



            if (Request.QueryString["id"] == null)
            {
                if (Request.QueryString["share"] == null)
                {
                    Response.Redirect("home");
                }
                else
                {
                    myUser = ParsnipData.Accounts.User.LogIn();
                    myMediaShare = new MediaShare(new MediaShareId(Request.QueryString["share"].ToString()));
                    shareId = myMediaShare.Id;
                    try
                    {
                        myMediaShare.Select();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }

                    if (string.IsNullOrEmpty(myMediaShare.MediaId.ToString()))
                    {
                        new LogEntry(Log.Debug) { text = $"Someone tried to access share {myMediaShare.Id}. Access was denied because the person who created this link has been suspended." };
                        ShareUserSuspendedError.Visible = true;
                    }
                    else
                    {
                        if (!IsPostBack)
                        {
                            myMediaShare.TimesUsed++;
                            myMediaShare.View(myUser);
                        }

                        User createdBy = ParsnipData.Accounts.User.Select(myMediaShare.UserId);
                        var myUserId = myUser == null ? default : myUser.Id;
                        myImage = ParsnipData.Media.Image.Select(myMediaShare.MediaId, myUserId);
                        myVideo = Video.Select(myMediaShare.MediaId, myUserId);
                        myYoutubeVideo = Youtube.Select(myMediaShare.MediaId, myUserId);
                        

                        new LogEntry(Log.Debug) { text = string.Format("{0}'s link to {1} got another hit! Now up to {2}", createdBy.FullName, MyMedia.Title, myMediaShare.TimesUsed) };
                    }
                }
            }
            else
            {
                myUser = Account.SecurePage("view?id=" + Request.QueryString["id"], this, Data.DeviceType);
                
                myVideo = Video.Select(new MediaId(Request.QueryString["id"]), myUser.Id);
                myYoutubeVideo = Youtube.Select(new MediaId(Request.QueryString["id"]), myUser.Id);
                myImage = ParsnipData.Media.Image.Select(new MediaId(Request.QueryString["id"].ToString()), myUser == null ? default : myUser.Id);


                if (MyMedia != null && MyMedia.MyMediaShare != null)
                {
                    myMediaShare = MyMedia.MyMediaShare;

                    if (myMediaShare == null)
                    {
                        myMediaShare = new MediaShare(MyMedia.Id, myUser.Id);
                        myMediaShare.Insert();
                    }
                }
            }

            ShareLink.Value = Request.Url.GetLeftPart(UriPartial.Authority) + "/view?share=" +
                    myMediaShare.Id;





            //Get the image which the user is trying to access, and display it on the screen.
            if (MyMedia == null || string.IsNullOrEmpty(MyMedia.Compressed))
            {
                //ShareLinkContainer.Visible = false;
                if (ShareUserSuspendedError.Visible == false)
                {
                    UploadUserSuspendedError.Visible = true;
                }
            }
            else
            {
                ImageTitle.InnerText = MyMedia.Title;
                Page.Title = MyMedia.Title;

                if(MyMedia.Type == "image")
                    ImagePreview.Src = MyMedia.Compressed;

                Page.Header.Controls.Add(new LiteralControl(string.Format("<meta property=\"og:title\" content=\"{0}\" />", MyMedia.Title)));
                //This will break youtube videos which have not had their thumbnail regenerated
                Page.Header.Controls.Add(new LiteralControl(string.Format("<meta property=\"og:image\" content=\"{0}\" />", MyMedia.Compressed.Contains("https://lh3.googleusercontent.com") ? MyMedia.Compressed : string.Format("{0}/{1}", Request.Url.GetLeftPart(UriPartial.Authority), MyMedia.Compressed))));
                Page.Header.Controls.Add(new LiteralControl("<meta property=\"og:type\" content=\"website\" />"));
                Page.Header.Controls.Add(new LiteralControl(string.Format("<meta property=\"og:url\" content=\"{0}\" />", Request.Url.ToString())));
                Page.Header.Controls.Add(new LiteralControl(string.Format("<meta property=\"og:description\" content=\"{0}\" />", MyMedia.Description)));
                Page.Header.Controls.Add(new LiteralControl(string.Format("<meta property=\"og:alt\" content=\"{0}\" />", MyMedia.Alt)));
                Page.Header.Controls.Add(new LiteralControl("<meta property=\"fb:app_id\" content=\"521313871968697\" />"));

                if (Request.QueryString["share"] == null)
                {
                    MediaShare myMediaShare;


                    myMediaShare = MyMedia.MyMediaShare;
                    if (myMediaShare == null)
                    {
                        myMediaShare = new MediaShare(MyMedia.Id, myUser.Id);
                        myMediaShare.Insert();
                    }
                }
            }
            
        }

        void Page_LoadComplete(object sender, EventArgs e)
        {
            if (myVideo == null && myYoutubeVideo == null)
            {
                    youtube_video_container.Visible = false;
                    video_container.Visible = false;
                
            }
            else
            {
                if (myVideo == null)
                {
                    youtube_video_container.Visible = true;
                    ImageTitle.InnerText = myYoutubeVideo.Title;
                    youtube_video.Attributes.Add("data-id", myYoutubeVideo.DataId);
                    ImagePreview.Visible = false;
                    video_container.Visible = false;
                }
                else
                {
                    if (!Data.IsMobile)
                        video_container.Attributes.Add("autoplay", "autoplay");

                    video_container.Poster = myVideo.Compressed;
                    video_container.Visible = true;
                    ImageTitle.InnerText = myVideo.Title;
                    VideoSource.Src = myVideo.VideoData.Compressed;
                    ImagePreview.Visible = false;
                    youtube_video_container.Visible = false;
                }

                ShareLink.Value = Request.Url.GetLeftPart(UriPartial.Authority) + "/view?share=" +
                    myMediaShare.Id;
            }


            myUser = ParsnipData.Accounts.User.LogIn();
            string personFullName = myUser == null ? "A stranger" : myUser.FullName;

            if (Request.QueryString["share"] != null)
            {

                User sharedBy = ParsnipData.Accounts.User.Select(myMediaShare.UserId);


                new LogEntry(Log.General)
                {
                    text = string.Format("{0} started watching video called \"{1}\" " +
                    "using {2}'s access token. This token has now been used {3} times!", personFullName, MyMedia.Title,
                    sharedBy.FullName, myMediaShare.TimesUsed)
                };
            }
            else
            {

                new LogEntry(Log.General) { text = string.Format("{0} started watching video called \"{1}\"", personFullName, MyMedia.Title) };
            }
        }

        protected void Button_ViewAlbum_Click(object sender, EventArgs e)
        {
            string redirect;

            switch (MyMedia.AlbumId)
            {
                case default(int):
                    redirect = $"home?id={MyMedia.Id}";
                    break;
                default:
                    redirect = $"tag?id={MyMedia.AlbumId}&focus={MyMedia.Id}";
                    break;
            }

            Response.Redirect(redirect + MyMedia.Id);
        }
    }
}



        
    

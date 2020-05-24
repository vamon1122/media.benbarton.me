using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ParsnipData.Accounts;
using ParsnipData.Media;
using ParsnipData.Logging;
using media.benbarton.me.Custom_Controls.Media;
using System.Configuration;

namespace media.benbarton.me
{
    public partial class Home : System.Web.UI.Page
    {
        private User myUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            MOTD_div.InnerHtml = ConfigurationManager.AppSettings["MOTD"];

            myUser = ParsnipData.Accounts.User.LogIn();
            if (string.IsNullOrEmpty(Data.DeviceType))
            {
                Response.Redirect("get_device_info?url=home");
            }

            if(myUser == null)
            {
                PleaseLogin.Visible = true;
            }
            else
            {
                MyMediaTitle.Visible = true;
                WelcomeLabel.Text =
                string.Format($"Hiya {myUser.Forename}, welcome back!");

                UploadMediaControl.Initialise(myUser, this);

                foreach (MediaControl mediaControl in MediaControl.GetUserMediaAsMediaControls(myUser.Id, myUser.Id))
                {
                    DynamicMediaDiv.Controls.Add(mediaControl);
                }
            }

            new LogEntry(Log.Debug) { text = string.Format("The home page was accessed by {0} from {1} {2} device.", 
                myUser == null ? "someone who was not logged in" : myUser.Forename, 
                myUser == null ? "their" : myUser.PosessivePronoun, Data.DeviceType) };

            
        }
    }
}
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ParsnipData.Accounts;
using ParsnipData.Logging;
using ParsnipData.Cookies;

namespace media.benbarton.me
{
    public partial class _TEMPLATE : System.Web.UI.Page
    {
        User myUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            //We secure the page using the UacApi. 
            //This ensures that the user is logged in etc
            //You only need to change where it says '_NEW TEMPLATE'.
            //Change this to match your page name without the '.aspx' extension.
            myUser = Account.SecurePage("_TEMPLATE", this, Data.DeviceType);
        }
    }
}
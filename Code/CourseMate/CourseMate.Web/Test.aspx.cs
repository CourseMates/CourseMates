using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

namespace CourseMate.Web
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [DirectMethod]
        public void LoadData()
        {
            for (int i = 0; i < 5; i++)
            {
                DesktopModuleProxy control = Ext.Net.Utilities.ControlUtils.FindControl<Ext.Net.DesktopModuleProxy>(this.LoadControl("CourseWindow.ascx"));
                control.Module.ModuleID = "ididi" + i;
                control.RegisterModule();
            }   

            
        }
    }
}
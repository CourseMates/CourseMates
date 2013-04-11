using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace CourseMatesWS.DAL
{
    public class DataAccess
    {
        #region Parameters
        private SqlConnection dsConn;

        #endregion

        #region destructor & constructor
        public DataAccess(string str)
        {

            dsConn = new SqlConnection
            {
                ConnectionString = str
            };
            //dsConn.ConnectionTimeout = 6000;
        }
        ~DataAccess()
        {
            if (dsConn != null)
            {
                if (dsConn.State == ConnectionState.Open)
                {
                    try
                    {

                        dsConn.Close();
                    }
                    catch
                    {
                        dsConn.Dispose();
                    }
                }
            }
        }
        #endregion

        #region General Functions
        
        # endregion
    }
}
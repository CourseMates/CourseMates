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
        public DataTable ExecuteQueryDS(string query)
        {
            var executeQryDataSet = new DataSet();

            try
            {
                dsConn.Open();
                var executeQryDsAdapter = new SqlDataAdapter(query, dsConn);
                executeQryDsAdapter.Fill(executeQryDataSet);
            }

            catch (Exception exception)
            {
            }
            finally
            {
                dsConn.Close();
            }
            if(executeQryDataSet.Tables != null && executeQryDataSet.Tables.Count > 0)
                return executeQryDataSet.Tables[0];
            return new DataTable();
        }
        public int ExecuteNonQuery(string query)
        {
            dsConn.Open();
            SqlCommand SqlCmd = new SqlCommand();
            SqlCmd.Connection = dsConn;
            SqlTransaction transaction = dsConn.BeginTransaction();
            SqlCmd.Transaction = transaction;
            SqlCmd.CommandText = query;
            SqlCmd.CommandType = CommandType.Text;
            int rowsEffected = -1;
            try
            {
                if (dsConn.State == System.Data.ConnectionState.Closed) SqlCmd.Connection.Open();
                rowsEffected = SqlCmd.ExecuteNonQuery();
                transaction.Commit();
            }
            catch
            {
                transaction.Rollback();
            }
            SqlCmd.Connection.Close();
            return rowsEffected;
        }
        public DataTable ExecuteQuerySP(string spName, params object[] parameters)
        {
            SqlCommand command = new SqlCommand();
            command.Connection = dsConn;
            command.CommandText = spName;
            command.CommandType = CommandType.StoredProcedure;

            var dataAdapter = new SqlDataAdapter();
            dataAdapter.SelectCommand = command;
            SqlParameter parameter;
            for (int i = 0; i < parameters.Length; i += 2)
            {
                parameter = command.Parameters.Add(parameters[i].ToString(), Convert2SqlDataType(parameters[i + 1]));
                parameter.Value = parameters[i + 1];
                parameter.Direction = ParameterDirection.Input;
            }
            var dTable = new DataTable();

            try
            {
                dataAdapter.Fill(dTable);
                var fillParameters = dataAdapter.GetFillParameters();
                return dTable;
            }
            catch (Exception exception)
            {


            }
            finally
            {
                dsConn.Close();
            }

            return dTable;
        }
        public int ExecuteNonQuerySP(string spName, params object[] parameters)
        {
            dsConn.Open();
            var sqlCmd = new SqlCommand();
            sqlCmd.Connection = dsConn;
            SqlTransaction transaction = dsConn.BeginTransaction();
            sqlCmd.Transaction = transaction;
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = spName;

            for (int i = 0; i < parameters.Length; i += 2)
            {
                SqlParameter parameter = sqlCmd.Parameters.Add(parameters[i].ToString(), Convert2SqlDataType(parameters[i + 1]));
                parameter.Value = parameters[i + 1];
                parameter.Direction = ParameterDirection.Input;
            }
            int rowsEffected;
            try
            {
                rowsEffected = sqlCmd.ExecuteNonQuery();
            }
            catch (Exception exception)
            {
                transaction.Rollback();
                dsConn.Close();
                return 0;
            }
            transaction.Commit();
            dsConn.Close();
            return rowsEffected;
        }
        private static SqlDbType Convert2SqlDataType(object param)
        {

            if (param == null) return System.Data.SqlDbType.Variant;

            switch (param.GetType().Name)
            {
                //byte 
                case "Byte": return SqlDbType.TinyInt;
                //sbyte 
                case "SByte": return SqlDbType.Int;
                //char 
                case "Char": return SqlDbType.Char;
                //short 
                case "Int16": return SqlDbType.Int;
                //ushort 
                case "UInt16": return SqlDbType.BigInt;
                //int 
                case "Int32": return SqlDbType.Int;
                //uint 
                case "UInt32": return SqlDbType.BigInt;
                //long 
                case "Int64": return SqlDbType.BigInt;
                //ulong 
                case "UInt64": return SqlDbType.BigInt;
                //float 
                case "Single": return SqlDbType.Real;
                //double 
                case "Double": return SqlDbType.Float;
                //string 
                case "String": return SqlDbType.VarChar;
                //bool 
                case "Boolean": return SqlDbType.Bit;
                //DateTime
                case "DateTime": return SqlDbType.DateTime;

                default: return SqlDbType.Int;
            }
        }
        # endregion
    }
}
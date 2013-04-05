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
        public DataSet ExecuteQryDS(string strQry)
        {
            var executeQryDataSet = new DataSet();

            try
            {
                dsConn.Open();
                var executeQryDsAdapter = new SqlDataAdapter(strQry, dsConn);
                executeQryDsAdapter.Fill(executeQryDataSet);
            }

            catch (Exception ex)
            {
            }
            finally
            {
                dsConn.Close();
            }

            return executeQryDataSet;
        }
        public long ExecuteQryScalar(string strQry)
        {
            Int32 scalar = 0;
            var cmd = new SqlCommand(strQry, this.dsConn);
            try
            {
                dsConn.Open();
                scalar = (Int32)cmd.ExecuteScalar();
            }
            catch (Exception exception)
            {
                var x = exception.InnerException;
            }
            finally
            {
                dsConn.Close();
            }

            return scalar;
        }
        public int UpdateTable(string tableName, string criteriaName, object criteriaValue, params object[] parameters)
        {
            if (parameters.Length == 0) return 0;
            string sqlString = "Update " + tableName + " Set ";
            for (int i = 0; i < parameters.Length; i += 2)
            {
                sqlString += parameters[i] + "=" + Convert2SqlText(parameters[i + 1]);
                if (i + 1 < parameters.Length - 1) sqlString += ",";
            }
            sqlString += " Where " + criteriaName + "=" + Convert2SqlText(criteriaValue);
            return ExecuteNonQuery(sqlString);
        }
        public int ExecuteNonQuerySP(string spName, params object[] spParameters)
        {

            dsConn.Open();
            var sqlCmd = new SqlCommand();
            sqlCmd.Connection = dsConn;
            SqlTransaction transaction = dsConn.BeginTransaction();
            sqlCmd.Transaction = transaction;
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = spName;

            for (int i = 0; i < spParameters.Length; i += 2)
            {
                SqlParameter parameter = sqlCmd.Parameters.Add(spParameters[i].ToString(), Convert2SqlDataType(spParameters[i + 1]));
                parameter.Value = spParameters[i + 1];
                parameter.Direction = ParameterDirection.Input;
            }
            int rowsEffected;
            try
            {
                rowsEffected = sqlCmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                transaction.Rollback();
                dsConn.Close();
                return 0;
            }
            transaction.Commit();
            dsConn.Close();
            return rowsEffected;

        }
        public DataTable ExecuteQuerySP(string spName, params object[] spParameters)
        {
            SqlCommand selectCommand = InitCommand(spName);
            var dataAdapter = new SqlDataAdapter();
            dataAdapter.SelectCommand = selectCommand;
            SqlParameter parameter;
            for (int i = 0; i < spParameters.Length; i += 2)
            {
                parameter = selectCommand.Parameters.Add(spParameters[i].ToString(), Convert2SqlDataType(spParameters[i + 1]));
                parameter.Value = spParameters[i + 1];
                parameter.Direction = ParameterDirection.Input;
            }
            var dTable = new DataTable();

            try
            {
                dataAdapter.Fill(dTable);
                var fillParameters = dataAdapter.GetFillParameters();
                return dTable;
            }
            catch (Exception e)
            {


            }
            finally
            {
                dsConn.Close();
            }

            return dTable;

        }
        public int InsertRecord(string tableName, bool identity, params object[] parameters)
        {
            if (parameters.Length == 0) return 0;
            string sqlString = "Insert Into " + tableName + "(";
            for (int i = 0; i < parameters.Length; i += 2)
            {
                sqlString += parameters[i].ToString();
                if (i + 1 < parameters.Length - 1) sqlString += ",";
            }
            sqlString += ") values(";

            for (int i = 1; i < parameters.Length; i += 2)
            {
                sqlString += Convert2SqlText(parameters[i]);
                if (i + 1 < parameters.Length - 1) sqlString += ",";
            }
            sqlString += ")";

            if (identity)
            {
                return ExecuteIdentityNonQuery(sqlString);
            }
            return ExecuteNonQuery(sqlString);
        }
        public int DeleteFromTable(string tableName, params object[] parameters)
        {
            string sqlString = "Delete From " + tableName + " Where ";
            for (int i = 0; i < parameters.Length; i += 2)
            {
                sqlString += parameters[i] + "=" + Convert2SqlText(parameters[i + 1]);
                if (i < parameters.Length - 2) sqlString += " And ";
            }
            return ExecuteNonQuery(sqlString);
        }
        private SqlCommand InitCommand(string commandTextSP)
        {
            var command = new SqlCommand();
            command.Connection = dsConn;
            command.CommandText = commandTextSP;
            command.CommandType = CommandType.StoredProcedure;
            return command;
        }
        public int ExecuteIdentityNonQuery(string sqlString)
        {
            sqlString += ";Select Cast(@@Identity as int)";
            SqlDataReader reader = ExecuteReaderQuery(sqlString);
            if (reader == null) return -1;
            if (reader.Read())
            {
                if (reader.GetValue(0) == DBNull.Value) return -1;
                return (int)reader.GetValue(0);
            }
            return -1;
        }
        public int ExecuteNonQuery(string sqlString)
        {
            dsConn.Open();
            SqlCommand SqlCmd = new SqlCommand();
            SqlCmd.Connection = dsConn;
            SqlTransaction transaction = dsConn.BeginTransaction();
            SqlCmd.Transaction = transaction;
            SqlCmd.CommandText = sqlString;
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
        public bool IsExist(string sqlString)
        {
            SqlDataReader reader = ExecuteReaderQuery(sqlString);
            if (reader == null) return false;
            bool exist = reader.Read();
            reader.Close();
            return exist;
        }
        public bool ExecuteQry(string strQry)
        {
            try
            {
                var runQry = new SqlCommand(strQry, this.dsConn);
                dsConn.Open();

                runQry.ExecuteNonQuery();
                runQry.Dispose();
                return true;
            }

            catch (Exception e)
            {
                return false;
            }

            finally
            {
                dsConn.Close();
            }

        }
        public SqlDataReader ExecuteReaderQuery(string sqlString)
        {
            SqlDataReader sqlReader;
            try
            {
                var cmd = new SqlCommand(sqlString, dsConn);
                cmd.Connection.Open();
                // CommandBehavior.CloseConnection means the the connection is open while the reader is open
                // to close the connection execute reader.close()
                sqlReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            }
            catch
            {
                return null;
            }
            return sqlReader;
        }
        # endregion

        #region Parameter Handeling

        static public DateTime HebStr2DateTime(string date)
        {
            IFormatProvider format =
                new System.Globalization.CultureInfo("he-IL", true);
            try
            {
                DateTime dt = DateTime.Parse(date, format, System.Globalization.DateTimeStyles.NoCurrentDateDefault);
                return dt;
            }
            catch
            {
                return new DateTime(1900, 1, 1);
            }
        }
        static public SqlDbType Convert2SqlDataType(object param)
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
        static public string Convert2SqlText(object param)
        {

            switch (param.GetType().Name)
            {
                case "Byte":
                case "SByte":
                case "Int16":
                case "UInt16":
                case "Int32":
                case "UInt32":
                case "Int64":
                case "UInt64":
                case "Single":
                case "Double": return param.ToString();
                case "Boolean": return ((bool)param) ? "1" : "0";
                case "String":
                case "Char": return "'" + param + "'";
                case "DateTime": return "CAST('" + param + "' as DateTime)";
                default: return "";
            }
        }

        #endregion
    }
}
using Project_QuanLyQuanCaffe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace Project_QuanLyQuanCaffe.DAO
{
    public class AccountDAO
    {
        private static AccountDAO instance;

        public static AccountDAO Instance
        {
            get { if (instance == null) instance = new AccountDAO(); return instance; }
            private set { instance = value; }
        }
        private AccountDAO() { }

        public bool Login(string userName, string passWord)
        {

            
            string query = "USP_Login @userName , @passWord "; 

            DataTable result = DataProvider.Instance.ExecuteQuery(query,new object[] { userName, passWord });

            return result.Rows.Count > 0;
        }

        public bool UpdateAccount(string userName, string displayName, string pass, string newPass)
        {
            int result = DataProvider.Instance.ExecuteNonQuery("EXEC USP_UpdateAccount @userName , @displayName , @password , @newPassword", new object[] { userName, displayName, pass, newPass });

            return result > 0;
        }

        public bool DeleteAccount(string name )
        {
            string query = string.Format("Delete dbo.Account WHERE UserName = N'{0}'", name);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool InsertAccount(string userName, string displayName, int type)
        {
            string query = string.Format("INSERT dbo.Account ( UserName, DisplayName, Type, password ) VALUES (  N'{0}' , N'{1}' , {2} , N'{3}' )", userName, displayName, type);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool AccountUpdate(string name, string displayname, int type)
        {
            string query = string.Format("Update dbo.Account Set  DisplayName = N'{0}', Type = {1} Where UserName = '{2}' ", displayname, type , name);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool ResetPassword(string name)
        {

            string query = string.Format("Update dbo.Account Set  password = N'0' where UserName = N'{0}' ", name);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;

        }

        public DataTable GetListAccount()
        {
            return DataProvider.Instance.ExecuteQuery("SELECT UserName, DisplayName, Type FROM dbo.Account");
        }

        public Account GetAccountByUserName(string userName)
        {
         DataTable data= DataProvider.Instance.ExecuteQuery("SELECT *FROM account WHERE userName = '" + userName + "'");

            foreach(DataRow item in data.Rows)
            {
                return new Account(item);
            }

            return null;
        }
    }
}

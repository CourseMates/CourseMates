using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WCFTest
{
    class Program
    {
        static void Main(string[] args)
        {
            ServiceReference1.CourseMatesClient cm = new ServiceReference1.CourseMatesClient();
            ServiceReference1.User u = new ServiceReference1.User();
            u.FirstName = "Hadar";
            u.LastName = "Pikali";
            u.Email = "hadarp10@gmail.com";
            u.Password = "0263bcf70efc6b086280efe4c8d5bf2e";
            u.UserName = "Hadarp";
            u.GCMId = string.Empty;
            int id;
            string session;
            Console.WriteLine(cm.Login("eliranye", "0263bcf70efc6b08620efe4c8d5bf2e"));

            Console.WriteLine(cm.Register(u, out id, out session));
            Console.WriteLine(id);
            Console.WriteLine(session);
            Console.ReadLine();
        }
    }
}

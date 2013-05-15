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
            ServiceReference1.Course[] all = cm.GetCourseByUserId("123", 1);
            Console.ReadLine();
        }
    }
}

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
            Console.WriteLine(cm.GetData(99));
            Console.ReadLine();
        }
    }
}

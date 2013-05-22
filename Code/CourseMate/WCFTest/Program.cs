using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WCFTest.ServiceReference1;
using System.IO;

namespace WCFTest
{
    class Program
    {
        static void Main(string[] args)
        {
            CourseMatesClient cm = new CourseMatesClient();
            FileStream f = new FileStream(@"C:\Users\bohana\Desktop\123.txt", FileMode.Open);
            cm.UploadFile(1, "file.doc",(int)f.Length, 2, "adffdsfdsaf", 2, 1, f);
            Console.ReadLine();
        }
    }
}

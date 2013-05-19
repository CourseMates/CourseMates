using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using CourseMatesWS.DAL.Objects;

namespace NUnitTest
{
    [TestFixture]
    public class TestFixture1
    {
        [Test]
        public void TestFiles()
        {
            #region Test File structure init
            FileType t = new FileType
            {
                ID = 1,
                IconClass = "folder.png",
                Exstention = null,
                Description = "Folder"
            };

            FileItem fi = new FileItem
            {
                FileName = "Root",
                ID = 0,
                IsFolder = true,
                OwnerId = 1,
                PerantID = -1,
                Rate = 0,
                SubItems = new List<FileItem>(),
                Type = t
            };
            //test for valid file item
            FileStructure fs = new FileStructure(fi);
            Assert.NotNull(fs.RootFolder);
            //test for null file item
            Assert.Throws<NullReferenceException>(() => { new FileStructure(null); }, "Root can't be null");
            #endregion

            #region Test Add File
            FileItem fi1 = GetNewFile(false, -1);

            Assert.IsTrue(fs.AddFileToRoot(fi1));
            Assert.IsTrue(fs.IsItemExist(fi1));
            #endregion

            #region Test Remove File

            #endregion

            #region Test file structure
            
	        #endregion
        }

        #region Genarate moace items
        public static int item = 1;
        private static FileItem GetNewFile(bool isNull, int PerantId)
        {
            if (isNull)
                return null;
            FileType t = new FileType
            {
                ID = 2,
                IconClass = "doc.png",
                Exstention = "doc",
                Description = "Word 2003 file"
            };

            FileItem fi = new FileItem
            {
                FileName = "file" + item + ".doc",
                ID = item,
                IsFolder = false,
                OwnerId = 1,
                PerantID = PerantId,
                Rate = 0,
                SubItems = new List<FileItem>(),
                Type = t
            };

            item++;
            return fi;
        }
        private static FileItem GetNewFolder(bool isNull, int PerantId)
        {
            if (isNull)
                return null;
            FileType t = new FileType
            {
                ID = 1,
                IconClass = "folder.png",
                Exstention = null,
                Description = "Folder"
            };

            FileItem fi = new FileItem
            {
                FileName = "folder" + item,
                ID = item,
                IsFolder = true,
                OwnerId = 1,
                PerantID = PerantId,
                Rate = 0,
                SubItems = new List<FileItem>(),
                Type = t
            };

            item++;
            return fi;
        } 
        #endregion
    }
}


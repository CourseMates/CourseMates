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
        public void TestInit()
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
        }

        [Test]
        public void TestAddFiles()
        {
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
            FileStructure fs = new FileStructure(fi);
            //When matched ParentId
            //test if AddFileToRoot method returns true  
            FileItem fi1 = GetNewFile(false, -1);
            Assert.IsTrue(fs.AddFileToRoot(fi1));
            //test if AddFileToRoot method added file to root 
            Assert.IsTrue(fs.IsItemExist(fi1));

            //test if AddFileByPerantID method added file to file 
            FileItem fi2 = GetNewFile(false, -1);
            fi1.PerantID = fi2.ID;
            Assert.IsFalse(fs.AddFileByPerantID(fi1)); // Should fail , no check if adding to file (NOT A FOLDER)

            //test if AddFileByPerantID method added folder to folder 
            FileItem fo1 = GetNewFolder(false, -1);
            fo1.PerantID = fi.ID;
            Assert.IsTrue(fs.AddFileByPerantID(fo1));

            //test tries to add NULL object to a file
            FileItem nullfile = null;
            Assert.IsFalse(fs.AddFileByPerantID(nullfile));

            //test tries to add NULL object to a root 
            Assert.IsFalse(fs.AddFileToRoot(nullfile));

            //test tries to add again file that already exist
            Assert.IsFalse(fs.AddFileByPerantID(fo1));

            //test tries to add again folder that already exist
            Assert.IsFalse(fs.AddFileByPerantID(fo1));

            //with different ParentId
            //test if AddFileToRoot method returns true  
            FileItem fi2_diff = GetNewFile(false, -1);
            fi2_diff.PerantID = 100;
            Assert.IsFalse(fs.AddFileToRoot(fi2_diff)); //TODO should fail
            //test if AddFileToRoot method added file to root 
            Assert.IsFalse(fs.IsItemExist(fi2_diff));   //TODO should fail

            //test if AddFileToRoot method added file to root 
            Assert.IsTrue(fs.IsItemExist(fi1));
        }

        [Test]
        public void TestRemoveFiles()
        {
            FileType t = new FileType
            {
                ID = 1,
                IconClass = "folder.png",
                Exstention = null,
                Description = "Folder"
            };
            //Creating new root and new filestructe object for clean test.
            FileItem t3root = new FileItem
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
            FileStructure fs_t3 = new FileStructure(t3root);


            //test if we try to delete some file from empty root
            Assert.IsFalse(fs_t3.RemoveFile(10, 10));

            //test if removefile removes file
            //adding new file for future removal 
            FileItem t3_fi1 = GetNewFile(false, -1);
            //remove with different ownerID
            Assert.IsFalse(fs_t3.RemoveFile(t3_fi1.ID, 10));
            //remove with mathed ownerID
            Assert.IsTrue(fs_t3.RemoveFile(t3_fi1.ID, 1));

            //adding new folder 
            FileItem fol1 = GetNewFolder(false, -1);
            fs_t3.AddFileToRoot(fol1);

            //test try to remove a folder with differnt user ID
            Assert.IsFalse(fs_t3.RemoveFile(fol1.ID, 10));

            //test try to remove a folder with matched user ID
            Assert.IsFalse(fs_t3.RemoveFile(fol1.ID, 1));

            //adding new folder 
            FileItem fol2 = GetNewFolder(false, -1);
            fs_t3.AddFileToRoot(fol2);
            //adding new file for future removal 
            FileItem t3_fi2 = GetNewFile(false, -1);
            t3_fi2.PerantID = fol2.ID;
            fs_t3.AddFileByPerantID(t3_fi2);
            //test try to remove non empty folder 
            Assert.IsFalse(fs_t3.RemoveFile(fol2.ID, 1));
        }

        #region Genarate mock items
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
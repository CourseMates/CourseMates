using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using CourseMatesWS.DAL.Objects;

namespace NUnitTest
{
    [TestFixture]
    public class FileStructureTest
    {
        #region FileStructure init
        [Test]
        public void TestRootIsValid()
        {
            FileType t = new FileType
            {
                ID = 1,
                ImageUrl = "folder.png",
                Extension = null,
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
            Assert.NotNull(fs.RootFolder);
        }
        [Test]
        public void TestRootIsNull()
        {
            Assert.Throws<NullReferenceException>(() => { new FileStructure(null); }, "Root can't be null");
        }
        [Test]
        public void TestRootSubItemsIsNull()
        {
            FileType t = new FileType
            {
                ID = 1,
                ImageUrl = "folder.png",
                Extension = null,
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
                SubItems = null,
                Type = t
            };
            Assert.Throws<NullReferenceException>(() => { new FileStructure(null); }, "Root can't be null");
        } 
        #endregion
        #region IsExistMethod
        [Test]
        public void TestIsItemExistMethod()
        {
            CreateNewStaticStructure();
            for (int i = 0; i < item; i++)
            {
                Assert.IsTrue(fs.IsItemExist(i));
            }

            for (int i = item; i < item + 100; i++)
            {
                Assert.IsFalse(fs.IsItemExist(i));
            }
        } 
        #endregion
        #region AddFilesAndFolder
        [Test]
        public void TestAddFilesToRoot()
        {
            CreateNewStaticStructure();
            FileItem fi1 = GetNewFile(false, -1);
            Assert.IsTrue(fs.AddFileToRoot(fi1));
            Assert.IsTrue(fs.IsItemExist(fi1.ID));
            Assert.AreEqual(fs.RootFolder.ID, fi1.PerantID);
            Assert.IsTrue(fs.RootFolder.SubItems.Contains(fi1));
        }
        [Test]
        public void TestAddFilesToFile()
        {
            CreateNewStaticStructure();
            FileItem fi1 = GetNewFile(false, -1);
            fs.AddFileToRoot(fi1);
            FileItem fi2 = GetNewFile(false, -1);
            fi1.PerantID = fi2.ID;
            Assert.IsFalse(fs.AddFileByPerantID(fi1)); 
        }
        [Test]
        public void TestAddFolderToFolder()
        {
            CreateNewStaticStructure();
            FileItem fo1 = GetNewFolder(false, -1);
            fo1.PerantID = fs.RootFolder.ID;
            Assert.IsTrue(fs.AddFileByPerantID(fo1));
        }
        [Test]
        public void TestAddNullFiles()
        {
            Assert.IsFalse(fs.AddFileByPerantID(null));
            Assert.IsFalse(fs.AddFileToRoot(null));
        }
        [Test]
        public void TestAddExistFileItem()
        {
            CreateNewStaticStructure();
            FileItem fi1 = GetNewFile(false, -1);
            fs.AddFileToRoot(fi1);
            FileItem fo1 = GetNewFolder(false, -1);
            fs.AddFileToRoot(fo1);
            Assert.IsFalse(fs.AddFileByPerantID(fi1));
            Assert.IsFalse(fs.AddFileByPerantID(fo1));
        }
        [Test]
        public void TestAddFileByPerentID()
        {
            CreateNewStaticStructure();
            FileItem fi2_diff = GetNewFile(false, 100);
            Assert.IsFalse(fs.AddFileByPerantID(fi2_diff));
            Assert.IsFalse(fs.IsItemExist(fi2_diff.ID));
            fi2_diff.PerantID = 4;
            Assert.IsTrue(fs.AddFileByPerantID(fi2_diff));
            Assert.IsTrue(fs.IsItemExist(fi2_diff.ID));
        }

        #endregion
        #region RemoveItems
        [Test]
        public void TestRemoveNotFiles()
        {
            CreateNewStaticStructure();

            Assert.IsFalse(fs.RemoveFile(item+100, 10));
        }
        [Test]
        public void TestRemoveFiles()
        {
            CreateNewStaticStructure();
            Assert.IsTrue(fs.RemoveFile(15, 1));
            Assert.IsFalse(fs.IsItemExist(15));
        }
        [Test]
        public void TestRemoveFilesOfOtherOwner()
        {
            CreateNewStaticStructure();
            Assert.IsFalse(fs.RemoveFile(18, 14));
            Assert.IsTrue(fs.IsItemExist(18));
        }
        [Test]
        public void TestRemoveFullFolder()
        {
            CreateNewStaticStructure(); 
            Assert.IsFalse(fs.RemoveFile(2, 1));
            Assert.IsTrue(fs.IsItemExist(2));
        }
        [Test]
        public void TestRemoveEmptyFolder()
        {
            CreateNewStaticStructure();
            Assert.IsTrue(fs.RemoveFile(6, 1));
            Assert.IsFalse(fs.IsItemExist(6));
        }
        [Test]
        public void TestRemoveFiles2Times()
        {
            CreateNewStaticStructure();
            Assert.IsTrue(fs.RemoveFile(17, 1));
            Assert.IsFalse(fs.IsItemExist(17));
            Assert.IsFalse(fs.RemoveFile(17, 1));

        }
        #endregion
        
        #region Genarate mock items
        private static FileStructure fs;
        /*
            root
	            -folder0
		            -folder1
			            -folder2
				            -folder3
					            -file0
		            -folder4
			            -folder5
			            -file1
		            -folder6
			            file2
			            file3
			            file4
	            -folder7
		            folder8
			            file5
			            file6
		            file7
	            -folder9
		            file8
		            file9
		            file10
	            -file11
	            -file12
         */
        private static void CreateNewStaticStructure()
        {
            item = 1;
            FileType t = new FileType
            {
                ID = 1,
                ImageUrl = "folder.png",
                Extension = null,
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
            List<FileItem> folders = new List<FileItem>();
            for (int i = 0; i < 10; i++)
            {
                folders.Add(GetNewFolder(false, -1));
            }
            List<FileItem> files = new List<FileItem>();
            for (int i = 0; i < 13; i++)
            {
                files.Add(GetNewFile(false, -1));
            }
            //root
            AddToFolder(fi, folders[0]);
                AddToFolder(folders[0], folders[1]);
                    AddToFolder(folders[1], folders[2]);
                        AddToFolder(folders[2], folders[3]);
                            AddToFolder(folders[3], files[0]);
                AddToFolder(fi, folders[4]);
                    AddToFolder(folders[4], folders[5]);
                    AddToFolder(folders[4], files[1]);
                AddToFolder(fi, folders[6]);
                    AddToFolder(folders[6], files[2]);
                    AddToFolder(folders[6], files[3]);
                    AddToFolder(folders[6], files[4]);
                AddToFolder(fi, folders[7]);
                    AddToFolder(folders[7], folders[8]);
                        AddToFolder(folders[8], files[5]);
                        AddToFolder(folders[8], files[6]);
                    AddToFolder(folders[7], files[7]);
                AddToFolder(fi, folders[9]);
                    AddToFolder(folders[9], files[8]);
                    AddToFolder(folders[9], files[9]);
                    AddToFolder(folders[9], files[10]);
                AddToFolder(fi, files[11]);
                AddToFolder(fi, files[12]);
            fs = new FileStructure(fi);
        }
        private static void AddToFolder(FileItem addTo, FileItem toAdd)
        {
            addTo.SubItems.Add(toAdd);
            toAdd.PerantID = addTo.ID;
        }
        private static int item = 1;
        private static FileItem GetNewFile(bool isNull, int PerantId)
        {
            if (isNull)
                return null;
            FileType t = new FileType
            {
                ID = 2,
                ImageUrl = "doc.png",
                Extension = "doc",
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
                ImageUrl = "folder.png",
                Extension = null,
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.DAL.Objects
{
    [DataContract]
    public class FileStructure
    {
        [DataMember]
        public FileItem RootFolder { get; private set; }
        
        public FileStructure(FileItem root)
        {
            if (root != null)
            {
                RootFolder = root;
            }
            else
            {
                throw new NullReferenceException("Root can't be null");
            }
        }

        public bool AddFileToRoot(FileItem file)
        {
            if (file == null)
                return false;
            if (RootFolder.SubItems == null)
                RootFolder.SubItems = new List<FileItem>();
            file.PerantID = RootFolder.ID;
            RootFolder.SubItems.Add(file);
            return true;
        }
        
        public bool AddFileByPerantID(FileItem file)
        {
            return AddFile(file, RootFolder);
        }

        public bool RemoveFile(int id, int userId)
        {
            return RemoveFile(RootFolder, id, userId);
        }

        public bool IsItemExist(int id)
        {
            return IsItemExist(RootFolder, id);
        }

        private bool IsItemExist(FileItem item, int toFind)
        {
            if (item == null || item.SubItems == null)
                return false;
            if (item.ID == toFind)
                return true;
            foreach (FileItem i in item.SubItems)
            {
                if (i.ID == toFind)
                    return true;
                else if (IsItemExist(i, toFind))
                    return true;
            }
            return false;
        }

        private bool AddFile(FileItem toAdd, FileItem current)
        {
            if (current == null || toAdd == null)
                return false;
            if (current.ID == toAdd.PerantID)
            {
                if (current.IsFolder && current.SubItems == null)
                    current.SubItems = new List<FileItem>();
                if (!current.IsFolder || current.SubItems.Contains(toAdd))
                    return false;
                current.SubItems.Add(toAdd);
                return true;
            }
            if (current.SubItems != null)
            {
                foreach (FileItem item in current.SubItems)
                {
                    if (AddFile(toAdd, item))
                        return true;
                }
            }
            return false;
        }

        private bool RemoveFile(FileItem current, int id, int userId)
        {
            if (current == null)
                return false;
            for (int i = 0; i < current.SubItems.Count; i++)
            {
                FileItem item = current.SubItems.ElementAt(i);
                if (item.ID == id && item.OwnerId == userId)
                {
                    if (item.IsFolder && item.SubItems.Count > 0)
                        return false;
                    current.SubItems.Remove(item);
                    return true;
                }
            }

            foreach (FileItem fi in current.SubItems)
            {
                if (RemoveFile(fi, id, userId))
                    return true;
            }

            return false;
        }
    }
}
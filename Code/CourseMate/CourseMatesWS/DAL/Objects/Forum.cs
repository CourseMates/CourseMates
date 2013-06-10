using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.DAL.Objects
{
    [DataContract]
    public class Forum
    {
        [DataMember]
        public List<ForumItem> AllItems { get; set; }

        public Forum()
        {
            AllItems = new List<ForumItem>();
        }

        public bool AddItemToRoot(ForumItem item)
        {
            if (item == null)
                return false;
            AllItems.Add(item);
            return true;
        }

        public bool AddItemByPerantID(ForumItem item)
        {
            if (item.PerentId == -1)
                return AddItemToRoot(item);
            return AddItem(item, AllItems);
        }

        private bool AddItem(ForumItem toAdd, List<ForumItem> current)
        {
            if (current == null || toAdd == null)
                return false;

            foreach (ForumItem item in current)
            {
                if (item.ID == toAdd.PerentId)
                {
                    if (item.SubItems == null)
                        item.SubItems = new List<ForumItem>();
                    item.SubItems.Add(toAdd);
                    return true;
                }
                if(AddItem(toAdd, item.SubItems))
                    return true;
            }
            return false;
        }
    }
}
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Platform.DAAS.OData.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class ServiceConsumption
    {
        public string ID { get; set; }
        public string Consumer { get; set; }
        public string UrlReferrer { get; set; }
        public string Result { get; set; }
        public string ServiceID { get; set; }
        public System.DateTime CreationTime { get; set; }
    
        public virtual Service Service { get; set; }
    }
}
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Platform.DAAS.OData.Security
{
    using System;
    using System.Collections.Generic;
    
    public partial class RoleOperation
    {
        public string Id { get; set; }
        public string RoleId { get; set; }
        public string OperationId { get; set; }
    
        public virtual Operation Operation { get; set; }
    }
}

﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class DataModelContainer : DbContext
    {
        public DataModelContainer()
            : base("name=DataModelContainer")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Application> Applications { get; set; }
        public virtual DbSet<Service> Services { get; set; }
        public virtual DbSet<ServiceSubscription> ServiceSubscriptions { get; set; }
        public virtual DbSet<ServiceConsumption> ServiceConsumptions { get; set; }
    }
}
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using Platform.DAAS.OData.Core.Security;
using Platform.DAAS.OData.Facade;

namespace Platform.DAAS.OData.Security.Extension
{
    public class APIAuthAttribute : AuthorizeAttribute, IAuthorizable
    {
        public string DataType
        {
            get; set;
        }

        public bool IsValidatingDataScope
        {
            get; set;
        }

        public string Operation
        {
            get; set;
        }

        public bool ShouldByPassSupperUser
        {
            get; set;
        }

        public override void OnAuthorization(HttpActionContext actionContext)
        {
            //base.OnAuthorization(actionContext);

            var identity = actionContext.RequestContext.Principal.Identity;

            if ((identity == null) || (!identity.IsAuthenticated) || (String.IsNullOrEmpty(DataType) || (String.IsNullOrEmpty(Operation))))
            {
                base.OnAuthorization(actionContext);
                return;
            }

            string actor = identity.Name;

            ISecurityManager securityManager = Provider.SecurityManager();

            if (((ShouldByPassSupperUser && !securityManager.IsSupperUser(identity)) || (!ShouldByPassSupperUser && securityManager.IsSupperUser(identity))) && (!securityManager.IsAuthorized(actor, Operation)))
            {
                base.OnAuthorization(actionContext);
                return;
            }

            if (IsValidatingDataScope)
            {
                var dataScopeAuthObject = securityManager.GetActorDataScopes(actor, DataType);

                actionContext.Request.Properties.Add(ModuleConfiguration.DefaultContextDataScopePropertyName, dataScopeAuthObject);
            }
        }
    }
}

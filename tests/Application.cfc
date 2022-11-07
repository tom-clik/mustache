<!---// set up a dummy application so that we don't need any specific mappings and the tests can run from any sub-directory //--->
<cfcomponent output="false">
	<!---// SET APPLICATION MAPPINGS //--->
	<cfset this.mappings["/tests"] = getDirectoryFromPath(getCurrentTemplatePath()) />
	<cfset this.mappings["/mustache"] = this.mappings["/tests"] & "../mustache" />

	<!---// APPLICATION CFC PROPERTIES //--->
	<cfset this.name = hash(this.mappings["/tests"]) />
	<cfset this.applicationTimeout = createTimespan(0, 0, 10, 0) />
	<cfset this.serverSideFormValidation = false />
	<cfset this.clientManagement = false />
	<cfset this.setClientCookies = false />
	<cfset this.setDomainCookies = false />
	<cfset this.sessionManagement = false />

	<cfscript>
	public void function onError(e) {
		
		var niceError = ["message"=e.message,"type"=e.type,"detail"=e.detail,"code"=e.errorcode,"ExtendedInfo"=deserializeJSON(e.ExtendedInfo)];
		
		// supply original tag context in extended info
		if (IsDefined("niceError.ExtendedInfo.tagcontext")) {
			niceError["tagcontext"] =  niceError.ExtendedInfo.tagcontext;
			StructDelete(niceError.ExtendedInfo,"tagcontext");
		}
		else {
			niceError["tagcontext"] =  e.TagContext;
		}
		
		// set to true in any API to always get JSON errors even when testing
		param name="request.prc.isAjaxRequest" default="false" type="boolean";
		
		if (e.type eq "missingInclude") {
	        cfheader(statuscode = 404);
	        cfinclude(template="/errorhandling/404.cfm");
	        cfexit;
	    }

		if (e.type == "ajaxError" OR request.prc.isAjaxRequest) {
			
			local.errorCode = createUUID();
			local.filename = this.errorFolder & "/" & local.errorCode & ".html";
			writeDump(var=niceError,output=local.filename,format="html");
			cfheader(statuscode = 500);
			local.error = {
				"status": 500,
				"filename": local.filename,
				"message" : e.message,
				"code": local.errorCode
			}
			
			WriteOutput(serializeJSON(local.error));
		}
		else {
			
			writeDump(niceError);
			
		}
		
	}
	</cfscript>

</cfcomponent>
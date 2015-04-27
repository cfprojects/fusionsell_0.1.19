<cfcomponent extends="mura.plugin.pluginGenericEventHandler">


<!--- view cart handler --->
<cffunction name="onPageViewCartBodyRender" output="true">
<cfargument name="$">
<cfset var currentPage = "">
	<cfoutput>
	<cfset currentPage = "#ReplaceNoCase(application.contentRenderer.getCurrentURL(),"404", "renderCheckout")#" />
	<cfinclude template="#application.fusionSell.cartsettings.pluginPath#\displayObjects\shoppingCart.cfm" >
	</cfoutput>
</cffunction>


<!--- checkout handler --->
<cffunction name="onPageCheckoutBodyRender" output="true">
<cfargument name="$">
<!--- check user is logged in --->
<cfif not len(getAuthUser())>
<!--- user is not logged in redirect--->
<cflocation addtoken="no" url="#application.settingsManager.getSite(request.siteid).getLoginURL()#&returnURL=#URLEncodedFormat(Replace(application.contentRenderer.getCurrentURL(),'404','renderCheckout'))#">
<cfelse>
<!--- user is logged in --->
	<cfoutput>
	   <!--- show enter address page --->
	  <cfinclude template="#application.fusionSell.cartsettings.pluginPath#\displayObjects\checkout-BillingandShipping.cfm" >
	</cfoutput>

</cfif>



</cffunction>


<!--- checkout status handler --->
<cffunction name="onPageOrderStatusBodyRender" output="true">
<cfargument name="$">
<!--- check user is logged in --->
<cfif not len(getAuthUser())>
<!--- user is not logged in redirect--->
<cfoutput>Not logged in, error. Session may have timed out</cfoutput>
<cfelse>
<!--- user is logged in --->
	<cfoutput>
	   <!--- show enter address page --->
	  <cfinclude template="#application.fusionSell.cartsettings.pluginPath#\displayObjects\checkout-status.cfm" >
	</cfoutput>

</cfif>



</cffunction>



</cfcomponent>











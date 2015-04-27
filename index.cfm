<cfinclude template="plugin/config.cfm" />
<cfset request.pluginConfig.addToHTMLHeadQueue("admin/inc/htmlHead.cfm")>



<cfsavecontent variable="body">



<cfoutput>

<h2>#request.pluginConfig.getName()#</h2>

<ul>
<li><a href="grid.cfm" target="_blank">View Pending Orders</a></li>
</ul>










</cfoutput>
</cfsavecontent>


<cfoutput>
#application.pluginManager.renderAdminTemplate(body=body,pageTitle=request.pluginConfig.getName())#
</cfoutput>










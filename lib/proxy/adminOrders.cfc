<cfcomponent output="false" name="adminOrders" extends="mura.plugin.pluginGenericEventHandler">



<!--- Get order  --->
    <cffunction name="getOrders" access="remote">
        <cfargument name="page" required="yes">
        <cfargument name="pageSize" required="yes">
        <cfargument name="gridsortcolumn" required="yes">
        <cfargument name="gridsortdirection" required="yes">

    <cfquery name="qryOrders" datasource="#application.configBean.getDatasource()#">
        SELECT orderId,orderStatus
        FROM fusionSell_custOrders
        <cfif gridsortcolumn neq ''>
        order by #gridsortcolumn# #gridsortdirection#
        </cfif>
    </cfquery>
    <cfreturn queryconvertforgrid(qryOrders,page,pagesize)/>
    </cffunction>
	
	
<!---<cffunction name="getcustOrders" access="remote" returntype="any" returnformat="JSON">
	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
        <cfargument name="gridsortdirection" required="yes" default="asc">	      
	    <!--- Set default sort column --->
	<cfif arguments.gridsortcolumn EQ "">	    
	    	<cfset sortColumn = "orderId">	    	
	<cfelse>
		<cfset sortColumn = arguments.gridsortcolumn>
	</cfif>
	<!--- Lowercasing it, probably not required --->
	<cfset sort  = lCase(Arguments.gridsortdirection)>
	<!--- Get all the results from the order table.--->

	<cfset objORMUsers = EntityLoad("poi",{},"#sortColumn# #sort#")>	
	<!--- Convert to queries and we are done --->		
	<cfset selORMUsers = EntityToQuery(objORMUsers)>
	    
	<cfreturn queryconvertforgrid(selORMUsers,Arguments.page,Arguments.pageSize)/>
	    
</cffunction>--->








</cfcomponent>
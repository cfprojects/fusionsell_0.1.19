<!--- ok this is not really  DAO stuff here, but its late let me off  --->
<cfcomponent output="false" name="dao" extends="mura.plugin.pluginGenericEventHandler">
	
	<cffunction name="init" access="public" output="false" returntype="Any">
		<cfreturn this />
	</cffunction>
<!--- this creates the product bean --->
	<cffunction name="getorderBean" access="public" returntype="Any">
		<cfreturn createObject("component","customerBean").init()>
	</cffunction>
	
	
	
</cfcomponent>




















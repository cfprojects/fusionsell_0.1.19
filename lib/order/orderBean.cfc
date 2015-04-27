<cfcomponent output="false" name="orderBean" hint="">


	<cfscript>
	 variables.instance.orderId="";
	 variables.instance.customerId="";
	 variables.instance.orderStatus="";
	 variables.instance.orderTotal="";
	 variables.instance.orderShipTo="";
	</cfscript>
	
	
	<cffunction name="init" access="public" output="false" returntype="Any">
		<cfreturn this />
	</cffunction>
	

	<!--- orderId --->
	<cffunction name="getorderId" returntype="string"  access="public" output="false" hint="">
    	<cfreturn variables.instance.orderId />
    </cffunction>
    <cffunction name="setorderId" access="public" output="false" hint="">
    	<cfargument name="orderId" type="string" required="true" />
    	<cfset variables.instance.orderId = trim(arguments.orderId) />
    </cffunction>
	
	<!--- orderShipTo --->
	<cffunction name="getorderShipTo" returntype="string"  access="public" output="false" hint="">
    	<cfreturn variables.instance.orderShipTo />
    </cffunction>
    <cffunction name="setorderShipTo" access="public" output="false" hint="">
    	<cfargument name="orderShipTo" type="string" required="true" />
    	<cfset variables.instance.orderShipTo = trim(arguments.orderShipTo) />
    </cffunction>
	
	
	
		<!--- customer ID --->
	<cffunction name="getcustomerId" returntype="string"  access="public" output="false" hint="">
    	<cfreturn variables.instance.customerId />
    </cffunction>
    <cffunction name="setcustomerId" access="public" output="false" hint="">
    	<cfargument name="customerId" type="string" required="true" />
    	<cfset variables.instance.customerId = trim(arguments.customerId) />
    </cffunction>
	
	
    <!--- orderStatus --->
	<cffunction name="getorderStatus" returntype="string"  access="public" output="false" hint="">
    	<cfreturn variables.instance.orderStatus />
    </cffunction>
    <cffunction name="setorderStatus" access="public" output="false" hint="">
    	<cfargument name="orderStatus" type="string" required="true" />
    	<cfset variables.instance.orderStatus = trim(arguments.orderStatus) />
    </cffunction>
	
	<!--- orderTotal --->
	<cffunction name="getorderTotal" returntype="string"  access="public" output="false" hint="">
    	<cfreturn variables.instance.orderTotal />
    </cffunction>
    <cffunction name="setorderTotal" access="public" output="false" hint="">
    	<cfargument name="orderTotal" type="string" required="true" />
    	<cfset variables.instance.orderTotal = trim(arguments.orderTotal) />
    </cffunction>

</cfcomponent>









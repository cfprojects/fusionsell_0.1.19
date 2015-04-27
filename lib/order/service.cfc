<cfcomponent output="false" name="service" hint="Manages all order functions">
	
	<cffunction name="init" returntype="any" output="false" access="public">
		<cfargument name="orderDAO" type="any" required="yes"/>
		<cfset variables.orderDAO=arguments.orderDAO />
		<cfreturn this />
	</cffunction>
	
	
	<!--- this creates the order bean when called--->
	<cffunction name="createOrderBean" access="public" returntype="Any">
		<cfreturn createObject("component","orderBean").init()>
	</cffunction>
	
	
	
	<!--- update order--->	
	<cffunction name="updateOrder" returntype="any" output="false" access="public">
	    <cfargument name="bean" required="true" type="any">
	<cfscript>
    	var results = "";
	 //check if we have a order session started
	 startOrderSession();
	 results = variables.orderDAO.updateOrder(bean);
	</cfscript>
	
	
	</cffunction>


<!--- add products to order --->
<cffunction name="addProductToOrder" returntype="any" output="false" access="public"  >	
	<cfargument name="results" required="true" type="any">
		<cfscript>
	 results = variables.orderDAO.updateProducts(results);
	</cfscript>
</cffunction>	

<!--- remove current session products from order, I do this everytime we update --->
<cffunction name="deleteProductToOrder" returntype="void" output="false" access="public"  >	
		<cfscript>
	     variables.orderDAO.deleteProducts();
     	</cfscript>
</cffunction>	

<!--- get the product items the customer has ordered by orderID--->
<cffunction name="getOrderedProductItems" returntype="query" output="false" access="public"  >
  <cfargument name="orderId" required="yes">
		<cfscript>
		 var results = "";
	     results = variables.orderDAO.getCustProducts(arguments.orderId);
     	</cfscript>
		<cfreturn results />
</cffunction>		
	
<!--- function checks to see if order id  exisit, if not  starts one --->
<cffunction name="startOrderSession" returntype="any" output="false" access="public"  >
  <cfif not structkeyexists(session,"orderID")>
    <cflock timeout="60" type="exclusive">
      <cfset session['orderID'] = structnew()>
      <cfset session['orderID'] =  "order_" & RAND() & timeFormat(Now(),'hhmmss') & dateFormat(Now(),'ddmmyy') />
    </cflock>
  </cfif>
</cffunction>

	
<!--- function checks to see if order id  exisit, if not  starts one --->
<cffunction name="getOrder" returntype="query" output="false" access="public"  >
  <cfargument name="orderId" required="yes">
		<cfscript>
		 var results = "";
		 results = variables.orderDAO.getOrder(arguments.orderId);
     	</cfscript>
		<cfreturn  results>
</cffunction>


	

<!--- -------------------------- service remote calls ---------------------------------- --->	
<!--- becuase these calls get made outside of the MURA coldspring does not seems to inject. 
Will look into this and find a better way then creating the object each time.--->	

	<!--- get pending orders --->
	<cffunction name="getPendingOrders" returntype="any"  access="remote" output="false" hint="remote call that returns all pending orders">
    	<cfargument name="page" required="yes">
        <cfargument name="pageSize" required="yes">
        <cfargument name="gridsortcolumn" required="yes">
        <cfargument name="gridsortdirection" required="yes">
        <cfset orderDAORemote = createObject("component","DAO")>
        <cfset qryOrders = orderDAORemote.pendingOrders(arguments.gridsortcolumn,arguments.gridsortdirection)>
       <cfreturn queryconvertforgrid(qryOrders,arguments.page,arguments.pagesize)/>
    </cffunction>

	
	
	
	
	<!--- change pending order grid --->
<cffunction name="changePendingOrders" output="true" access="remote" >
  <cfargument name="gridaction" type="string" required="yes">
  <cfargument name="gridrow" type="struct" required="yes">
  <cfargument name="gridchanged" type="struct" required="yes">
  
  

    <cfset orderDAORemote = createObject("component","DAO")>
    <cfset orderDAORemote.editPendingOrders(gridaction=#arguments.gridaction#,
															 gridrow=#arguments.gridrow#,
															 gridchanged=#arguments.gridchanged#)>
	
									
</cffunction> 
	
	
</cfcomponent>











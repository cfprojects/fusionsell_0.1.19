<!--- ok this is not really  DAO stuff here, but its late let me off  --->
<cfcomponent output="false" name="dao" extends="mura.plugin.pluginGenericEventHandler">
	
	<cffunction name="init" access="public" output="false" returntype="Any">
		<cfreturn this />
	</cffunction>
<!--- this creates the product bean --->
	<cffunction name="getorderBean" access="public" returntype="Any">
		<cfreturn createObject("component","orderBean").init()>
	</cffunction>
	
	
	<cffunction name="updateOrder" access="public" returntype="Any">
		<cfargument name="bean" required="true" type="bean" >

		<!--- are we updated or creating an order? --->
		<cfif findOrder(#bean.getorderID()#) >
		
		
	 		<!--- update new order --->
			<cfquery datasource="#application.configBean.getDatasource()#" name="orderUpdate">
			 UPDATE fusionSell_custOrders
			 
				SET 
				orderStatus=<cfqueryparam value="#bean.getorderStatus()#" >,
				orderTotal=<cfqueryparam value="#bean.getorderTotal()#" >,
				orderShipTo=<cfqueryparam value="#bean.getorderShipTo()#" >
				
				WHERE orderId=<cfqueryparam value="#bean.getorderId()#" >
			</cfquery>
			
			

		
		<cfelse>

		
			<!--- create new order --->
			<cfquery datasource="#application.configBean.getDatasource()#" name="orderCreate">
			INSERT INTO fusionSell_custOrders (
			orderid,
			customerid,
			orderStatus,
			orderTotal,
			orderShipTo
			
			)
			VALUES (
			<cfqueryparam value="#bean.getorderId()#" >,
			<cfqueryparam value="#bean.getcustomerId()#" >, 
			<cfqueryparam value="#bean.getorderStatus()#" >,
			<cfqueryparam value="#bean.getorderTotal()#" >,
			<cfqueryparam value="#bean.getorderShipTo()#" >
		
			)
	
			</cfquery>
		
		</cfif>
		
		
		
	</cffunction>
	 
	
	<!--- find a order --->
	<cffunction name="findOrder" access="public" returntype="boolean" >
	    <cfargument name="orderID" required="true" type="any">
			<cfquery datasource="#application.configBean.getDatasource()#" name="getOrder">
			SELECT orderId
			FROM fusionSell_custOrders
			WHERE orderId =  <cfqueryparam value="#arguments.orderID#" cfsqltype="cf_sql_varchar" maxlength="100" >
		</cfquery>

		<cfif getOrder.recordcount eq 1>
		   <cfreturn true>
		 <cfelse>
		   <cfreturn false>
		</cfif>
		
	</cffunction>


	<!--- update products --->
	<cffunction name="updateProducts" access="public" returntype="boolean" >
	    <cfargument name="results" required="true" type="any">
	    
		

		
		
		<!--- insert new --->
			<cfquery datasource="#application.configBean.getDatasource()#" name="updateProducts">
		   INSERT INTO fusionSell_custOrderedProds (
			orderId,
			productName,
			productPrice,
			productSalePrice,
			productDiscount,
			productQty,
			prodItemId
			)
			VALUES (
			<cfqueryparam value="#session['orderID']#" >,
			<cfqueryparam value="#results.productBean.getproductName()#" >, 
			<cfqueryparam value="#results.productBean.getproductPrice()#" >,
			<cfqueryparam value="#results.productBean.getproductSalePrice()#" >,
			<cfqueryparam value="#results.productBean.getproductDiscount()#" >,
			<cfqueryparam value="#results.productBean.getproductQty()#" >,
			<cfqueryparam value="#RAND() & timeFormat(Now(),'hhmmss') & dateFormat(Now(),'ddmmyy')#" > 
		
			)
			
			
		  </cfquery>

	
		   <cfreturn true>

		
	</cffunction>	

<!--- delete products --->	
	<cffunction name="deleteProducts" access="public" returntype="void" >
		<cfquery datasource="#application.configBean.getDatasource()#" name="deleteCurrent">
			DELETE FROM fusionSell_custOrderedProds
			WHERE orderId=<cfqueryparam value="#session['orderID']#" >
		  </cfquery>	
	
	</cffunction>
	
	<!--- get a customer product by order id unlike the cart version we don't get the products from the page this time incase the price as changed--->	
	<cffunction name="getCustProducts" access="public" returntype="query" >
	 <cfargument name="orderId" required="yes">
	 <cfset var qryProducts = "">
		<cfquery datasource="#application.configBean.getDatasource()#" name="qryProducts">
			SELECT *
			FROM fusionSell_custOrderedProds
			WHERE orderId=<cfqueryparam value="#arguments.orderId#" >
		  </cfquery>	
	<cfreturn qryProducts>  
	</cffunction>




<!--- get pending orders --->
	<cffunction name="pendingOrders" access="public" returntype="Query" >
        <cfargument name="gridsortcolumn" required="yes">
        <cfargument name="gridsortdirection" required="yes">
		
    <cfquery name="qryOrders" datasource="#application.configBean.getDatasource()#">
        SELECT o.orderId,o.orderStatus,o.orderTotal,u.userID,u.fname,u.lname
        FROM fusionSell_custOrders o
		INNER JOIN tusers u
		ON  o.customerID = u.userID
        <cfif arguments.gridsortcolumn neq ''>
        order by <cfqueryparam value="#arguments.gridsortcolumn#" > <cfqueryparam value="#arguments.gridsortdirection#" > 
        </cfif>
    </cfquery>	
	<!--- return query --->
	<cfreturn qryOrders >
	</cffunction>

<!--- get orders by id--->
	<cffunction name="getOrder" access="public" returntype="Query" >
	    <cfargument name="orderId" required="yes">	
	    <cfset var qryOrders = "">
	    <cfquery name="qryOrders" datasource="#application.configBean.getDatasource()#">
	        SELECT 
			o.orderId,o.orderStatus,o.orderTotal,o.orderShipTo,
			u.userID,u.fname,u.lname,
			a.*
	        FROM fusionSell_custOrders o
			INNER JOIN tusers u
			ON  o.customerID = u.userID
			INNER JOIN tuseraddresses a
			ON  o.customerID = a.userID
			where orderid = <cfqueryparam  value="#arguments.orderId#">
			and a.addressName = 'Billing Address'
	    </cfquery>	
	<!--- return query --->
	<cfreturn qryOrders >
	</cffunction>

<cffunction name="editPendingOrders" access="public"  output="no">
  <cfargument name="gridaction" type="string" required="yes">
  <cfargument name="gridrow" type="struct" required="yes">
  <cfargument name="gridchanged" type="struct" required="yes">
  <!--- Local variables --->
  <cfset var colname="">
  <cfset var value="">
  <!--- Process gridaction --->
  <cfswitch expression="#ARGUMENTS.gridaction#">
    <!--- Process updates --->
    <cfcase value="U">
    <!--- Get column name and value --->
    <cfset colname=StructKeyList(ARGUMENTS.gridchanged)>
    <cfset value=ARGUMENTS.gridchanged[colname]>
    <cfif NOT #colname# EQ "orderId">
      <!--- Perform  update --->  	
    <cfquery name="qryOrders" datasource="#application.configBean.getDatasource()#">
            UPDATE fusionSell_custOrders
            SET #colname# = '#value#'
            WHERE orderId = '#ARGUMENTS.gridrow.orderId#'
			and orderStatus = 'pending'
			
      </cfquery>
    </cfif>
    </cfcase>
    <!--- Process deletes --->
    <cfcase value="D">
    <!--- Perform actual delete --->
    <cfquery datasource="#THIS.dsn#">
           <!--- DELETE FROM artists
            WHERE artistid = #ARGUMENTS.gridrow.artistid#--->
            </cfquery>
    </cfcase>
  </cfswitch>
</cffunction>








	
</cfcomponent>






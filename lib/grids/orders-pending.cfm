				<!--- campaign grid --->		
				<cfform>
					<cfgrid name="orderGrid" pagesize="10" format="html" colheaderbold="true" colheaderfont="Verdana" colheaderfontsize="90%"
				align="middle" colheaderalign="center"  selectOnLoad="false"	font="Verdana" fontsize="90%" striperows="true" 
				striperowcolor="##F0FAFF" bind="cfc:proxy.adminOrders.getOrders({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})"  >
					
					<cfgridcolumn name="order_id" header="Order ID" width="150" display="false" select="no" >
					<cfgridcolumn name="orderStatus" header="Order Status" width="150" display="true" select="no" >				

					
				</cfgrid>
				</cfform>
				<!--- load in any javascript --->
				<cfset ajaxOnLoad("init")>
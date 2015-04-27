<!--- start layout --->
<cfoutput>



	<cflayout name="mainLayout" type="tab" > 

	
	<!--- area for campaign grid --->
		<cflayoutarea name="ordersMain" title="Pending Orders"  >
		
				<!--- campaign grid --->		
				<cfform>
					<cfgrid name="orderGrid" pagesize="10" format="html" colheaderbold="true" colheaderfont="Verdana" colheaderfontsize="90%"
				align="middle" colheaderalign="center"  selectOnLoad="false"	font="Verdana" fontsize="90%" striperows="true" 
				striperowcolor="##F0FAFF" bind="cfc:lib.order.service.getPendingOrders({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})"  >
					
					<cfgridcolumn name="order_id" header="Order ID" width="250" display="false" select="no" >
					<cfgridcolumn name="orderStatus" header="Order Status" width="250" display="true" select="no" values="Pending,On Hold,Processed,Dispatched" >
					<cfgridcolumn name="fname" header="First Name" width="250" display="true" select="no" >
					<cfgridcolumn name="lname" header="Last Name" width="250" display="true" select="no" >
					<cfgridcolumn name="orderTotal" header="Order Total" width="250" display="true" select="no" >						

					
				</cfgrid>
				</cfform>
				<!--- load in any javascript --->
				<cfset ajaxOnLoad("init")>
         </cflayoutarea><!--- end orders grid area --->
	
	</cflayout> 

</cfoutput>
<!--- end layout --->
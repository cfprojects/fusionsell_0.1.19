<!--- start layout --->
<cfoutput>



	<cflayout name="mainLayout" type="tab" > 

	
	<!--- area for campaign grid --->
		<cflayoutarea name="ordersMain" title="Pending Orders"  >
		
				<!--- campaign grid --->		
				<cfform>
					<cfgrid name="orderGrid"
					         format="html"
					         pagesize="15"
					         striperows="yes"
					         selectmode="edit"
					         width="yes" 
					         height="auto"
										
					
				bind="cfc:lib.order.service.getPendingOrders({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
				onchange="cfc:lib.order.service.changePendingOrders({cfgridaction},
                                 {cfgridrow},
                                 {cfgridchanged})">
					
					<cfgridcolumn name="orderId" header="Order ID" width="250" display="false" select="no" >
					<cfgridcolumn name="orderStatus" header="Order Status" width="250" display="true" select="true" values="Pending,On Hold,Processed,Dispatched" >
					<cfgridcolumn name="fname" header="First Name" width="250" display="true" >
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
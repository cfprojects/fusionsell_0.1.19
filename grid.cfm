<!--- start layout --->   
<style type="text/css">
    @media print
    {
        #non-printable { display: none; }
        #printable { display: block; }
    }
    </style>
<cfoutput>

<script type="text/javascript" src="/CFIDE/scripts/ajax/ext/package/menu/menus.js"></script>

<script type="text/javascript">
		function init(){
		grid = ColdFusion.Grid.getGridObject("orderGrid");
		
		grid.addListener("rowcontextmenu", function(grid, rowIndex, e) {
		var record = grid.getDataSource().getAt(rowIndex); // Get the Record 
		var custName = record.data.LNAME + " " + record.data.LNAME;
		var orderId = record.data.ORDERID;
		
		var contextMenu = new Ext.menu.Menu();
		contextMenu.add({text:"Edit Record",handler:function(){
		   
		   ColdFusion.Window.create("viewOrder","View Order For " + custName,"order.cfm?id="+orderId,{
		      modal:true,
		      width:900,
		      height:600,
		      center:true
		   });
		   
		}});
		
		// Stops the browser context menu from showing. 
		e.stopEvent();
		// show menu at 
		contextMenu.showAt(e.xy);
		
		
		console.log(record);
		}); 
		
		}
</script>

<cfajaximport tags="CFWINDOW">
<cfinclude template="plugin/config.cfm" />
<div id="non-printable">

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
					<cfgridcolumn name="fname" header="First Name" width="250" display="true" select="no">
					<cfgridcolumn name="lname" header="Last Name" width="250" display="true" select="no" >
					<cfgridcolumn name="orderTotal" header="Order Total" width="250" display="true" select="no" type="numeric" mask="99.99" numberformat="99.99" >						

					
				</cfgrid>
				</cfform>
				<!--- load in any javascript --->
				<script type="text/javascript">
					window.onload = function()
					{
						init();
					};
				</script>
         </cflayoutarea><!--- end orders grid area --->
	
	</cflayout> 
 </div>
</cfoutput>
<!--- end layout --->
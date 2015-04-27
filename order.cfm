<cfinclude template="plugin/config.cfm" />

<cfoutput>
<cfscript>
    // get this order details
	order = application.fusionSell.orderService.getOrder(url.id);
	//get this order product items
    products = application.fusionSell.orderService.getOrderedProductItems(order.orderId);
</cfscript>


<div id="printable">

	<table width="99%" border="0">
	  <tr>
	    <td colspan="3" valign="top"><h1>Order Details</h1></td>
	  </tr>
	  <tr>
	    <td valign="top">
	      <p><strong>Billing Address:</strong></p>
	      <p>#order.address1#<br />
		  #order.address1#<br />
		  #order.address2#<br />
		  #order.city#<br />
		  #order.state#<br />
		  #order.zip#<br />
		  #order.country#<br />
		  #order.phone#
	      
	      </p>
	    </td>
	    <td valign="top">
	      <p><strong>Ship To:</strong></p>
	      <p>#order.orderShipTo#</p>
	    </td>
	  </tr>
	</table>
</cfoutput>
<!--- order items --->
	  
	  
		<table width="99%" border="0">
		  <tr>
		    <th align="left" valign="top">Item</th>
		    <th align="left" valign="top">Quantity</th>
		    <th align="left" valign="top">Subtotal</th>
		  </tr>
		 <cfloop query="products" >
		  <cfset subprice = 0>
		<cfoutput>
				  <tr>
					<!--- show product name --->
				      <td align="left" valign="top"> #productName#</td>
					<!--- show qty --->
					<td>
					#productQty#					
					<!--- line price of product --->
				    <td align="left" valign="top"> 
					<cfif productSalePrice gt productPrice >
					<cfset subprice = productSalePrice * productQty>
					&###application.fusionSell.cartsettings.Defaultcurrency#;#trim(numberformat(subprice,"9,999.00"))#
					<cfelse>
					<cfset subprice = productPrice * productQty>
					&###application.fusionSell.cartsettings.Defaultcurrency#;#trim(numberformat(subprice,"9,999.00"))#
					</cfif>
					</td>
				  </tr>
			</cfoutput>
		  </cfloop>
		  <tr>
			    <td colspan="3" align="right"><hr></td>
		    </tr>
			<cfoutput>
			  <tr>
			    <td colspan="2" align="right">Discount:</td>
			    <td>&###application.fusionSell.cartsettings.Defaultcurrency#;</td>
		    </tr>
			  <tr>
			    <td colspan="2" align="right">Subtotal:</td>
			    <td>&###application.fusionSell.cartsettings.Defaultcurrency#;</td>
		    </tr>
			  <tr>
			    <td colspan="2" align="right">Order Total:</td>
			    <td>&###application.fusionSell.cartsettings.Defaultcurrency#;#trim(numberformat(order.orderTotal,"9,999.00"))#</td>
		    </tr>
		</cfoutput>
		</table>
	</div>	
		<form><input type="button" value="Print Order"
onclick="window.print();return false;" /></form> 

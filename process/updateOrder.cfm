<!---
	Name         : process/updateOrder.cfm
	Author       : Glyn Jackson
	Last Updated : 30 Nov 2010
	History      : 
	Purpose		 : update order and customer address process
--->
<cfdiv id="cart">
<cftry>
	<cfscript>
		application.fusionSell.orderService.startOrderSession();
	    //update customer address
	    application.fusionSell.customerService.updateCustAddress(data=#form#);	
		
		
		
		
		//remove any current items form the product table for this order as we are above to update it
		application.fusionSell.orderService.deleteProductToOrder();
	
	    
	</cfscript>
	
	
	<cfset subtotal = 0>
	<!--- update ordered items --->
	 <cfloop collection="#session['cartItem']#" item="key">
	   		  <!--- get each item using the session as a pointer to what product we want, no sessions for prices! --->
			 <cfscript>
				results = application.fusionSell.cartService.getItem(contentID=#session['cartItem'][key]['prodId']#,qty=#session['cartItem'][key]['qty']#);
				
				results.productBean.setproductQty(#session['cartItem'][key]['qty']#);	
				
				//this adds the items to the current order in the database
				application.fusionSell.orderService.addProductToOrder(results);
				
				//add up total cost
				subtotal = subtotal + #trim(numberformat(results.sumCost,"9,999.00"))#;
			</cfscript>
	 </cfloop>
	
	
	
	<cfscript>
		//update order
		orderBean = application.fusionSell.orderService.createOrderBean();
		orderBean.setorderID('#session['orderID']#');
		orderBean.setcustomerId('#session.mura.userID#');
		orderBean.setorderStatus('Pending');
		orderBean.setorderTotal('#subtotal#');
		orderBean.setorderShipTo('#form.shipping1# #form.shipping2# #form.shippingcity# #form.shippingstate# #form.shippingzip# #form.shippingcountry#');
		
		//backup ship address this is the one used on the order print
		application.fusionSell.orderService.updateOrder(bean=#orderBean#);
		
	</cfscript>
	<cfoutput>
		<script>
		//refresh the cart widget 
		javascript:ColdFusion.navigate('#application.fusionSell.cartsettings.pluginURL#/displayObjects/checkout-PaymentOrderConfirm.cfm', 'cart');
		</script>
	</cfoutput>
	
<cfcatch type="Any" >
  <p>You need to be logged in as a site member to process an order. Sign up as a user to proces this order</p>
  <cfabort>
</cfcatch>
</cftry>

</cfdiv>











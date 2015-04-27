<!---
	Name         : displayObjects/shoppingCart.cfm
	Author       : Glyn Jackson
	Last Updated : 30 Nov 2010
	History      : added remove from cart 
	Purpose		 : Display object shopping cart page (US may want to change the word 'trolley' to 'cart' here)
--->
<cfdiv id="addedtoCart">	
<cfset $=application.serviceFactory.getBean("muraScope").init(session.siteID)>	
<cfif CGI.https is "off"><cfset httpMode = "http"><cfelse>><cfset httpMode = "https"></cfif>
<cfset mycount = 0>
	<cfif NOT structisempty(session['cartItem'])>
	<cfform name="updateCart" action="#application.fusionSell.cartsettings.pluginURL#/process/CartUpdate.cfm">
	  <cfparam name="MyQty" default="0">
	 <cfset subtotal = 0>
		<table width="99%" border="0">
		  <tr>
		    <th>&nbsp;</th>
		    <th>Product</th>
		    <th>Quantity</th>
		    <th>Tax</th>
		    <th>Subtotal</th>
		  </tr>
		 <cfloop collection="#session['cartItem']#" item="key">
		  <!--- get each item using the session as a pointer to what product we want, don't rely on sessions for prices --->
		 <cfscript>
			results = application.fusionSell.cartService.getItem(contentID=#session['cartItem'][key]['prodId']#,qty=#session['cartItem'][key]['qty']#);
			//mycount is use to know how many times we will be looping over the data for the update cart function
			mycount = mycount + 1;

		</cfscript>
		<!--- a few hidden text boxes here --->
		 <cfinput type="hidden" name="contentID" value="#session['cartItem'][key]['prodId']#">
		 <cfinput type="hidden" name="itemNode" value="#key#">
	
		 
	
         <!--- diplay vars --->
		<cfoutput>
				  <tr>
				    <td><!---img---></td>
					<!--- show product name --->
				    <td>#results.productBean.getproductName()#</td>
					<!--- show qty box --->
					<td>
					 <select name="qty">
					    <cfloop from="1" to="10" index="i">
					      <option value="#i#" <cfif #session['cartItem'][key]['qty']# eq #i#> selected="selected"</cfif> >#i#</option>
					     </cfloop>
					</select>
					<!--- remove item from cart link --->
					<cfset rtnURL = "#application.fusionSell.cartsettings.pluginPath#/displayObjects/shoppingCart.cfm">
					<br><a href="javaScript:ColdFusion.navigate('#application.fusionSell.cartsettings.pluginURL#/process/cartRemoveFrom.cfm?removeID=#key#&returnURL=#rtnURL#','addedtoCart')">Remove?</a></td>
					<!--- tax value of item --->
				    <td>&nbsp;</td>
					
					<!--- line price of product --->
				    <td> &###application.fusionSell.cartsettings.Defaultcurrency#;#trim(numberformat(results.sumCost,"9,999.00"))#
					<cfif results.hasSale>*</cfif></td>
				  </tr>
			</cfoutput>
			
			<!--- add it all up for a grand total and the end --->
			 <cfset subtotal = subtotal + results.sumCost>
		  </cfloop>
			<cfoutput>
			  <tr>
			    <td colspan="4">Discount:</td>
			    <td>&###application.fusionSell.cartsettings.Defaultcurrency#;0.00</td>
			  </tr>
			  <tr>
			    <td colspan="4">Subtotal:</td>
			    <td>&###application.fusionSell.cartsettings.Defaultcurrency#;#trim(numberformat(subtotal,"9,999.00"))#</td>
			  </tr>
			  <tr>
			    <td colspan="4">Total:</td>
				<cfset grandTotal =  subtotal>
			    <td>&###application.fusionSell.cartsettings.Defaultcurrency#;#trim(numberformat(grandTotal,"9,999.00"))#</td>
			  </tr>
		</cfoutput>
		</table>
			<cfinput type="hidden" name="count" value="#mycount#">
			<p>* Sale price</p>
			<div class="buttons">		
			<input type="submit" value="Update Items" >
		</div>	


	</cfform>
<cfoutput>
	   <form name="checkout" action="#httpMode#://#listFirst(cgi.http_host,':')#/#session.siteID#/index.cfm/renderCheckout/">
		<div class="buttons">		
				<input type="submit" value="Checkout" >
			</div>	
		</form>
</cfoutput>	
			<cfelse>
		<p>Your trolley is currently empty</p>
	</cfif>	

</cfdiv>
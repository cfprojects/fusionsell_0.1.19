<!---
	Name         : displayObjects/checkout-PaymentOrderConfirm.cfm
	Author       : Glyn Jackson
	Last Updated : 30 Nov 2010
	History      : 
	Purpose		 : Display object for order confirm page
--->
<cfscript>
$=application.serviceFactory.getBean("muraScope");
address = $.currentUser().getAddressesIterator().next();
</cfscript>

<h4>Order Details</h4>
<table width="99%" border="0">
  <tr>
    <td>Billing...</td>
    <td>Ship to...</td>
  </tr>
  <tr>
<cfoutput>
	    <td>
	    <b>Bill Name:</b> #$.currentUser().GETUSERBEAN().GETFNAME()# #$.currentUser().GETUSERBEAN().GETLNAME()# <br />
		<b>Address:</b>
		#address.getAddress1()# #address.getAddress2()#<br>
		#address.getcity()#<br>
		#address.getstate()#<br>
		#address.getzip()#<br>
		#address.getcountry()#<br>
		#address.getphone()#
		</td>
	    <td>
<!--- shipping address --->
<cfscript>
if ($.currentUser().getAddressesIterator().HASNEXT()){
	address = $.currentUser().readAddress(name="Shipping Address");
}	
</cfscript>
	    <b>Ship Name:</b> #$.currentUser().GETUSERBEAN().GETFNAME()# #$.currentUser().GETUSERBEAN().GETLNAME()# <br />
		<b>Address:</b>
		#address.getAddress1()# #address.getAddress2()#<br>
		#address.getcity()#<br>
		#address.getstate()#<br>
		#address.getzip()#<br>
		#address.getcountry()#<br>
		#address.getphone()#
</td>
</cfoutput>
  </tr>
</table>

	   
	   	<cfform name="profile" id="profile" action="#application.fusionSell.cartsettings.pluginURL#/process/orderSave.cfm" method="post" >
		<div class="buttons">
	    <input name="submit" type="submit"  value="Send Order" />
		<cfif CGI.https is "off"><cfset httpMode = "http"><cfelse>><cfset httpMode = "https"></cfif>
		<input type="hidden" name="userid" value="#session.mura.userID#"/>
		</div>
		
		
		<!--- address --->
		
		<cfinput type="hidden" id="address1" class="text" name="address1" value="#address.getAddress1()#" required="true"  message="Billing address required"  maxlength="50"/>	
	    <cfinput type="hidden" id="address2" class="text" name="address2" value="#address.getAddress2()#"  maxlength="50"/>
		<cfinput type="hidden" id="city" class="text" name="city" value="#address.getcity()#" required="true" message="Billing city required" maxlength="50"/>
		<cfinput type="hidden" id="state" class="text" name="state" value="#address.getstate()#" required="true"  message="Billing county required" maxlength="50"/>
		<cfinput type="hidden" id="zip" class="text" name="zip" value="#address.getzip()#" required="true"  message="Billing postcode required" maxlength="50"/>
		<cfinput type="hidden" id="country" class="text" name="country" value="#address.getcountry()#" required="true"  message="Billing country required"  maxlength="50"/>
        <cfinput type="hidden" id="phone" class="text" name="phone" value="#address.getphone()#" required="true"  message="Billing phone number required"  maxlength="50"/>

		<!--- shipping address --->
		<cfscript>
		 address = $.currentUser().readAddress(addressName='Shipping Address');
		</cfscript>

		<cfinput type="hidden" id="shipping1" class="text" name="shipping1" value="#address.getAddress1()#" required="true" message="Shipping name required"  maxlength="50" />
		<cfinput type="hidden" id="shipping2" class="text" name="shipping2" value="#address.getAddress2()#"  maxlength="50"/>
		<cfinput type="hidden" id="shippingcity" class="text" name="shippingcity" value="#address.getcity()#"  message="Shipping city required" required="true"  maxlength="50"/>
		<cfinput type="hidden" id="shippingstate" class="text" name="shippingstate" value="#address.getstate()#"  message="Shipping county required" required="true"  maxlength="50"/>
		<cfinput type="hidden" id="shippingzip" class="text" name="shippingzip" value="#address.getzip()#" required="true"  message="Shipping postcode required"  maxlength="50"/>
		<cfinput type="hidden" id="shippingcountry" class="text" name="shippingcountry" value="#address.getcountry()#" required="true"  message="Shipping county required" maxlength="50"/>
		<cfinput type="hidden" id="shippingphone" class="text" name="shippingphone" value="#address.getphone()#"  maxlength="50"/>
		
		
		</cfform>



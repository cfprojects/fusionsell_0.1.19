<!---
	Name         : displayObjects/checkout-BillingandShipping.cfm
	Author       : Glyn Jackson
	Last Updated : 30 Nov 2010
	History      : 
	Purpose		 : Display object for billing and shipping page 
--->
<cfdiv id="cart">
<cfscript>
//outside of the normal Mura event model so I obtain an istance of objects from the application.serviceFactory. --->
$=application.serviceFactory.getBean("muraScope");
//user=$.getBean("user").loadBy(userID='#session.mura.userid#', siteid='#session.mura.siteID#');
//address=user.getAddressesIterator().next();
address = $.currentUser().getAddressesIterator().next();
</cfscript>
<cfoutput>
	<div id="svEditProfile">
		<!--- billing address is always the first address returned --->
		<cfform name="profile" id="profile" action="#application.fusionSell.cartsettings.pluginURL#/process/updateOrder.cfm" method="post" >
		<!--- Billing Address --->
		<fieldset>
			<legend>Billing Address</legend>
		</fieldset>
		
		<ul>
		    <!--- address 1 --->
			<li>
				<label for="address1">Address 1<span class="required">*</span></label>
				<cfinput type="text" id="address1" class="text" name="address1" value="#address.getAddress1()#" required="true"  message="Billing address required"  maxlength="50"/>
			</li>
		    <!--- address 2 --->
			<li>
				<label for="address2">Address 2</label>
				<cfinput type="text" id="address2" class="text" name="address2" value="#address.getAddress2()#"  maxlength="50"/>
			</li>
		    <!--- city --->
			<li>
				<label for="city">City<span class="required">*</span></label>
				<cfinput type="text" id="city" class="text" name="city" value="#address.getcity()#" required="true" message="Billing city required" maxlength="50"/>
			</li>
		    <!--- state/county --->
			<li>
				<label for="state">County<span class="required">*</span></label>
				<cfinput type="text" id="state" class="text" name="state" value="#address.getstate()#" required="true"  message="Billing county required" maxlength="50"/>
			</li>
		    <!--- zip/post code --->
			<li>
				<label for="zip">Post Code<span class="required">*</span></label>
				<cfinput type="text" id="zip" class="text" name="zip" value="#address.getzip()#" required="true"  message="Billing postcode required" maxlength="50"/>
			</li>
		    <!--- country --->
			<li>
				<label for="country">Country<span class="required">*</span></label>
				<cfinput type="text" id="country" class="text" name="country" value="#address.getcountry()#" required="true"  message="Billing country required"  maxlength="50"/>
			</li>
			<!--- phone --->
			<li>
				<label for="phone">Phone<span class="required">*</span></label>
				<cfinput type="text" id="phone" class="text" name="phone" value="#address.getphone()#" required="true"  message="Billing phone number required"  maxlength="50"/>
			</li>				
		</ul>
<!--- shipping address --->
<cfscript>
if ($.currentUser().getAddressesIterator().HASNEXT()){
	address = $.currentUser().readAddress(name="Shipping Address");
}
</cfscript>
		<fieldset>
			<legend>Shipping Address</legend>
		</fieldset>
		
		<ul>
		    <!--- Shipping 1 --->
			<li>
				<label for="shipping1">Shipping 1<span class="required">*</span></label>
				<cfinput type="text" id="shipping1" class="text" name="shipping1" value="#address.getAddress1()#" required="true" message="Shipping name required"  maxlength="50" />
			</li>
		    <!--- address 2 --->
			<li>
				<label for="shipping2">Shipping 2</label>
				<cfinput type="text" id="shipping2" class="text" name="shipping2" value="#address.getAddress2()#"  maxlength="50"/>
			</li>
		    <!--- city --->
			<li>
				<label for="shippingcity">City<span class="required">*</span></label>
				<cfinput type="text" id="shippingcity" class="text" name="shippingcity" value="#address.getcity()#"  message="Shipping city required" required="true"  maxlength="50"/>
			</li>
		    <!--- state/county --->
			<li>
				<label for="shippingstate">County<span class="required">*</span></label>
				<cfinput type="text" id="shippingstate" class="text" name="shippingstate" value="#address.getstate()#"  message="Shipping county required" required="true"  maxlength="50"/>
			</li>
		    <!--- zip/post code --->
			<li>
				<label for="shippingzip">Post Code<span class="required">*</span></label>
				<cfinput type="text" id="shippingzip" class="text" name="shippingzip" value="#address.getzip()#" required="true"  message="Shipping postcode required"  maxlength="50"/>
			</li>
		    <!--- country --->
			<li>
				<label for="shippingcountry">Country<span class="required">*</span></label>
				<cfinput type="text" id="shippingcountry" class="text" name="shippingcountry" value="#address.getcountry()#" required="true"  message="Shipping county required" maxlength="50"/>
			</li>
			<!--- phone --->
			<li>
				<label for="shippingphone">Phone</label>
				<cfinput type="text" id="shippingphone" class="text" name="shippingphone" value="#address.getphone()#"  maxlength="50"/>
			</li>				
									
		</ul>

		<div class="buttons">
	    <input name="submit" type="submit"  value="Next" />
		<cfif CGI.https is "off"><cfset httpMode = "http"><cfelse>><cfset httpMode = "https"></cfif>
		<input type="hidden" name="returnURL" value="#httpMode#://#listFirst(cgi.http_host,':')##cgi.SCRIPT_NAME##cgi.PATH_INFO#" />
		<input type="hidden" name="userid" value="#session.mura.userID#"/>
		</div>
		</cfform>
	
	</div>
</cfoutput>
</cfdiv>












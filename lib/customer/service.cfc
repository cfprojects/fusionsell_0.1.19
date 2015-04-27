<cfcomponent output="false" name="service" hint="Manages all customer actions">
	<!--- init --->
	<cffunction name="init" returntype="any" output="false" access="public">
		<cfargument name="customerDAO" type="any" required="yes"/>
		<cfset variables.customerDAO=arguments.customerDAO />
		<cfreturn this />
	</cffunction>
<!--- update the customers billing and shipping address--->	
	<cffunction name="updateCustAddress" returntype="any" output="false" access="public">
	    <cfargument name="data" required="true" type="struct">
        <!--- save details --->
		<cfscript>
		//obtain an istance of objects itfrom the application.serviceFactory object
		var $ = "";
		var address = "";
		$=application.serviceFactory.getBean("muraScope");
		//SAVE: billing first address for the user is always billing 
		address = $.currentUser().getAddressesIterator().next();
		address.setAddressName("Billing Address");
		address.setAddress1(#arguments.data.address1#);
		address.setAddress2(#arguments.data.address2#);
		address.setcity(#arguments.data.city#);
		address.setstate(#arguments.data.state#);
		address.setzip(#arguments.data.zip#);
		address.setcountry(#arguments.data.country#);
		address.setphone(#arguments.data.phone#);
		address.save();
		
		//SAVE: shipping address
		
		if ($.currentUser().getAddressesIterator().HASNEXT()){
			address = $.currentUser().readAddress(name="Shipping Address");
		}
		
		else {
		  address=$.getBean("address");
		}
		
		
		address.setAddressName("Shipping Address");
		address.setAddress1(#arguments.data.shipping1#);
		address.setAddress2(#arguments.data.shipping2#);
		address.setcity(#arguments.data.shippingcity#);
		address.setstate(#arguments.data.shippingstate#);
		address.setzip(#arguments.data.shippingzip#);
		address.setcountry(#arguments.data.shippingcountry#);
		address.setphone(#arguments.data.shippingphone#);
		address.save();
		
		</cfscript>
	</cffunction>	
<!--- used to send out emails --->	
<cffunction name="sendCustEmail" returntype="any" output="false" access="public">
	<cfargument name="subject" type="any" required="yes"/>
	<cfargument name="from" type="any" required="no"/>
	<cfargument name="to" type="any" required="yes"/>
	<cfargument name="body" type="any" required="yes"/>	
		<cfmail
		
		from = "#pluginConfig.getSetting( 'fusion_ordersEmail' )#"
		to = "#arguments.to#"
		subject = "#arguments.subject#"
	    >
		#arguments.body#
		</cfmail>
</cffunction>
	
</cfcomponent>










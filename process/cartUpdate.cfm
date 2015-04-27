<!---
	Name         : process/cartUpdate.cfm
	Author       : Glyn Jackson
	Last Updated : 30 Nov 2010
	History      : 
	Purpose		 : cart update process. refreshes two display objects
--->
<cfdiv id="updatedCart">
<CFLOOP from="1" to="#form.count#" index="i">
	<cfscript>
		try
		{
			results = application.fusionSell.cartService.addUpdateItem(
				contentID=#ListGetAt(form.contentID, i)#,//this is the content id of the page that made the request
				qty=#ListGetAt(form.qty, i)#, //this is the qty the user wants
				itemNode=#ListGetAt(form.itemNode, i)#
			);
		}
		catch(Any e)
		{
		
		}
	
	</cfscript>
</CFLOOP>
<!--- display the results of the call, did the items get added to the cart? only one way to find out, fight, er, I mean output --->
<cfoutput>please wait...</cfoutput>
<cfoutput>
	<script>
	//refresh the cart widget 
	javascript:ColdFusion.navigate('#application.fusionSell.cartsettings.pluginURL#/displayObjects/shoppingCartWidget.cfm', 'cartWidget');
	javascript:ColdFusion.navigate('#application.fusionSell.cartsettings.pluginURL#/displayObjects/shoppingCart.cfm', 'addedtoCart');
	</script>

</cfoutput>
</cfdiv>



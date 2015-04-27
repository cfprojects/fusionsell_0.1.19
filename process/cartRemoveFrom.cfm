<!---
	Name         : process/cartRemoveFrom.cfm
	Author       : Glyn Jackson
	Last Updated : 30 Nov 2010
	History      : added a refresh link
	Purpose		 : remove from cart process
--->
<cfdiv id="addedtoCart">
<cfoutput>
	<script>
	//refresh the cart widget 
	javascript:ColdFusion.navigate('#application.fusionSell.cartsettings.pluginURL#/displayObjects/shoppingCartWidget.cfm', 'cartWidget');
	</script>
</cfoutput>
<cfscript>
results = application.fusionSell.cartService.removeUpdateItem(
    //this is the content id of the page that made the request we also use it for the product id
	removeID=#url.removeID#
);
</cfscript>
<cfoutput>#results# <cfif isdefined('returnURL')> - <a href="javascript:ColdFusion.navigate('#returnURL#', 'addedtoCart');">Refresh</a> </cfif></</cfoutput>
</cfdiv>














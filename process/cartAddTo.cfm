<!---
	Name         : process/cartAddTo.cfm
	Author       : Glyn Jackson
	Last Updated : 30 Nov 2010
	History      : 
	Purpose		 : add to cart process. used when add to cart button is clicked
--->
<cfdiv id="addedtoCart">

<!--- add item to the cart --->
<cfscript>
results = application.fusionSell.cartService.addUpdateItem(
	contentID=#form.contentID#,//this is the content id of the page that made the request
	qty=#form.qty#, //this is the qty the user wants
	itemNode=#form.itemNode#
);
</cfscript>
<!--- display the results of the call, did the items get added to the cart? only one way to find out, fight, er, I mean output --->
<cfoutput>#results.message# - <a href="javaScript:ColdFusion.navigate('#application.fusionSell.cartsettings.pluginURL#/process/cartRemoveFrom.cfm?removeID=#results.itemNode#','addedtoCart')">[x]</a> Remove?</cfoutput>
<cfoutput>
	<script>
	//refresh the cart widget 
	javascript:ColdFusion.navigate('#application.fusionSell.cartsettings.pluginURL#/displayObjects/shoppingCartWidget.cfm', 'cartWidget');
	</script>
</cfoutput>
</cfdiv>
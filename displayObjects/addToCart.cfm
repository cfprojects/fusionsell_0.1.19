<!---
	Name         : displayObjects/addToCart.cfm
	Author       : Glyn Jackson
	Last Updated : 6 Dec 2010
	History      : 
	Purpose		 : Display object for add to cart
--->
<!--- only show if this page has product values, otherwise we will get some nasty errors --->
<cfif len($.content('fusion_price')) neq 0 >
<cfif CGI.https is "off"><cfset httpMode = "http"><cfelse>><cfset httpMode = "https"></cfif>
	<cfif #pluginConfig.getSetting( 'fusion_PriceWithoutLogIn' )# eq "no" and not len(getAuthUser())>
		<!--- does not want to show prices untill logged in --->
	<cfoutput><p>You need to <a href="#httpMode#://#listFirst(cgi.http_host,':')#/#session.siteID#/index.cfm?display=login&returnURL=#httpMode#://#listFirst(cgi.http_host,':')#/#session.siteID#/index.cfm/" title="Login to view">login</a> to view prices</p></cfoutput>
	<cfelse>
	 <!--- if you want to show prices before logged in, then do this... --->
			<cfdiv id="addtoCart">
			<!--- product price and any options --->
			<cfoutput>
			<div id="prod_price">
			<p><cfif $.content('fusion_priceRRP') gt 0><div id="prod_rrp">RRP: <b>&###pluginConfig.getSetting( 'fusion_Defaultcurrency' )#;#$.content('fusion_priceRRP')#</b></div></cfif>
			<cfif not #trim(numberformat($.content('fusion_priceSale'),"9,999.00"))# eq 0><div id="prod_salePrice">Sale Price: <b>&###pluginConfig.getSetting( 'fusion_Defaultcurrency' )#;#$.content('fusion_priceSale')#</b></div></cfif>
			<cfif  not #trim(numberformat($.content('fusion_priceSale'),"9,999.00"))# eq 0><div id="prod_wasPrice">Was:<cfelse>Price:</cfif> <b>&###pluginConfig.getSetting( 'fusion_Defaultcurrency' )#;#$.content('fusion_price')#</b></div><br />
			</p>
			</div>
			</cfoutput>
				<cfform name="myform" id="prod_addTocart" action="#application.fusionSell.cartsettings.pluginURL#/process/CartAddTo.cfm">
					<cfoutput>
					<select name="qty">
						<cfloop from="1" to="10" index="i">
							 <option value="#i#">#i#</option>
						</cfloop>
					</select>
					<cfinput type="hidden" name="contentID" value="#$.content('contentID')#">
					<cfinput type="hidden" name="itemNode" value="0">
					<cfinput type="submit" value="Add To Cart" name="addme" class="addme">
					</cfoutput>
				</cfform>
			<!---	
			<cfdump var="#pluginConfig.getApplication().getValue("FusionSellCS").getbean("productBean")#">	
			<cfdump var="#event.getValue("fusionSellCS").getbean("cartService")#">--->
			<!---
				--->
			</cfdiv>
	</cfif>	
	
</cfif>


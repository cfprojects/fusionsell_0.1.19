<!---
	Name         : displayObjects/shoppingCartWidget.cfm
	Author       : Glyn Jackson
	Last Updated : 3rd Dec 2010
	History      : 
	Purpose		 : Display object for cart widget, this display gets refreshed every time an item is added or cart is updated
--->
<cfdiv id="cartWidget">
<cfif CGI.https is "off"><cfset httpMode = "http"><cfelse>><cfset httpMode = "https"></cfif>
<cfoutput>
	<ul class="navUtility cartWidgetNav">
    <!--- check if they are logged in --->
	<cfif not len(getAuthUser())>
		<li  class="first"><a href="#httpMode#://#listFirst(cgi.http_host,':')#/#session.siteID#/index.cfm?display=login&returnURL=#httpMode#://#listFirst(cgi.http_host,':')#/#session.siteID#/index.cfm/" title="Sign in">Sign in</a></li> 
	<cfelse>
	   	<li  class="first"><a href="#httpMode#://#listFirst(cgi.http_host,':')#/#session.siteID#/index.cfm?doaction=logout" title="Logout">Logout</a></li> 
	</cfif>
	<li><a href="#httpMode#://#listFirst(cgi.http_host,':')#/#session.siteID#/index.cfm/renderCheckout/?display=editProfile&returnURL=#httpMode#://#listFirst(cgi.http_host,':')#/#session.siteID#/index.cfm/" title="Register here">Register</a></li>
	<!---<li class="last"><a href="" title="My account">My account</a></li> --->
	</ul>
	<p class="ViewTrolley"><a href="#application.configBean.getContext()#/#session.siteID#/index.cfm/renderViewCart" title="View Trolly">My Trolley</a> (#application.fusionSell.cartService.getTotals(getwhat="items")# Item<cfif application.fusionSell.cartService.getTotals(getwhat="items") gt 1>s</cfif> 
	- &###application.fusionSell.cartsettings.Defaultcurrency#;#application.fusionSell.cartService.getTotals(getwhat="carttotal")#) </p>
<p class="cartCheckout"><a href="#application.configBean.getContext()#/#session.siteID#/index.cfm/renderViewCart" title="Checkout">Checkout</a></p>
</cfoutput>
</cfdiv>
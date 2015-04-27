<cfif CGI.https is "off"><cfset httpMode = "http"><cfelse>><cfset httpMode = "https"></cfif>
<!--- clean up --->
<cfscript>
StructDelete(session, "cartitem");
StructDelete(session, "orderid");
</cfscript>
<cflocation url="#httpMode#://#cgi.HTTP_HOST#/#session.siteID#/index.cfm/renderStatus/">
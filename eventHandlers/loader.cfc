<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

	<cffunction name="onApplicationLoad" output="false" returntype="any">
		<cfargument name="event">
		
		<cfset var serviceFactory = "" />
		<cfset var xml = "" />
		<cfset var xmlPath = "#expandPath( '\plugins' )#/#pluginConfig.getDirectory()#/#pluginConfig.getSetting( 'xmlPath' )#" />
		
		<!--- error handling --->
		<cfif NOT fileExists( xmlPath )>
			<cfthrow message="Plugin #pluginConfig.getName()#: XML path is invalid. File cannot be found." />
		</cfif>
		
		<!--- read in xml --->
		<cffile action="read" file="#xmlPath#" variable="xml" />
		
		<!--- parse the xml and replace all [plugin] with the actual plugin mapping path --->
		<cfset xml = replaceNoCase( xml, "[plugin]", "plugins.#pluginConfig.getDirectory()#.", "ALL") />
		
		<!--- build CS factory --->
		<cfset serviceFactory=createObject("component","coldspring.beans.DefaultXmlBeanFactory").init() />
		<cfset serviceFactory.loadBeansFromXmlRaw( xml ) />
		
		<!--- push in the Mura parent factory (if asked to do so) --->
		<cfif pluginConfig.getSetting( "injectMura" )>
			<cfset serviceFactory.setParent( event.getServiceFactory() ) />
		</cfif>
		
		<!--- if loader exists then call it --->
		<cfif serviceFactory.containsBean( "eventHandler" )>
			<cftry>
				<cfset serviceFactory.getBean( "eventHandler" ).configure( event ) />
				<cfcatch></cfcatch>
			</cftry>
		</cfif>
		
		<!--- push CS factory into plugin application scope --->
		<cfset pluginConfig.getApplication().setValue( pluginConfig.getSetting( "eventVariable" ), serviceFactory ) />
		
		<!--- set service components in application for calls outside of Mura --->
		<cftry>
			<cfset application.fusionSell = structNew() />
			
			<cfset application.fusionSell.cartService = pluginConfig.getApplication().getValue( pluginConfig.getSetting( "eventVariable" ) ).getBean( "cartService" ) />
			<cfset application.fusionSell.CustomerService = pluginConfig.getApplication().getValue( pluginConfig.getSetting( "eventVariable" ) ).getBean( "customerService" ) />
			<cfset application.fusionSell.orderService = pluginConfig.getApplication().getValue( pluginConfig.getSetting( "eventVariable" ) ).getBean( "orderService" ) />
			<cfset application.fusionSell.cartsettings.pluginURL = "http://#cgi.HTTP_HOST#/plugins/#pluginConfig.getDirectory()#" />
			<cfset application.fusionSell.cartsettings.pluginPath = "/plugins/#pluginConfig.getDirectory()#" />
			<cfset application.fusionSell.cartsettings.Defaultcurrency = "#pluginConfig.getSetting( 'fusion_Defaultcurrency' )#" />
	

			<cfdump var="##">
			<cfcatch><cfoutput>#cfcatch.message#<br /><cfdump var="#cfcatch#"></cfoutput><cfabort /></cfcatch>
		</cftry>
		<cfset variables.pluginConfig.addEventHandler(this) />
		
	</cffunction>
	
	<cffunction name="onSiteRequestStart" output="false" returntype="any">
		<cfargument name="event">
	
		<!--- assign the cs factory into the event --->
		<cfset event.setValue( pluginConfig.getSetting( "eventVariable" ), pluginConfig.getApplication().getValue( pluginConfig.getSetting( "eventVariable" ) ) ) />
	
	</cffunction>

	<cffunction name="onContentSave" output="false" returntype="any">
		<cfargument name="event">
		
		<!--- purge cache --->
		<cfset purgeCache( event ) />
		
	</cffunction>

	<cffunction name="onComponentSave" output="false" returntype="any">
		<cfargument name="event">
		
		<!--- purge cache --->
		<cfset purgeCache( event ) />
		
	</cffunction>
	
	<cffunction name="onFormSave" output="false" returntype="any">
		<cfargument name="event">
		
		<!--- purge cache --->
		<cfset purgeCache( event ) />
		
	</cffunction>

	<!--- **************************** PRIVATE **************************** --->
	<cffunction name="purgeCache" access="private" output="false" returntype="any">
		<cfargument name="event">
	
		<cfset var serviceFactory = pluginConfig.getApplication().getValue( pluginConfig.getSetting( "eventVariable" ) ) />
	
		<!--- if loader exists then call it --->
		<cfif serviceFactory.containsBean( "eventHandler" )>
			<cftry>
				<cfset serviceFactory.getBean( "eventHandler" ).purgeCache( event ) />
				<cfcatch></cfcatch>
			</cftry>
		</cfif>
	
	</cffunction>


</cfcomponent>


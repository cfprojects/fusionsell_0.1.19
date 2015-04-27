

<!--- 
    This plugin is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, Version 2 of the License.

    his plugin is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Sava CMS.  If not, see <http://www.gnu.org/licenses/>. --->
<cfcomponent extends="mura.plugin.plugincfc" output="false">

	<cfset variables.config="" />
	<cfset variables.instance.extensionManager = application.classExtensionManager />
	
	<cffunction name="init" returntype="any" access="public" output="false">
		<cfargument name="config"  type="any" default="">
		<cfset variables.config = arguments.config>
	</cffunction>
	
	<cffunction name="install" returntype="void" access="public" output="false">
		<cfset application.appInitialized=false />
		<cfset updateOrderTables()>
		<cfset updateSiteExtensions("Page")>
	</cffunction>
	
	<cffunction name="update" returntype="void" access="public" output="false">		
		<cfset application.appInitialized=false />
		<cfset updateOrderTables()>
		<cfset updateSiteExtensions("Page")>
	</cffunction>
	
	<cffunction name="delete" returntype="void" access="public" output="false">
		<cfset deleteSiteExtensions("Page")>
		<!--- decided not to delete database tables at this point incase they need the order data --->
	</cffunction>

	<cffunction name="deleteSiteExtensions" returntype="void" access="private" output="false">
		<cfargument name="useType" type="string" required="true">

		<cfset var siteStruct = application.settingsManager.getSites()>
		<cfset var siteID = "">

		<cfloop collection="#siteStruct#" item="siteID">
			<cfset deleteExtension(siteID,"Page")>
		</cfloop>
	</cffunction>




	<cffunction name="updateOrderTables" returntype="void" access="private" output="false">
	   
	   
	    <!--- check we have the  order table if not and we get an error create one --->
		<cftry>
			<cfquery datasource="#application.configBean.getDatasource()#" name="selectorderForm">
				SELECT
					orderId
				FROM
					fusionSell_custOrders
			</cfquery>
		<cfcatch type="Any" >
		<!--- if we get an error table needs creating --->
		
		<cfquery datasource="#application.configBean.getDatasource()#">
			CREATE TABLE [dbo].[fusionSell_custOrders](
				[orderId] [varchar](100) NOT NULL,
				[customerId] [varchar](100) NULL,
				[orderStatus] [varchar](50) NULL,
				[orderTotal] [float] NULL,
				[orderShipTo] [text] NULL
			) 
		</cfquery>
		</cfcatch>
		</cftry>
	   
	   
	   
	    <!--- check we have the product order table if not and we get an error create one --->
		<cftry>
			<cfquery datasource="#application.configBean.getDatasource()#" name="selectorderForm">
				SELECT
					orderId
				FROM
					fusionSell_custOrderedProds
			</cfquery>
		<cfcatch type="Any" >
		<!--- if we get an error table needs creating --->
		
		<cfquery datasource="#application.configBean.getDatasource()#">
			CREATE TABLE [dbo].[fusionSell_custOrderedProds](
				[orderId] [varchar](100) NOT NULL,
				[productName] [varchar](200) NULL,
				[productPrice] [float] NULL,
				[productSalePrice] [float] NULL,
				[productDiscount] [float] NULL,
				[productQty] [int] NULL,
				[itemId] [int] NULL,
				[prodItemId] [varchar](200) NULL
			)
		</cfquery>
		</cfcatch>
		</cftry>
		
		
		<!--- system table updates here --->
     </cffunction>



	<cffunction name="deleteExtension" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="useType" type="string" required="true">

		<cfset var sExtension = variables.instance.extensionManager.getSubTypeByName(arguments.useType,"Product",arguments.siteID)>
		<cfset var sExtendSet = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean()>
		<cfset var qExtendSets = sExtension.getSetsQuery()>

		<cfquery dbtype="query" name="selectGSMExtendSetForDelete">
			SELECT
				extendSetID
			FROM
				qExtendSets
			WHERE
				name = 'Product Pricing'
		</cfquery>
		


		<cfoutput query="selectGSMExtendSetForDelete">
			<cfset sExtendSet = sExtension.loadSet( extendSetID ) />
			<cfset sExtendSet.delete()>
		</cfoutput>
		
		<cfquery dbtype="query" name="selectGSMExtendSetForDelete2">
			SELECT
				extendSetID
			FROM
				qExtendSets
			WHERE
				name = 'General Product Information'
		</cfquery>
		
		<cfoutput query="selectGSMExtendSetForDelete2">
			<cfset sExtendSet = sExtension.loadSet( extendSetID ) />
			<cfset sExtendSet.delete()>
		</cfoutput>
		
		
		<cfquery dbtype="query" name="selectGSMExtendSetForDelete3">
			SELECT
				extendSetID
			FROM
				qExtendSets
			WHERE
				name = 'Product Images'
		</cfquery>
		
		<cfoutput query="selectGSMExtendSetForDelete3">
			<cfset sExtendSet = sExtension.loadSet( extendSetID ) />
			<cfset sExtendSet.delete()>
		</cfoutput>
		
		
	</cffunction>

	<cffunction name="updateSiteExtensions" returntype="void" access="private" output="false">
		<cfargument name="useType" type="string" required="true">

		<cfset var siteStruct = application.settingsManager.getSites()>
		<cfset var siteID = "">

		<cfloop collection="#siteStruct#" item="siteID">
			<cfset checkExtension(siteID,"Page")>
		</cfloop>
	</cffunction>

	<cffunction name="checkExtension" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="useType" type="string" required="true">

		<cfset var qExtensions = variables.instance.extensionManager.getSubTypes(arguments.siteID)>
		<cfset var sExtension = variables.instance.extensionManager.getSubTypeByName(arguments.useType,"Product",arguments.siteID)>
		<cfset var qExtendSets = sExtension.getSetsQuery()>

		<cfif not qExtensions.recordCount>
			<cfset addExtension(arguments.siteID,arguments.useType)>
			<cfreturn>
		</cfif>

		<cfquery dbtype="query" name="selectDefaultExtensionType">
			SELECT
				subTypeID
			FROM
				qExtensions
			WHERE
				type = '#arguments.useType#'
		</cfquery>

		<cfif not selectDefaultExtensionType.recordCount>
			<cfset addExtension(arguments.siteID,arguments.useType)>
			<cfreturn>
		</cfif>

		<cfquery dbtype="query" name="selectGSMExtendSet">
			SELECT
				extendSetID
			FROM
				qExtendSets
			WHERE
				name = 'Product Pricing'
		</cfquery>
		
		
		<cfif not selectGSMExtendSet.recordCount>
			<cfset addExtendSet(arguments.siteID,selectDefaultExtensionType.subTypeID)>
		</cfif>
		
		<cfquery dbtype="query" name="selectGSMExtendSet2">
			SELECT
				extendSetID
			FROM
				qExtendSets
			WHERE
				name = 'General Product Information'
		</cfquery>
		
		<cfif not selectGSMExtendSet2.recordCount>
			<cfset addExtendSet2(arguments.siteID,selectDefaultExtensionType.subTypeID)>
		</cfif>
		
		<cfquery dbtype="query" name="selectGSMExtendSet3">
			SELECT
				extendSetID
			FROM
				qExtendSets
			WHERE
				name = 'Product Images'
		</cfquery>
		
		<cfif not selectGSMExtendSet3.recordCount>
			<cfset addExtendSet3(arguments.siteID,selectDefaultExtensionType.subTypeID)>
			<cfreturn>
		</cfif>
		
			
			
			
		<cfset checkAttributes(arguments.siteID,selectDefaultExtensionType.subTypeID,selectGSMExtendSet.extendSetID)>
	</cffunction>

   <!--- The New Extension Name  --->
	<cffunction name="addExtension" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="useType" type="string" required="true">
		<cfargument name="subTypeID" type="string" required="false" default="#createUUID()#">

		<cfset var newExtensionID = createUUID()>
		<cfset var sExtension = variables.instance.extensionManager.getSubTypeByID(arguments.subTypeID)>

		<cfset sExtension.setType(arguments.useType)>
		<cfset sExtension.setSubType("Product")>
		<cfset sExtension.setIsActive(1)>
		<cfset sExtension.setBaseKeyField("contentHistID")>
		<cfset sExtension.setBaseTable("tcontent")>
		<cfset sExtension.setDataTable("tclassextenddata")>
		<cfset sExtension.setSiteID(arguments.siteID)>
		<cfset sExtension.save()>

		<cfset addExtendSet(arguments.siteID,arguments.subTypeID)>
		<cfset addExtendSet2(arguments.siteID,arguments.subTypeID)>
		<cfset addExtendSet3(arguments.siteID,arguments.subTypeID)>
	</cffunction>
	
	
	
	
	<!--- ------------------------------------------------------------------------------------------------------------- --->
     <!--- The group --->
	<cffunction name="addExtendSet" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="subTypeID" required="false" type="string" default="#createUUID()#">

		<cfset var newExtendSetID = createUUID()>
		<cfset var sExtendSet = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean()>
		<cfset var attName = "">

		<cfset sExtendSet.setSubTypeID(arguments.subTypeID)>
		<cfset sExtendSet.setExtendSetID(newExtendSetID)>
		<cfset sExtendSet.setName("Product Pricing")>
		<cfset sExtendSet.setOrderNo(0)>
		<cfset sExtendSet.setIsActive(1)>
		<cfset sExtendSet.setSiteID(arguments.siteID)>
		<cfset sExtendSet.save()>

		<cfset checkAttributes(arguments.siteID,arguments.subTypeID,newExtendSetID)>
	</cffunction>

	<cffunction name="checkAttributes" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="subTypeID" type="string" required="true">
		<cfargument name="extendSetID" type="string" required="true">

		<cfset var sExtension = application.classExtensionManager.getSubTypeByID(arguments.subTypeID)>
		<cfset var sExtendSet = sExtension.loadSet( arguments.extendSetID ) />
		<cfset var qExtendAtts = sExtendSet.getAttributesQuery() />
		
		<cfloop list="fusion_price,fusion_priceRRP,fusion_priceSale,fusion_productDiscount,fusion_productDiscountMix,fusion_taxValue" index="attName">
			<cfquery dbtype="query" name="selectGSMExtendSetAttributes">
				SELECT
					attributeID
				FROM
					qExtendAtts
				WHERE
					name = '#attName#'
			</cfquery>

			<cfif not selectGSMExtendSetAttributes.recordCount>
				<cfset addAttribute( arguments.siteID,attName,arguments.extendSetID )>
			</cfif>
		</cfloop>
	</cffunction>
    <!--- Set 1 --->
	<cffunction name="addAttribute" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="useName" type="string" required="true">
		<cfargument name="extendSetID" required="true">

		<cfset var sAttribute = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean().getattributeBean()>

		<cfset sAttribute.setExtendSetID(arguments.extendSetID)>
		<cfset sAttribute.setSiteID(arguments.siteID)>

		<cfswitch expression="#arguments.useName#">
			<!--- price --->
			<cfcase value="fusion_price">
				<cfset sAttribute.setName("fusion_price")>
				<cfset sAttribute.setLabel("Product Price")>
				<cfset sAttribute.setType("textBox")>
				<cfset sAttribute.setDefaultValue("00.00")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(1)>
			</cfcase>
			<!--- RRP Price --->
			<cfcase value="fusion_priceRRP">
				<cfset sAttribute.setName("fusion_priceRRP")>
				<cfset sAttribute.setLabel("Recommended Retail Price (RRP)")>
				<cfset sAttribute.setType("textBox")>
				<cfset sAttribute.setDefaultValue("00.00")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(2)>
			</cfcase>
			<!--- Sale Price --->
			<cfcase value="fusion_priceSale">
				<cfset sAttribute.setName("fusion_priceSale")>
				<cfset sAttribute.setLabel("Sale Price")>
				<cfset sAttribute.setType("textBox")>
				<cfset sAttribute.setDefaultValue("00.00")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(3)>
			</cfcase>
			<!--- Discount Rate  --->
			<cfcase value="fusion_productDiscount">
				<cfset sAttribute.setName("fusion_productDiscount")>
				<cfset sAttribute.setLabel("Apply A Discount To The Price")>
				<cfset sAttribute.setType("selectBox")>
				<cfset sAttribute.setDefaultValue("0")>
				<cfset sAttribute.setOptionList("0^5^10^15^20^25^30^35^40^45^50^55^60^65^70^75^80^85^90^95")>
				<cfset sAttribute.setOptionLabelList("None^5%^10%^15%^20%^25%^30%^35%^40%^45%^50%^55%^60%^65%^70%^75%^80%^85%^90%^95%")>
				<cfset sAttribute.setOrderNo(4)>
			</cfcase>			
			<!--- Discount Rate  --->
			<cfcase value="fusion_productDiscountMix">
				<cfset sAttribute.setName("fusion_productDiscountMix")>
				<cfset sAttribute.setLabel("Combine Discount With Global Discount")>
				<cfset sAttribute.setType("radioGroup")>
				<cfset sAttribute.setDefaultValue("0")>
				<cfset sAttribute.setOptionList("0^1")>
				<cfset sAttribute.setOptionLabelList("No, Don't Mix^Yes Allow Mixed Discounts")>
				<cfset sAttribute.setOrderNo(5)>
			</cfcase>			
      	<!--- Tax Rate --->
			<cfcase value="fusion_taxValue">
				<cfset sAttribute.setName("fusion_taxValue")>
				<cfset sAttribute.setLabel("Tax/VAT")>
				<cfset sAttribute.setType("selectBox")>
				<cfset sAttribute.setDefaultValue("17.5%")>
				<cfset sAttribute.setOptionList("None^0^5^9^10^15%^17.5^20^22")>
				<cfset sAttribute.setOptionLabelList("None^0^5%^9%^10%^15%^17.5%^20%^22%")>
				<cfset sAttribute.setOrderNo(6)>
			</cfcase>
			
			
			
		</cfswitch>
		<cfset sAttribute.save()>
	</cffunction>
	
	<!--- ----------------------------------------------------------------------------------------------------- --->
	
	
	
	
	
	
	<!--- ------------------------------------------------------------------------------------------------------------- --->
     <!--- The group2 --->
	<cffunction name="addExtendSet2" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="subTypeID" required="false" type="string" default="#createUUID()#">

		<cfset var newExtendSetID = createUUID()>
		<cfset var sExtendSet = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean()>
		<cfset var attName = "">

		<cfset sExtendSet.setSubTypeID(arguments.subTypeID)>
		<cfset sExtendSet.setExtendSetID(newExtendSetID)>
		<cfset sExtendSet.setName("General Product Information")>
		<cfset sExtendSet.setOrderNo(0)>
		<cfset sExtendSet.setIsActive(1)>
		<cfset sExtendSet.setSiteID(arguments.siteID)>
		<cfset sExtendSet.save()>

		<cfset checkAttributes2(arguments.siteID,arguments.subTypeID,newExtendSetID)>
	</cffunction>

	<cffunction name="checkAttributes2" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="subTypeID" type="string" required="true">
		<cfargument name="extendSetID" type="string" required="true">

		<cfset var sExtension = application.classExtensionManager.getSubTypeByID(arguments.subTypeID)>
		<cfset var sExtendSet = sExtension.loadSet( arguments.extendSetID ) />
		<cfset var qExtendAtts = sExtendSet.getAttributesQuery() />
		
		<cfloop list="fusion_code,fusion_codeManu,fusion_weight" index="attName">
			<cfquery dbtype="query" name="selectGSMExtendSetAttributes">
				SELECT
					attributeID
				FROM
					qExtendAtts
				WHERE
					name = '#attName#'
			</cfquery>

			<cfif not selectGSMExtendSetAttributes.recordCount>
				<cfset addAttribute2( arguments.siteID,attName,arguments.extendSetID )>
			</cfif>
		</cfloop>
	</cffunction>
    <!--- Set 2 --->
	<cffunction name="addAttribute2" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="useName" type="string" required="true">
		<cfargument name="extendSetID" required="true">

		<cfset var sAttribute = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean().getattributeBean()>

		<cfset sAttribute.setExtendSetID(arguments.extendSetID)>
		<cfset sAttribute.setSiteID(arguments.siteID)>

		<cfswitch expression="#arguments.useName#">
			<!--- product code --->
			<cfcase value="fusion_code">
				<cfset sAttribute.setName("fusion_code")>
				<cfset sAttribute.setLabel("Product Code")>
				<cfset sAttribute.setType("textBox")>
				<cfset sAttribute.setDefaultValue("")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(1)>
			</cfcase>
			<!--- product manufacturer --->
			<cfcase value="fusion_codeManu">
				<cfset sAttribute.setName("fusion_codeManu")>
				<cfset sAttribute.setLabel("Product Manufacturer Code")>
				<cfset sAttribute.setType("textBox")>
				<cfset sAttribute.setDefaultValue("")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(2)>
			</cfcase>

			<!--- product weight --->
			<cfcase value="fusion_weight">
				<cfset sAttribute.setName("fusion_weight")>
				<cfset sAttribute.setLabel("Product Weight (kg)")>
				<cfset sAttribute.setType("textBox")>
				<cfset sAttribute.setDefaultValue("0")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(3)>
			</cfcase>
		

			
			
			
		</cfswitch>
		<cfset sAttribute.save()>
	</cffunction>
	
	<!--- ----------------------------------------------------------------------------------------------------- --->
	
	



	
	<!--- ------------------------------------------------------------------------------------------------------------- --->
     <!--- The group3 Product Images --->
	<cffunction name="addExtendSet3" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="subTypeID" required="false" type="string" default="#createUUID()#">

		<cfset var newExtendSetID = createUUID()>
		<cfset var sExtendSet = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean()>
		<cfset var attName = "">

		<cfset sExtendSet.setSubTypeID(arguments.subTypeID)>
		<cfset sExtendSet.setExtendSetID(newExtendSetID)>
		<cfset sExtendSet.setName("Product Images")>
		<cfset sExtendSet.setOrderNo(0)>
		<cfset sExtendSet.setIsActive(1)>
		<cfset sExtendSet.setSiteID(arguments.siteID)>
		<cfset sExtendSet.save()>

		<cfset checkAttributes3(arguments.siteID,arguments.subTypeID,newExtendSetID)>
	</cffunction>

	<cffunction name="checkAttributes3" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="subTypeID" type="string" required="true">
		<cfargument name="extendSetID" type="string" required="true">

		<cfset var sExtension = application.classExtensionManager.getSubTypeByID(arguments.subTypeID)>
		<cfset var sExtendSet = sExtension.loadSet( arguments.extendSetID ) />
		<cfset var qExtendAtts = sExtendSet.getAttributesQuery() />
		
		<cfloop list="fusion_image1,fusion_image2,fusion_image3,fusion_image4" index="attName">
			<cfquery dbtype="query" name="selectGSMExtendSetAttributes">
				SELECT
					attributeID
				FROM
					qExtendAtts
				WHERE
					name = '#attName#'
			</cfquery>

			<cfif not selectGSMExtendSetAttributes.recordCount>
				<cfset addAttribute3( arguments.siteID,attName,arguments.extendSetID )>
			</cfif>
		</cfloop>
	</cffunction>
    <!--- Set 3 Images --->
	<cffunction name="addAttribute3" returntype="void" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="useName" type="string" required="true">
		<cfargument name="extendSetID" required="true">

		<cfset var sAttribute = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean().getattributeBean()>

		<cfset sAttribute.setExtendSetID(arguments.extendSetID)>
		<cfset sAttribute.setSiteID(arguments.siteID)>

		<cfswitch expression="#arguments.useName#">
			<!--- product image --->
			<cfcase value="fusion_image1">
				<cfset sAttribute.setName("fusion_image1")>
				<cfset sAttribute.setLabel("Product Image 1")>
				<cfset sAttribute.setType("file")>
				<cfset sAttribute.setDefaultValue("")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(1)>
			</cfcase>
			<!--- product image 2 --->
			<cfcase value="fusion_image2">
				<cfset sAttribute.setName("fusion_image2")>
				<cfset sAttribute.setLabel("Product Image 2")>
				<cfset sAttribute.setType("file")>
				<cfset sAttribute.setDefaultValue("")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(2)>
			</cfcase>
			<!--- product image 3 --->
			<cfcase value="fusion_image3">
				<cfset sAttribute.setName("fusion_image3")>
				<cfset sAttribute.setLabel("Product Image 3")>
				<cfset sAttribute.setType("file")>
				<cfset sAttribute.setDefaultValue("")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(3)>
			</cfcase>
			<!--- product image 4 --->
			<cfcase value="fusion_image4">
				<cfset sAttribute.setName("fusion_image4")>
				<cfset sAttribute.setLabel("Product Image 4")>
				<cfset sAttribute.setType("file")>
				<cfset sAttribute.setDefaultValue("")>
				<cfset sAttribute.setOptionList("")>
				<cfset sAttribute.setOptionLabelList("")>
				<cfset sAttribute.setOrderNo(4)>
			</cfcase>


			
			
			
		</cfswitch>
		<cfset sAttribute.save()>
	</cffunction>
	
	<!--- ----------------------------------------------------------------------------------------------------- --->
	



	
	
	
	
	
</cfcomponent>












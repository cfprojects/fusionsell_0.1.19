<!--- ok this is not really  DAO stuff here, but its late let me off  --->
<!---
	Name         : lib/cart/dao.cfm
	Author       : Glyn Jackson
	Last Updated : 3rd Dec 2010
	History      : 
	Purpose		 : 
--->
<cfcomponent output="false" name="dao" extends="mura.plugin.pluginGenericEventHandler">
	
	<cffunction name="init" access="public" output="false" returntype="Any">
		<cfreturn this />
	</cffunction>
<!--- this creates the product bean --->
	<cffunction name="getprodBean" access="public" returntype="Any">
		<cfreturn createObject("component","productBean").init()>
	</cffunction>

<!--- returns all product details based on content id --->	
		<cffunction name="getProductDetails">
		<cfargument name="contentID" required="true">
		<cfscript>
		//vars: wish i was doing this in cf9 then I could put vars anywhere!
		var contentManager = getServiceFactory().getBean('contentManager').getActiveContent('#arguments.contentID#', '#session.siteID#');
	    //create my product bean ready to set
		var productBean=getprodBean();
		
		//set name/title of the product. This uses mura page title for the product name
		productBean.setproductName(contentManager.getTitle());
		//set standard price of the product
		productBean.setproductPrice(contentManager.getExtendedAttribute("fusion_price"));
		//set rrp price of the product
		productBean.setproductRRP(contentManager.getExtendedAttribute("fusion_priceRRP"));
		//set sale price of the product
		productBean.setproductSalePrice(contentManager.getExtendedAttribute("fusion_priceSale"));		
		//set weight of the product
		productBean.setproductWeight(contentManager.getExtendedAttribute("fusion_weight"));
		//set discount % of product
		productBean.setproductDiscount(contentManager.getExtendedAttribute("fusion_productDiscount"));
		//set discount mix of product
		productBean.setproductDiscountMix(contentManager.getExtendedAttribute("fusion_productDiscountMix"));
		//set code of product
		productBean.setproductCode(contentManager.getExtendedAttribute("fusion_code"));
		//set Manufacturer/code of product
		productBean.setproductManufacturer(contentManager.getExtendedAttribute("fusion_codeManu"));
		
		//return product bean
		return productBean;	
		</cfscript>
	
	</cffunction>
</cfcomponent>
























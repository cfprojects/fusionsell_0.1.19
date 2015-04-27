<cfcomponent output="false" name="productBean" hint="">
	
	<cfscript>
	 variables.instance.productName="";
	 variables.instance.productPrice="";
	 variables.instance.productRRP="";
	 variables.instance.productSalePrice="";
	 variables.instance.productDiscount="";
	 variables.instance.productDiscountMix="";
	 variables.instance.productCode="";
	 variables.instance.productManufacturer="";
	 variables.instance.productWeight="";
	 variables.instance.productQty="";

	</cfscript>
	

	

	
	<cffunction name="init" access="public" output="false" returntype="Any">
		<cfreturn this />
	</cffunction>
	
	<!--- productName --->
	<cffunction name="getproductName" returntype="string" access="public" output="false" hint="">
    	<cfreturn variables.instance.productName />
    </cffunction>
    <cffunction name="setproductName" access="public" output="false" hint="">
    	<cfargument name="productName" type="string" required="true" />
    	<cfset variables.instance.productName = trim(arguments.productName) />
    </cffunction>
	<!--- productPrice --->
	<cffunction name="getproductPrice" returntype="string" access="public" output="false" hint="">
    	<cfreturn variables.instance.productPrice />
    </cffunction>
    <cffunction name="setproductPrice" access="public" output="false" hint="">
    	<cfargument name="productPrice" type="numeric"  required="true" />
    	<cfset variables.instance.productPrice = trim(arguments.productPrice) />
    </cffunction>
	<!--- productRRP --->
	<cffunction name="getproductRRP" returntype="numeric" access="public" output="false" hint="">
    	<cfreturn variables.instance.productRRP />
    </cffunction>
    <cffunction name="setproductRRP" access="public" output="false" hint="">
    	<cfargument name="productRRP" type="numeric"  required="true" />
    	<cfset variables.instance.productRRP = trim(arguments.productRRP) />
    </cffunction>    
	<!--- productSalePrice --->
	<cffunction name="getproductSalePrice" returntype="numeric" access="public" output="false" hint="">
    	<cfreturn variables.instance.productSalePrice />
    </cffunction>
    <cffunction name="setproductSalePrice" access="public" output="false" hint="">
    	<cfargument name="productSalePrice" type="numeric"  required="true" />
    	<cfset variables.instance.productSalePrice = trim(arguments.productSalePrice) />
    </cffunction>   
	<!--- productDiscount --->
	<cffunction name="getproductDiscount" returntype="numeric" access="public" output="false" hint="">
    	<cfreturn variables.instance.productDiscount />
    </cffunction>
    <cffunction name="setproductDiscount" access="public" output="false" hint="">
    	<cfargument name="productDiscount" type="numeric"  required="true" />
    	<cfset variables.instance.productDiscount = trim(arguments.productDiscount) />
    </cffunction>      
	<!--- productDiscountMix --->
	<cffunction name="getproductDiscountMix" returntype="boolean" access="public" output="false" hint="">
    	<cfreturn variables.instance.productDiscountMix />
    </cffunction>
    <cffunction name="setproductDiscountMix" access="public" output="false" hint="">
    	<cfargument name="productDiscountMix" type="boolean"  required="true" />
    	<cfset variables.instance.productDiscountMix = trim(arguments.productDiscountMix) />
    </cffunction> 
	<!--- productCode --->
	<cffunction name="getproductCode" returntype="string" access="public" output="false" hint="">
    	<cfreturn variables.instance.productCode />
    </cffunction>
    <cffunction name="setproductCode" access="public"  output="false" hint="">
    	<cfargument name="productCode" type="string"  required="true" />
    	<cfset variables.instance.productCode = trim(arguments.productCode) />
    </cffunction>
	<!--- productManufacturer --->
	<cffunction name="getproductManufacturer" returntype="string" access="public" output="false" hint="">
    	<cfreturn variables.instance.productManufacturer />
    </cffunction>
    <cffunction name="setproductManufacturer" access="public" output="false" hint="">
    	<cfargument name="productManufacturer" type="string"  required="true" />
    	<cfset variables.instance.productManufacturer = trim(arguments.productManufacturer) />
    </cffunction> 	
	<!--- productWeight --->
	<cffunction name="getproductWeight" returntype="numeric" access="public" output="false" hint="">
    	<cfreturn variables.instance.productWeight />
    </cffunction>
    <cffunction name="setproductWeight" access="public" output="false" hint="">
    	<cfargument name="productWeight" type="numeric"  required="true" />
    	<cfset variables.instance.productWeight = trim(arguments.productWeight) />
    </cffunction> 
		<!--- productqty --->
	<cffunction name="getproductqty" returntype="numeric" access="public" output="false" hint="">
    	<cfreturn variables.instance.productqty />
    </cffunction>
    <cffunction name="setproductqty" access="public" output="false" hint="">
    	<cfargument name="productqty" type="numeric"  required="true" />
    	<cfset variables.instance.productqty = trim(arguments.productqty) />
    </cffunction> 		
		
	<!--- get debug info --->
	<cffunction name="getDebug" returnType="any" output="false">
		<cfreturn variables />
	</cffunction>
</cfcomponent>














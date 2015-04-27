<cfcomponent output="false" name="service" hint="">
	
	<cffunction name="init" returntype="any" output="false" access="public">
		<cfargument name="cartDAO" type="any" required="yes"/>
		<cfset variables.cartDAO=arguments.cartDAO />
		<cfreturn this />
	</cffunction>

<!--- remove an item from the cart --->
	<cffunction name="removeUpdateItem" returntype="any" output="false" access="public">
	    <cfargument name="removeID" required="true">
	    
	    <cfscript>
	     var results = "";
		 try
         {
         	structdelete(session['cartItem'],"#arguments.removeID#");
			results = "Item removed";
         }
         catch(Any e)
         {
		  results = "Error, could not remove item";
         }
			return results;
	    </cfscript>
	</cffunction>
	
<!--- add or update cart with an item --->
	<cffunction name="addUpdateItem" returntype="any" output="false" access="public">
	    <cfargument name="contentID" required="true">
		<cfargument name="qty" required="true" type="numeric" >
		<cfargument name="itemNode" required="true">
	
		<cfscript>
		//vars: if I was doing this in cf9 I could put vars anywhere!
		var productBean = "";
		var results = structnew();
		//return product details from the content id: I always do this NEVER rely on the session for payment!
		productBean = variables.cartDAO.getProductDetails(contentID=#arguments.contentID#);
		//check if we have a cart session started, if not this function starts one
		startCartSession();
		//add item to cart
		results.itemNode = addProductItem(productBean=#productBean#,contentID=#contentID#,qty=#qty#,itemNode=#itemNode#);
		//message
		results.message = "Item added.";
		//return results 
		return results;
		</cfscript>
	</cffunction>
	
	<!--- get an item by content ID work out total cost also based on dicounts, tax and qty --->
	<cffunction name="getItem" returntype="Struct"  output="false" access="public">
	    <cfargument name="contentID" required="true">
	    <cfargument name="qty" required="true" type="1000">
		<cfscript>
		var productBean = "";
		var sumCost = "";
		var hasSale = "";
		var results = structnew();
		
		//return product details from the content id: I always do this NEVER on the session!
		results.productBean = variables.cartDAO.getProductDetails(contentID=#arguments.contentID#);
		
		if (results.productBean.getproductSalePrice() gt 0.00){
		  results.sumCost = results.productBean.getproductSalePrice();
		  results.hasSale = true;
		}
		else {
		 results.sumCost = results.productBean.getproductPrice();
		 results.hasSale = false;
		}
		results.sumCost = results.sumCost * arguments.qty;
		
			
			
		//return results 
		return results;
		</cfscript>
	</cffunction>
	


<!--- gets cart totals for display --->
	<cffunction name="getTotals" returntype="any" output="false" access="public">
	    <cfargument name="getwhat" required="true">
		<cfscript>
		//vars: if I was doing this in cf9 I could put vars anywhere!
		var results = "";
	    //check if we have a cart session started, if not this function starts one
		startCartSession();
		//what do we want to find out?
		    switch(arguments.getwhat)
		     {
		          case "items":
		          {
		               results = getCartItemTotal();
		               break;
		          }
				   case "carttotal":
		          {
		               results = getCartTotal();
		               break;
		          }
		          default:
		          {
				       results = "No match on " & arguments.getwhat;
		               break;
		          }
		     }


		//return results 
		return results;
		</cfscript>
	</cffunction>


<!--- function checks to see if cart sessions has exisit, if not it starts one --->
<cffunction name="startCartSession" returntype="any" output="false" access="private"  >
  <cfif not structkeyexists(session,"cartItem")>
    <cflock timeout="60" type="exclusive">
      <cfset session['cartItem'] = structnew()>
    </cflock>
  </cfif>
</cffunction>

<!--- add item to cart --->
<cffunction name="addProductItem" returntype="any" output="false" access="private">
<cfargument name="productBean" required="true">
<cfargument name="contentID" required="true">
<cfargument name="itemNode" required="yes">
<cfargument name="qty" required="true">

<cfscript>
if (arguments.itemNode eq 0){
//create default node for product id
 arguments.itemNode = "pCode_" & RAND() & timeFormat(Now(),'hhmmss') & dateFormat(Now(),'ddmmyy');
}
//if no node exists for the given product, create it.
if (not structkeyexists(session['cartItem'],arguments.itemNode)){
	 //define new node as a struct
      session['cartItem'][itemNode] = structnew();
      session['cartItem'][itemNode]['qty'] = arguments.qty;
	  //grab the product info from the bean
	  session['cartItem'][itemNode]['productCode'] = productBean.getproductCode();
      session['cartItem'][itemNode]['productName'] = productBean.getproductName();
      session['cartItem'][itemNode]['prodId'] = arguments.contentID;
	  session['cartItem'][itemNode]['productPrice'] = productBean.getproductPrice();
	  session['cartItem'][itemNode]['productSalePrice'] = productBean.getproductSalePrice();
	  session['cartItem'][itemNode]['productDiscount'] = productBean.getproductDiscount();
	  session['cartItem'][itemNode]['productDiscountMix'] = productBean.getproductDiscountMix();
	  session['cartItem'][itemNode]['productWeight'] = productBean.getproductWeight();
	  //does the item have options?
	  //not done yet!

}
//we must be updating the item here then....
else if (structkeyexists(session['cartItem'],itemNode)) {
   session['cartItem'][itemNode]['qty'] = arguments.qty ;
}
return itemNode;
</cfscript>  
</cffunction>

<!--- get cart totals item--->
<cffunction name="getCartItemTotal" returntype="Numeric" output="false" access="private">
<cfscript>
  var keyList = structkeylist(session['cartItem']);
  var itemCount = "";
  itemCount = structCount(session['cartItem']);
  return itemCount;
</cfscript>
</cffunction>



<!--- get cart total cost--->
<cffunction name="getCartTotal" returntype="any" output="false" access="private">
<cfset var keyList = structkeylist(session['cartItem'])>
<cfset var subtotal = 0>
<cfset var totalOutput = 0>
<cfset var grandTotal = 0>
      <cfloop from="1" to="#listlen(keyList)#" index="y">
        <cfset currentListItemDsp = session['cartItem'][listgetat(keyList,y)]>
        <cfif currentListItemDsp['productPrice'] gt 0 and currentListItemDsp['qty'] gt 0>
          <cfset totalOutput = currentListItemDsp['productPrice'] * currentListItemDsp['qty']>
          <cfelse>
          <cfset totalOutput = "0">
        </cfif>
 <cfset subtotal = subtotal + totalOutput>		
</cfloop>
<cfset itemCount = #listlen(keyList)#>
<cfset grandTotal = subtotal>
<cfreturn grandTotal>
</cffunction>



</cfcomponent>















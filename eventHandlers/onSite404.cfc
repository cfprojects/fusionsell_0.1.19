<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

<cffunction name="onSite404" output="true">
	<cfargument name="$">
     <cfscript>
       if ($.event("currentFilename") eq "renderViewCart"){
	   $.content("isNew",0);
	   $.content("title","View Trolley");
	   $.content("htmlTitle","View Your Items");

	   //The type and subtype are to target the body rendering method.
	   //You can also explicitly set the body at this point without the cutsom body rendering method.
	   $.content("type","Page");
	   $.content("subtype","ViewCart");
	    //You can also start a new display object cascade to that it does not inherit object from the home page
	   $.content("inheritObjects","Inherit");
	   }//end of view cart check 
	   
	   
	   
	  else if ($.event("currentFilename") eq "renderCheckout"){
		   $.content("isNew",0);
		   $.content("Restricted",1);
		   $.content("title","Checkout");
		   $.content("htmlTitle","Checkout");
		   $.content("type","Page");
		   $.content("subtype","Checkout");
		   $.content("inheritObjects","Inherit");
	   }
	   
	   else if ($.event("currentFilename") eq "renderStatus"){
		   $.content("isNew",0);
		   $.content("Restricted",1);
		   $.content("title","Order Status");
		   $.content("htmlTitle","Order Status");
		   $.content("type","Page");
		   $.content("subtype","OrderStatus");
		   $.content("inheritObjects","Inherit");
	   }
	   
	   
	   
	 </cfscript>
	 <cfoutput>
</cfoutput>
	 


</cffunction>


</cfcomponent>



















<!---
	Name         : displayObjects/productImages.cfm
	Author       : Glyn Jackson
	Last Updated : 30 Nov 2010
	History      : 
	Purpose		 : Display object for product images
--->
<!--- only show if this page has product values, otherwise we will get some nasty errors --->
<cfif len($.content('fusion_price')) neq 0 >
	<cfoutput>
		<div id="prod_image">
		<div id="prod_imageMain">
		<cfif len(Trim($.content().getFileID()))><a href="#$.createHREF(filename='')#cache/file/#$.content('fusion_image1')#.jpg" rel="shadowbox[Prodbody]" id="fusion_image"><img alt="#$.content().getMenuTitle()#" src="#$.createHREF(filename='')#cache/file/#$.content().getFileID()#_medium.#$.content().getFileEXT()#"/>
		</a>
		<cfelse>
		<div class="NoImage">&nbsp;</div>
		</cfif>
		</div>
		<div id="prod_adImage"><cfif len(Trim($.content("fusion_image1")))  gt 0>
		<a href="#$.createHREF(filename='')#cache/file/#$.content('fusion_image1')#.jpg" rel="shadowbox[Prodbody]" id="fusion_image"><img src="#$.createHREF(filename='')#cache/file/#$.content('fusion_image1')#_small.jpg"></a>
		</cfif>
		<cfif len(Trim($.content("fusion_image2")))  gt 0>
		<a href="#$.createHREF(filename='')#cache/file/#$.content('fusion_image2')#.jpg" rel="shadowbox[Prodbody]" id="fusion_image"><img src="#$.createHREF(filename='')#cache/file/#$.content('fusion_image2')#_small.jpg"></a>
		</cfif>
		<cfif len(Trim($.content("fusion_image3")))  gt 0>
		<a href="#$.createHREF(filename='')#cache/file/#$.content('fusion_image3')#.jpg" rel="shadowbox[Prodbody]" id="fusion_image"><img src="#$.createHREF(filename='')#cache/file/#$.content('fusion_image3')#_small.jpg"></a>
		</cfif>
		<cfif len(Trim($.content("fusion_image4"))) gt 0>
		<a href="#$.createHREF(filename='')#cache/file/#$.content('fusion_image4')#.jpg" rel="shadowbox[Prodbody]" id="fusion_image"><img src="#$.createHREF(filename='')#cache/file/#$.content('fusion_image4')#_small.jpg"></a>
		</cfif></div>
		</div>
	</cfoutput>
</cfif>
<nav class="${nav_css_class} navbar navbar-expand-sm navbar-background-color custom-navbar" id="navigation" role="navigation">
<div class="container">
	<h1 class="hide-accessible"><@liferay.language key="navigation" /></h1>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

<div class="collapse navbar-collapse" id="navbarSupportedContent">

	<ul aria-label="<@liferay.language key="site-pages" />" role="menubar" class="navbar-nav mr-auto">
		<#list nav_items as nav_item>
			<#assign
				nav_item_attr_has_popup = ""
				nav_item_css_class = "parent-nav"
				nav_item_layout = nav_item.getLayout()
			/>

			<#if nav_item.isSelected()>
				<#assign
					nav_item_attr_has_popup = "aria-haspopup='true'"
					nav_item_css_class = "selected"
				/>
			</#if>

			<li class="${nav_item_css_class} px-2" id="layout_${nav_item.getLayoutId()}" role="presentation">
				
				<#if nav_item.hasChildren()>
					<a aria-labelledby="layout_${nav_item.getLayoutId()}" ${nav_item_attr_has_popup} href="javascript:void(0)" ${nav_item.getTarget()} role="menuitem" class="nav-link text-white"><span><@liferay_theme["layout-icon"] layout=nav_item_layout /> ${nav_item.getName()}</span></a>
				<#else>
					<a aria-labelledby="layout_${nav_item.getLayoutId()}" ${nav_item_attr_has_popup} href="${nav_item.getURL()}" ${nav_item.getTarget()} role="menuitem" class="nav-link text-white"><span><@liferay_theme["layout-icon"] layout=nav_item_layout /> ${nav_item.getName()}</span></a>
				</#if>
				
				

				<#if nav_item.hasChildren()>
					<ul class="child-menu" role="menu">
						<#list nav_item.getChildren() as nav_child>
							<#assign
								nav_child_css_class = ""
							/>

							<#if nav_item.isSelected()>
								<#assign
									nav_child_css_class = ""
								/>
							</#if>

							<li class="${nav_child_css_class}" id="layout_${nav_child.getLayoutId()}" role="presentation">
								<a aria-labelledby="layout_${nav_child.getLayoutId()}" href="${nav_child.getURL()}" ${nav_child.getTarget()} role="menuitem">${nav_child.getName()}</a>
							</li>
						</#list>
					</ul>
				</#if>
			</li>
		</#list>
	</ul>
	</div>
	</div>
</nav>


<script>

// sticky menu
var header = $('.custom-navbar');
var win = $(window);
win.on('scroll',function(){setHeaderPostion();});
function setHeaderPostion(){
    var scroll = win.scrollTop();
	    if (scroll < 150) {
	    	header.removeClass("sticky-fixed-top");
	        
	    } else {
	    	header.addClass("sticky-fixed-top");
	    }
	
}

$(document).ready(function(){
setHeaderPostion();
});

</script>




<!DOCTYPE html>

<#include init />

<html class="${root_css_class}" dir="<@liferay.language key="lang.dir" />" lang="${w3c_language_id}">

<head>
	<title>${the_title} - ${company_name}</title>

	<meta content="initial-scale=1.0, width=device-width" name="viewport" />

	<@liferay_util["include"] page=top_head_include />
	
	<link rel="stylesheet" href="${css_folder}/owl-carousel/owl.carousel.min.css">
	
	<link rel="stylesheet" href="${css_folder}/font-awesome/all.css">
	
	<link rel="stylesheet" href="${css_folder}/owl-carousel/owl.theme.default.min.css">
	
	<script src="${javascript_folder}/owl-carousel/owl.carousel.min.js"></script>
	
	<script src="${javascript_folder}/owl-carousel/owl.carousel.js"></script>
</head>

<body class="${css_class}">

<@liferay_ui["quick-access"] contentId="#main-content" />

<@liferay_util["include"] page=body_top_include />

<@liferay.control_menu />

<div class="pt-0" id="wrapper">
	<header role="banner">
	<#include "${full_templates_path}/outer-top-header.ftl" />
		  <#include "${full_templates_path}/top-header.ftl" />
			<#include "${full_templates_path}/navigation.ftl" />
		
		
	</header>

	<section id="content" class="container-fluid">
	
		<#if selectable>
			<@liferay_util["include"] page=content_include />
		<#else>
			${portletDisplay.recycle()}

			${portletDisplay.setTitle(the_title)}

			<@liferay_theme["wrap-portlet"] page="portlet.ftl">
				<@liferay_util["include"] page=content_include />
			</@>
		</#if>
	</section>
	<#include "${full_templates_path}/footer.ftl" />

</div>

<@liferay_util["include"] page=body_bottom_include />

<@liferay_util["include"] page=bottom_include />

</body>

</html>
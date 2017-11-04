<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<style>
			.menu_title{
				color:#006DA5;
				font-weight:bold;
			}
		</style>
	</head>
	<body class="lbody">
	<table width="100%" cellpadding="2" cellspacing="10" border="0">
		<tr>
			<td>
			<script type="text/javascript">
				d = new dTree('d');
				d.add(0,-1,"<font class='menu_title'>功能菜单</font> (<a href=\"javascript:location.reload();\">点击刷新</a>)");
				<c:forEach items="${list}" var="module">
					d.add(${module.id},${module.parent==null?0:module.parent.id},"${module.name}","<c:if test="${module.url!=''}">${basePath}${module.url}?mid=${module.id}</c:if>","","rightFrame");
				</c:forEach>
				d.config.closeSameLevel = true;
				document.write(d);
				//d.closeAll();
			</script>
			</td>
		</tr>
	</table>
	</body>
</html>
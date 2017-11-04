<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<html>
	<head>
		<title>智慧车管综合服务平台</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script language="javascript">
			function reload(){
				window.location.reload();
			}
		</script>
	</head>
	<frameset rows="93,*,0" cols="*" frameborder="no" frameborder="0" border="0" framespacing="0">
		<frame src="${basePath}/sys_top.do" name="topFrame" scrolling="NO" noresize border="0" frameborder="no" framespacing="0">
		<frameset id="mainFrame" cols="170,90,*" border="0" framespacing="0" rows="*">
			<frame name="leftFrame" scrolling="auto" noresize src="${basePath}/sys_left.do">
			<frame id="middleFrame" name="midFrame" scrolling="no" noresize src="${basePath}/sys_middle.do">
			<frame name="rightFrame" scrolling="auto" noresize src="${basePath}/sys_right.do">
		</frameset>
	</frameset>
</html>
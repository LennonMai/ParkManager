<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<html>
<head>
	<title>top</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		
	<script type="text/javascript">
		function check() {
			if(confirm("�Ƿ�Ҫ���µ�¼��")==true) {
				return true;
			}
			return false;
		}
	</script>
</head>
<body>
	<div id="top">
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td width="456"><img src="${basePath}/image/top_01.jpg" border="0" /></td>
				<td width="100%" background="${basePath}/image/menu_back.jpg"></td>
				<td width="57"><a href="sys_right.do" target="rightFrame"><img src="${basePath}/image/top_03.jpg" border="0"/></a></td>
				<td width="80"><a href="admin_info.do" target="rightFrame">
					<img src="${basePath}/image/top_04.jpg" border="0"/></a></td>
				<td width="82"><a href="download.do" target="rightFrame"><img src="${basePath}/image/top_05.jpg" border="0"/></a></td>
				<td width="82"><a href="admin_logout.do" target="rightFrame" onclick="return check();" ><img src="${basePath}/image/top_06.jpg" border="0"/></a></td>
			</tr>
		</table>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td background="${basePath}/image/msg_bg.jpg"><span style="color:#006DA5">&nbsp;&nbsp;����, ${session.operator.name}</span></td>
				<td width="73" align="center" background="${basePath}/image/msg_bg.jpg"></td>
				<td width="28" background="${basePath}/image/msg_bg.jpg">
				<img src="${basePath}/image/tleft.jpg" width="28" height="26" border="0"/></td>
				<td width="140" align="center" background="${basePath}/image/tbg.jpg">
					<script language="JavaScript" type="text/javascript">
						var enabled = 0; today = new Date();
						var day; var date;
						if(today.getDay()==0) day = " ������"
						if(today.getDay()==1) day = " ����һ"
						if(today.getDay()==2) day = " ���ڶ�"
						if(today.getDay()==3) day = " ������"
						if(today.getDay()==4) day = " ������"
						if(today.getDay()==5) day = " ������"
						if(today.getDay()==6) day = " ������"
						date = (today.getFullYear()) + "��" + (today.getMonth() + 1 ) + "��" + today.getDate() + "��" + day +"";
						document.write(date);
					</script></td>
			</tr>
		</table>
		<div style="border-top:1px solid #1879B0;"></div>
		</div>
	</body>
</html>
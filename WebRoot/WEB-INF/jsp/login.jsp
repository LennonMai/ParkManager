<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gbk" language="java" pageEncoding="gbk"%>
<html>
	<head>
	<title>�û���½</title>
			<script type="text/javascript" src="${basePath}/js/util.js"></script>
	<style type="text/css">
	body {
		margin: 0;
		padding: 0;
		font-size: 12px;
		background-color: #eeeeee;
	}
	.input {
		BORDER: #cccccc 1px solid;
		height: 16px;
		width: 150px;
	}
	</style>
	<script type="text/javascript">
	if("${result}"=="RELOAD"){
		try{
			parent.reload();
		}catch(e){
		}
	}
	window.onload = function() {
		get("admin.username").focus();
	}
	function check(){
		if(get("admin.username").value==""){
			alert("�����������û�����");
			get("admin.username").focus();
			return false;
		}
		if(get("admin.password").value==""){
			alert("�������������룡");
			get("admin.password").focus();
			return false;
		}
		/* if(get("checkCode").value==""){
			alert("��������֤�룡");
			get("checkCode").focus();
			return false;
		}
		if(get("checkCode").value.length!=4){
			alert("��������ȷ����֤�룡");
			get("checkCode").focus();
			return false;
		} */
		return true;
	}
	function reload(obj){
		obj.src = "randomCode.do?time="+new Date().getTime();
	}
	</script>
	</head>
	<body>
	<table width="478" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-top: 10%;">
		<form name="loginForm" action="login.do" method="post" onsubmit="return check()">
		<tr>
			<td width="478" height="296" background="${basePath}/image/login.jpg">
				<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="15%" rowspan="2">&nbsp;</td>
						<td width="85%" height="205" valign="bottom">
							<table width="295" border="0" cellspacing="6" cellpadding="0">
								<tr valign="bottom">
									<td colspan="3" align="center"><font color="red">${message}</font></td>
								</tr>
								<tr valign="bottom">
									<td width="75">&nbsp;</td>
									<td height="25" colspan="2">
										<input type="text" class="input" name="admin.username" onfocus="this.select();" value=""/>
									</td>
								</tr>
								<tr valign="bottom">
									<td>&nbsp;</td>
									<td height="25" colspan="2">
										<input type="password" class="input" name="admin.password" onfocus="this.select();" value=""/>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td height="25" valign="bottom">
										<!-- <input type="text" name="checkCode" class="input" style="width: 100px" /> -->
									</td>
									<td width="100" valign="bottom" align="left">
										<%-- <img title="����������ͼƬ" width="50" height="20" src="${basePath}/randomCode.do" 
										onclick="reload(this);" style="cursor: pointer" /> --%>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td valign="top" height="91">
							<table width="60%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr>
									<td width="43%" align="right"><input type="image" src="${basePath}/image/l.jpg"></td>
									<td width="16%">&nbsp;</td>
									<td width="41%"><input type="image" src="${basePath}/image/r.jpg" onclick="reset();return false">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		</form>
	</table>
	</body>
</html>
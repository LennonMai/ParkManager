<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title></title>
		<%@include file="../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript">
			function Len(str) {	//计算输入字符长度
                var i,sum;
                sum=0;
                for(i=0;i<str.length;i++) {
                	if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255)) {
                		sum=sum+1;
                	} else {
                		sum=sum+2;
                	}
                }
                return sum;
            }
			function check(){
				if(document.getElementById('callNum').value==""){
					$("#tishiCallNum").empty();
					$("#tishiCallNum").append("联系电话不能为空");
					document.getElementById('callNum').focus();
					return false;
				}else{
					$("#tishiCallNum").empty();
				}
				if(Len(document.getElementById('callNum').value)!=11){
					$("#tishiCallNum").empty();
					$("#tishiCallNum").append("联系电话为是11位数字");
					document.getElementById('callNum').focus();
					return false;
				}else{
					$("#tishiCallNum").empty();
				}
				var value = document.getElementById('callNum').value;     
     			if(/^[1,9]\d{10}$/g.test(value)){   
             		$("#tishiCallNum").empty();     
     			}else{
     				$("#tishiCallNum").empty(); 
     				$("#tishiCallNum").append("请输入11位数字（不能以0开头）.");
					document.getElementById('callNum').focus();
            		return false;   
     			}
				if(document.getElementById('password').value==""){
					$("#tishiPassword").empty();
					$("#tishiPassword").append("密码不能为空");
					document.getElementById('password').focus();
					return false;
				}else{
					$("#tishiPassword").empty();
				}
				if(document.getElementById('password').value != document.getElementById('password1').value){
					$("#tishiPassword1").empty();
					$("#tishiPassword1").append("两次密码不一样");
					document.getElementById('password').value="";
					document.getElementById('password1').value="";
					document.getElementById('password').focus();
					return false;
				}else{
					$("#tishiPassword1").empty();
				}
				var password = document.getElementById('password').value;
				if(Len(password)<6){
					$("#tishiPassword").empty();
					$("#tishiPassword").append("密码太短，密码为在6-16位");
					return false;
				}else{
					$("#tishiPassword").empty();
				}
				if(Len(password)>16){
					$("#tishiPassword").empty();
					$("#tishiPassword").append("密码太长，密码为在6-16位");
					return false;
				}else{
					$("#tishiPassword").empty();
				}
				return true;
			}
			function back(id,count){
				window.location.href = "securityUserInfo_querySecurityUserInfo.do?pager.currentPage="+id+"&pager.pageSize="+count;
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" 返 回 " onclick="back('${pager.currentPage }','${pager.pageSize }');"/>
				</form>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="securityUserInfo_register.do" onsubmit="return check();">
				<table width="800" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">卡表面号：</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="cardNo" size="20" value="${cardNo }" readonly="readonly"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">联系电话：</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="callNum" id="callNum" size="20"/>&nbsp;
							<font style="color:red">* &nbsp;<label id="tishiCallNum"></label></font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">安全密码：</td>
						<td width="80%" class="pn-fcontent"><input type="password" name="password" id="password" size="21" value="000000"/>&nbsp;
							<font style="color:red">* &nbsp;<label id="tishiPassword"></label></font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">重复密码：</td>
						<td width="80%" class="pn-fcontent"><input type="password" name="password1" id="password1" size="21" value="000000"/>&nbsp;
							<font style="color:red">* &nbsp;<label id="tishiPassword1"></label></font></td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fcontent">
							<font color="red">&nbsp;&nbsp;&nbsp;&nbsp;备注：初始密码为6个0</font>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/> &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" 重 置 "/></td>
						<input type="hidden" name="pager.currentPage" value="${pager.currentPage }" />
						<input type="hidden" name="pager.pageSize" value="${pager.pageSize }" />
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
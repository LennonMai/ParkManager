<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript">
			if("${result}" == "FAIL") {
				alert("���û��Ѿ�����");
			}
			function Len(str) {	//���������ַ�����
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
				if(get("admin.username").value==""){
					alert("��¼������Ϊ�գ�����������");
					get("admin.username").focus();
					return false;
				}
				if(Len(document.getElementsByName("admin.username")[0].value) > 20) {
					alert("��¼�����Ȳ��ܴ���20������������");
					get("admin.username").focus();
					return false;
				}
				if(get("admin.name").value==""){
					alert("��ʵ��������Ϊ�գ�����������");
					get("admin.name").focus();
					return false;
				}
				if(Len(document.getElementsByName("admin.name")[0].value) > 20) {
					alert("��ʵ�������Ȳ��ܴ���20������������");
					get("admin.name").focus();
					return false;
				}
				if(get("admin.password").value==""){
					alert("���벻��Ϊ�գ�����������");
					get("admin.password").focus();
					return false;
				}
				if(Len(document.getElementsByName("admin.password")[0].value) > 32) {
					alert("���볤�Ȳ��ܴ���32������������");
					get("admin.password").focus();
					return false;
				}
				if(get("admin.password").value!=null&&get("admin.password").value!=get("admin.password2").value){
					alert("�����������벻һ�£�����������");
					get("admin.password").focus();
					return false;
				}
	            //���������֤
	            if(get("admin.email").value != "") {
		            var myreg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		            //var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		            var temp = document.getElementsByName("admin.email")[0];
		            if(Len(document.getElementsByName("admin.email")[0].value) > 50) {
						alert("���䳤�Ȳ��ܴ���50������������");
						get("admin.email").focus();
						return false;
					}
		            if(!myreg.test(temp.value)) {
			            alert("��������Ч������");
			            get("admin.email").focus();
			            return false;
		            }
				}
				//�Ե绰�������֤
				if(get("admin.phone").value != "") {
					/*var phone =/^\d+$/;
					var temp = document.getElementsByName("admin.phone")[0];
					if(!phone.test(temp.value)) {
			            alert("��������Ч�ĵ绰");
			            get("admin.phone").focus();
			            return false;
		            }*/
		            if(Len(document.getElementsByName("admin.phone")[0].value) > 20) {
						alert("�绰���Ȳ��ܴ���20������������");
						get("admin.phone").focus();
						return false;
					}
		        }
		        return true;
			}
			function getAdminByUsername() {	//jquery��֤�û���¼���Ƿ����
				var adminName = document.getElementsByName("admin.username")[0].value;
				jQuery.post("admin_getAdminByUsername.do?admin.username="+adminName, function(data) {
					if(data == "fail") {
						alert("���û��Ѿ�����");
					}
				});
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" �� �� " onclick="history.back();"/>
				</form>
				<div class="clear"></div>
			</div>
			<form method="post" action="admin_save.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;¼&nbsp;����</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="admin.username" size="20" onblur="getAdminByUsername();"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��ʵ������</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="admin.name" size="20"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">�û���ɫ��</td>
						<td width="80%" class="pn-fcontent">
							<c:forEach items="${roleList}" var="item">
							<input type="checkbox" name="roles" value="${item.id}" />${item.name}
						</c:forEach>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�룺</td>
						<td width="80%" class="pn-fcontent"><input type="password" name="admin.password" class="required" size="32"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">�ظ����룺</td>
						<td width="80%" class="pn-fcontent"><input type="password" name="admin.password2" size="32"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td width="80%" class="pn-fcontent">
							<input type="radio" name="admin.sex" value="��" checked/>��
						<input type="radio" name="admin.sex" value="Ů"/>Ů</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�䣺</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="admin.email" size="50"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="admin.phone" size="20"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">�Ƿ���ã�</td>
						<td width="80%" class="pn-fcontent">
							<input type="radio" name="admin.valid" value="1" checked/>��
						<input type="radio" name="admin.valid" value="0"/>��</td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="submit" value=" �� �� "/> &nbsp;
						<input type="reset" value=" �� �� "/></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
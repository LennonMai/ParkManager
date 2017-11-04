<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
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
					alert("��½������Ϊ�գ�����������");
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
		            var temp = document.getElementsByName("admin.email")[0];
		            if(!myreg.test(temp.value)) {
			            alert("��������Ч������");
			            get("admin.email").focus();
			            return false;
		            }
		            if(Len(document.getElementsByName("admin.email")[0].value) > 50) {
						alert("���䳤�Ȳ��ܴ���50������������");
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
			<form method="post" action="admin_update.do?adminUsername=${admin.username }" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;¼&nbsp;����</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="admin.username" value="${admin.username}" size="20"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��ʵ������</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="admin.name" value="${admin.name}" size="20"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">�û���ɫ��</td>
						<td width="80%" class="pn-fcontent">
						<c:forEach items="${roleList}" var="item">
							<input type="checkbox" name="roles" value="${item.id}"
							<c:forEach items="${admin.roles}" var="role">
								<c:if test="${role.id==item.id}">checked</c:if> 
							</c:forEach>/>${item.name}
						</c:forEach>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�룺</td>
						<td width="80%" class="pn-fcontent"><input type="password" name="admin.password" class="required" size="32"/>���������򱣳�ԭ���벻�䣩</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">�ظ����룺</td>
						<td width="80%" class="pn-fcontent"><input type="password" name="admin.password2"/ size="32"></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td width="80%" class="pn-fcontent">
							<input type="radio" name="admin.sex" value="��" checked/>��
							<input type="radio" name="admin.sex" value="Ů" <c:if test="${admin.sex=='Ů'}">checked</c:if>/>Ů</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�䣺</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="admin.email" value="${admin.email}" size="50"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="admin.phone" value="${admin.phone}" size="20"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">�Ƿ���ã�</td>
						<td width="80%" class="pn-fcontent">
							<input type="radio" name="admin.valid" value="1" checked/>��
							<input type="radio" name="admin.valid" value="0" <c:if test="${admin.valid!='1'}">checked</c:if>/>��</td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="hidden" name="admin.id" value="${admin.id}"/>
							<input type="hidden" name="admin.createTime" value="${admin.createTime}"/>
							<input type="hidden" name="admin.lastIp" value="${admin.lastIp}"/>
							<input type="hidden" name="admin.lastTime" value="${admin.lastTime}"/>
							<input type="submit" value=" �� �� "/> &nbsp;
							<input type="reset" value=" �� �� "/></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
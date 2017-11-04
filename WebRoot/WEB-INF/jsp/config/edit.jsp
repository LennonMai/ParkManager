<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript">
			if("${result}"=="SUCCESS")
				alert("�����ɹ�");
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
				if($("config.siteName").value==""){
					alert("��վ���Ʋ���Ϊ��");
					$("config.siteName").focus();
					return false;
				}
				if($("config.propertyName").value==""){
					alert("��ҵ���Ʋ���Ϊ��");
					$("config.propertyName").focus();
					return false;
				}
				if(Len(document.getElementsByName("config.siteName")[0].value) > 100) {
					alert("��վ���ⳤ�Ȳ��ܴ���100������������");
					$("config.siteName").focus();
					return false;
				}
				if(Len(document.getElementsByName("config.propertyName")[0].value) > 50) {
					alert("��ҵ���Ƴ��Ȳ��ܴ���50������������");
					$("config.propertyName").focus();
					return false;
				}
				if(Len(document.getElementsByName("config.company")[0].value) > 200) {
					alert("��˾���Ƴ��Ȳ��ܴ���200������������");
					$("config.company").focus();
					return false;
				}
				//���������֤
	            if($("config.email").value != "") {
		            var myreg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		            var temp = document.getElementsByName("config.email")[0];
		            if(Len(document.getElementsByName("config.email")[0].value) > 100) {
						alert("���䳤�Ȳ��ܴ���100������������");
						$("config.email").focus();
						return false;
					}
		            if(myreg.test(temp.value)) {}
		            else{
			            alert("��������Ч������");
			            $("config.email").focus();
			            return false;
		            }
				}
				//�Ե绰�������֤
				if($("config.phone").value != "") {
					var phone =/^\d+$/;
					var temp = document.getElementsByName("config.phone")[0];
					if(!phone.test(temp.value)) {
			            alert("��������Ч�ĵ绰");
			            $("config.phone").focus();
			            return false;
		            }
		            if(Len(document.getElementsByName("config.phone")[0].value) > 200) {
						alert("�绰���Ȳ��ܴ���200������������");
						$("config.phone").focus();
						return false;
					}
		        }
				//���ֻ��������֤
				if($("config.mobile").value != "") {
					var mobile =/^1[3,5]\d{9}$/;
					var temp = document.getElementsByName("config.mobile")[0];
					if(!mobile.test(temp.value)) {
			            alert("��������Ч���ֻ�");
			            $("config.mobile").focus();
			            return false;
		            }
		            if(Len(document.getElementsByName("config.mobile")[0].value) > 200) {
						alert("�ֻ����Ȳ��ܴ���200������������");
						$("config.mobile").focus();
						return false;
					}
		        }
		        if(Len(document.getElementsByName("config.recordCode")[0].value) > 255) {
					alert("�����ų��Ȳ��ܴ���255������������");
					$("config.recordCode").focus();
					return false;
				}
		        if(Len(document.getElementsByName("config.copyright")[0].value) > 255) {
					alert("��Ȩ��Ϣ���Ȳ��ܴ���255������������");
					$("config.copyright").focus();
					return false;
				}
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form method="post" action="config_update.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��վ���ƣ�</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="config.siteName" value="${config.siteName}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��ҵ���ƣ�</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="config.propertyName" value="${config.propertyName}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��λ���ƣ�</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="config.company" value="${config.company}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�䣺</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="config.email" value="${config.email}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="config.phone" value="${config.phone}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="config.mobile" value="${config.mobile}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="config.recordCode" value="${config.recordCode}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��Ȩ��Ϣ��</td>
						<td width="80%" class="pn-fcontent">
						<textarea name="config.copyright" rows="5" cols="50">${config.copyright}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="hidden" name="config.id" value="${config.id}"/>
							<input type="submit" value=" �� �� "/> &nbsp;
						<input type="reset" value=" �� �� "/></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
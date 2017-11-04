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
				alert("操作成功");
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
				if($("config.siteName").value==""){
					alert("网站名称不能为空");
					$("config.siteName").focus();
					return false;
				}
				if($("config.propertyName").value==""){
					alert("物业名称不能为空");
					$("config.propertyName").focus();
					return false;
				}
				if(Len(document.getElementsByName("config.siteName")[0].value) > 100) {
					alert("网站标题长度不能大于100，请重新输入");
					$("config.siteName").focus();
					return false;
				}
				if(Len(document.getElementsByName("config.propertyName")[0].value) > 50) {
					alert("物业名称长度不能大于50，请重新输入");
					$("config.propertyName").focus();
					return false;
				}
				if(Len(document.getElementsByName("config.company")[0].value) > 200) {
					alert("公司名称长度不能大于200，请重新输入");
					$("config.company").focus();
					return false;
				}
				//对邮箱的验证
	            if($("config.email").value != "") {
		            var myreg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		            var temp = document.getElementsByName("config.email")[0];
		            if(Len(document.getElementsByName("config.email")[0].value) > 100) {
						alert("邮箱长度不能大于100，请重新输入");
						$("config.email").focus();
						return false;
					}
		            if(myreg.test(temp.value)) {}
		            else{
			            alert("请输入有效的邮箱");
			            $("config.email").focus();
			            return false;
		            }
				}
				//对电话号码的验证
				if($("config.phone").value != "") {
					var phone =/^\d+$/;
					var temp = document.getElementsByName("config.phone")[0];
					if(!phone.test(temp.value)) {
			            alert("请输入有效的电话");
			            $("config.phone").focus();
			            return false;
		            }
		            if(Len(document.getElementsByName("config.phone")[0].value) > 200) {
						alert("电话长度不能大于200，请重新输入");
						$("config.phone").focus();
						return false;
					}
		        }
				//对手机号码的验证
				if($("config.mobile").value != "") {
					var mobile =/^1[3,5]\d{9}$/;
					var temp = document.getElementsByName("config.mobile")[0];
					if(!mobile.test(temp.value)) {
			            alert("请输入有效的手机");
			            $("config.mobile").focus();
			            return false;
		            }
		            if(Len(document.getElementsByName("config.mobile")[0].value) > 200) {
						alert("手机长度不能大于200，请重新输入");
						$("config.mobile").focus();
						return false;
					}
		        }
		        if(Len(document.getElementsByName("config.recordCode")[0].value) > 255) {
					alert("备案号长度不能大于255，请重新输入");
					$("config.recordCode").focus();
					return false;
				}
		        if(Len(document.getElementsByName("config.copyright")[0].value) > 255) {
					alert("版权信息长度不能大于255，请重新输入");
					$("config.copyright").focus();
					return false;
				}
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form method="post" action="config_update.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">网站名称：</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="config.siteName" value="${config.siteName}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">物业名称：</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="config.propertyName" value="${config.propertyName}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">单位名称：</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="config.company" value="${config.company}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">邮&nbsp;&nbsp;&nbsp;&nbsp;箱：</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="config.email" value="${config.email}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">电&nbsp;&nbsp;&nbsp;&nbsp;话：</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="config.phone" value="${config.phone}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">手&nbsp;&nbsp;&nbsp;&nbsp;机：</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="config.mobile" value="${config.mobile}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">备&nbsp;案&nbsp;号：</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="config.recordCode" value="${config.recordCode}" size="40"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">版权信息：</td>
						<td width="80%" class="pn-fcontent">
						<textarea name="config.copyright" rows="5" cols="50">${config.copyright}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="hidden" name="config.id" value="${config.id}"/>
							<input type="submit" value=" 保 存 "/> &nbsp;
						<input type="reset" value=" 重 置 "/></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
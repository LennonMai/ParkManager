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
				alert("该用户已经存在");
			}
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
				if(get("admin.username").value==""){
					alert("登陆名不能为空，请重新输入");
					get("admin.username").focus();
					return false;
				}
				if(Len(document.getElementsByName("admin.username")[0].value) > 20) {
					alert("登录名长度不能大于20，请重新输入");
					get("admin.username").focus();
					return false;
				}
				if(get("admin.name").value==""){
					alert("真实姓名不能为空，请重新输入");
					get("admin.name").focus();
					return false;
				}
				if(Len(document.getElementsByName("admin.name")[0].value) > 20) {
					alert("真实姓名长度不能大于20，请重新输入");
					get("admin.name").focus();
					return false;
				}
				if(Len(document.getElementsByName("admin.password")[0].value) > 32) {
					alert("密码长度不能大于32，请重新输入");
					get("admin.password").focus();
					return false;
				}
				if(get("admin.password").value!=null&&get("admin.password").value!=get("admin.password2").value){
					alert("两次输入密码不一致，请重新输入");
					get("admin.password").focus();
					return false;
				}
	            //对邮箱的验证
	            if(get("admin.email").value != "") {
		            var myreg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		            var temp = document.getElementsByName("admin.email")[0];
		            if(!myreg.test(temp.value)) {
			            alert("请输入有效的邮箱");
			            get("admin.email").focus();
			            return false;
		            }
		            if(Len(document.getElementsByName("admin.email")[0].value) > 50) {
						alert("邮箱长度不能大于50，请重新输入");
						get("admin.email").focus();
						return false;
					}
				}
				//对电话号码的验证
				if(get("admin.phone").value != "") {
					/*var phone =/^\d+$/;
					var temp = document.getElementsByName("admin.phone")[0];
					if(!phone.test(temp.value)) {
			            alert("请输入有效的电话");
			            get("admin.phone").focus();
			            return false;
		            }*/
		            if(Len(document.getElementsByName("admin.phone")[0].value) > 20) {
						alert("电话长度不能大于20，请重新输入");
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" 返 回 " onclick="history.back();"/>
				</form>
				<div class="clear"></div>
			</div>
			<form method="post" action="admin_update.do?adminUsername=${admin.username }" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">登&nbsp;录&nbsp;名：</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="admin.username" value="${admin.username}" size="20"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">真实姓名：</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="admin.name" value="${admin.name}" size="20"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">用户角色：</td>
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
						<td width="20%" class="pn-flabel pn-flabel-h">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
						<td width="80%" class="pn-fcontent"><input type="password" name="admin.password" class="required" size="32"/>（若不填则保持原密码不变）</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">重复密码：</td>
						<td width="80%" class="pn-fcontent"><input type="password" name="admin.password2"/ size="32"></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
						<td width="80%" class="pn-fcontent">
							<input type="radio" name="admin.sex" value="男" checked/>男
							<input type="radio" name="admin.sex" value="女" <c:if test="${admin.sex=='女'}">checked</c:if>/>女</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">邮&nbsp;&nbsp;&nbsp;&nbsp;箱：</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="admin.email" value="${admin.email}" size="50"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">电&nbsp;&nbsp;&nbsp;&nbsp;话：</td>
						<td width="80%" class="pn-fcontent">
						<input type="text" name="admin.phone" value="${admin.phone}" size="20"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">是否禁用：</td>
						<td width="80%" class="pn-fcontent">
							<input type="radio" name="admin.valid" value="1" checked/>否
							<input type="radio" name="admin.valid" value="0" <c:if test="${admin.valid!='1'}">checked</c:if>/>是</td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="hidden" name="admin.id" value="${admin.id}"/>
							<input type="hidden" name="admin.createTime" value="${admin.createTime}"/>
							<input type="hidden" name="admin.lastIp" value="${admin.lastIp}"/>
							<input type="hidden" name="admin.lastTime" value="${admin.lastTime}"/>
							<input type="submit" value=" 保 存 "/> &nbsp;
							<input type="reset" value=" 重 置 "/></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
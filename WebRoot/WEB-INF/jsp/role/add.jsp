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
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript">
			if("${result}"=="FAIL") {
				alert("角色名称已存在");
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
			function check() {
				if(document.getElementsByName("role.name")[0].value=="") {
					alert("角色名称不能为空，请重新输入");
					get("role.name").focus();
					return false;
				}
				if(Len(document.getElementsByName("role.name")[0].value) > 50) {
					alert("角色名称长度不能大于50，请重新输入");
					get("role.name").focus();
					return false;
				}
				if(Len(document.getElementsByName("role.remark")[0].value) > 100) {
					alert("备注长度不能大于100，请重新输入");
					get("role.remark").focus();
					return false;
				}
				return true;
			}
			function getRoleName() {	//jquery验证角色名称是否存在
				var roleName = document.getElementsByName("role.name")[0].value;
				jQuery.post("role_getRoleByName.do?role.name="+roleName,function(data) {
					if(data=="fail") {
						alert("角色名称已存在");
					}
				});
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
			<form method="post" action="role_save.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">角色名称：</td>
						<td width="80%" class="pn-fcontent"><input type="text" name="role.name" size="50" onblur="getRoleName();"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
						<td width="80%" class="pn-fcontent"><textarea name="role.remark" rows="3" cols="100" ></textarea></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">角色权限：</td>
						<td width="80%" class="pn-fcontent">
							<div class="dtree">
								<script type="text/javascript">
									var dtree = new Array();
									var i = 1;
									<c:forEach items="${list}" var="module">
										dtree[i] = new Array();
										dtree[i][0] = "${module.id}";
										dtree[i][1] = "${module.parent==null?0:module.parent.id}";
										dtree[i][2] = "${module.name}";
										i++;
									</c:forEach>
									d = new dTree('d');
									d.config.check=true;
									d.config.inputName="modules";
									d.add(0,-1,"功能菜单");
									for(var i=1;i<dtree.length;i++){
										d.add(dtree[i][0],dtree[i][1],dtree[i][2]);
									}
									document.write(d);
									<%--d.openAll();--%>									
								</script>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/> &nbsp;
						<input type="reset" value=" 重 置 "/></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
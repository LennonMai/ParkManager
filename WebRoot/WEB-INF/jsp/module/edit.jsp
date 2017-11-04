<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>
		<title>edit</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>

		<script type="text/javascript">
			if("${result}"=="SUCCESS"){
				alert("操作成功");
			}
			if("${result}" == "FAIL1") {
				alert("该父目录下功能模块已经存在")
			}
			if("${result}"=="FAIL"){
				alert("删除失败，请先删除该模块下的子模块");
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
				if(get("module.name").value==""){
					alert("模块名称不能为空");
					get("module.name").focus();
					return false;
				}
				if(Len(document.getElementsByName("module.name")[0].value) > 50) {
					alert("登录名长度不能大于50，请重新输入");
					get("module.name").focus();
					return false;
				}
				if(Len(document.getElementsByName("module.functions")[0].value) > 8000) {
					alert("功能集合长度不能大于8000，请重新输入");
					get("module.functions").focus();
					return false;
				}
				//对排序号的验证
				if(isNaN(get("module.priority").value)) {
					alert("请输入有效的排序号");
					get("module.priority").focus();
					return false;
				}
				if(Len(document.getElementsByName("module.priority")[0].value) > 4) {
					alert("排序号长度不能大于4，请重新输入");
					get("module.priority").focus();
					return false;
				}
				if(Len(document.getElementsByName("module.remark")[0].value) > 200) {
					alert("备注长度不能大于200，请重新输入");
					get("module.remark").focus();
					return false;
				}
				return true;
			}
			function put(i){
				get("module.id").value = dtree[i][0];
				get("module.parent.id").value = dtree[i][1];
				get("module.name").value = dtree[i][2];
				get("module.url").value = dtree[i][3];
				get("module.functions").value = dtree[i][4];
				get("module.priority").value = dtree[i][5];
				var display = document.getElementsByName("module.display");
				for(j=0;j<display.length;j++){
					if(display[j].value == dtree[i][6]){
						display[j].checked = true;
					}
				}
				get("module.level").value = dtree[i][7];
				get("module.remark").value = dtree[i][8];
			}
			function add(){
				if(!check())
				return false;
				get("tableForm").action = "module_save.do";
				get("tableForm").submit();
			}
			function update(){
				if(get("module.id").value==""){
					alert("请先选择要修改的信息");
					return false;
				}
				//alert(get("module.name").value)
				if(!check()) {
					return false;
				}
				get("tableForm").action = "module_update.do?moduleName="+get("module.name").value;
				get("tableForm").submit();
			}
			function del(){
				if(get("module.id").value==""){
					alert("请先选择要删除的信息");
					return false;
				}
				if(confirm("确定要删除信息吗？")){
					get("tableForm").action = "module_delete.do";
					get("tableForm").submit();
				}
			}
			function getModuleByName() {	////jquery验证父节点下功能模块名是否存在
				var moduleName = document.getElementsByName("module.name")[0].value;
				var parentId = document.getElementsByName("module.parent.id")[0].value;
				jQuery.ajax({
					type:"post",
					url:"module_getModuleByName.do?module.name="+moduleName+"&module.parent.id="+parentId,
					async:true,	//设为异步方式
					success:function(data, textStatus) {
						if(data == "fail") {
							alert("该父目录下功能模块已经存在");
						}
					}
				});
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="module_update.do?moduleName=${module.name}">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td width="300" valign="top" style="padding-left:30px;padding-top:20px;">
							<div class="dtree">
								<script type="text/javascript">
									var dtree = new Array();
									var i = 1;
									<c:forEach items="${list}" var="module">
										dtree[i] = new Array();
										dtree[i][0] = "${module.id}";
										dtree[i][1] = "${module.parent==null?0:module.parent.id}";
										dtree[i][2] = "${module.name}";
										dtree[i][3] = "${module.url}";
										dtree[i][4] = "${module.functions}";
										dtree[i][5] = "${module.priority}";
										dtree[i][6] = "${module.display}";
										dtree[i][7] = "${module.level}";
										dtree[i][8] = "${module.remark}";
										dtree[i][9] = "javascript:put("+i+");";
										i++;
									</c:forEach>

									m = new dTree('m');
									m.add(0,-1,"根目录");
									for(var i=1;i<dtree.length;i++){
										m.add(dtree[i][0],dtree[i][1],dtree[i][2],dtree[i][9]);
									}
									document.write(m);
									//d.openAll();
								</script>

							</div>
						</td>

						<td width="550" valign="top" style="padding-top:20px;">
							<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
								<tr>
									<td width="20%" class="pn-flabel pn-flabel-h">上级模块：</td>
									<td width="80%" class="pn-fcontent">
										<select name="module.parent.id">
											<option value="0" selected>根目录</option>
											<c:forEach items="${list}" var="item">
												<option value="${item.id}">${fn:substring("││││││││││",0,item.level-1)}├${item.name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td width="20%" class="pn-flabel pn-flabel-h">模块名称：</td>
									<td width="80%" class="pn-fcontent"><input type="text" name="module.name" size="50" />&nbsp;<font style="color:red">*</font></td>
								</tr>
								<tr>
									<td width="20%" class="pn-flabel pn-flabel-h">首页地址：</td>
									<td width="80%" class="pn-fcontent"><input type="text" name="module.url" size="50"/></td>
								</tr>
								<tr>
									<td width="20%" class="pn-flabel pn-flabel-h">功能集合：</td>
									<td width="80%" class="pn-fcontent"><textarea name="module.functions" rows="8" cols="50"></textarea><br>
									使用分号";"隔开</td>
								</tr>
								<tr>
									<td width="20%" class="pn-flabel pn-flabel-h">排&nbsp;&nbsp;&nbsp;&nbsp;序：</td>
									<td width="80%" class="pn-fcontent"><input type="text" name="module.priority" value="10"/></td>
								</tr>
								<tr>
									<td width="20%" class="pn-flabel pn-flabel-h">是否隐藏：</td>
									<td width="80%" class="pn-fcontent"><input type="radio" name="module.display" value="1" checked/>否
										<input type="radio" name="module.display" value="0"/>是</td>
								</tr>
								<tr>
									<td width="20%" class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
									<td width="80%" class="pn-fcontent"><input type="text" name="module.remark" size="50"/></td>
								</tr>
								<tr>
									<td colspan="2" class="pn-fbutton">
										<input type="hidden" name="module.id"/>
										<input type="hidden" name="module.level"/>
										<input type="button" onclick="add();" value=" 添 加 "/> &nbsp;
										<input type="button" onclick="update();" value=" 修 改 "/> &nbsp;
										<input type="button" onclick="del();" value=" 删 除 "/> &nbsp;
										</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
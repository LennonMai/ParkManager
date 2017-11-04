<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>添加车道操作员信息</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>	
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>	
		<script type="text/javascript">
		
		if("${message}"=="exitLaneOperator"){
			alert("操作员编码已存在！");
			}
        //返回首页
		function back(){
			window.location.href = "laneOperator_list.do";
			}
		//获取小区
		function getPark(){
		  (function($) { 
			   $(function() {
			$.ajax({
				type:"post",
				url:"lostCard_ajaxPark.do?areaNo="+document.getElementById('laneOperator_areaNo').value,
				success:function(res){
					$("#laneOperator_parkNo").empty();
					var op = $("<option value=''>- 请选择 -</option>");		
					$("#laneOperator_parkNo").append(op);
					$(res).find("parks > park").each(function(){								
					var op = $("<option value=" + $(this).attr("id") + ">" 
							+ $(this).attr("name") + "</option>");
					$("#laneOperator_parkNo").append(op);	
				});
				}
			});
		   });
		  })(jQuery);
		}
		
		 //创建保存角色的数组
	    var roles=new Array();
	    var checkCount=0;

	  //根据下标删除某个数组元素	
		  Array.prototype.remove=function(dx) 
		  { 
		      if(isNaN(dx)||dx>this.length){return false;} 
		      for(var i=0,n=0;i<this.length;i++) 
		      { 
		          if(this[i]!=this[dx]) 
		          { 
		              this[n++]=this[i] 
		          } 
		      } 
		      this.length-=1 
		  }
		  Array.prototype.baoremove = function(dx) 
		  { 
		      if(isNaN(dx)||dx>this.length){return false;} 
		      this.splice(dx,1); 
		  } 
		  
		function setRole(obj){
			if(obj.checked){
				roles[checkCount]=obj.value;
				checkCount++;
				}else{
					//当第一次选择checkbox后，再取消，则出数组中去掉该值
					var del=obj.value;
					for(var i=0;i<roles.length;i++){
						  if(del==roles[i]){
							  roles.baoremove(i);
							  checkCount--;}
						}
					}
			}
		function setRoles(){
			get("roles").value=roles;
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="laneOperator_save.do" onsubmit="setRoles()"/>
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<input type="hidden" name="roles" ></input>
					<tr>
						<td class="pn-flabel pn-flabel-h">设置角色：</td>
						<td colspan="3" class="pn-fcontent">
						<c:forEach items="${list}" var="item">
							<input type="checkbox" id="${item.roleNo}" value="${item.roleNo}" onclick="setRole(this);"></input>${item.roleName}
						</c:forEach>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">区域名称：</td>
						<td class="pn-fcontent">
						<select id="laneOperator_areaNo" class="required" name="laneOperator.areaNo" style="width: 178px;height: 22px;" onchange="getPark();">
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">小区名称：</td>
						<td class="pn-fcontent">
						<select id="laneOperator_parkNo" class="required" name="laneOperator.parkNo" style="width: 178px;height: 22px;">
							<option value="">- 请选择 -</option>
						</select><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">操作员编码：</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" name="laneOperator.operatorNo" value="${laneOperator.operatorNo}" size="24"/><span style="color: red">&nbsp;*</span></td>
					  	<td class="pn-flabel pn-flabel-h">登录密码：</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength6" name="laneOperator.password" value="${laneOperator.password}" size="24"/><span style="color: red">&nbsp;*</span></td>
						</tr>
					
					<tr>
						<td class="pn-flabel pn-flabel-h">操作员名称：</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength8" name="laneOperator.operatorName" value="${laneOperator.operatorName}" size="24"/></td>
							<td  class="pn-flabel pn-flabel-h">状&nbsp;&nbsp;&nbsp;&nbsp;态：</td>
						<td  class="pn-fcontent">
						<c:if test="${laneOperator.status==null}">
						<select class="required"  name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="" selected="selected"> - 请选择 -</option>
						   <option value="0" > 无效</option>
						   <option value="1" > 正常</option>
						</select>
						</c:if>			
						<c:if test="${laneOperator.status=='0'}">
						<select class="required" name="laneOperator.status"  style="width: 178px;height: 24px;">
						   <option value="0" selected="selected"> 无效</option>
						   <option value="1" > 正常</option>
						</select>
						</c:if>
						<c:if test="${laneOperator.status=='1'}">
						<select class="required" name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="0" > 无效</option>
						   <option value="1" selected="selected"> 正常</option>
						</select>
						</c:if>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">身份卡号：</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16" name="laneOperator.opCardId" value="${laneOperator.opCardId}" size="24"/></td>
						<td class="pn-flabel pn-flabel-h">身份卡号自编号：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="laneOperator.opCardNo" value="${laneOperator.opCardNo}" size="24"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 保 存 " />&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
	<script language="javascript">
	//构造区域编码下拉列表
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	var result1 = jsonrpc.ajax.getAreaNo_AreaName();
	for (var i=0;i<result1.length;i++){
		option =document.createElement("OPTION");
		option.value = result1[i][0];
		option.text = result1[i][1];
		document.getElementById("laneOperator_areaNo").options.add(option);
	}
	
</script>	
	</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript">
			if("${message}"=="1"){
				alert("该卡号还没有注册安全用户信息");
			}
			if("${message}"=="2"){
				alert("卡号或车牌号有误不存在");
			}
			if("${message}"=="3"){
				alert("该条信息已经存在");
			}
			if("${message}"=="4"){
				alert("添加失败");
			}
			if("${message}"=="5"){
				alert("添加成功");
			}
			if("${message}"=="6"){
				alert("修改失败");
			}
			if("${message}"=="7"){
				alert("修改成功");
			}
			if("${message}"=="8"){
				alert("删除成功");
			}
			if("${message}"=="9"){
				alert("删除成功");
			}
			function toAddCommand(sizes,crrPage){
				window.location.href="securityCommand_toAddCommand.do?pager.pageSize="+sizes+"&pager.currentPage="+crrPage;
			}
			function del(id,sizes,crrPage){
				if(confirm("确认要删除吗？")){
					window.location.href = "securityCommand_delete.do?commandId="+id+"&pager.pageSize="+sizes+"&pager.currentPage="+crrPage;
				}
			}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
			}
	    	function toUpdateCommand(commandId,pageSize,currentPage) {														
			    window.location = "securityCommand_toUpdateCommand.do?commandId=" + commandId+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;	
	        }
		    function setRowBGcolor(){
				var rowIndex="${rowIndex}";
				var pageSize="${pageSize}";
				var currentPage="${currentPage}";
				if(rowIndex!=""&&pageSize!=""&&currentPage!=""){
					var trs=document.getElementById("tb").getElementsByTagName("tr");
					for(var i=0;i<trs.length;i++){
						if(i==rowIndex&&get("pager.pageSize").value==pageSize&&get("pager.currentPage").value==currentPage){
							trs[i].style.backgroundColor="#E6E6E6";
						}
					}
				}
			}	
		</script>
	</head>
	<body onload="setRowBGcolor();">
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityCommand_query.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">用户名：</td>
						<td class="pn-fcontent">
						  <input type="text" name="owner" value="${owner}" />
						</td>
						<td class="pn-flabel pn-flabel-h">指令类型：</td>
						<td class="pn-fcontent">
						  	<select name="type">
						  		<option value="" <c:if test="${type==null}">selected</c:if>>-请选择-</option>
						  		<option value="1" <c:if test="${type==1}">selected</c:if>>锁定</option>
						  		<option value="2" <c:if test="${type==2}">selected</c:if>>解锁</option>
						  	</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;号：</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNo" value="${cardNo}" />
						</td>
						
						<td class="pn-flabel pn-flabel-h">有效类型：</td>
						<td class="pn-fcontent">
							<select name="validType">
								<option value="" <c:if test="${validType==null}">selected</c:if>>-请选择-</option>
						  		<option value="1" <c:if test="${validType==1}">selected</c:if>>每日有效</option>
						  		<option value="2" <c:if test="${validType==2}">selected</c:if>>当次有效</option>
								<option value="3" <c:if test="${validType==3}">selected</c:if>>永久有效</option>
								<option value="4" <c:if test="${validType==4}">selected</c:if>>不定时</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">车牌号：</td>
						<td class="pn-fcontent" colspan="3">
						  <input type="text" name="vehPlate" value="${vehPlate}" />
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" 查 询 " />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" 重 置 " />&nbsp;&nbsp;&nbsp;&nbsp;	
						<input type="button" onclick="toAddCommand(${pager.pageSize},${pager.currentPage })" value=" 添 加 "/>
						</td>
					</tr>
				</table>
			<!-- 显示list数据-->
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>用户姓名</th>
						<th>卡表面号</th>
						<th>车 牌 号</th>
						<th>指令类型</th>
						<th>有效类型</th>
						<th>生效时间</th>					
						<th>失效时间</th>
						<th>添加时间</th>
						<th>处理时间</th>
						<th>状    态</th>
						<th>操    作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item[1].owner }</td>
							<td>${item[0].cardNo }</td>
							<!--<td>${item[1].vehPlate }</td>-->
							<td>${fn:trim(item[1].vehPlate)}</td>
							<td>
								<c:if test="${item[0].type==1}">锁定</c:if>
								<c:if test="${item[0].type==2}">解锁</c:if>
							</td>
							<td>
								<c:if test="${item[0].validType==1}">每日有效</c:if>
								<c:if test="${item[0].validType==2}">当次有效</c:if>
								<c:if test="${item[0].validType==3}">永久有效</c:if>
								<c:if test="${item[0].validType==4}">不定时</c:if>
							</td>
							<td>${item[0].startTime}</td>
							<td>${item[0].endTime}</td>
							<td><fmt:formatDate value="${item[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${item[0].handleTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item[0].attribute==0}">正常</c:if>
								<c:if test="${item[0].attribute==1}">已删除</c:if>
								<c:if test="${item[0].attribute==2}">已处理</c:if>
								<c:if test="${item[0].attribute==3}">超时未处理</c:if>
							</td>
							<td>
								<c:if test="${item[0].attribute!=1}"><!-- 去除掉已删除状态,不可以做删除和修改操作 -->
									<c:if test="${item[0].validType==4 || item[0].validType==3}">
										<a href="javascript:del(${item[0].commandId },${pager.pageSize},${pager.currentPage });" class="pn-loperator">删 除</a>
									</c:if>
									<c:if test="${item[0].validType==1 || item[0].validType==2}">
										<a href="javascript:toUpdateCommand(${item[0].commandId },${pager.pageSize},${pager.currentPage });" class="pn-loperator">修改</a>|
										<a href="javascript:del(${item[0].commandId },${pager.pageSize},${pager.currentPage });" class="pn-loperator">删 除</a>
									</c:if>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>
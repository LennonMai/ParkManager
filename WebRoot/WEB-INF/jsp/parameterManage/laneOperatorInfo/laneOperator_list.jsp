<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>操作员信息列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
			
		<script language="javascript">
		
		if("${result}"=="SUCCESS"){
			alert("操作员信息添加成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
		function del(operatorNo,pageSize,currentPage){
			if(confirm("确认要删除吗？")){
				window.location.href = "laneOperator_delete.do?laneOperator.operatorNo="+operatorNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
			}
		}
		function add(){
			window.location.href = "laneOperator_add.do";
			}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
		function edit(operatorNo,pageSize,currentPage){
			window.location.href ="laneOperator_edit.do?laneOperator.operatorNo="+operatorNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form  name="tableForm"  method="post" action="laneOperator_query.do" onsubmit="">
						<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
					    <td  class="pn-flabel pn-flabel-h">小区编码：</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.parkNo" value="${laneOperator.parkNo}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">状&nbsp;&nbsp;&nbsp;&nbsp;态：</td>
						<td  class="pn-fcontent">
						<c:if test="${laneOperator.status==null}">
						<select  name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="" selected="selected"> - 请选择 -</option>
						   <option value="0" > 无效</option>
						   <option value="1" > 正常</option>
						</select>
						</c:if>
						<c:if test="${laneOperator.status==''}">
						<select  name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="" selected="selected"> - 请选择 -</option>
						   <option value="0" > 无效</option>
						   <option value="1" > 正常</option>
						</select>
						</c:if>
						<c:if test="${laneOperator.status=='0'}">
						<select  name="laneOperator.status"  style="width: 178px;height: 24px;">
						   <option value="0" selected="selected"> 无效</option>
						   <option value="1" > 正常</option>
						</select>
						</c:if>
						<c:if test="${laneOperator.status=='1'}">
						<select  name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="0" > 无效</option>
						   <option value="1" selected="selected"> 正常</option>
						</select>
						</c:if>
						</td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">操作员编码：</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.operatorNo" value="${laneOperator.operatorNo}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">身份卡号：</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.opCardId" value="${laneOperator.opCardId}" size="24"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">操作员名称：</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.operatorName" value="${laneOperator.operatorName}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">身份卡自编号：</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.opCardNo" value="${laneOperator.opCardNo}" size="24"/></td>
					</tr>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"value=" 查 询 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button" value=" 添 加 " onclick="add();"/>	
						</td>
					</tr>
			</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">区域编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">小区编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操作员编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操作员名称</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">身份卡号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">身份卡自编号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">登录密码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">状态</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.parkNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.operatorNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.operatorName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.opCardId}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.opCardNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.password}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.status==0}">无效</c:if>
							<c:if test="${item.status==1}">正常</c:if>
							</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							 <!--<a href="laneOperator_edit.do?laneOperator.operatorNo=${item.operatorNo}&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage}" class="pn-loperator">修改</a>-->
							 <a href="javascript:edit(${item.operatorNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							┆ <a href="javascript:del(${item.operatorNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">删除</a>							
							</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		</div>		
	</body>
</html>
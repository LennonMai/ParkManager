<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>特殊车辆管理</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		
		<script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("特殊车辆信息添加成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
			function del(vehPlate,cardNo,pageSize,currentPage){
				if(confirm("确认要删除吗？")){
					window.location.href = "specialVeh_delete.do?specialVeh.vehPlate="+vehPlate+"&specialVeh.cardNo="+cardNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}			
			function add(){
				window.location.href = "specialVeh_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(vehPlate,cardNo,pageSize,currentPage){
				window.location.href ="specialVeh_edit.do?specialVeh.vehPlate="+vehPlate+"&specialVeh.cardNo="+cardNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
				<div class="rpos">当前位置： ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="specialVeh_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td  class="pn-flabel pn-flabel-h">车牌号：</td>
						<td  class="pn-fcontent"> <input type="text" name="specialVeh.vehPlate" value="${specialVeh.vehPlate }" size="24"/></td>
					    <td  class="pn-flabel pn-flabel-h">特殊类型：</td>
						<td  class="pn-fcontent">
						<select id="specialVeh_specialType" name="specialVeh.specialType" style="width:178px;height: 22px;">
						<option value="">- 请选择 -</option>
						<c:forEach items="${stList}" var="item">
								 <option value="${item.typeCode}" <c:if test="${item.typeCode==specialVeh.specialType}">selected="selected"</c:if>>${item.typeName}</option>
							</c:forEach>
						</select>
						
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;号：</td>
						<td  class="pn-fcontent"> <input type="text" name="specialVeh.cardNo" value="${specialVeh.cardNo }" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">车道类型：</td>
						<td  class="pn-fcontent">
						<select  name="specialVeh.lanetype" style="width: 178px;height: 22px;;">
						   <option value="">- 请选择 -</option>
						   <option value="1" <c:if test="${specialVeh.lanetype==1}">selected="selected"</c:if>>入口</option>
						   <option value="2" <c:if test="${specialVeh.lanetype==2}">selected="selected"</c:if>>出口</option>
						   <option value="0" <c:if test="${specialVeh.lanetype==0}">selected="selected"</c:if>>出入口</option>
						</select></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" 查 询 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button"  value=" 添 加 "  onclick="add();"/>&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 " />	
						</td>
					</tr>
			
			</table>			
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车牌号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">卡&nbsp;&nbsp;号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">特殊类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车道类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">拦截信息</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
					
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.vehPlate}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.cardNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:forEach items="${stList}" var="stItem">
								<c:if test="${stItem.typeCode==item.specialType}">${stItem.typeName}</c:if>
							</c:forEach>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.lanetype==1}">入口</c:if>
							<c:if test="${item.lanetype==2}">出口</c:if>
							<c:if test="${item.lanetype==0}">出入口</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.info}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							
							<a href="javascript:edit('${item.vehPlate}','${item.cardNo}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							┆ <a href="javascript:del('${item.vehPlate}','${item.cardNo}',${pager.pageSize},${pager.currentPage});" class="pn-loperator">删除</a></td>
						</tr>
					
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>

		</div>
	</body>
</html>
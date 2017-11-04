<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>参数列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
			
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("参数配置成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
		function del(paraClass,item,pageSize,currentPage){
			if(confirm("确认要删除吗？")){
				window.location.href = "systemPara_delete.do?systemPara.paraClass="+paraClass+"&systemPara.item="+item+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
			}
		}
		
		function add(){
			window.location.href = "systemPara_add.do";
			}
		function dataToExcel(){
			window.location.href = "systemPara_dataToExcel.do";
			}
		//过滤空格
		function Trim() {
            return this.replace(/\s+$|^\s+/g,"");
		}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
		function edit(paraClass,item,pageSize,currentPage){
			window.location.href ="systemPara_edit.do?systemPara.paraClass="+paraClass+"&systemPara.item="+item+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form  name="tableForm"  method="post" action="systemPara_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td  class="pn-flabel pn-flabel-h">键&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
						<td  class="pn-fcontent"> <input type="text" name="systemPara.item" value="${systemPara.item}" size="24"/></td>
					    <td  class="pn-flabel pn-flabel-h">参数类型：</td>
						<td  class="pn-fcontent">
						<select name="systemPara.paraClass" style="width: 178px;height: 24px;">
						  <option value="" <c:if test="${systemPara.paraClass==null}">selected="selected"</c:if> >- 请选择 -</option>
						   <option value="-1" <c:if test="${systemPara.paraClass==-1}">selected="selected"</c:if> >组别参数</option>
						   <option value="0" <c:if test="${systemPara.paraClass==0}">selected="selected"</c:if> >全局参数</option>
						   <option value="1" <c:if test="${systemPara.paraClass==1}">selected="selected"</c:if> >下发参数</option>
						   <option value="2" <c:if test="${systemPara.paraClass==2}">selected="selected"</c:if> >卡管理参数</option>
						
						</select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">键&nbsp;&nbsp;&nbsp;&nbsp;值：</td>
						<td  class="pn-fcontent"> <input type="text" name="systemPara.itemValue" value="${systemPara.itemValue }" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">组&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
						<%-- <td  class="pn-fcontent"><input type="text" name="systemPara.groupName" value="${systemPara.groupName }" size="24"/></td> --%>
						<td class="pn-fcontent">
						<select name="systemPara.groupName" style="width: 178px;height: 24px;">
							<option value="" <c:if test="${systemPara.groupName==''}">selected="selected"</c:if> >- 请选择 -</option>
						<c:forEach items="${groupNameList}" var="gName">
							<option value="${gName.item}" <c:if test="${systemPara.groupName eq gName.item}">selected="selected"</c:if> >${gName.item}</option>
						</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" 查 询 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button"  value=" 添 加 "  onclick="add();"/> &nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 "/>	
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">参数类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">键&nbsp;&nbsp;名</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">键&nbsp;&nbsp;值</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">组&nbsp;&nbsp;别</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">项顺序</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">参数下发控制</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.paraClass==-1}">组别参数</c:if>
							<c:if test="${item.paraClass==0}">全局参数</c:if>
							<c:if test="${item.paraClass==1}">下发参数</c:if>
							<c:if test="${item.paraClass==2}">卡管理参数</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.item}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.itemValue}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.groupName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.itemOrder}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.paraClass==1}">
								<c:if test="${item.sendControl==0}">不下发</c:if>
								<c:if test="${item.sendControl==1}">有效下发</c:if>
							</c:if>
							</td>
						
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:edit(${item.paraClass},'${item.item}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							┆ <a href="javascript:del(${item.paraClass},'${item.item}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">删除</a>							
											
							</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		<div class=pn-sp>
		<input type="button" name="" style="padding-left: 5px;padding-right: 5px;padding-bottom: 1px;padding-top: 2px;" value="将数据导出Excel" onclick="dataToExcel();"/> 
		<div class="clear"></div>
        </div>
		</div>		
	</body>
</html>
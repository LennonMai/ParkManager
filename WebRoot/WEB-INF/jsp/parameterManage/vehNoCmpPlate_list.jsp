<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>����Ƚ�ʶ���Ƴ���</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
			
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("�������Ƚ�ʶ���Ƴ����ɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
		function del(vehPlate,pageSize,currentPage){
			if(confirm("ȷ��Ҫɾ����")){
				window.location.href = "vehNoCmpPlate_delete.do?vehNoCmpPlate.vehPlate="+vehPlate+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
			}
		}
		
		function add(){
			window.location.href = "vehNoCmpPlate_add.do";
			}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
		function edit(vehPlate,pageSize,currentPage){
			window.location.href ="vehNoCmpPlate_edit.do?vehNoCmpPlate.vehPlate="+vehPlate+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="vehNoCmpPlate_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
					    <td style="width: 150px;" class="pn-flabel pn-flabel-h">���ƺţ�</td>
						<td  colspan="3" class="pn-fcontent"> <input type="text" name="vehNoCmpPlate.vehPlate" value="${vehNoCmpPlate.vehPlate }" size="24"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton" style="padding-bottom: 3px;padding-top: 3px;">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button"  value=" �� �� "  onclick="add();"/> &nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� "/>	
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ƺ�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.vehPlate}</td>

							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:edit('${item.vehPlate}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del('${item.vehPlate}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">ɾ��</a>							
											
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
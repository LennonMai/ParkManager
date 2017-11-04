<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>������Ϣ�б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("������Ϣ��ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
			function del(id,pageSize,currentPage){
				if(confirm("����ɾ��["+id+"]������Ϣ��ͬʱ��ɾ�������ó��е���Ϣ��\n  ������Ϣ��С����Ϣ��������Ϣ��������Ϣ����λ��Ϣ��   \n\n  ȷ��Ҫɾ����")){
					window.location.href = "baseInfo_city_delete.do?cityInformation.cityNo="+id+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}			
			function add(){
				window.location.href = "baseInfo_city_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(cityNo,pageSize,currentPage){
				window.location.href ="baseInfo_city_edit.do?cityInformation.cityNo="+cityNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="baseInfo_city_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;��ӳ�����Ϣ&nbsp;"  onclick="add();"/>
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���б���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;ע</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center"  onclick="getRowIndex(this)">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.cityNo}</td>
							<td align="left" style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.cityName}</td>
							<td align="left" style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.remark}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							
							<!--<a href="baseInfo_city_edit.do?cityInformation.cityNo=${item.cityNo}" class="pn-loperator">�޸�</a>
							-->
							<a href="javascript:edit(${item.cityNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.cityNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>
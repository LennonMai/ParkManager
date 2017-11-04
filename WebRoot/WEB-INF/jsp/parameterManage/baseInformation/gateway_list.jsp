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
			function del(areaNo,parkNo,gateNo,pageSize,currentPage){
				if(confirm("\n����ɾ���ô���["+gateNo+"]��Ϣ���ô���["+gateNo+"]�µ�ȫ��������Ϣ��   \nȷ��Ҫɾ����")){
					window.location.href = "baseInfo_gateway_delete.do?gatewayInformation.areaNo="+areaNo+"&gatewayInformation.parkNo="+parkNo+"&gatewayInformation.gateNo="+gateNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			
			function add(){
				window.location.href = "baseInfo_gateway_add.do";
				}

			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(areaNo,parkNo,gateNo,pageSize,currentPage){
				window.location.href ="baseInfo_gateway_edit.do?gatewayInformation.areaNo="+areaNo+"&gatewayInformation.parkNo="+parkNo+"&gatewayInformation.gateNo="+gateNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form  name="tableForm"  method="post" action="baseInfo_gateway_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;��Ӵ�����Ϣ&nbsp;"  onclick="add();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ű���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ȫ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ע</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.parkNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.gateNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.gateName}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.gateAllName}</td>							
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.remark}</td>
							
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="baseInfo_gateway_edit.do?gatewayInformation.areaNo=${item.areaNo}&gatewayInformation.parkNo=${item.parkNo}&gatewayInformation.gateNo=${item.gateNo}" class="pn-loperator">�޸�</a>-->
							<a href="javascript:edit(${item.areaNo},${item.parkNo},${item.gateNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							
							�� <a href="javascript:del(${item.areaNo},${item.parkNo},${item.gateNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>
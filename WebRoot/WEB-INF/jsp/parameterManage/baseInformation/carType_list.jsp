<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>���������б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<%@include file="../../include/common.jsp" %>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("����������ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
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
			
			function add(){
				window.location.href="carType_add.do";
			}
			
			function del(carType){
				jQuery.post("carType_isCarTypeInUse.do?carType.carType="+carType,function(data) {
					if(data == "UseInUserCarInfo") {
						alert("�ó�����������У԰���û���Ϣ��ʹ�ã�����ɾ����");
						return false;
					}else if(data == "UseInSmallType"){
						alert("�ó�����������ͣ��λ��Ϣ��ʹ�ã�����ɾ����");
						return false;
					}else if(data == "noUse"){
						if(confirm("ȷ��ɾ������������Ϣ��")){
							window.location.href="carType_delete.do?carType.carType="+carType;
						}
					}
				});
				
				
				
			}
			
			function edit(carType){
				window.location.href="carType_edit.do?carType.carType="+carType;
			}
			
		</script>
	</head> 
	<body   onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="carType_getCarTypeList.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px" type="button"  value="&nbsp;��ӳ�������&nbsp;"  onclick="add();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������ͱ���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">������������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="carType">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${carType.carType}</td>
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${carType.carTypeName}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:edit('${carType.carType}');" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del('${carType.carType}');" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>
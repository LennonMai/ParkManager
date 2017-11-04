<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>ͣ��λ�б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<%@include file="../../include/common.jsp" %>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("ͣ��λ��ӳɹ���");
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
				window.location.href="carSmallType_add.do";
			}
			
			function del(carType,carSmallType){
				jQuery.post("carSmallType_isCarSmallTypeInUse.do?carSmallType.carType="+carType+"&carSmallType.carSmallType="+carSmallType,function(data){
					if(data=="InUse"){
						alert("��ͣ��λ��Ϣ����У԰��ע����Ϣ��ʹ�ã�����ɾ����");
					}else if(data=="noInUse"){
						if(confirm("ȷ��ɾ��ͣ��λ��Ϣ��")){
							window.location.href="carSmallType_delete.do?carSmallType.carType="+carType+"&carSmallType.carSmallType="+carSmallType;
						}
					}
				});
			}
			
			function edit(carType,carSmallType){
				window.location.href="carSmallType_edit.do?carSmallType.carType="+carType+"&carSmallType.carSmallType="+carSmallType;
			}
			
		</script>
	</head> 
	<body   onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="carSmallType_getCarSmallTypeList.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px" type="button"  value="&nbsp;���ͣ��λ&nbsp;"  onclick="add();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������ͱ���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">������������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ͣ��λ����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ͣ��λ����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="carSmallType">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" >
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${carSmallType.carType}</td>
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">
								<c:forEach items="${carTypelist}" var="carType">
									<c:if test="${carSmallType.carType==carType.carType}">${carType.carTypeName}</c:if>
								</c:forEach>
							</td>
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${carSmallType.carSmallType}</td>
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${carSmallType.carSmallName}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:edit('${carSmallType.carType}','${carSmallType.carSmallType}');" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del('${carSmallType.carType}','${carSmallType.carSmallType}');" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>
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
				alert("�ÿ��Ż�û��ע�ᰲȫ�û���Ϣ");
			}
			if("${message}"=="2"){
				alert("���Ż��ƺ����󲻴���");
			}
			if("${message}"=="3"){
				alert("������Ϣ�Ѿ�����");
			}
			if("${message}"=="4"){
				alert("���ʧ��");
			}
			if("${message}"=="5"){
				alert("��ӳɹ�");
			}
			if("${message}"=="6"){
				alert("�޸�ʧ��");
			}
			if("${message}"=="7"){
				alert("�޸ĳɹ�");
			}
			if("${message}"=="8"){
				alert("ɾ���ɹ�");
			}
			if("${message}"=="9"){
				alert("ɾ���ɹ�");
			}
			function toAddCommand(sizes,crrPage){
				window.location.href="securityCommand_toAddCommand.do?pager.pageSize="+sizes+"&pager.currentPage="+crrPage;
			}
			function del(id,sizes,crrPage){
				if(confirm("ȷ��Ҫɾ����")){
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityCommand_query.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�û�����</td>
						<td class="pn-fcontent">
						  <input type="text" name="owner" value="${owner}" />
						</td>
						<td class="pn-flabel pn-flabel-h">ָ�����ͣ�</td>
						<td class="pn-fcontent">
						  	<select name="type">
						  		<option value="" <c:if test="${type==null}">selected</c:if>>-��ѡ��-</option>
						  		<option value="1" <c:if test="${type==1}">selected</c:if>>����</option>
						  		<option value="2" <c:if test="${type==2}">selected</c:if>>����</option>
						  	</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;�ţ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNo" value="${cardNo}" />
						</td>
						
						<td class="pn-flabel pn-flabel-h">��Ч���ͣ�</td>
						<td class="pn-fcontent">
							<select name="validType">
								<option value="" <c:if test="${validType==null}">selected</c:if>>-��ѡ��-</option>
						  		<option value="1" <c:if test="${validType==1}">selected</c:if>>ÿ����Ч</option>
						  		<option value="2" <c:if test="${validType==2}">selected</c:if>>������Ч</option>
								<option value="3" <c:if test="${validType==3}">selected</c:if>>������Ч</option>
								<option value="4" <c:if test="${validType==4}">selected</c:if>>����ʱ</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ƺţ�</td>
						<td class="pn-fcontent" colspan="3">
						  <input type="text" name="vehPlate" value="${vehPlate}" />
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� ѯ " />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" �� �� " />&nbsp;&nbsp;&nbsp;&nbsp;	
						<input type="button" onclick="toAddCommand(${pager.pageSize},${pager.currentPage })" value=" �� �� "/>
						</td>
					</tr>
				</table>
			<!-- ��ʾlist����-->
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>�û�����</th>
						<th>�������</th>
						<th>�� �� ��</th>
						<th>ָ������</th>
						<th>��Ч����</th>
						<th>��Чʱ��</th>					
						<th>ʧЧʱ��</th>
						<th>���ʱ��</th>
						<th>����ʱ��</th>
						<th>״    ̬</th>
						<th>��    ��</th>
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
								<c:if test="${item[0].type==1}">����</c:if>
								<c:if test="${item[0].type==2}">����</c:if>
							</td>
							<td>
								<c:if test="${item[0].validType==1}">ÿ����Ч</c:if>
								<c:if test="${item[0].validType==2}">������Ч</c:if>
								<c:if test="${item[0].validType==3}">������Ч</c:if>
								<c:if test="${item[0].validType==4}">����ʱ</c:if>
							</td>
							<td>${item[0].startTime}</td>
							<td>${item[0].endTime}</td>
							<td><fmt:formatDate value="${item[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${item[0].handleTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item[0].attribute==0}">����</c:if>
								<c:if test="${item[0].attribute==1}">��ɾ��</c:if>
								<c:if test="${item[0].attribute==2}">�Ѵ���</c:if>
								<c:if test="${item[0].attribute==3}">��ʱδ����</c:if>
							</td>
							<td>
								<c:if test="${item[0].attribute!=1}"><!-- ȥ������ɾ��״̬,��������ɾ�����޸Ĳ��� -->
									<c:if test="${item[0].validType==4 || item[0].validType==3}">
										<a href="javascript:del(${item[0].commandId },${pager.pageSize},${pager.currentPage });" class="pn-loperator">ɾ ��</a>
									</c:if>
									<c:if test="${item[0].validType==1 || item[0].validType==2}">
										<a href="javascript:toUpdateCommand(${item[0].commandId },${pager.pageSize},${pager.currentPage });" class="pn-loperator">�޸�</a>|
										<a href="javascript:del(${item[0].commandId },${pager.pageSize},${pager.currentPage });" class="pn-loperator">ɾ ��</a>
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
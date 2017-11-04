<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>��������б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("���������Ϣ��ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
			function del(feeRuleType,type,value,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "zjuPriceConfig_freeDays_delete.do?freeDays.feeRuleType="+feeRuleType+"&freeDays.type="+type+"&freeDays.value="+value+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}			
			function add(){
				window.location.href = "zjuPriceConfig_freeDays_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(feeRuleType,type,value,pageSize,currentPage){
				window.location.href ="zjuPriceConfig_freeDays_edit.do?freeDays.feeRuleType="+feeRuleType+"&freeDays.type="+type+"&freeDays.value="+value+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form  name="tableForm"  method="post" action="zjuPriceConfig_freeDays_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr align="right">
					<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;����������&nbsp;"  onclick="add();"/>
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շ�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<!--<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.feeRuleType}</td>
							-->
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" id="${item.feeRuleType}+${item.type}+${item.value}"></td>
						    <script language="javascript">			    
	                             //�����У������շ�����ȡ�ó��������д������
	                             var feeRuleType=${item.feeRuleType};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	                             var _name = jsonrpc.ajax.get_Name(feeRuleType);                          	 
	                           	 document.getElementById("${item.feeRuleType}+${item.type}+${item.value}").innerHTML=_name;
                            </script>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
								<c:if test="${item.type==0}">����</c:if>
								<c:if test="${item.type==1}">����</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
								<c:choose>
									<c:when test="${item.value eq '1         '}">����һ</c:when>
									<c:when test="${item.value eq '2         '}">���ڶ�</c:when>
									<c:when test="${item.value eq '3         '}">������</c:when>
									<c:when test="${item.value eq '4         '}">������</c:when>
									<c:when test="${item.value eq '5         '}">������</c:when>
									<c:when test="${item.value eq '6         '}">������</c:when>
									<c:when test="${item.value eq '7         '}">������</c:when>
									<c:otherwise>${item.value}</c:otherwise>
								</c:choose>
							
							</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="zjuPriceConfig_freeDays_edit.do?freeDays.feeRuleType=${item.feeRuleType}&freeDays.type=${item.type}&freeDays.value=${item.value}" class="pn-loperator">�޸�</a>-->
							<a href="javascript:edit(${item.feeRuleType},${item.type},'${item.value}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.feeRuleType},${item.type},'${item.value}',${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>

		</div>

	</body>
</html>
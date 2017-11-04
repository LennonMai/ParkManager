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
		<title>���ʹ����б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("���ʹ�����Ϣ��ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
			function del(feeRuleType,vehTypeNo,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "zjuPriceConfig_priceRule_zd_delete.do?priceRule_zd.feeRuleType="+feeRuleType+"&priceRule_zd.vehTypeNo="+vehTypeNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}			
			function add(){
				window.location.href = "zjuPriceConfig_priceRule_zd_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(feeRuleType,vehTypeNo,pageSize,currentPage){
				window.location.href ="zjuPriceConfig_priceRule_zd_edit.do?priceRule_zd.feeRuleType="+feeRuleType+"&priceRule_zd.vehTypeNo="+vehTypeNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form  name="tableForm"  method="post" action="zjuPriceConfig_priceRule_zd_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr align="right">
					<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;��ӷ��ʹ���&nbsp;"  onclick="add();"/>
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շ�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շѽ��֣�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��Ѵ���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��Чʱ���Ƿ�ȡ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ʧЧʱ���Ƿ�ȡ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ÿ��ʹ����Ѵ���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����շѽ��֣�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;ע</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<!--<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.feeRuleType}</td>
							
							-->
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" id="${item.feeRuleType}+${item.vehTypeNo}+${item.freeTimes}+${item.maxFreeTimesUsedEveryTimes}"></td>
						    <script language="javascript">			    
	                             //�����У������շ�����ȡ�ó��������д������
	                             var feeRuleType=${item.feeRuleType};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	                             var _name = jsonrpc.ajax.get_Name(feeRuleType);                          	 
	                           	 document.getElementById("${item.feeRuleType}+${item.vehTypeNo}+${item.freeTimes}+${item.maxFreeTimesUsedEveryTimes}").innerHTML=_name;
                            </script>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
							<c:if test="${item.vehTypeNo==1}">Ħ�г�</c:if>
							<c:if test="${item.vehTypeNo==2}">С��</c:if>
							<c:if test="${item.vehTypeNo==3}">�����ͳ�</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.feeOfOneCycle}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.freeTimes}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
								<c:if test="${item.validateTrim == 0}"> ��ȡ�� </c:if>
								<c:if test="${item.validateTrim == 1}"> ȡ��  </c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
								<c:if test="${item.invalidateTrim == 0}"> ��ȡ��  </c:if>
								<c:if test="${item.invalidateTrim == 1}"> ȡ��  </c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.maxFreeTimesUsedEveryTimes}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.maxTotalFee}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.remark}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="zjuPriceConfig_priceRule_zd_edit.do?priceRule_zd.feeRuleType=${item.feeRuleType}&priceRule_zd.vehTypeNo=${item.vehTypeNo}" class="pn-loperator">�޸�</a>-->
							<a href="javascript:edit(${item.feeRuleType},${item.vehTypeNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.feeRuleType},${item.vehTypeNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>

		</div>

	</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
			if("${result}"=="SUCCESS") {
				alert("�����ܺϼ����ɹ�");
			}
			if("${result}"=="SUCCESS1") {
				alert("����ѡ�г����ϼ����ɹ�");
			}
			if("${result}"=="SUCCESS2") {
				alert("����ȫ�������ϼ����ɹ�");
			}
			//if("${result}"=="FAIL"){
				//alert("�ܺϼ����Ѵ���");
			//}			
		       		
			if("${result}"=="FAIL1"){
				alert("�ù������ڵĹ���ϼ�����ûȫ�����꣬������������ĺϼ�����");
			}
			if("${result}"=="FAIL2"){
				confirm("�ù������ڵĲ��ֹ�������δ�ϴ����Ƿ�ǿ�������ܺϼ�����");
			}
			if("${result}"=="FAIL3"){
				alert("�ù������ڵĲ��ֹ�������δ�ϴ��������ϴ������ݻ�ûȫ�����꣡");
			}
			if("${result}"=="FAIL4"){
				alert("�ó����ϼ����Ѵ���");
			}
			window.onload = function() {
				if("${listButtonStatus}" == "1") {
					get("button").disabled = true;
				}
			}
			//��ӡ
			function doPrint() {
				window.location.href = "generateSum_printGateSum.do?gateNo="+'${gateNo}'+"&squadDateTemp="+'${squadDateTemp}'
					+"&stationYNSum="+'${stationYNSum}';
			}
			function checkyn(stationYNSum){
				alert("a");
			}
			
			function againGenerateGateSum(areaNo,parkNo,gateNo,squadDate,gateNoTemp,squadDateTemp,stationYNSumTemp){
		       	if(confirm("�ϼ����Ѵ��ڣ��Ƿ��������ɺϼ�����")) {
		       		window.location="generateSum_generateGateSum.do?areaNo="+areaNo+"&parkNo="+parkNo+
					"&gateNo="+gateNo+
					"&squadDatejs="+squadDate+
					"&gateNoTemp="+gateNoTemp+
					"&squadDateTemp="+squadDateTemp+
					"&stationYNSumTemp="+stationYNSumTemp;
		       	}
			}
			function generateAllGateSum(){				
				window.location="generateSum_generateAllGateSum.do?gateNoTemp="+'${gateNoTemp}'+"&squadDateTemp="+'${squadDateTemp}'+"&stationYNSumTemp="+'${stationYNSumTemp}';					
			}
			
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="generateSum_queryGateSum.do" >
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						  <select id="gateNo" name="gateNo" style="width: 150px">
						  		<option value="" <c:if test="${gateNo==null}">selected</c:if>>����</option>
						  	<c:forEach items="${listGate}" var="item">
						  		<option value="${item.gateNo}" <c:if test="${gateNo==item.gateNo}">selected</c:if> >${item.gateName}</option>
						  	</c:forEach>
						  </select>
						</td>
						<td class="pn-flabel pn-flabel-h">�������ڣ�</td>
						<td class="pn-fcontent">
						  <input type="text" name="squadDate" value="<fmt:formatDate value="${squadDate }" pattern="yyyy-MM-dd" />" class="Wdate" onclick="WdatePicker()">
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">״̬��</td>
						<td class="pn-fcontent" colspan="3">
						  <select name="stationYNSum" style="width:150px">
								<option value="" <c:if test="${stationYNSum==null}">selected</c:if>>ȫ��</option>
							    <option value="1" <c:if test="${stationYNSum==1}">selected</c:if>>δ�ϼ�</option>
								<option value="2" <c:if test="${stationYNSum==2}">selected</c:if>>�Ѻϼ�</option>
						  </select>
						</td>
					</tr>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� ѯ " />&nbsp;
						<input type="reset" value=" �� �� "/>&nbsp;
						<input type="button" value=" �� ӡ " onclick="doPrint();"/>&nbsp;
						<input id="button" type="button" value="�ϼ�ȫ������ " onclick="generateAllGateSum();"/>
						</td>
					</tr>
				</table>
			<!-- ${fn:length(list)} ��ʾlist����-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>��&nbsp;&nbsp;��</th>
						<th>С&nbsp;&nbsp;��</th>
						<th>��&nbsp;&nbsp;��</th>
						<th>��������</th>
						<th>�����¼��</th>
						<th>����ͨ�з�</th>
						<th>�Ѻϼ�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.AreaName }</td>
							<td>${item.ParkName }</td>
							<td>${item.GateName }</td>
							<td>${item.SquadDate}</td>
							<td>${item.RecordCnt }</td>
							<td>${item.MoneySummation }</td>					
							<!--  <script language="javascript">			    	                            
	                             var areaNo=${item.AreaNo};	
	                             var parkNo=${item.ParkNo};	 
	                             var gateNo=${item.GateNo};	 
	                             var squadDate='${item.SquadDate}';		                                                  
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL                           
	                             var result = jsonrpc.ajax.getCountAndMoney(areaNo,parkNo,gateNo,squadDate);
	                             for (var i=0;i<result.length;i++){			                         
		                                  var no=result[i][0];
		                                  var count=result[i][1];
		                                  var money=result[i][2];	                                      		                        
		                            	  document.getElementById("${item.AreaNo}+${item.ParkNo}+${item.GateNo}+${item.SquadDate}+1").innerHTML=count;	
		                            	  document.getElementById("${item.AreaNo}+${item.ParkNo}+${item.GateNo}+${item.SquadDate}+2").innerHTML=money;		                      
	                              }	  
	                              </script>  -->  	                      
							<td>${item.StationYNSum }</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							 
								<a href="generateSum_queryLaneSum.do?areaNo=${item.areaNo}&parkNo=${item.parkNo}
									&gateNo=${item.gateNo}
									&squadDate=${item.squadDate}
                                    &gateNoTemp=${gateNoTemp}
									&squadDateTemp=${squadDateTemp}
									&stationYNSumTemp=${stationYNSumTemp}" class="pn-loperator">�����ϼ�</a>
								�� 
								<c:choose> 
                            <c:when test="${item.StationYNSum =='��'}">                          
									 <a href="javascript:againGenerateGateSum(${item.areaNo},${item.parkNo},${item.gateNo},'${item.squadDate}','${gateNoTemp}','${squadDateTemp}','${stationYNSumTemp}')" class="pn-loperator">���ºϼ�</a>									
                             </c:when>                            
                             <c:otherwise> 
                              <a href="generateSum_generateGateSum.do?areaNo=${item.areaNo}&parkNo=${item.parkNo}
									&gateNo=${item.gateNo}
									&squadDatejs=${item.squadDate}
									&gateNoTemp=${gateNoTemp}
									&squadDateTemp=${squadDateTemp}
									&stationYNSumTemp=${stationYNSumTemp}" class="pn-loperator" >��&nbsp&nbsp;&nbsp&nbsp;��</a>
                             </c:otherwise> 
                               </c:choose>	
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>
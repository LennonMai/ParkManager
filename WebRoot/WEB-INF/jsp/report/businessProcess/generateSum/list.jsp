<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 使用JavaBean 引入jsonrpc.jar -->
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
				alert("生成总合计数成功");
			}
			if("${result}"=="SUCCESS1") {
				alert("生成选中车道合计数成功");
			}
			if("${result}"=="SUCCESS2") {
				alert("生成全部车道合计数成功");
			}
			//if("${result}"=="FAIL"){
				//alert("总合计数已存在");
			//}			
		       		
			if("${result}"=="FAIL1"){
				alert("该工班日期的工班合计数还没全部做完，请先做各工班的合计数！");
			}
			if("${result}"=="FAIL2"){
				confirm("该工班日期的部分工班数据未上传，是否强制生成总合计数？");
			}
			if("${result}"=="FAIL3"){
				alert("该工班日期的部分工班数据未上传，且已上传的数据还没全部做完！");
			}
			if("${result}"=="FAIL4"){
				alert("该车道合计数已存在");
			}
			window.onload = function() {
				if("${listButtonStatus}" == "1") {
					get("button").disabled = true;
				}
			}
			//打印
			function doPrint() {
				window.location.href = "generateSum_printGateSum.do?gateNo="+'${gateNo}'+"&squadDateTemp="+'${squadDateTemp}'
					+"&stationYNSum="+'${stationYNSum}';
			}
			function checkyn(stationYNSum){
				alert("a");
			}
			
			function againGenerateGateSum(areaNo,parkNo,gateNo,squadDate,gateNoTemp,squadDateTemp,stationYNSumTemp){
		       	if(confirm("合计数已存在，是否重新生成合计数？")) {
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="generateSum_queryGateSum.do" >
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">大门名称：</td>
						<td class="pn-fcontent">
						  <select id="gateNo" name="gateNo" style="width: 150px">
						  		<option value="" <c:if test="${gateNo==null}">selected</c:if>>所有</option>
						  	<c:forEach items="${listGate}" var="item">
						  		<option value="${item.gateNo}" <c:if test="${gateNo==item.gateNo}">selected</c:if> >${item.gateName}</option>
						  	</c:forEach>
						  </select>
						</td>
						<td class="pn-flabel pn-flabel-h">工班日期：</td>
						<td class="pn-fcontent">
						  <input type="text" name="squadDate" value="<fmt:formatDate value="${squadDate }" pattern="yyyy-MM-dd" />" class="Wdate" onclick="WdatePicker()">
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">状态：</td>
						<td class="pn-fcontent" colspan="3">
						  <select name="stationYNSum" style="width:150px">
								<option value="" <c:if test="${stationYNSum==null}">selected</c:if>>全部</option>
							    <option value="1" <c:if test="${stationYNSum==1}">selected</c:if>>未合计</option>
								<option value="2" <c:if test="${stationYNSum==2}">selected</c:if>>已合计</option>
						  </select>
						</td>
					</tr>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" 查 询 " />&nbsp;
						<input type="reset" value=" 重 置 "/>&nbsp;
						<input type="button" value=" 打 印 " onclick="doPrint();"/>&nbsp;
						<input id="button" type="button" value="合计全部大门 " onclick="generateAllGateSum();"/>
						</td>
					</tr>
				</table>
			<!-- ${fn:length(list)} 显示list长度-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>区&nbsp;&nbsp;域</th>
						<th>小&nbsp;&nbsp;区</th>
						<th>大&nbsp;&nbsp;门</th>
						<th>工班日期</th>
						<th>工班记录数</th>
						<th>工班通行费</th>
						<th>已合计</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
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
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL                           
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
									&stationYNSumTemp=${stationYNSumTemp}" class="pn-loperator">车道合计</a>
								┆ 
								<c:choose> 
                            <c:when test="${item.StationYNSum =='是'}">                          
									 <a href="javascript:againGenerateGateSum(${item.areaNo},${item.parkNo},${item.gateNo},'${item.squadDate}','${gateNoTemp}','${squadDateTemp}','${stationYNSumTemp}')" class="pn-loperator">重新合计</a>									
                             </c:when>                            
                             <c:otherwise> 
                              <a href="generateSum_generateGateSum.do?areaNo=${item.areaNo}&parkNo=${item.parkNo}
									&gateNo=${item.gateNo}
									&squadDatejs=${item.squadDate}
									&gateNoTemp=${gateNoTemp}
									&squadDateTemp=${squadDateTemp}
									&stationYNSumTemp=${stationYNSumTemp}" class="pn-loperator" >合&nbsp&nbsp;&nbsp&nbsp;计</a>
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
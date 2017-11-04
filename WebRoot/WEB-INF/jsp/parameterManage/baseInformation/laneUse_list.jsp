<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>

<html>
	<head>
		<title>有用车道信息列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS")
			alert("设置成功"); 
			function addLaneUse(areaNo,parkNo,gateNo,laneNo){
				if(confirm("确认要启用吗？")){
					 window.location.href ="baseInfo_addLaneUse.do?laneUse.areaNo="+areaNo+"&laneUse.parkNo="+parkNo+"&laneUse.gateNo="+gateNo+"&laneUse.laneNo="+laneNo;
				}
			}
			function deleteLaneUse(areaNo,parkNo,gateNo,laneNo){
				if(confirm("确认要不启用吗？")){
				    window.location.href ="baseInfo_deleteLaneUse.do?laneUse.areaNo="+areaNo+"&laneUse.parkNo="+parkNo+"&laneUse.gateNo="+gateNo+"&laneUse.laneNo="+laneNo;
				}
			}
			function addAllLaneUse(){
				if(confirm("确认设置为全启用吗？")){
				    window.location.href ="baseInfo_addAllLaneUse.do";
				}
			}
			function deleteAllLaneUse(){
				if(confirm("确认设置为全不启用吗？")){
				    window.location.href ="baseInfo_deleteAllLaneUse.do";
				}
			}
			<%--function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
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
		--%></script>
	</head> 
	<body>
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="baseInfo_laneUse_list.do" >
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">	
						<input type="button"  value=" 设置为全启用 "  onclick="addAllLaneUse();"/> &nbsp;
						<input type="button"  value=" 设置为全不启用 "  onclick="deleteAllLaneUse();"/> &nbsp;				
						</td>
					</tr>
				</table>
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="height: 22px;background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="hidden"  value="&nbsp;添加有用车道&nbsp;"  onclick="add();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">区域编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">小区编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">大门编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">大门名称</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车道编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">计算机IP地址</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">是否已启用</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" >
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.parkNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.gateNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:forEach items="${gateList}" var="gate">
             		 		<c:if test="${item.gateNo==gate.gateNo}">${gate.gateName}</c:if> 
             				</c:forEach>
							</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneComputerIp}</td>
							<td  id="${item.areaNo}${item.parkNo}${item.gateNo}${item.laneNo}" style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;"></td>							
							<script language="javascript">			    	                            
	                             var areaNo=${item.areaNo};
	                             var parkNo=${item.parkNo};	
	                             var gateNo=${item.gateNo};	
	                             var laneNo=${item.laneNo};		                          
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	                             var result = jsonrpc.ajax.getUseLane(areaNo,parkNo,gateNo,laneNo);	                           	                     	 
		                         var isExist=result[0][0]; 		                       
		                         document.getElementById("${item.areaNo}${item.parkNo}${item.gateNo}${item.laneNo}").innerHTML=isExist;	 		                        			                        	                        		                                           		                         			                                                      	
                            </script>
							<%--<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.isUse==0}">NO</c:if>
							<c:if test="${item.isUse==1}">YES</c:if>
							</td>	
							
							--%><td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:addLaneUse(${item.areaNo},${item.parkNo},${item.gateNo},${item.laneNo})" class="pn-loperator">启用</a>┆<a href="javascript:deleteLaneUse(${item.areaNo},${item.parkNo},${item.gateNo},${item.laneNo})" class="pn-loperator">不启用</a>
							<%-- ┆ <a href="javascript:del(${item.areaNo},${item.parkNo},${item.gateNo},${item.laneNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">删除</a> --%></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<%--<jsp:include page="../../include/pager.jsp"/>
			--%></form>
		
		</div>
		
	</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>免费日期列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("免费日期信息添加成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
			function del(feeRuleType,type,value,pageSize,currentPage){
				if(confirm("确认要删除吗？")){
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
				<div class="rpos">当前位置： ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="zjuPriceConfig_freeDays_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr align="right">
					<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;添加免费日期&nbsp;"  onclick="add();"/>
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">收费类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">类&nbsp;&nbsp;型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">免费日期</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<!--<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.feeRuleType}</td>
							-->
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" id="${item.feeRuleType}+${item.type}+${item.value}"></td>
						    <script language="javascript">			    
	                             //构造列，根据收费类型取得车辆类别名写进列中
	                             var feeRuleType=${item.feeRuleType};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	                             var _name = jsonrpc.ajax.get_Name(feeRuleType);                          	 
	                           	 document.getElementById("${item.feeRuleType}+${item.type}+${item.value}").innerHTML=_name;
                            </script>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
								<c:if test="${item.type==0}">星期</c:if>
								<c:if test="${item.type==1}">日期</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
								<c:choose>
									<c:when test="${item.value eq '1         '}">星期一</c:when>
									<c:when test="${item.value eq '2         '}">星期二</c:when>
									<c:when test="${item.value eq '3         '}">星期三</c:when>
									<c:when test="${item.value eq '4         '}">星期四</c:when>
									<c:when test="${item.value eq '5         '}">星期五</c:when>
									<c:when test="${item.value eq '6         '}">星期六</c:when>
									<c:when test="${item.value eq '7         '}">星期日</c:when>
									<c:otherwise>${item.value}</c:otherwise>
								</c:choose>
							
							</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="zjuPriceConfig_freeDays_edit.do?freeDays.feeRuleType=${item.feeRuleType}&freeDays.type=${item.type}&freeDays.value=${item.value}" class="pn-loperator">修改</a>-->
							<a href="javascript:edit(${item.feeRuleType},${item.type},'${item.value}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							┆ <a href="javascript:del(${item.feeRuleType},${item.type},'${item.value}',${pager.pageSize},${pager.currentPage});" class="pn-loperator">删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>

		</div>

	</body>
</html>
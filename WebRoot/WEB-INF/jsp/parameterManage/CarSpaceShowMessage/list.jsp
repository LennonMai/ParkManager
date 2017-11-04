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
		<title>车位显示信息列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">
			if("${result}"=="SUCCESS")
				alert("操作成功"); 
			if("${result}"=="FAIL")
				alert("操作失败");
			function display(parkNo,gateNo,laneNo){
				if(confirm("确认要设置为可显示吗？")){
					 window.location.href ="carSpaceShowMessage_display.do?carSpaceShowMessage.parkNo="+parkNo+"&carSpaceShowMessage.gateNo="+gateNo+"&carSpaceShowMessage.laneNo="+laneNo;
				}
			}
			function noDisplay(parkNo,gateNo,laneNo){
				if(confirm("确认要设置为不可显示吗？")){
					window.location.href ="carSpaceShowMessage_noDisplay.do?carSpaceShowMessage.parkNo="+parkNo+"&carSpaceShowMessage.gateNo="+gateNo+"&carSpaceShowMessage.laneNo="+laneNo;
				}
			}
			
			function toSave(){
				window.location.href = "carSpaceShowMessage_toSave.do"
			}
			function toUpdate(parkNo,gateNo,laneNo){				
				window.location.href ="carSpaceShowMessage_toUpdate.do?carSpaceShowMessage.parkNo="+parkNo+"&carSpaceShowMessage.gateNo="+gateNo+"&carSpaceShowMessage.laneNo="+laneNo;
			}
			function deleteCarSpaceShowMessage(parkNo,gateNo,laneNo){	
				if(confirm("确认要删除吗？")){			
					window.location.href ="carSpaceShowMessage_deleteCarSpaceShowMessage.do?carSpaceShowMessage.parkNo="+parkNo+"&carSpaceShowMessage.gateNo="+gateNo+"&carSpaceShowMessage.laneNo="+laneNo;
				}	
			}		
			</script>
	</head> 
	<body>
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="carSpaceShowMessage_list.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
							<input style="height: 22px;" type="button"  value="&nbsp;添加车位显示信息&nbsp;"  onclick="toSave();"/>
						</td>
					</tr>
			</table>
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">小区名称</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">大门名称</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车道编号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">显示内容</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">是否显示</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" >
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
								<c:forEach items="${parkList}" var="parkitem">
             		 				<c:if test="${item.parkNo==parkitem.parkNo}">${parkitem.parkName}</c:if> 
             					</c:forEach>
							</td>	
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:forEach items="${gateList}" var="gateitem">
             		 		<c:if test="${item.parkNo==gateitem.parkNo&&item.gateNo==gateitem.gateNo}">${gateitem.gateName}</c:if> 
             				</c:forEach>
							</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.initShow}</td>			
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.isShowPosition==1}">NO</c:if>
							<c:if test="${item.isShowPosition==0}">YES</c:if>
							</td>															
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<c:if test="${item.isShowPosition==1}">
								<a href="javascript:display(${item.parkNo},${item.gateNo},${item.laneNo})" class="pn-loperator">显 &nbsp;示</a>┆ <a href="javascript:toUpdate(${item.parkNo},${item.gateNo},${item.laneNo});" class="pn-loperator">修改</a>┆ <a href="javascript:deleteCarSpaceShowMessage(${item.parkNo},${item.gateNo},${item.laneNo});" class="pn-loperator">删除</a>
							</c:if>
							<c:if test="${item.isShowPosition==0}">
								<a href="javascript:noDisplay(${item.parkNo},${item.gateNo},${item.laneNo})" class="pn-loperator">不显示</a>┆ <a href="javascript:toUpdate(${item.parkNo},${item.gateNo},${item.laneNo});" class="pn-loperator">修改</a>┆ <a href="javascript:deleteCarSpaceShowMessage(${item.parkNo},${item.gateNo},${item.laneNo});" class="pn-loperator">删除</a>
							</c:if>
							</td>							
						</tr>
					</c:forEach>
				</tbody>
			</table>
         </form>
		
		</div>
		
	</body>
</html>
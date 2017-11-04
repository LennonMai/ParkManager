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
		<title>停车位监控列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">
			function toSave() {
				console.log(1);
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
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">小区</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">大门</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">空余车位数</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">最大车位数</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" >
						<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">华南师范大学</td>	
						<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">全区</td>		
						<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">500</td>
						<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">1000</td>															
						<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:void(0);" class="pn-loperator">修 &nbsp;改</a>
						</td>							
					</tr>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
         </form>
		
		</div>
		
	</body>
</html>
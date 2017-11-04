<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>车道类型编码</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">

		</script>
	</head> 
	<body >
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="operatePara_laneType_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
					    <td class="pn-flabel pn-flabel-h">车道类型编号：</td>
						<td class="pn-fcontent"> <input type="text" name="laneType.laneTypeNo" value="${laneType.laneTypeNo }" size="24"/></td>
						<td class="pn-flabel pn-flabel-h">车道类型名称：</td>
						<td class="pn-fcontent"> <input type="text" name="laneType.laneTypeName" value="${laneType.laneTypeName }" size="24"/></td>
					
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton" style="padding-bottom: 3px;padding-top: 3px;">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" 查 询 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 "/>	
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车道类型编号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车道类型名称</th>
						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" >
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneTypeNo}</td>
						    <td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneTypeName}</td>
							
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		</div>		
	</body>
</html>
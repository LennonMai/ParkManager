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
		<title>�·��������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>	
		<script language="javascript">
			if("${message}"=="success"){
				alert("ɾ���ɹ��� ");
				}
			if("${message}"=="deleteBCSuccess"){
				alert("����ɾ���ɹ��� ");
				}
			function del(fieldValue,laneNo,laneComputerIp,tableName,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "sendPara_delete.do?sendPara.sendType="+get("sendPara.sendType").value+"&sendPara.fieldValue="+fieldValue+"&sendPara.laneNo="+laneNo+"&sendPara.laneComputerIp="+laneComputerIp+"&sendPara.tableName="+tableName+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			function deleteByCondition(){
				if(confirm("ȷ��Ҫ������������ɾ����")){
					window.location.href = "sendPara_deleteFailSendPara.do?sendPara.sendType="+get("sendPara.sendType").value+"&sendPara.fieldName="+get("sendPara.fieldName").value+"&sendPara.fieldValue="+get("sendPara.fieldValue").value+"&sendPara.laneNo="+get("sendPara.laneNo").value+"&sendPara.laneComputerIp="+get("sendPara.laneComputerIp").value+"&sendPara.tableName="+get("sendPara.tableName").value;
				}
			}	
		</script>
	</head> 
	<body>
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="sendPara_queryFailSendList.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td  class="pn-flabel pn-flabel-h">�ֶ�����</td>
						<td  class="pn-fcontent"><input type="text" name="sendPara.fieldName" value="${sendPara.fieldName}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">�·����ͣ�</td>
						<td  class="pn-fcontent">
						<select  name="sendPara.sendType"  style="width: 178px;height: 24px;;">
						   <option value="1" <c:if test="${sendPara.sendType==1}">selected="selected"</c:if>> ��ͨ����</option>
						   <option value="2" <c:if test="${sendPara.sendType==2}">selected="selected"</c:if>> ͼƬ</option>
						   <option value="0" <c:if test="${sendPara.sendType==0}">selected="selected"</c:if>> ��ͨ������ͼƬ</option>
						</select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">�ֶ�ֵ��</td>
						<td  class="pn-fcontent"> <input type="text" name="sendPara.fieldValue" value="${sendPara.fieldValue}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">�������룺</td>
						<td  class="pn-fcontent"> <input type="text" name="sendPara.laneNo" value="${sendPara.laneNo}" size="24"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">����IP��</td>
						<td  class="pn-fcontent"> <input type="text" name="sendPara.laneComputerIp" value="${sendPara.laneComputerIp}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">������Ŀ¼��</td>
						<td  class="pn-fcontent"> <input type="text" name="sendPara.tableName" value="${sendPara.tableName}" size="24"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button" value=" ����ɾ�� " onclick="deleteByCondition()"/>&nbsp;
						</td>
					</tr>
					<tr>
					    <td style="width: 130px;" class="pn-flabel pn-flabel-h">��ͨ�����·�ʧ������</td>
						<td colspan="3" class="pn-fcontent"><span style="font-weight: bolder;">${typeOneCount}</span></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">ͼ&nbsp;&nbsp;&nbsp;&nbsp;Ƭ�·�ʧ������</td>
						<td colspan="3" class="pn-fcontent"><span style="font-weight: bolder;">${typeTwoCount}</span></td>
					</tr>
				</table>		
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�·�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������Ŀ¼��</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ļ���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����������Ŀ¼��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ֶ���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ֶ�ֵ</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����IP</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>	
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.sendType==1}">��ͨ����</c:if>
							<c:if test="${item.sendType==2}">ͼ&nbsp;&nbsp;&nbsp;&nbsp;Ƭ</c:if>
							</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.tableName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.fileName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;" id="${item.fieldValue}+${item.laneNo}+${item.laneComputerIp}+${item.tableName}"></td>
							<script language="javascript">			    
	 							//�����У������շ�����ȡ�ó��������д������ 
	  							var itemValue='${item.tableName}';  
	  							//alert(itemValue);  
	 							jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	  							var _item = jsonrpc.ajax.getItemByitemValue(itemValue);    
	  							//alert(_item);                      	 
	  							document.getElementById("${item.fieldValue}+${item.laneNo}+${item.laneComputerIp}+${item.tableName}").innerHTML=_item;
    						</script>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.fieldName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.fieldValue}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneComputerIp}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:del('${item.fieldValue}',${item.laneNo},'${item.laneComputerIp}','${item.tableName}',${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ&nbsp;��</a>
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
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
		<title>��λ��ʾ��Ϣ�б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">
			if("${result}"=="SUCCESS")
				alert("�����ɹ�"); 
			if("${result}"=="FAIL")
				alert("����ʧ��");
			function display(parkNo,gateNo,laneNo){
				if(confirm("ȷ��Ҫ����Ϊ����ʾ��")){
					 window.location.href ="carSpaceShowMessage_display.do?carSpaceShowMessage.parkNo="+parkNo+"&carSpaceShowMessage.gateNo="+gateNo+"&carSpaceShowMessage.laneNo="+laneNo;
				}
			}
			function noDisplay(parkNo,gateNo,laneNo){
				if(confirm("ȷ��Ҫ����Ϊ������ʾ��")){
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
				if(confirm("ȷ��Ҫɾ����")){			
					window.location.href ="carSpaceShowMessage_deleteCarSpaceShowMessage.do?carSpaceShowMessage.parkNo="+parkNo+"&carSpaceShowMessage.gateNo="+gateNo+"&carSpaceShowMessage.laneNo="+laneNo;
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
			<form  name="tableForm"  method="post" action="carSpaceShowMessage_list.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
							<input style="height: 22px;" type="button"  value="&nbsp;��ӳ�λ��ʾ��Ϣ&nbsp;"  onclick="toSave();"/>
						</td>
					</tr>
			</table>
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С������</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ʾ����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�Ƿ���ʾ</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
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
								<a href="javascript:display(${item.parkNo},${item.gateNo},${item.laneNo})" class="pn-loperator">�� &nbsp;ʾ</a>�� <a href="javascript:toUpdate(${item.parkNo},${item.gateNo},${item.laneNo});" class="pn-loperator">�޸�</a>�� <a href="javascript:deleteCarSpaceShowMessage(${item.parkNo},${item.gateNo},${item.laneNo});" class="pn-loperator">ɾ��</a>
							</c:if>
							<c:if test="${item.isShowPosition==0}">
								<a href="javascript:noDisplay(${item.parkNo},${item.gateNo},${item.laneNo})" class="pn-loperator">����ʾ</a>�� <a href="javascript:toUpdate(${item.parkNo},${item.gateNo},${item.laneNo});" class="pn-loperator">�޸�</a>�� <a href="javascript:deleteCarSpaceShowMessage(${item.parkNo},${item.gateNo},${item.laneNo});" class="pn-loperator">ɾ��</a>
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
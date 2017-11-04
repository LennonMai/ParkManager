<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>�·������ɹ���Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>	
		<script language="javascript">
			if("${message}"=="deleteSuccess"){
				alert("ɾ���ɹ��� ");
				}
			if("${message}"=="deleteBCSuccess"){
				alert("����ɾ���ɹ��� ");
				}
			function del(fieldValue,laneNo,laneComputerIp,tableName,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "sendParaResult_delete.do?sendParaResult.sendType="+get("sendParaResult.sendType").value+"&sendParaResult.fieldValue="+fieldValue+"&sendParaResult.laneNo="+laneNo+"&sendParaResult.laneComputerIp="+laneComputerIp+"&sendParaResult.tableName="+tableName+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			function deleteByCondition(){
				if(confirm("ȷ��Ҫ������������ɾ����")){
					window.location.href = "sendParaResult_deleteByCondition.do?sendParaResult.sendType="+get("sendParaResult.sendType").value+"&sendParaResult.fieldName="+get("sendParaResult.fieldName").value+"&sendParaResult.fieldValue="+get("sendParaResult.fieldValue").value+"&sendParaResult.laneNo="+get("sendParaResult.laneNo").value+"&sendParaResult.laneComputerIp="+get("sendParaResult.laneComputerIp").value+"&sendParaResult.tableName="+get("sendParaResult.tableName").value+"&sendParaResult.fileName="+get("sendParaResult.fileName").value+"&sendParaResult.sendResult="+get("sendParaResult.sendResult").value+"&startTime="+get("startTime").value+"&endTime="+get("endTime").value;
				}
			}	
			  
		    function check(){		       
		        if(get("startTime").value !=""&& get("endTime").value != ""){
				      if(get("startTime").value > get("endTime").value) {
				         alert("��ʼʱ��������ڻ���ڽ���ʱ��");
				    	 return false;				        
				        }
			     }	
		        if(get("startTime").value =="" && get("endTime").value !=""){					
					alert("ʱ�������һ������Ϊ�գ�");
					return false;					
			     }  
		        if(get("startTime").value !="" && get("endTime").value ==""){					
					alert("ʱ�������һ������Ϊ�գ�");
					return false;					
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
			<form  name="tableForm"  method="post" action="sendParaResult_query.do" onsubmit="return check();">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td  class="pn-flabel pn-flabel-h">�ֶ�����</td>
						<td  class="pn-fcontent"><input type="text" name="sendParaResult.fieldName" value="${fieldName}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">�·����ͣ�</td>
						<td  class="pn-fcontent">
						<select  name=sendParaResult.sendType  style="width: 178px;height: 24px;;">
						   <option value="" <c:if test="${sendParaResult.sendType==null}">selected="selected"</c:if>>- ��ѡ�� -</option>
						   <option value="1" <c:if test="${sendParaResult.sendType==1}">selected="selected"</c:if>> ��ͨ����</option>
						   <option value="2" <c:if test="${sendParaResult.sendType==2}">selected="selected"</c:if>> ͼƬ</option>
						   <option value="0" <c:if test="${sendParaResult.sendType==0}">selected="selected"</c:if>> ��ͨ������ͼƬ</option>
						</select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">�ֶ�ֵ��</td>
						<td  class="pn-fcontent"> <input type="text" name="sendParaResult.fieldValue" value="${sendParaResult.fieldValue}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">�������룺</td>
						<td  class="pn-fcontent"> <input type="text" name="sendParaResult.laneNo" value="${sendParaResult.laneNo}" size="24"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">����IP��</td>
						<td  class="pn-fcontent"> <input type="text" name="sendParaResult.laneComputerIp" value="${sendParaResult.laneComputerIp}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">������Ŀ¼��</td>
						<td  class="pn-fcontent"> <input type="text" name="sendParaResult.tableName" value="${sendParaResult.tableName}" size="24"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">�ļ�����</td>
						<td  class="pn-fcontent"><input type="text" name="sendParaResult.fileName" value="${sendParaResult.fileName}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">�·������</td>
						<td  class="pn-fcontent">
						<select  name="sendParaResult.sendResult"  style="width: 178px;height: 24px;;">
						   <option value="" <c:if test="${sendParaResult.sendResult==null}">selected="selected"</c:if>>- ��ѡ�� -</option>
						   <option value="0" <c:if test="${sendParaResult.sendResult==0}">selected="selected"</c:if>> �ɹ�</option>
						   <option value="-1" <c:if test="${sendParaResult.sendResult==-1}">selected="selected"</c:if>> ����ping��ͨ</option>
						   <option value="-2" <c:if test="${sendParaResult.sendResult==-2}">selected="selected"</c:if>> �Է�����ʧ��</option>
						   <option value="-3" <c:if test="${sendParaResult.sendResult==-3}">selected="selected"</c:if>> ����ʧ��</option>
						</select>
						</td>
					
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h" >ʱ��Σ�</td>
						<td colspan="3" class="pn-fcontent" >
						  <input type="text" id="startTime" name="startTime" value="${startTime}"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input type="text" id="endTime" name="endTime"  value="${endTime}"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">				
						</td>
					    </tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button" value=" ����ɾ�� " onclick="deleteByCondition()"/>&nbsp;
						</td>
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
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�·����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�·�ʱ��</th>
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
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.sendResult==0}">�ɹ�</c:if>
							<c:if test="${item.sendResult==-1}">����ping��ͨ</c:if>
							<c:if test="${item.sendResult==-2}">�Է�����ʧ��</c:if>
							<c:if test="${item.sendResult==-3}">����ʧ��</c:if>
							</td>							
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;"><fmt:formatDate value="${item.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>							
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
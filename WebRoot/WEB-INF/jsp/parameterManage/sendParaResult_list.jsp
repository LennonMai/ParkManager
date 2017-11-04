<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>下发参数成功信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>	
		<script language="javascript">
			if("${message}"=="deleteSuccess"){
				alert("删除成功！ ");
				}
			if("${message}"=="deleteBCSuccess"){
				alert("条件删除成功！ ");
				}
			function del(fieldValue,laneNo,laneComputerIp,tableName,pageSize,currentPage){
				if(confirm("确认要删除吗？")){
					window.location.href = "sendParaResult_delete.do?sendParaResult.sendType="+get("sendParaResult.sendType").value+"&sendParaResult.fieldValue="+fieldValue+"&sendParaResult.laneNo="+laneNo+"&sendParaResult.laneComputerIp="+laneComputerIp+"&sendParaResult.tableName="+tableName+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			function deleteByCondition(){
				if(confirm("确认要根据以上条件删除吗？")){
					window.location.href = "sendParaResult_deleteByCondition.do?sendParaResult.sendType="+get("sendParaResult.sendType").value+"&sendParaResult.fieldName="+get("sendParaResult.fieldName").value+"&sendParaResult.fieldValue="+get("sendParaResult.fieldValue").value+"&sendParaResult.laneNo="+get("sendParaResult.laneNo").value+"&sendParaResult.laneComputerIp="+get("sendParaResult.laneComputerIp").value+"&sendParaResult.tableName="+get("sendParaResult.tableName").value+"&sendParaResult.fileName="+get("sendParaResult.fileName").value+"&sendParaResult.sendResult="+get("sendParaResult.sendResult").value+"&startTime="+get("startTime").value+"&endTime="+get("endTime").value;
				}
			}	
			  
		    function check(){		       
		        if(get("startTime").value !=""&& get("endTime").value != ""){
				      if(get("startTime").value > get("endTime").value) {
				         alert("开始时间必须早于或等于结束时间");
				    	 return false;				        
				        }
			     }	
		        if(get("startTime").value =="" && get("endTime").value !=""){					
					alert("时间段其中一个不能为空！");
					return false;					
			     }  
		        if(get("startTime").value !="" && get("endTime").value ==""){					
					alert("时间段其中一个不能为空！");
					return false;					
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
			<form  name="tableForm"  method="post" action="sendParaResult_query.do" onsubmit="return check();">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td  class="pn-flabel pn-flabel-h">字段名：</td>
						<td  class="pn-fcontent"><input type="text" name="sendParaResult.fieldName" value="${fieldName}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">下发类型：</td>
						<td  class="pn-fcontent">
						<select  name=sendParaResult.sendType  style="width: 178px;height: 24px;;">
						   <option value="" <c:if test="${sendParaResult.sendType==null}">selected="selected"</c:if>>- 请选择 -</option>
						   <option value="1" <c:if test="${sendParaResult.sendType==1}">selected="selected"</c:if>> 普通参数</option>
						   <option value="2" <c:if test="${sendParaResult.sendType==2}">selected="selected"</c:if>> 图片</option>
						   <option value="0" <c:if test="${sendParaResult.sendType==0}">selected="selected"</c:if>> 普通参数与图片</option>
						</select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">字段值：</td>
						<td  class="pn-fcontent"> <input type="text" name="sendParaResult.fieldValue" value="${sendParaResult.fieldValue}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">车道编码：</td>
						<td  class="pn-fcontent"> <input type="text" name="sendParaResult.laneNo" value="${sendParaResult.laneNo}" size="24"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">车道IP：</td>
						<td  class="pn-fcontent"> <input type="text" name="sendParaResult.laneComputerIp" value="${sendParaResult.laneComputerIp}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">表名或目录：</td>
						<td  class="pn-fcontent"> <input type="text" name="sendParaResult.tableName" value="${sendParaResult.tableName}" size="24"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">文件名：</td>
						<td  class="pn-fcontent"><input type="text" name="sendParaResult.fileName" value="${sendParaResult.fileName}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">下发结果：</td>
						<td  class="pn-fcontent">
						<select  name="sendParaResult.sendResult"  style="width: 178px;height: 24px;;">
						   <option value="" <c:if test="${sendParaResult.sendResult==null}">selected="selected"</c:if>>- 请选择 -</option>
						   <option value="0" <c:if test="${sendParaResult.sendResult==0}">selected="selected"</c:if>> 成功</option>
						   <option value="-1" <c:if test="${sendParaResult.sendResult==-1}">selected="selected"</c:if>> 网络ping不通</option>
						   <option value="-2" <c:if test="${sendParaResult.sendResult==-2}">selected="selected"</c:if>> 对方接受失败</option>
						   <option value="-3" <c:if test="${sendParaResult.sendResult==-3}">selected="selected"</c:if>> 发送失败</option>
						</select>
						</td>
					
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h" >时间段：</td>
						<td colspan="3" class="pn-fcontent" >
						  <input type="text" id="startTime" name="startTime" value="${startTime}"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input type="text" id="endTime" name="endTime"  value="${endTime}"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">				
						</td>
					    </tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"value=" 查 询 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button" value=" 条件删除 " onclick="deleteByCondition()"/>&nbsp;
						</td>
					</tr>
				</table>		
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">下发类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">表名（或目录）</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">文件名</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">参数名（或目录）</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">字段名</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">字段值</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车道编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车道IP</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">下发结果</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">下发时间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>	
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.sendType==1}">普通参数</c:if>
							<c:if test="${item.sendType==2}">图&nbsp;&nbsp;&nbsp;&nbsp;片</c:if>
							</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.tableName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.fileName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;" id="${item.fieldValue}+${item.laneNo}+${item.laneComputerIp}+${item.tableName}"></td>
							<script language="javascript">			    
	  							var itemValue='${item.tableName}';  
	  							//alert(itemValue);  
	 							jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	  							var _item = jsonrpc.ajax.getItemByitemValue(itemValue);    
	  							//alert(_item);                      	 
	  							document.getElementById("${item.fieldValue}+${item.laneNo}+${item.laneComputerIp}+${item.tableName}").innerHTML=_item;
    						</script>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.fieldName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.fieldValue}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.laneComputerIp}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.sendResult==0}">成功</c:if>
							<c:if test="${item.sendResult==-1}">网络ping不通</c:if>
							<c:if test="${item.sendResult==-2}">对方接受失败</c:if>
							<c:if test="${item.sendResult==-3}">发送失败</c:if>
							</td>							
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;"><fmt:formatDate value="${item.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>							
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:del('${item.fieldValue}',${item.laneNo},'${item.laneComputerIp}','${item.tableName}',${pager.pageSize},${pager.currentPage});" class="pn-loperator">删&nbsp;除</a>
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
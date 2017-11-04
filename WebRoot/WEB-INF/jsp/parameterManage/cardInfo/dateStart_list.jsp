<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>粤通卡启动日期设置</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("粤通卡启动日期设置成功！");
			}
		</script>
	</head> 
	<body>
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" name="tableForm"  method="post" action="cardInfo_dateStart_set.do">
			<table align="center" width="100%" style="background-color:#B4CFCF;margin-top:5px;" cellpadding="0" cellspacing="1" border="0">			
				<tr >
				<td style="white-space:nowrap;padding-left:5px;padding-right:5px;width: 46%;" class="pn-flabel pn-flabel-h">储值卡有效启用日期：</td>
				<td style="padding-left: 10px;" class="pn-fcontent"><input size="28"  type="text" class="required " name="storeCardDate.firTime" value="<fmt:formatDate value="${storeCardDate.firTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span>
				</td>				   
				</tr>
				<tr >
				<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">记账卡有效启用日期：</td>
				<td style="padding-left:10px;" class="pn-fcontent"><input  size="28"  type="text" class="required " name="tollyCardDate.firTime" value="<fmt:formatDate value="${tollyCardDate.firTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span>
				</td>				   
				</tr>
				<tr>
				<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h"><span style="font-weight: bolder;">OBU&nbsp;</span>有效启用日期：</td>
				<td style="padding-left: 10px;" class="pn-fcontent"><input  size="28"  type="text" class="required " name="obuDate.firTime" value="<fmt:formatDate value="${obuDate.firTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span>
				</td>				   
				</tr>
				<tr>
				<td colspan="3" style="background-color:#FFFFFF;text-align:center; padding-top: 5px;padding-bottom: 5px; ">
				   <input align="middle" style="padding-left: 10px;padding-right: 10px;" type="submit" value=" 启 用 "/>&nbsp;
		           <input align="middle" style="padding-left: 10px;padding-right: 10px;" type="reset" value=" 重 置 "/>&nbsp;
				</td>
				</tr>
			</table>
			
			<table style="margin-top:5px;" align="center" id="controltb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">储值卡有效启用日期</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">记账卡有效启用日期</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;"><span style="font-weight: bolder;">OBU&nbsp;</span>有效启用日期</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
                  	<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
						<td style="word-break:break-all;padding-left:5px;padding-right:5px;" id="storeCardDate"></td>
						<td style="word-break:break-all;padding-left:5px;padding-right:5px;" id="tollyCardDate"></td>
						<td style="word-break:break-all;padding-left:5px;padding-right:5px;" id="obuDate"></td>
						<script language="javascript">			    
	                             //构造列，获取储值卡有效启用日期写进列中
	                             jsonrpc = new JSONRpcClient("JSON-RPC");
	                             var result = jsonrpc.ajax.getDate_StoreCardTollyCardOBU();
	                             //alert(result);
	                             for(var i=0;i<result.length;i++){	
									if(result[i][0]=="StoreCard")document.getElementById("storeCardDate").innerHTML=result[i][1];
									if(result[i][0]=="TollyCard") document.getElementById("tollyCardDate").innerHTML=result[i][1];
									if(result[i][0]=="OBU") document.getElementById("obuDate").innerHTML=result[i][1];
		                             }	                           	                         
		                         
                        </script>
					</tr>
				</tbody>
			</table>
			
			</form>

		</div>

	</body>
</html>
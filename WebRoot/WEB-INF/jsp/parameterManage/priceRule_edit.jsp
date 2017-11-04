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
		<title>修改车道费率</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
	
		function back(){
			window.location.href = "priceRule_list.do";
		}
		function check(){
			if(document.getElementById('priceRule_endRange').value != ""){
				var max = document.getElementById('priceRule_endRange').value;
				var min = document.getElementById('priceRule_startRange').value;
				if(parseInt(min) > parseInt(max)){
					alert("最小时间不能大于最大时间");
					return false;
				}
			}
			return true;
		}

		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="priceRule_updatePriceRule.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">小区编码：</td>
						<td class="pn-fcontent">${priceRule.parkNo}<input readonly="readonly" type="hidden"  name="priceRule.parkNo" value="${priceRule.parkNo}" size="28"/> </td>
			    		<td class="pn-flabel pn-flabel-h">小区名称：</td>
						<td id="_parkName"  class="pn-fcontent"> </td>
						<script language="javascript">			    
	                             //构造列，根据小区编号取得小区名称写进列中
	                             var parkNo=${priceRule.parkNo};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	                             var result = jsonrpc.ajax.getParkNo_ParkName();	                           	 
	                           	 for (var i=0;i<result.length;i++){	                    	 
		                              var no=result[i][0];
		                              var _name=result[i][1];
		                              if(no==parkNo){               
		                            	  document.getElementById("_parkName").innerHTML=_name;
			                            }   	
	                         	}	                         	
                        </script>
						</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">车&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
						<td class="pn-fcontent">
						<c:if test="${priceRule.vehTypeNo==1 }"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.vehTypeNo">						
						<option value="1" selected="selected">摩托车</option>
						</select></c:if>
						<c:if test="${priceRule.vehTypeNo==2 }"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.vehTypeNo">						
						<option value="2" selected="selected">小车</option>
						</select></c:if>
						<c:if test="${priceRule.vehTypeNo==3 }"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.vehTypeNo">						
						<option value="3" selected="selected">大型车</option>
						</select></c:if>
						<c:if test="${priceRule.vehTypeNo==4 }"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.vehTypeNo">						
						<option value="4" selected="selected">超大型车</option>
						</select></c:if>
						</td>
						
						<td class="pn-flabel pn-flabel-h">收费类型：</td>
						<td class="pn-fcontent">

					    <%--<c:if test="${priceRule.feeTypeNo==1}"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">						
						  <option value="1" selected="selected">正常收费</option>
						</select></c:if>
					    <c:if test="${priceRule.feeTypeNo==2}"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">						
						<option value="2" selected="selected">无卡收费</option>
						</select></c:if>
						<c:if test="${priceRule.feeTypeNo==3}"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">						
						<option value="3" selected="selected">异门收费</option>
						</select></c:if>
					    <c:if test="${priceRule.feeTypeNo==4}"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">						
						<option value="4" selected="selected">优惠收费</option>
						--%>
						<c:if test="${priceRule.feeTypeNo==2}"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">						
						<option value="2" selected="selected">同门收费</option>
						</select></c:if>
						<c:if test="${priceRule.feeTypeNo==3}"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">						
						<option value="3" selected="selected">异门收费</option>
						</select></c:if>
					    <c:if test="${priceRule.feeTypeNo==4}"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">						
						<option value="4" selected="selected">优惠收费</option>
						</select></c:if>
						</td>
					   </tr>
	     			<tr>
						<td class="pn-flabel pn-flabel-h">最小时间：</td>
						<td class="pn-fcontent">${priceRule.startRange}<input readonly="readonly" type="hidden" id="priceRule_startRange"  name="priceRule.startRange" value="${priceRule.startRange}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">最大时间：</td>
						<td class="pn-fcontent"><input type="text" name="priceRule.endRange" id="priceRule_endRange" class="isNo_NotOverValueInt" value="${priceRule.endRange}" size="28"/></td>
						</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">时间基数：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.allowStay" value="${priceRule.allowStay}" size="28"/></td>
					   <td class="pn-flabel pn-flabel-h">收费基数：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.baseFee" value="${priceRule.baseFee}" size="28"/></td>
						</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">时间间隔：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.stayAdd" value="${priceRule.stayAdd}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">收费增量：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.addFee" value="${priceRule.addFee}" size="28"/></td>
						</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">最大费率：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.maxFee" value="${priceRule.maxFee}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">启用时间：</td>
						<td class="pn-fcontent"><input style="width: 204px;" type="text" class="required "  name="priceRule.startTime" value="<fmt:formatDate value="${priceRule.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""/><span style="color: red">&nbsp;*</span></td>
					  </tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">版本号：</td>
						<td class="pn-fcontent"><input type="text" class="versonNoFormat" name="priceRule.verNo" value="${priceRule.verNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;用：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.backUp1" value="${priceRule.backUp1}" size="28"/></td>
				    </tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/>&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
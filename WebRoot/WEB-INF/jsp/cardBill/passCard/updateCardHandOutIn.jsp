<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title></title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
        <script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>		
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
						
		<script type="text/javascript">
		 
		<%--function check(){
			if(document.getElementsByName("squadDate")[0].value==""){
				alert("�������ڲ���Ϊ�գ�������ѡ������."); 
				document.getElementsByName("squadDate")[0].focus();
				return false;
			}
			if(document.getElementsByName("cardHandOutIn.parkNo")[0].value==""){
				alert("С������Ϊ�գ�������ѡ������."); 
				document.getElementsByName("cardHandOutIn.parkNo")[0].focus();
				return false;
			}
			if(document.getElementsByName("cardHandOutIn.gateNo")[0].value==""){
				alert("���Ų���Ϊ�գ�������ѡ������."); 
				document.getElementsByName("cardHandOutIn.gateNo")[0].focus();
				return false;
			}
			if(document.getElementsByName("cardHandOutIn.laneNo")[0].value==""){
				alert("��������Ϊ�գ�������ѡ������."); 
				document.getElementsByName("cardHandOutIn.laneNo")[0].focus();
				return false;
			}
		}--%>	     
		 function getGate(){
			 var parkNo=document.getElementsByName("cardHandOutIn.parkNo")[0].value; 
				$.ajax({
					type:"post",
					url:"passCard_ajaxGate.do?cardHandOutIn.parkNo="+parkNo,
					success:function(res){
						$("#gateNo").empty();
						var op = $("<option value=''>-��ѡ��-</option>");
						$("#laneNo").empty();
						var op1 = $("<option value=''>-��ѡ��-</option>");		
						$("#laneNo").append(op1);		
						$("#gateNo").append(op);
						$(res).find("gates > gate").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#gateNo").append(op);	
					});
					}
				});
			}
			function getLane(){
				var parkNo=document.getElementsByName("cardHandOutIn.parkNo")[0].value; 
				  var gateNo=document.getElementsByName("cardHandOutIn.gateNo")[0].value;
				$.ajax({
					type:"post",
					url:"passCard_ajaxLane.do?cardHandOutIn.parkNo="+parkNo+"&cardHandOutIn.gateNo="+gateNo,
					success:function(res){
						$("#laneNo").empty();
						var op = $("<option value=''>-��ѡ��-</option>");		
						$("#laneNo").append(op);
						$(res).find("lanes > lane").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#laneNo").append(op);	
					});
					}
				});
			}
			
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>				
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="passCard_updteEdit.do" >  				   
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" height="200">					 					
					<tr>
					  <td class="pn-flabel pn-flabel-h">�������ڣ�</td>
					  <td  class="pn-fcontent"> <input type="text" name="squadDate"  value="${squadDate}" class="Wdate required" onClick="WdatePicker()" >&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">����ţ�</td>
					  <td  class="pn-fcontent"> 
					  <select name="cardHandOutIn.squadNo" style="width:150px" class="required">
							 		<option value="">��ѡ��</option>
							 		<c:forEach items="${squadList}" var="squadItem">
							 		   <option value="${squadItem.squadNo}" <c:if test="${cardHandOutIn.squadNo==squadItem.squadNo}">selected</c:if>>${squadItem.squadName}</option>							 			
							 		</c:forEach>	
							 	</select> &nbsp;<font style="color:red">*</font>
					 </td>				 
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</td>
					   <td  class="pn-fcontent">
						  <select name="cardHandOutIn.type" style="width:150px" class="required">								
								<option value="" <c:if test="${cardHandOutIn.type==null}">selected</c:if>>��ѡ��</option>						
								<option value="1" <c:if test="${cardHandOutIn.type==1}">selected</c:if>>�쿨 </option>
								<option value="2" <c:if test="${cardHandOutIn.type==2}">selected</c:if>>���� </option>						
						  </select>&nbsp;<font style="color:red">*</font>
						  </td>
					   <td class="pn-flabel pn-flabel-h">������</td>
					   <td class="pn-fcontent"><input type="text" name="cardHandOutIn.amount" value="${cardHandOutIn.amount}" class="required positiveInteger max2147483647" />&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">λ&nbsp;&nbsp;&nbsp;&nbsp;�ã�</td>
					    <td  class="pn-fcontent" colspan="3">С����:				    	   
					      <select name="cardHandOutIn.parkNo" style="width:100px" onchange="getGate();" class="required">
								<option value="" <c:if test="${cardHandOutIn.parkNo==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${parkList}" var="itemPark">
								<option value="${itemPark.parkNo}" <c:if test="${cardHandOutIn.parkNo==itemPark.parkNo}">selected</c:if>>${itemPark.parkName}</option>
							    </c:forEach>  
						   </select>&nbsp;<font style="color:red">*</font>
						
						
						��������
						
						      <select name="cardHandOutIn.gateNo" id="gateNo" style="width:100px" onchange="getLane();" class="required">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${gateList}" var="itemGate">
										<option value="${itemGate.gateNo }"<c:if test="${itemGate.gateNo==cardHandOutIn.gateNo}"> selected</c:if>>${itemGate.gateName }</option>
									</c:forEach>
							 </select>&nbsp;<font style="color:red">*</font>
                       
						������
						
						   <select name="cardHandOutIn.laneNo" id="laneNo" style="width:100px" class="required">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${laneList}" var="itemLane" >
										<option value="${itemLane.laneNo }"<c:if test="${itemLane.laneNo==cardHandOutIn.laneNo }"> selected</c:if>>${itemLane.laneNo }</option>
									</c:forEach>
						 </select>&nbsp;<font style="color:red">*</font>
						 </td>					 				 
					</tr>
					<tr>
					 <td class="pn-flabel pn-flabel-h">��/�����ˣ�</td>
					      <td   class="pn-fcontent">
						    <select name="cardHandOutIn.operatorNo" style="width:150px" class="required">
								<option value="" <c:if test="${cardHandOutIn.operatorNo==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listOperator}" var="item">
								   <option value="${item.operatorNo}" <c:if test="${cardHandOutIn.operatorNo==item.operatorNo}">selected</c:if>>${item.operatorName}</option>
							    </c:forEach>  
						   </select>&nbsp;<font style="color:red">*</font>
						</td>
						 <td class="pn-flabel pn-flabel-h"></td>
					  <td  class="pn-fcontent"> <input type="hidden" name="cardHandOutIn.recordNo"  value="${cardHandOutIn.recordNo}" ></td>		
					</tr>
	
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �޸� "/> &nbsp;
						<input type="reset" value=" �� �� "/>	&nbsp;
						<input type="button" value=" �� �� " onclick="history.back();"/>
						</td>
					</tr>
					
	          </table>
					
			</form>
		</div>
	</body>
</html>

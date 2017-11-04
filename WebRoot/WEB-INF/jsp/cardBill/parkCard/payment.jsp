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
		if("${result}"=="SUCCESS"){
			if(confirm("�ɷѳɹ�,�Ƿ��ӡ��")){
				window.open("parkCard_printsUserCardInfo.do?userCardInfo.cardNo="+"${cardNo}");
				//window.location="parkCard_printsUserCardInfo.do?userCardInfo.cardNo="+"${cardNo}";
			}
		}
		if("${result}"=="SUCCESS1")
			alert("ע��ɹ�,��ɷ�"); 
		
		if("${result}" == "FAIL"){
			alert("�ύ����ʼʱ��ͽ���ʱ����ɷ������������");
		}
		if("${result}" == "FAIL2"){
			alert("У����ʼʱ��ͽ���ʱ����ɷ������Ƿ��������");
		}
		window.onload = function() {
			if("${amount}"==""){
			document.getElementById("amount").focus();
			}	
		}


		function payment(){
			
		     var val=document.getElementsByName("userCardInfo.recNO")[0].value;
		     var valAmount=document.getElementsByName("userCardBill.amount")[0].value;
		     var valVersionAndRecNo=document.getElementsByName("versionAndRecNo")[0].value;
		     var partten=/^[1-9]\d*$/;				
		     if(valAmount!=""){
			    if(partten.test(valAmount)){
				    if(valAmount>100){				     
				          document.getElementById("amount").value = valAmount;
				          document.getElementById("money").value = 0;
				          document.getElementById("amount").focus();	
				          alert("�ɷ��·ݲ��ܴ���100");			  
				          return;
			           }else{
			    	         var valStartTime=document.getElementsByName("startTimeTemp")[0].value;	
			    	         if(valStartTime==""){
				    	         alert("����ʱ�䲻��Ϊ��");
				    	         return;
			    	         }
			    	        // document.getElementById("payBtn").disabled = true;
			    	         jQuery.ajax({type:"post",url:"parkCard_getMoneyAndEndTime.do?amount="+valAmount+"&versionAndRecNo="+valVersionAndRecNo+"&startTime="+valStartTime,async:false, success:function(data,textStatus){			    
			    	        	 	var moneyAndEndTime=new Array();
                                    moneyAndEndTime=data.split(",");
			    				    var money=moneyAndEndTime[0];
			    				    var endTimeTemp=moneyAndEndTime[1];
			    				    var endTime=moneyAndEndTime[2];
			    				    document.getElementById("money").value=money;
			    				   // document.getElementById("endTimeTemp").value=endTime;
			    				    document.getElementById("endTime").value=endTimeTemp;
			    				    //document.getElementById("payBtn").disabled = false;
			    					 }
			    					 });	    					  	   
					         //window.location="parkCard_payment.do?userCardInfo.recNO="+val+"&amount="+valAmount+"&versionAndRecNo="+valVersionAndRecNo+"&endTime="+valStartTime;
			           }
			    } else{				
				         document.getElementById("amount").value = valAmount;
				         document.getElementById("money").value = 0;	
				         document.getElementById("amount").focus();	
				         return;
			     }							 
		   }		     		     		     				
		}		
		<%--function paymentRate(){				
		     var val=document.getElementsByName("userCardInfo.recNO")[0].value;
		     var valAmount=document.getElementsByName("userCardBill.amount")[0].value;
		     //var valMoney=document.getElementsByName("userCardRate.money")[0].value;
		     var valVersionAndRecNo=document.getElementsByName("versionAndRecNo")[0].value;
		     var valStartTime=document.getElementsByName("startTimeTemp")[0].value;	
		     if(valAmount==""){	
			     document.getElementById("amount").focus();	
			     return;
		     }else{
		    	 var partten=/^[1-9]\d*$/;	
		    	 if(partten.test(valAmount)){
					 if(valAmount>100){
					     return;
				     }
				 } else{
					 return;
				 }
		    	 //window.location="parkCard_payment.do?userCardInfo.recNO="+val+"&amount="+valAmount+"&money="+valMoney+"&endTime="+valStartTime;
		    	  window.location="parkCard_payment.do?amount="+valAmount+"&versionAndRecNo="+valVersionAndRecNo+"&startTime="+valStartTime;
		    	  
		     }
			
		}--%>
		function deleteByNoAndOptime(userRecNo,opTime) {				
			if(confirm("ȷ��Ҫɾ���û����Ϊ"+userRecNo+"�������ɷѼ�¼��")) {								
				window.location = "parkCard_deleteByNoAndOptime.do?userCardBill.userRecNo=" + userRecNo+"&opTime="+opTime;	
			}	
		}
		function deleteAll() {
			var val=document.getElementsByName("userCardInfo.recNO")[0].value;					
			if(confirm("ȷ��Ҫɾ���û����Ϊ"+val+"�����нɷѼ�¼��")) {											
				window.location = "parkCard_deleteAllByuserRecNo.do?userCardBill.userRecNo=" + val;	
			}	
		}

		function paymentEdit() {
			if($("#dataform").valid()!=false){
			var valversionAndRecNo=document.getElementsByName("versionAndRecNo")[0].value;
			var valamount=document.getElementsByName("userCardBill.amount")[0].value;
			var valmoney=document.getElementsByName("userCardBill.money")[0].value;
			var valstartTimeTemp=document.getElementsByName("startTimeTemp")[0].value;
			var valendTimeTemp=document.getElementsByName("endTimeTemp")[0].value;	
			var valrecNO=document.getElementsByName("userCardInfo.recNO")[0].value;				
			window.location = "parkCard_paymentEdit.do?userCardInfo.recNO=" + valrecNO+"&versionAndRecNo="+valversionAndRecNo+"&userCardBill.amount="+valamount+"&userCardBill.money="+valmoney+"&startTimeTemp="+valstartTimeTemp+"&endTimeTemp="+valendTimeTemp;				
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
			<form id="dataform" name="tableForm" method="post" action="parkCard_payment.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">				    							 
					<tr>						
						<td   rowspan="2" class="pn-flabel pn-flabel-h">���⣨Ԫ����</td>
						<td     rowspan="2" class="pn-fcontent">
						<select name="versionAndRecNo" style="width:150px"  size="5" onchange="payment()">								
							    <c:forEach items="${listuserCardRate}" var="item">
								<option value="${item.version},${item.recNo}" <c:if test="${versionAndRecNo==item.versionAndRecNo}">selected</c:if>>${item.money}</option>
								
							   </c:forEach>  
						</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">�ɷ�������</td>				
						<td  class="pn-fcontent"> <input  id="amount" type="text" name="userCardBill.amount"  value="${userCardBill.amount}"  onkeyup="payment()" class="required positiveInteger max100"/></td>				
						<td  class="pn-flabel pn-flabel-h">�ܽ�Ԫ����</td>						
						<td  class="pn-fcontent"><input id="money" type="text" name="userCardBill.money"  value="${userCardBill.money}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>						
					</tr>												
					<tr>					   													
					    <td  class="pn-flabel pn-flabel-h">��ʼʱ�䣺</td>	
					    <td class="pn-fcontent">
					    <input type="text" name="startTimeTemp" value="<fmt:formatDate value="${userCardBill.startTime}" pattern="yyyy-MM-dd" />" class="Wdate" onclick="WdatePicker({opposite:true,disabledDates:['01$'],isShowClear:false})"  onchange="payment()" readonly="readonly"/>								
						</td>
						<%-- <td class="pn-fcontent"><input type="text" value="<fmt:formatDate value="${userCardBill.startTime}" pattern="yyyy-MM-dd" />"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>--%>
						<td  class="pn-flabel pn-flabel-h">����ʱ�䣺</td>											
						<td class="pn-fcontent"><input id="endTime" name="endTimeTemp" type="text" value="<fmt:formatDate value="${userCardBill.endTime}" pattern="yyyy-MM-dd" />"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>	
					</tr>
					<%--<tr>					   														
					    <td style="height:0px;" class="pn-flabel pn-flabel-h"></td>									
						<td style="height:0px;" class="pn-fcontent"><input type="hidden" name="startTimeTemp" value="${userCardBill.startTime}"/></td>
						<td style="height:0px;" class="pn-flabel pn-flabel-h"></td>											
						<td style="height:0px;" class="pn-fcontent"><input type="hidden" id="endTimeTemp"   name="endTimeTemp"  value="${userCardBill.endTime}"/></td>	
					    <td style="height:0px;" class="pn-flabel pn-flabel-h"></td>
					     <td style="height:0px;" class="pn-flabel pn-flabel-h"></td>
					</tr>--%>
	
					<tr>
						<td colspan="6" class="pn-fbutton">
						<input type="button" id="payBtn"  value=" �ɷ� " onclick="paymentEdit()" />&nbsp;
						<input type="reset" value=" �� �� "/>&nbsp;
						<input type="button" value=" �� �� " onclick="history.back();"/>
						<input type="button" value=" ɾ�����û�ȫ���ɷѼ�¼ " onclick="deleteAll()"/>
						<input type="hidden"  name="userCardInfo.recNO" value="${userCardInfo.recNO}"/>												
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>�û�����</th>
						<th>�������</th>
						<th>�ɷ�ʱ��</th>
						<th>��ʼʱ��</th>						
						<th>����ʱ��</th>
						<th>�ɷ�����</th>
						<th>�ɷ��ܽ��</th>						
						<th>���ʰ汾</th>					
						<th>���ʱ��</th>						
						<th>����Ա</th>
						<th>����</th>						 
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${userCardInfo.owner}</td>
							<td>${userCardInfo.cardNo}</td>	
							<td>${item.opTime}</td>						
							<td>${item.startTime}</td>
							<td>${item.endTime}</td>
							<td>${item.amount}</td>
							<td>${item.money}</td>
							<td>${item.version}</td>
							<td>${item.rateRecNo}</td>					
							<td><c:forEach items="${listAdmin}" var="itemAdmin"><c:if test="${item.operator==itemAdmin.id}">${itemAdmin.username}</c:if></c:forEach></td>					
						    <td><a href="javascript:deleteByNoAndOptime('${item.userRecNo}','${item.opTime}')" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>
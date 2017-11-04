<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>		
		<link type="text/css" rel="stylesheet" media="screen" href="css/validate-css/showmgs.css"/>		
        <script type="text/javascript" src="js/util.js"></script>
        <script type="text/javascript" src="js/validate/jquery.js" charset="UTF-8"></script> 
	    <script type="text/javascript" src="js/validate/jquery.validate.js" charset="UTF-8"></script> 
	    <script type="text/javascript" src="js/validate/messages_cn.js" charset="UTF-8"></script> 	
		<script type="text/javascript">
		if("${result}"=="SUCCESS")
			alert("Ʊ�ݳ���ɹ�"); 		
				 
				 $(document).ready(function(){
				 	 $("#dataform").validate({
						submitHandler:function(form){
				 		 var position=document.getElementsByName("billStorage.position")[0].value;                
		                   var transactor=document.getElementsByName("billTransfer.transactor")[0].value;               
		                   var squadDatevar=document.getElementsByName("squadDate")[0].value;
		                   var squadNo=document.getElementsByName("billTransfer.squadNo")[0].value;
		                   var remark=document.getElementsByName("billTransfer.remark")[0].value;
		                   var temp=new Array();
		                   if(document.getElementById("right").length == 0) {
		   			  		alert("��ѡ��Ҫ�����Ʊ��");
		   			  		return;
		   			  	} else {
		   			  		for(i=0;i<document.getElementById("right").length;i++) {
		   			  		temp[i]=document.getElementById("right")[i].value;  			  			
		   			  		}  			  		
		   			  	     window.location="bill_moveOutEdit.do?right="+temp+"&billStorage.position="+position+"&billTransfer.transactor="+transactor+"&squadDate="+squadDatevar+"&billTransfer.squadNo="+squadNo+"&billTransfer.remark="+remark;		  		
		   			  	}
				 		  //window.open("bill_moveOutEdit.do?right="+temp+"&billStorage.position="+position+"&billTransfer.transactor="+transactor+"&squadDate="+squadDatevar+"&billTransfer.squadNo="+squadNo+"&billTransfer.remark="+remark);	    				 		     
					    }});
				 	jQuery.validator.addMethod("positiveInteger", function(value, element) {					     
					    var decimal = /^[1-9]\d*$/;
					    return this.optional(element) || (decimal.test(value));
				       }, $.validator.format("������������."));	
				 	jQuery.validator.addMethod("max2147483647", function(value, element) {
					      return this.optional(element) || (value <= 2147483647);
				         }, $.validator.format("���ܴ���2147483647"));	
				 	jQuery.validator.addMethod("maxlengthForty", function(value, element) {
					      return this.optional(element) || ((Len(value.trim()) <= 40));
				         }, $.validator.format("���Ȳ��ܴ���40������������)"));	
				  });
				 <%--function commit(){
            	  
            	   if((document.getElementsByName("billStorage.position")[0].value).trim()==""){
   					alert("Ŀ�ĵص㲻��Ϊ�գ���ѡ��.");
   					document.getElementsByName("billStorage.position")[0].focus();
   					return false;
   				    }
            	   if((document.getElementsByName("billTransfer.transactor")[0].value).trim()==""){
      					alert("�����˲���Ϊ�գ���ѡ��.");
      					document.getElementsByName("billTransfer.transactor")[0].focus();
      					return false;
      				 }
            	   if(Len((document.getElementsByName("billTransfer.remark")[0].value).trim())>40){
   					alert("��ע���Ȳ��ܴ���40����һ��������������");
   					document.getElementsByName("billTransfer.remark")[0].focus();
   					return false;
   				     }
            	   if((document.getElementsByName("billTransfer.squadNo")[0].value).trim()!=""){
            		   var partten = /^\d*$/;           		   
            		   if(partten.test((document.getElementsByName("billTransfer.squadNo")[0].value).trim())){			     
            			   if(document.getElementsByName("billTransfer.squadNo")[0].value>2147483647){
     					        alert("��β��ܴ���2147483647������������.");
     					        document.getElementsByName("billTransfer.squadNo")[0].focus();
     					        return false;
     				         }
            		   } else {
            			   alert("���Ҫ������������������.");
					        document.getElementsByName("billTransfer.squadNo")[0].focus();
					        return false;
            		   }
            	   }
                  
                   var position=document.getElementsByName("billStorage.position")[0].value;                
                   var transactor=document.getElementsByName("billTransfer.transactor")[0].value;               
                   var squadDatevar=document.getElementsByName("squadDate")[0].value;
                   var squadNo=document.getElementsByName("billTransfer.squadNo")[0].value;
                   var remark=document.getElementsByName("billTransfer.remark")[0].value;
                   var temp=new Array();
                   if(document.getElementById("right").length == 0) {
   			  		alert("��ѡ��Ҫ�����Ʊ��");
   			  		return false;
   			  	} else {
   			  		for(i=0;i<document.getElementById("right").length;i++) {
   			  		temp[i]=document.getElementById("right")[i].value;  			  			
   			  		}  			  		
   			  	     window.location.href="bill_moveOutEdit.do?right="+temp+"&billStorage.position="+position+"&billTransfer.transactor="+transactor+"&squadDate="+squadDatevar+"&billTransfer.squadNo="+squadNo+"&billTransfer.remark="+remark;		  		
   			  	}
               }--%>
			function moveOption(e1, e2) {
				for(var i=0;i<e1.options.length;i++){
					if(e1.options[i].selected) {
				   		var e = e1.options[i];
				   		e2.options.add(new Option(e.text, e.value));
				   		e1.remove(i);
				   		i=i-1;
				  	}
				}
			}	
			function moveAllOption(e1, e2) {
				for(var i=0;i<e1.options.length;i++){
					if(e1.options[i]) {
				   		var e = e1.options[i];
				   		e2.options.add(new Option(e.text, e.value));
				   		e1.remove(i);
				   		i=i-1;
				  	}
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
			 <form id="dataform" method="post">  		
					<table width="700"  cellpadding="2" cellspacing="1" border="0.5" height="250">
	
						
							<tr>
								<td >���Ʊ��									
								</td>
								<td ></td>
								<td >Ŀ�ĵص㣺
								 <select name="billStorage.position" style="width:100px" class="required">	
						       	   <option value="" <c:if test="${billStorage.position==null}">selected</c:if>>��ѡ��</option>							
							         <c:forEach items="${listgatewayInformation}" var="item">
								      <option value="${item.gateNo}" <c:if test="${billStorage.position==item.gateNo}">selected</c:if>>${item.gateName}</option>
							         </c:forEach> 															
						        </select>	
								&nbsp;<font style="color:red">*</font></td>
							</tr>
							<tr>
								<td width="40%" >
									<select style="width: 100%;" multiple name="left" size="15" id="left"
										ondblclick="moveOption(document.getElementById('left'), document.getElementById('right'))">
										<c:forEach items="${list}" var="item">
							          <option value="${item.hankNo}">${item.hankNo}[${item.amount-item.usedAmount}][${item.billHead}:${item.usedBillNo}--${item.endBillNo}]</option>
							        </c:forEach>  								
									</select>
								</td>
								<td width="20%" align="center" >
									<input type="button" value=" &nbsp;> &nbsp;&nbsp;" 
										onClick="moveOption(document.getElementById('left'), document.getElementById('right'))">
										<br>
										<br>
									<input type="button" value=" &nbsp;>> &nbsp;"
										onClick="moveAllOption(document.getElementById('left'), document.getElementById('right'))">
									<br>
									<br>
									<input type="button" value="&nbsp; <&nbsp; &nbsp;"
										onClick="moveOption(document.getElementById('right'), document.getElementById('left'))">
									<br>
									<br>
									<input type="button" value="&nbsp; << &nbsp;"
										onClick="moveAllOption(document.getElementById('right'), document.getElementById('left'))">
								</td>
								<td width="40%">
									<select style="width: 100%;" multiple name="right" size="15" id="right" 
										ondblclick="moveOption(document.getElementById('right'), document.getElementById('left'))" >										
									</select>
								</td>
							</tr>
							<tr>
							<td colspan="3">��&nbsp;��&nbsp;�ˣ�
								 <select name="billTransfer.transactor" style="width:206px" class="required">
							        <option value="">��ѡ��</option>
							        <c:forEach items="${listTemp}" var="itemTemp">
							          <option value="${itemTemp.operatorNo}">${itemTemp.operatorName}</option>
							        </c:forEach>  
						         </select>&nbsp;<font style="color:red">*</font>
							</td>
							</tr>
							<tr>
							<td colspan="3">�������ڣ�
							<input type="text" name="squadDate" value="${squadDate}" class="Wdate" onClick="WdatePicker()" size="28.5">
							</td>
							</tr>
							<tr>
							 <td colspan="3">
								 ��&nbsp;&nbsp;&nbsp;&nbsp;�Σ�
								 <select name="billTransfer.squadNo" class="required" style="width:205px">
							 		<option value="">��ѡ��</option>
							 		<c:forEach items="${squadList}" var="squadItem">
							 			<option value="${squadItem.squadNo }">${squadItem.squadName }</option>
							 		</c:forEach>	
							 	 </select>
								 <!-- <input type="text" name="billTransfer.squadNo" size="28" class="positiveInteger max2147483647"> -->
							 </td>
							</tr>
							<tr>
					          <td colspan="3">��&nbsp;&nbsp;&nbsp;&nbsp;ע��
					            <textarea rows='2' cols='53' name="billTransfer.remark" class="maxlengthForty"></textarea>
					          </td>
					       </tr>
					
							
					<tr>
						<td colspan="3" class="pn-fbutton">
							<input type="submit" value=" &nbsp;ȷ�� &nbsp;"/> &nbsp;
						<input type="reset" value=" &nbsp;ȡ��&nbsp; "/></td>
					</tr>
					
					 </table>
					
			</form>
		</div>
	</body>
</html>

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
		if ("${result}" == "SUCCESS")
			alert("�����ɹ�");	
			function check(){
				
				if((document.getElementsByName("ICCardStorageLeft.position")[0].value).trim()==""){
					alert("����ص㲻��Ϊ�գ���ѡ��.");
					return false;
				}
				if((document.getElementsByName("ICCardStorageRight.position")[0].value).trim()==""){
					alert("���ص㲻��Ϊ�գ���ѡ��.");
					return false;
				}
				if((document.getElementsByName("ICCardStorageRight.position")[0].value).trim()==(document.getElementsByName("ICCardStorageLeft.position")[0].value).trim()){
					alert("����ص�����ص㲻����ͬ��������ѡ��.");
					return false;
				}
				<%--if((document.getElementsByName("ICCardStorageTemp.amount")[0].value).trim()==""){
					alert("������������Ϊ�գ��������������.");
					document.getElementsByName("ICCardStorageTemp.amount")[0].focus();
					return false;
				} else {
				    var partten=/^[1-9]\d*$/;
				    if(partten.test((document.getElementsByName("ICCardStorageTemp.amount")[0].value).trim())){
				    }else{
				     alert("��������ֻ����������������1������50��������������.");
				     document.getElementsByName("ICCardStorageTemp.amount")[0].focus();
					 return false;
				    }
				}
				
				if((document.getElementsByName("id")[0].value).trim()==""){
					alert("�����˲���Ϊ�գ���ѡ��.");
					document.getElementsByName("id")[0].focus();
					return false;
				}
					if(Len((document.getElementsByName("ICCardTransferTemp.remark")[0].value).trim())>40){
					alert("��ע���Ȳ��ܴ���40����һ��������������");
					document.getElementsByName("ICCardTransferTemp.remark")[0].focus();
					return false;
				}--%>
				if((document.getElementsByName("ICCardStorageTemp.amount")[0].value).trim()!=""){		 
				var v="succuss";
				var valPosition=(document.getElementsByName("ICCardStorageLeft.position")[0].value).trim();
				var valAmount=(document.getElementsByName("ICCardStorageTemp.amount")[0].value).trim();
			    jQuery.ajax({type:"post",url:"iCCard_getAmount.do?ICCardStorageLeft.position="+valPosition+"&ICCardStorageTemp.amount="+valAmount,async:false, success:function(data,textStatus){			    
			    if(data=="fail"){v="fail";alert("�����������ڿ�������������������������."); }			   
				 }
				 });				 					 
				 if(v=="fail"){document.getElementsByName("ICCardStorageTemp.amount")[0].focus();return false;}
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
			 <form id="dataform" method="post" action="iCCard_allotEdit.do" onsubmit="return check();">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="580" class="pn-ftable"  border="0" bordercolor="black" cellspacing="0" rules="none"height="120" >			
					<tr>
					  <td  class="pn-fcontent"><font size=3>����ص�:</font></td>
					  <td   class="pn-fcontent"></td>
					   <td   class="pn-fcontent"></td>
					  <td  class="pn-fcontent"><font size=3>���ص�:</font></td>	  
					</tr>
					<tr>
					<td   class="pn-fcontent"> 					 
						  <select name="ICCardStorageLeft.position" style="width:250px" size="15" >
						  <option value="${ICCardStoragePosition.position}">��������(${ICCardStoragePosition.amount})</option>
						   <c:forEach items="${list}" var="item">
								<option value="${item[0].position}">${item[1].gateName}(${item[0].amount})</option>
							 </c:forEach>   
							</select>								 
						</td>
						
					 <td   class="pn-fcontent" align="right"><font size=6 color="red" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt;</font></td>  
					  <td   class="pn-fcontent">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td   class="pn-fcontent"> 					 
						  <select name="ICCardStorageRight.position" style="width:250px" size="15">
						   <option value="${ICCardStoragePosition.position}">��������(${ICCardStoragePosition.amount})</option>
						   <c:forEach items="${list}" var="item">
								<option value="${item[0].position}">${item[1].gateName}(${item[0].amount})</option>
							 </c:forEach>    
							</select>								 
						</td>
					</tr>
					<tr>
					 <td   class="pn-fcontent"></td>
					  <td   class="pn-fcontent"></td>
					   <td   class="pn-fcontent"></td>
					    <td   class="pn-fcontent"></td>
					</tr>
					<tr>
					 <td   class="pn-fcontent"></td>
					  <td   class="pn-fcontent"></td>
					   <td   class="pn-fcontent"></td>
					    <td   class="pn-fcontent"></td>
					</tr>
					<tr>
					<td colspan="4" class="pn-fcontent">����������
					  <input type="text" name="ICCardStorageTemp.amount"   class="required positiveInteger max2147483647"/>&nbsp;<font style="color:red">*</font></td>
					 </tr>
					 <tr>
					  <td colspan="4" class="pn-fcontent">��&nbsp;��&nbsp;�ˣ�
					  <select name="id" style="width:150px" class="required">
							<option value="">��ѡ��</option>
							<c:forEach items="${listTemp}" var="itemTemp">
							<option value="${itemTemp.operatorNo}">${itemTemp.operatorName}</option>
							 </c:forEach>  
						</select>&nbsp;<font style="color:red">*</font>
					</td>
					</tr>
				
					<tr>
					<td colspan="4" class="pn-fcontent">��&nbsp;&nbsp;&nbsp;&nbsp;ע��
					  <textarea rows='2' cols='54' name="ICCardTransferTemp.remark" class="maxlengthForty"></textarea></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" &nbsp;ȷ�� &nbsp;" /> &nbsp;
						<input type="reset" value=" &nbsp;ȡ��&nbsp; "/></td>
					</tr>
					 </table>
					
			</form>
		</div>
	</body>
</html>

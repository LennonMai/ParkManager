<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
		<script type="text/javascript">
		if("${result}"=="FAIL")
				alert("���д˳��ƺ�");
				if("${result}"=="FAIL1")
				alert("���д˿���");
				      
              String.prototype.trim = function() 
                   { 
                           // ��������ʽ��ǰ��ո��ÿ��ַ�������� 
                        return this.replace(/(^\s*)|(\s*$)/g, ""); 
                   } 
		      		
              function Len(str)
              {
              var i,sum;
              sum=0;
              for(i=0;i<str.length;i++)
                {   
                   if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255)){
                       if(str.charCodeAt(i)==183)
                       {
                           sum=sum+2;
                       }else{
                      	 sum=sum+1;
                       }
                     
                      } else{
                      	 sum=sum+2;
                      }
                     
                 }
              return sum;
              }
           
		
			function check(){			
				if((document.getElementsByName("user.userName")[0].value).trim()==""){
					alert("�û�������Ϊ�գ�����������.");
					document.getElementsByName("user.userName")[0].focus();
					return false;
				}
				if((document.getElementsByName("user.userName")[0].value).trim()!="" && Len((document.getElementsByName("user.userName")[0].value).trim())>50){
				   alert("�û������Ȳ��ܳ���50���ַ�,����������."); 
				   document.getElementsByName("user.userName")[0].focus();
					return false;
				}

				if((document.getElementsByName("user.credentialsType")[0].value).trim()==""){
					alert("֤�����Ͳ���Ϊ�գ�������ѡ��.");
					document.getElementsByName("user.credentialsType")[0].focus();
					return false;
				}
				if((document.getElementsByName("user.credentialsNo")[0].value).trim()==""){
					alert("֤�����벻��Ϊ�գ�����������.");
					document.getElementsByName("user.credentialsNo")[0].focus();
					return false;
				}
				if((document.getElementsByName("user.credentialsNo")[0].value).trim()!="" && Len((document.getElementsByName("user.credentialsNo")[0].value).trim())>50){
				   alert("֤�����볤�Ȳ��ܳ���50���ַ�,����������."); 
				   document.getElementsByName("user.credentialsNo")[0].focus();
					return false;
				}
				   
				
				
				if((document.getElementsByName("user.phone")[0].value).trim()!=""){
				
				if(Len((document.getElementsByName("user.phone")[0].value).trim())>20){
                 
                
                   alert("��ϵ�绰���Ȳ��ܳ���20���ַ�������������.");
                   document.getElementsByName("user.phone")[0].focus();
					return false;
                 }
                 }
                 
             
                 if((document.getElementsByName("user.mobileNumber")[0].value).trim()!=""){
				var partten=/^[0-9]*$/;
				if(partten.test((document.getElementsByName("user.mobileNumber")[0].value).trim())){
                 if(Len((document.getElementsByName("user.mobileNumber")[0].value).trim())>50){
                    alert("�ֻ������ʽ������Ҫ�󣬣�����13751841933������������.");
                    document.getElementsByName("user.mobileNumber")[0].focus();
					return false;
                 }
                 }else{alert("�ֻ������ʽ������Ҫ�󣬣�����13751841933������������.");
                    document.getElementsByName("user.mobileNumber")[0].focus();
					return false;
                 }
                 }	
                 if((document.getElementsByName("user.address")[0].value).trim()!="" && Len((document.getElementsByName("user.address")[0].value).trim())>80){
				   alert("��ϵ��ַ���Ȳ��ܳ���80���ַ�,����������."); 
				   document.getElementsByName("user.address")[0].focus();
					return false;
				}			
				if((document.getElementsByName("car.vehPlate")[0].value).trim()==""){
					alert("���ƺŲ���Ϊ�գ�����������.");
					document.getElementsByName("car.vehPlate")[0].focus();
					return false;
				}
				if((document.getElementsByName("car.vehPlate")[0].value).trim()!="" && Len((document.getElementsByName("car.vehPlate")[0].value).trim())>10){
				   alert("���ƺų��Ȳ��ܳ���10���ַ�,����������."); 
				  document.getElementsByName("car.vehPlate")[0].focus();
					return false;
				}
				
				if((document.getElementsByName("car.carColour")[0].value).trim()!="" && Len((document.getElementsByName("car.carColour")[0].value).trim())>50){
				   alert("����ɫ���Ȳ��ܳ���50���ַ�,����������."); 
				  document.getElementsByName("car.carColour")[0].focus();
					return false;
				}
				if((document.getElementsByName("car.carType")[0].value).trim()==""){
					alert("�������Ͳ���Ϊ�գ�������ѡ��.");
					document.getElementsByName("car.carType")[0].focus();
					return false;
				}
				
				if((document.getElementsByName("account.cardNo")[0].value).trim()==""){
					alert("���Ų���Ϊ�գ�����������.");
					document.getElementsByName("account.cardNo")[0].focus();
					return false;
				}	
				if((document.getElementsByName("account.cardNo")[0].value).trim()!=""){
				var partten=/^[0-9]\d*$/;
				//var partten=/^d*$/;
				//var partten=/^[0]*$/;
				if(partten.test((document.getElementsByName("account.cardNo")[0].value).trim())){
				  
				}
				else{
				  alert("����ֻ�������֣�����������.");
					document.getElementsByName("account.cardNo")[0].focus();
					return false;
					}
				}		
				if((document.getElementsByName("account.cardNo")[0].value).trim()!=""){
				//var partten=/^[1-9]\d*$/;
				//var partten=/^[0]$/;
				var partten=/^[0]*$/;
				//^[1-9]*$/;/^[1-9]\d$/;^[1-9]\d*$
				if(partten.test((document.getElementsByName("account.cardNo")[0].value).trim())){
				  alert("���ŵ����е�λ������ȫΪ0������������.");
					document.getElementsByName("account.cardNo")[0].focus();
					return false;
				}
				}	
				var cardNoLegth = document.getElementsByName("param_accountCardNoLength.pvalue")[0].value;
				if(cardNoLegth == 10){
					if((document.getElementsByName("account.cardNo")[0].value).trim()!="" && Len((document.getElementsByName("account.cardNo")[0].value).trim())>cardNoLegth){
						   alert("���ų��Ȳ��ܳ���"+cardNoLegth+"���ַ�,����������."); 
						   document.getElementsByName("account.cardNo")[0].focus();
						   return false;
						}	
				} 
				if(cardNoLegth != 10) {
					if(Len((document.getElementsByName("account.cardNo")[0].value).trim())!=cardNoLegth){
						 alert("���ų���Ҫ����"+cardNoLegth+"���ַ�,����������."); 
						 document.getElementsByName("account.cardNo")[0].focus();
						 return false;
					}
					
				}
				
				
				
			   
			     
				if((document.getElementsByName("cost")[0].value).trim()==""){
					alert("�����Ѳ���Ϊ�գ�����������.");
					document.getElementsByName("cost")[0].focus();
					return false;
				}	
				if((document.getElementsByName("cost")[0].value).trim()!=""){
				//var partten = /^\+?[0-9][0-9]*$/;
				//var partten=/^d+(.d+)?$/;
				var partten=/^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				if(partten.test((document.getElementsByName("cost")[0].value))){
				   if(document.getElementsByName("cost")[0].value>=100000){
                    alert("�����ѹ��󣨲��ܳ���100000��������������.");
                    document.getElementsByName("cost")[0].focus();
					return false;
					}
                 }else{
                   alert("������Ϊ��ʵ������0������0����50.5��������������.");
                   document.getElementsByName("cost")[0].focus();
					return false;
                 }
                 }	
                 if((document.getElementsByName("param_card_type.pvalue")[0].value).trim()=="0"){
                   if((document.getElementsByName("lowestBalanceAfterConsume")[0].value).trim()==""){
					alert("�������Ϊ�գ�����������.");
					document.getElementsByName("lowestBalanceAfterConsume")[0].focus();
					return false;
				}
				
				if((document.getElementsByName("lowestBalanceAfterConsume")[0].value).trim()!=""){
				var partten = /^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				if(partten.test((document.getElementsByName("lowestBalanceAfterConsume")[0].value))){
                    if(document.getElementsByName("lowestBalanceAfterConsume")[0].value>=100000){
                         alert("��������󣨲��ܳ���100000��������������.");
                         document.getElementsByName("lowestBalanceAfterConsume")[0].focus();
					     return false;
                    }
                    
                 }else{
                   alert("������Ϊ��ʵ������0������0����50.5��������������.");
                  document.getElementsByName("lowestBalanceAfterConsume")[0].focus();
					return false;
                 }
                 }
                   if((document.getElementsByName("tollyLowestBalanceAC")[0].value).trim()==""){
					alert("�����������Ϊ�գ�����������.");
					document.getElementsByName("tollyLowestBalanceAC")[0].focus();
					return false;
				}
				
				if((document.getElementsByName("tollyLowestBalanceAC")[0].value).trim()!=""){
				var partten = /^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
			     if(partten.test((document.getElementsByName("tollyLowestBalanceAC")[0].value))){
                    if(document.getElementsByName("tollyLowestBalanceAC")[0].value>=100000){
                      alert("������������󣨲��ܳ���100000����������������.");
                      document.getElementsByName("tollyLowestBalanceAC")[0].focus();
					   return false;
					}
                 }else{
                   alert("����������Ϊ��ʵ������0������0����50.5��������������.");
                   document.getElementsByName("tollyLowestBalanceAC")[0].focus();
					return false;
                 }
                 }
				
				if((document.getElementsByName("noEntryBalance")[0].value).trim()!=""){
				var partten = /^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				if(partten.test((document.getElementsByName("noEntryBalance")[0].value))){
                     if(document.getElementsByName("noEntryBalance")[0].value>=100000){
                      alert("��ֹʻ����������󣨲��ܳ���100000����������������.");
                      document.getElementsByName("noEntryBalance")[0].focus();
					   return false;
					}
                 }else{
                   alert("��ֹʻ��������Ϊ��ʵ������0������0����50.5��������������.");
                   document.getElementsByName("noEntryBalance")[0].focus();
					return false;
                 }
                 }
				
				if((document.getElementsByName("lowBalanceNotice")[0].value).trim()!=""){
				var partten = /^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				if(partten.test((document.getElementsByName("lowBalanceNotice")[0].value))){
                     if(document.getElementsByName("lowBalanceNotice")[0].value>=100000){
                      alert("��ʾ�û�ȥ���ѵ���������󣨲��ܳ���100000����������������.");
                      document.getElementsByName("lowBalanceNotice")[0].focus();
					   return false;
					}
                  
                 }else{
                   alert("��ʾ�û�ȥ���ѵ�������Ϊ��ʵ������0������0����50.5��������������.");
                   document.getElementsByName("lowBalanceNotice")[0].focus();
					return false;
                 }
                 }	
                 }
                 
                 
                 
             
              
			
                 if((document.getElementsByName("account.remark")[0].value).trim()!="" && Len((document.getElementsByName("account.remark")[0].value).trim())>80){
				   alert("��ע���Ȳ��ܳ���80���ַ�,����������."); 
				   document.getElementsByName("account.remark")[0].focus();
					return false;
				}
				
				
			if((document.getElementsByName("car.vehPlate")[0].value).trim()!=""){
			 
				var v="succuss";
				var val=(document.getElementsByName("car.vehPlate")[0].value).trim();
			   // jQuery.post("userCarAccount_getCarByVehPlate.do?car.vehPlate="+val,function(data){
			  //  alert("data---"+data);
			  //  if(data=="fail"){v="fail"; alert(v);alert("�˳����Ѵ���"); }
			    //  }
			    //  );
			    // alert("V---"+v);
			    // if(v=="fail"){document.getElementsByName("car.vehPlate")[0].focus();return false;}
			    jQuery.ajax({type:"post",url:"userCarAccount_getCarByVehPlate.do?car.vehPlate="+val,async:false, success:function(data,textStatus){			    
			    if(data=="fail"){v="fail";alert("�˳����Ѵ���"); }			   
				 }
				 });				 					 
				 if(v=="fail"){document.getElementsByName("car.vehPlate")[0].focus();return false;}
				 }
				 
				 if(document.getElementsByName("account.cardNo")[0].value!=""){
				     var v1="succuss";				   
		        	 var val3=(document.getElementsByName("account.cardNo")[0].value).trim();
			        // jQuery.post("userCarAccount_getAccountByCardNo.do?account.cardType="+val2+ "&account.cardNo=" +val3,function(data1){
			        // if(data1=="fail1") {alert("�����Ϳ����д˿���"); document.getElementsByName("account.cardNo")[0].focus();return false;}		
			        //  }
			        //  );
			        jQuery.ajax({type:"post",url:"userCarAccount_getAccountByCardNo.do?account.cardNo=" +val3,async:false, success:function(data1,textStatus){			    
					if(data1=="fail1"){v1="No";alert("�˿��ѱ������˻�����"); }	
			        if(data1=="statusNoUse"){v1="No";alert("�ÿ��ڿ���Ϣ�в�������������������"); }	
			        if(data1=="secondUse"){v1="No";alert("�ÿ�֮ǰ�ѱ����ù��������ٱ�����"); }
			        if(data1=="NoRegister"){alert("�ÿ���û���еǼǣ��뿪���ɹ�����еǼ�ʹ��"); }			   
				     }
				     });
				    		 					 
				   if(v1=="No"){document.getElementsByName("account.cardNo")[0].focus();return false;}				 
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
						 <form method="post" action="userCarAccount_save.do" onsubmit="return check();">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="871" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" height="345">
					 
					
					<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;����</td>
					  <td   class="pn-fcontent"><input type="text" name="user.userName"/>&nbsp;<font style="color:red">*</font></td>
					    <td class="pn-flabel pn-flabel-h">У�����ƣ�</td>
					    <td   class="pn-fcontent">
					    <select name="account.parkNo" style="width:150px">
							    <c:forEach items="${list}" var="item">
								<option value="${item.parkNo}" <c:if test="${account.parkNo==item.parkNo}">selected</c:if>>${item.parkName}</option>
							 </c:forEach>  
						</select>
					    </td>
					 
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">֤�����ͣ�</td>
					 <td class="pn-fcontent">				  
					   <select name="user.credentialsType" style="width:150px">
							<option value="">-��ѡ��-</option>
							    <option value="0">��       ��            ֤ </option>
								<option value="1">��                     �� </option>
						</select>&nbsp;<font style="color:red">*</font>
					  </td>
					  <td class="pn-flabel pn-flabel-h">֤�����룺</td>
					  <td class="pn-fcontent"><input type="text" name="user.credentialsNo"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">��ϵ�绰��</td>
					   <td class="pn-fcontent"><input type="text" name="user.phone"/></td>
					   <td class="pn-flabel pn-flabel-h">�ֻ����룺</td>
					   <td class="pn-fcontent"><input type="text" name="user.mobileNumber"/></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">��ϵ��ַ��</td>
					     <td colspan="3" class="pn-fcontent"><input type="text" name="user.address" size="86"/></td>
					</tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">�������ͣ�</td>
					  
					  <td colspan="3" class="pn-fcontent"><select name="car.carType" style="width:610px" >
							<option value="">-��ѡ��-</option>
							    <option value="1">С�γ������ճ�����ʿͷ�˻�����Ħ�г�</option>
								<option value="2">�������С���˻��������ͻ�����С�Ϳͳ�</option>
								<option value="3">���Ϳͳ������Ϳͳ������ͻ���</option>
								<option value="4">���Ϳͳ������ͻ����������ϣ��ң�����20Ӣ�߼�װ�䳵</option>
								<option value="5">���ͻ����������ϣ��ң�����40Ӣ�߼�װ�䳵</option>
						</select>&nbsp;<font style="color:red">*</font>
					  </td>
				  </tr>
			
					<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="car.vehPlate"/>&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;ɫ��</td>
					  <td class="pn-fcontent"><input type="text" name="car.carColour"/></td>
					  
					</tr>
					
					<tr>
					  
					  <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="account.cardNo" />&nbsp;<font style="color:red">*</font></td>
					   <td class="pn-flabel pn-flabel-h">�����ѣ�Ԫ����</td>
					  <td class="pn-fcontent"><input type="text" name="cost" value="<fmt:formatNumber value="${account.cost/100}" pattern="#.##" type="number"/>"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					
					 <c:if test="${param_card_type.pvalue!=1}">
					 <tr>
					  <td class="pn-flabel pn-flabel-h">������(Ԫ����</td>
					  <td  class="pn-fcontent"><input type="text" name="lowestBalanceAfterConsume" value="<fmt:formatNumber value="${account.lowestBalanceAfterConsume/100}" pattern="#.##" type="number"/>" />&nbsp;<font style="color:red">*</font></td>			  
					  <td class="pn-flabel pn-flabel-h">����������(Ԫ��:</td>
					  <td class="pn-fcontent"><input type="text" name="tollyLowestBalanceAC" value="<fmt:formatNumber value="${account.tollyLowestBalanceAC/100}" pattern="#.##" type="number"/>"/>&nbsp;<font style="color:red">*</font></td>
					 
					 </tr>
					 <tr>
					
					   <td class="pn-flabel pn-flabel-h">��ֹʻ��������(Ԫ��:</td>
					  <td class="pn-fcontent"><input type="text" name="noEntryBalance" value="<fmt:formatNumber value="${account.noEntryBalance/100}" pattern="#.##" type="number"/>" /></td>
					  <td class="pn-flabel pn-flabel-h">��ʾ�û�ȥ���ѵ�������(Ԫ��:</td>
					  <td class="pn-fcontent"><input type="text" name="lowBalanceNotice" value="<fmt:formatNumber value="${account.lowBalanceNotice/100}" pattern="#.##" type="number"/>"/></td>
					 </tr>
					 </c:if>
					
					<!--  <tr>
					 <td class="pn-flabel pn-flabel-h">����ʱ��:</td>
					  <td class="pn-fcontent"><input type="text" name="account.openAccountTime" value=""
						class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/></td>
					  <td class="pn-flabel pn-flabel-h">״̬����ʱ��:</td>
					  <td class="pn-fcontent"><input type="text" name="account.statusUpdateTime" value=""
						class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/></td>
					 </tr> -->
					<tr>
					  <td class="pn-flabel pn-flabel-h">��ע��</td>
					  <td colspan="3" class="pn-fcontent"><textarea rows='2' cols='84' name="account.remark"></textarea></td>
					</tr>					
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� "/> &nbsp;
						<input type="reset" value=" �� �� "/>
						<input type="button" value=" �� �� " onclick="history.back();"/></td>
					</tr>
					
					<tr>
					<td colspan="2" class="pn-fcontent"><input type="hidden" name="param_card_type.pvalue" value="${param_card_type.pvalue}"/></td>
					<td colspan="2" class="pn-fcontent"><input type="hidden" name="param_accountCardNoLength.pvalue" value="${param_accountCardNoLength.pvalue}"/></td>
					</tr>
					
					 </table>
					
			</form>
		</div>
	</body>
</html>

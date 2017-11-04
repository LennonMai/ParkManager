<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			if("${result}"=="SUCCESS")
				alert("更改成功");
				if("${result}"=="FAIL")
				alert("已有此车牌号");
				if("${result}"=="FAIL1")
				alert("已有此卡号");
				if("${result}"=="FAIL2")
				alert("成功加入黑名单");
				if("${result}"=="FAIL3")
				alert("此账户不在黑名单内，不能移出黑名单");
				if("${result}"=="FAIL4")
				alert("成功移出黑名单");
				
				function blackList(){
			 
		            window.location="userCarAccount_blackList.do?account.sys_id="+get("account.sys_id").value;
		      
		       }
		       function blackOut(){
		          window.location="userCarAccount_blackOut.do?sys_id="+get("account.sys_id").value;
		      
		       }
		       function back(){
					window.location.href = "userCarAccount_query.do";
				}
		       
		       
		       String.prototype.trim = function() 
                   { 
                           // 用正则表达式将前后空格，用空字符串替代。 
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
					alert("用户名不能为空，请重新输入.");
					document.getElementsByName("user.userName")[0].focus();
					return false;
				}
				if((document.getElementsByName("user.userName")[0].value).trim()!="" && Len((document.getElementsByName("user.userName")[0].value).trim())>50){
				   alert("用户名长度不能超过50个字符,请重新输入."); 
				   document.getElementsByName("user.userName")[0].focus();
					return false;
				}

				if((document.getElementsByName("user.credentialsType")[0].value).trim()==""){
					alert("证件类型不能为空，请重新选择.");
					document.getElementsByName("user.credentialsType")[0].focus();
					return false;
				}
				if((document.getElementsByName("user.credentialsNo")[0].value).trim()==""){
					alert("证件号码不能为空，请重新输入.");
					document.getElementsByName("user.credentialsNo")[0].focus();
					return false;
				}
				if((document.getElementsByName("user.credentialsNo")[0].value).trim()!="" && Len((document.getElementsByName("user.credentialsNo")[0].value).trim())>50){
				   alert("证件号码长度不能超过50个字符,请重新输入."); 
				   document.getElementsByName("user.credentialsNo")[0].focus();
					return false;
				}
				   
				
				
				if((document.getElementsByName("user.phone")[0].value).trim()!=""){
				
				if(Len((document.getElementsByName("user.phone")[0].value).trim())>20){
                 
                
                   alert("联系电话长度不能超过20个字符，请重新输入.");
                   document.getElementsByName("user.phone")[0].focus();
					return false;
                 }
                 }
                 
             
                 if((document.getElementsByName("user.mobileNumber")[0].value).trim()!=""){
				var partten=/^[0-9]*$/;
				if(partten.test((document.getElementsByName("user.mobileNumber")[0].value).trim())){
                 if(Len((document.getElementsByName("user.mobileNumber")[0].value).trim())>50){
                    alert("手机号码格式不符合要求，（例如13751841933）请重新输入.");
                    document.getElementsByName("user.mobileNumber")[0].focus();
					return false;
                 }
                 }else{alert("手机号码格式不符合要求，（例如13751841933）请重新输入.");
                    document.getElementsByName("user.mobileNumber")[0].focus();
					return false;
                 }
                 }	
                 if((document.getElementsByName("user.address")[0].value).trim()!="" && Len((document.getElementsByName("user.address")[0].value).trim())>80){
				   alert("联系地址长度不能超过80个字符,请重新输入."); 
				   document.getElementsByName("user.address")[0].focus();
					return false;
				}			
				if((document.getElementsByName("car.vehPlate")[0].value).trim()==""){
					alert("车牌号不能为空，请重新输入.");
					document.getElementsByName("car.vehPlate")[0].focus();
					return false;
				}
				if((document.getElementsByName("car.vehPlate")[0].value).trim()!="" && Len((document.getElementsByName("car.vehPlate")[0].value).trim())>10){
				   alert("车牌号长度不能超过10个字符,请重新输入."); 
				  document.getElementsByName("car.vehPlate")[0].focus();
					return false;
				}
				
				if((document.getElementsByName("car.carColour")[0].value).trim()!="" && Len((document.getElementsByName("car.carColour")[0].value).trim())>50){
				   alert("车颜色长度不能超过50个字符,请重新输入."); 
				  document.getElementsByName("car.carColour")[0].focus();
					return false;
				}
				if((document.getElementsByName("car.carType")[0].value).trim()==""){
					alert("车辆类型不能为空，请重新选择.");
					document.getElementsByName("car.carType")[0].focus();
					return false;
				}
				
				if((document.getElementsByName("account.cardNo")[0].value).trim()==""){
					alert("卡号不能为空，请重新输入.");
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
				  alert("卡号只能是数字，请重新输入.");
					document.getElementsByName("account.cardNo")[0].focus();
					return false;
					}
				}		
				if((document.getElementsByName("account.cardNo")[0].value).trim()!=""){
				//var partten=/^[0-9]\d*$/;
				var partten=/^[0]*$/;
				if(partten.test((document.getElementsByName("account.cardNo")[0].value).trim())){
				   alert("卡号的所有的位数不能全为0，请重新输入.");
					document.getElementsByName("account.cardNo")[0].focus();
					return false;
				}
				}	
				var cardNoLegth = document.getElementsByName("param_accountCardNoLength.pvalue")[0].value;
				if(cardNoLegth == 10){
					if((document.getElementsByName("account.cardNo")[0].value).trim()!="" && Len((document.getElementsByName("account.cardNo")[0].value).trim())>cardNoLegth){
						   alert("卡号长度不能超过"+cardNoLegth+"个字符,请重新输入."); 
						   document.getElementsByName("account.cardNo")[0].focus();
						   return false;
						}	
				} 
				if(cardNoLegth != 10) {
					if(Len((document.getElementsByName("account.cardNo")[0].value).trim())!=cardNoLegth){
						 alert("卡号长度要等于"+cardNoLegth+"个字符,请重新输入."); 
						 document.getElementsByName("account.cardNo")[0].focus();
						 return false;
					}
					
				}
				
				
			   
			     
				if((document.getElementsByName("cost")[0].value).trim()==""){
					alert("工本费不能为空，请重新输入.");
					document.getElementsByName("cost")[0].focus();
					return false;
				}	
				if((document.getElementsByName("cost")[0].value).trim()!=""){
				//var partten = /^\+?[0-9][0-9]*$/;
				//var partten=/^d+(.d+)?$/;
				var partten=/^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				if(partten.test((document.getElementsByName("cost")[0].value))){
				   if(document.getElementsByName("cost")[0].value>=100000){
                    alert("工本费过大（不能超过100000），请重新输入.");
                    document.getElementsByName("cost")[0].focus();
					return false;
					}
                 }else{
                   alert("工本费为正实数或者0（例如0或者50.5），请重新输入.");
                   document.getElementsByName("cost")[0].focus();
					return false;
                 }
                 }	
                 if((document.getElementsByName("param_card_type.pvalue")[0].value).trim()=="0"){
                   if((document.getElementsByName("lowestBalanceAfterConsume")[0].value).trim()==""){
					alert("最低余额不能为空，请重新输入.");
					document.getElementsByName("lowestBalanceAfterConsume")[0].focus();
					return false;
				}
				
				if((document.getElementsByName("lowestBalanceAfterConsume")[0].value).trim()!=""){
				var partten = /^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				if(partten.test((document.getElementsByName("lowestBalanceAfterConsume")[0].value))){
                    if(document.getElementsByName("lowestBalanceAfterConsume")[0].value>=100000){
                         alert("最低余额过大（不能超过100000），请重新输入.");
                         document.getElementsByName("lowestBalanceAfterConsume")[0].focus();
					     return false;
                    }
                    
                 }else{
                   alert("最低余额为正实数或者0（例如0或者50.5），请重新输入.");
                  document.getElementsByName("lowestBalanceAfterConsume")[0].focus();
					return false;
                 }
                 }
                   if((document.getElementsByName("tollyLowestBalanceAC")[0].value).trim()==""){
					alert("记账最低余额不能为空，请重新输入.");
					document.getElementsByName("tollyLowestBalanceAC")[0].focus();
					return false;
				}
				
				if((document.getElementsByName("tollyLowestBalanceAC")[0].value).trim()!=""){
				var partten = /^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
			     if(partten.test((document.getElementsByName("tollyLowestBalanceAC")[0].value))){
                    if(document.getElementsByName("tollyLowestBalanceAC")[0].value>=100000){
                      alert("记账最低余额过大（不能超过100000）），请重新输入.");
                      document.getElementsByName("tollyLowestBalanceAC")[0].focus();
					   return false;
					}
                 }else{
                   alert("记账最低余额为正实数或者0（例如0或者50.5），请重新输入.");
                   document.getElementsByName("tollyLowestBalanceAC")[0].focus();
					return false;
                 }
                 }
				
				if((document.getElementsByName("noEntryBalance")[0].value).trim()!=""){
				var partten = /^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				
				if(partten.test((document.getElementsByName("noEntryBalance")[0].value))){
                     if(document.getElementsByName("noEntryBalance")[0].value>=100000){
                      alert("禁止驶入最低余额过大（不能超过100000）），请重新输入.");
                      document.getElementsByName("noEntryBalance")[0].focus();
					   return false;
					}
                 }else{
                   alert("禁止驶入最低余额为正实数或者0（例如0或者50.5），请重新输入.");
                   document.getElementsByName("noEntryBalance")[0].focus();
					return false;
                 }
                 }
				
				if((document.getElementsByName("lowBalanceNotice")[0].value).trim()!=""){
				var partten=/^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				if(partten.test((document.getElementsByName("lowBalanceNotice")[0].value))){
                     if(document.getElementsByName("lowBalanceNotice")[0].value>=100000){
                      alert("提示用户去续费的最低余额过大（不能超过100000）），请重新输入.");
                      document.getElementsByName("lowBalanceNotice")[0].focus();
					   return false;
					}
                  
                 }else{
                   alert("提示用户去续费的最低余额为正实数或者0（例如0或者50.5），请重新输入.");
                   document.getElementsByName("lowBalanceNotice")[0].focus();
					return false;
                 }
                 }	
                 }
                 
                 
                 
                 
              
			
                 if((document.getElementsByName("account.remark")[0].value).trim()!="" && Len((document.getElementsByName("account.remark")[0].value).trim())>80){
				   alert("备注长度不能超过80个字符,请重新输入."); 
				   document.getElementsByName("account.remark")[0].focus();
					return false;
				}
                 if((document.getElementsByName("car.vehPlate")[0].value).trim()!=(document.getElementsByName("vehPlate")[0].value).trim()){	
                 if((document.getElementsByName("car.vehPlate")[0].value).trim()!=""){
        			 
     				var v="succuss";
     				var val=(document.getElementsByName("car.vehPlate")[0].value).trim();
     			   // jQuery.post("userCarAccount_getCarByVehPlate.do?car.vehPlate="+val,function(data){
     			  //  alert("data---"+data);
     			  //  if(data=="fail"){v="fail"; alert(v);alert("此车牌已存在"); }
     			    //  }
     			    //  );
     			    // alert("V---"+v);
     			    // if(v=="fail"){document.getElementsByName("car.vehPlate")[0].focus();return false;}
     			    jQuery.ajax({type:"post",url:"userCarAccount_getCarByVehPlate.do?car.vehPlate="+val,async:false, success:function(data,textStatus){ 
         			    if(data=="fail"){v="fail";alert("此车牌已存在"); }			   
     				 }
     				 });				 					 
     				 if(v=="fail"){document.getElementsByName("car.vehPlate")[0].focus();return false;}
     				 }
                 }
                 if((document.getElementsByName("account.cardNo")[0].value).trim()!=(document.getElementsByName("cardNo")[0].value).trim()){ 
     				 if(document.getElementsByName("account.cardNo")[0].value!=""){
     				     var v1="succuss";				   
     		        	 var val3=(document.getElementsByName("account.cardNo")[0].value).trim();
     			        jQuery.ajax({type:"post",url:"userCarAccount_getAccountByCardNo.do?account.cardNo=" +val3,async:false, success:function(data1,textStatus){			           
     			        	if(data1=="fail1"){v1="No";alert("此卡已被其它账户运用"); }	
     				        if(data1=="statusNoUse"){v1="No";alert("该卡在卡信息中不是正常卡，不能运用"); }	
     				        if(data1=="secondUse"){v1="No";alert("该卡之前已被运用过，不能再被运用"); }
     				        if(data1=="NoRegister"){alert("该卡还没进行登记，请更改信息成功后进行登记使用"); }			   
     					     }
     					     });    					    		 					 
     					   if(v1=="No"){document.getElementsByName("account.cardNo")[0].focus();return false;}				 
     				          }	
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
			 <form method="post" action="userCarAccount_updateAccountAndSaveLog.do" onsubmit="return check();">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="871" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" height="345">
					
					
					
					<tr>
					  <td class="pn-flabel pn-flabel-h">账&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
					  <td  class="pn-fcontent"><input type="text" name="account.sys_id" value="${account.sys_id}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td> 
					    <td class="pn-flabel pn-flabel-h">账号状态：</td>
					  
					    <c:if test="${account.status==0}"><td class="pn-fcontent"><input type="text" value="有效" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==1}"><td class="pn-fcontent"><input type="text" value="挂失" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==2}"><td class="pn-fcontent"><input type="text" value="预销户" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==3}"><td class="pn-fcontent"><input type="text" value="余额不足" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==4}"><td class="pn-fcontent"><input type="text" value="其他" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==5}"><td class="pn-fcontent"><input type="text" value="已销户" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==6}"><td class="pn-fcontent"><input type="text" value="余额过低" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.status==7}"><td class="pn-fcontent"><input type="text" value="黑名单" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>						
					  
					  </tr>
					  <tr>
					  <td class="pn-flabel pn-flabel-h">用&nbsp;户&nbsp;名：</td>
					  <td class="pn-fcontent"><input type="text" name="user.userName" value="${user.userName}"/>&nbsp;<font style="color:red">*</font></td>
					   <td class="pn-flabel pn-flabel-h">校区名称：</td>
					    <td   class="pn-fcontent">
					    <select name="account.parkNo" style="width:150px">
							    <c:forEach items="${listPark}" var="item">
								<option value="${item.parkNo}" <c:if test="${account.parkNo==item.parkNo}">selected</c:if>>${item.parkName}</option>
							 </c:forEach>  
						</select>
					    </td>
					  </tr>
					  	<tr>
					
					  <td class="pn-flabel pn-flabel-h">证件类型：</td>
					    <c:if test="${user.credentialsType==0}"><td class="pn-fcontent"> <select name="user.credentialsType" style="width:150px">
							<option value="0">身       份            证</option>
							<option value="1">其                     他 </option>
			
						</select>&nbsp;<font style="color:red">*</font></td></c:if>
					   
					    <c:if test="${user.credentialsType==1}"><td class="pn-fcontent"> <select name="user.credentialsType" style="width:150px">
							<option value="1">其                     他 </option>
							<option value="0">身       份            证</option>
						</select>&nbsp;<font style="color:red">*</font></td></c:if>
					
					  <td class="pn-flabel pn-flabel-h">证件号码：</td>
					  <td class="pn-fcontent"><input type="text" name="user.credentialsNo" value="${user.credentialsNo}"/>&nbsp;<font style="color:red">*</font></td>
					</tr>
					  <tr>
					   <td class="pn-flabel pn-flabel-h">联系电话：</td>
					   <td class="pn-fcontent"><input type="text" name="user.phone" value="${user.phone}"/></td>
					   <td class="pn-flabel pn-flabel-h">手机号码：</td>
					   <td class="pn-fcontent"><input type="text" name="user.mobileNumber" value="${user.mobileNumber}"/></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">联系地址：</td>
					    <td colspan="3" class="pn-fcontent"><input type="text" name="user.address" value="${user.address}" size="86"/></td>
					</tr> 
					<tr>
					  <td  class="pn-flabel pn-flabel-h">车辆类型：</td>
					  <c:if test="${car.carType==1}"><td colspan="3" class="pn-fcontent"> <select name="car.carType" style="width:610px">
							<option value="1">小轿车、吉普车、的士头人货车、摩托车</option>
							<option value="2">面包车、小型人货车、轻型货车、小型客车 </option>
							<option value="3">中型客车、大型客车、中型货车</option>
							<option value="4">大型客车、大型货车、大型拖（挂）车、20英尺集装箱车 </option>
							<option value="5">重型货车、重型拖（挂）车、40英尺集装箱车</option>
							
						</select>&nbsp;<font style="color:red">*</font></td></c:if>
					    <c:if test="${car.carType==2}"><td colspan="3" class="pn-fcontent"> <select name="car.carType" style="width:610px">
							<option value="2">面包车、小型人货车、轻型货车、小型客车 </option>
							<option value="1">小轿车、吉普车、的士头人货车、摩托车</option>
							<option value="3">中型客车、大型客车、中型货车</option>
							<option value="4">大型客车、大型货车、大型拖（挂）车、20英尺集装箱车 </option>
							<option value="5">重型货车、重型拖（挂）车、40英尺集装箱车</option>
							
						</select>&nbsp;<font style="color:red">*</font></td></c:if>
						 <c:if test="${car.carType==3}"><td colspan="3" class="pn-fcontent"> <select name="car.carType" style="width:610px">
							<option value="3">中型客车、大型客车、中型货车</option>
							<option value="1">小轿车、吉普车、的士头人货车、摩托车</option>
							<option value="2">面包车、小型人货车、轻型货车、小型客车 </option>
							<option value="4">大型客车、大型货车、大型拖（挂）车、20英尺集装箱车 </option>
							<option value="5">重型货车、重型拖（挂）车、40英尺集装箱车</option>
							
						</select>&nbsp;<font style="color:red">*</font></td></c:if>
						 <c:if test="${car.carType==4}"><td colspan="3" class="pn-fcontent"> <select name="car.carType" style="width:610px">
							<option value="4">大型客车、大型货车、大型拖（挂）车、20英尺集装箱车 </option>
							<option value="1">小轿车、吉普车、的士头人货车、摩托车</option>
							<option value="2">面包车、小型人货车、轻型货车、小型客车 </option>
							<option value="3">中型客车、大型客车、中型货车</option>
							<option value="5">重型货车、重型拖（挂）车、40英尺集装箱车</option>
							
						</select>&nbsp;<font style="color:red">*</font></td></c:if>
						 <c:if test="${car.carType==5}"><td colspan="3" class="pn-fcontent"> <select name="car.carType" style="width:610px">
							<option value="5">重型货车、重型拖（挂）车、40英尺集装箱车</option>
							<option value="1">小轿车、吉普车、的士头人货车、摩托车</option>
							<option value="2">面包车、小型人货车、轻型货车、小型客车 </option>
							<option value="3">中型客车、大型客车、中型货车</option>
							<option value="4">大型客车、大型货车、大型拖（挂）车、20英尺集装箱车 </option>														
						</select>&nbsp;<font style="color:red">*</font></td></c:if>
						
					  </tr> 
					<tr>			  					  
					  <td class="pn-flabel pn-flabel-h">车&nbsp;牌&nbsp;号：</td>
					  <td class="pn-fcontent"><input type="text" name="car.vehPlate" value="${car.vehPlate}" />&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">车&nbsp;颜&nbsp;色：</td>
					   <td class="pn-fcontent"><input type="text" name="car.carColour" value="${car.carColour}"/></td>
					</tr>
					
					<tr>
					  <%--<td class="pn-flabel pn-flabel-h">卡类型：</td>
					    <c:if test="${account.cardType==0}"><td class="pn-fcontent"><input type="text" value="粤通卡" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.cardType==5}"><td class="pn-fcontent"><input type="text" value="缴费卡" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${account.cardType!=5&&account.cardType!=0}"><td class="pn-fcontent"><input type="text" value="" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					  --%><td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
					   <c:if test="${param_card_type.pvalue==1}">
					     <td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   </c:if>
					   <c:if test="${param_card_type.pvalue!=1}">
					     <td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}"/>&nbsp;<font style="color:red">*</font></td>
					   </c:if>
					   <td class="pn-flabel pn-flabel-h">工&nbsp;本&nbsp;费：</td>
					  <td class="pn-fcontent"><input type="text" name="cost" value="<fmt:formatNumber value="${account.cost/100}" pattern="#.##" type="number"/>"/>&nbsp;<font style="color:red">*</font></td>
					  
					</tr> 	
					 <c:if test="${param_card_type.pvalue!=1}">
					 <tr>
					  <td class="pn-flabel pn-flabel-h">最低余额：</td>
					  <td class="pn-fcontent"><input type="text" name="lowestBalanceAfterConsume" value="<fmt:formatNumber value="${account.lowestBalanceAfterConsume/100}" pattern="#.##" type="number"/>"/>&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">记账最低余额(元）：</td>
					  <td class="pn-fcontent"><input type="text" name="tollyLowestBalanceAC" value="<fmt:formatNumber value="${account.tollyLowestBalanceAC/100}" pattern="#.##" type="number"/>"/>&nbsp;<font style="color:red">*</font></td>					 
					</tr>
					 <tr>
					  <td class="pn-flabel pn-flabel-h">禁止驶入最低余额(元）：</td>
					  <td class="pn-fcontent"><input type="text" name="noEntryBalance" value="<fmt:formatNumber value="${account.noEntryBalance/100}" pattern="#.##" type="number"/>"/></td>
					  <td class="pn-flabel pn-flabel-h">提示用户去续费的最低余额(元）：</td>
					  <td class="pn-fcontent"><input type="text" name="lowBalanceNotice" value="<fmt:formatNumber value="${account.lowBalanceNotice/100}" pattern="#.##" type="number"/>"/></td>					 
					 </tr>
					 </c:if>		 
					 <tr>
					 <td class="pn-flabel pn-flabel-h">开户时间：</td>
					  <td class="pn-fcontent"><input type="text" name="account.openAccountTime" value="${account.openAccountTime}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">状态更改时间：</td>
					  <td class="pn-fcontent"><input type="text" name="account.statusUpdateTime" value="<fmt:formatDate value="${account.statusUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss" />"
						 readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>					  
					<tr>
					  <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
					  <td colspan="3" class="pn-fcontent"><textarea rows='2' cols='84' name="account.remark">${account.remark}</textarea></td>
					</tr>					
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 修改 "/> &nbsp;							 
							<c:if test="${account.status==0}">							
							<input type="button" value="移进黑名单" onclick="blackList();"/> &nbsp;
							</c:if>							
							<c:if test="${account.status==7}">							
							<input type="button" value="移出黑名单" onclick="blackOut();"/> &nbsp;						    
						    </c:if>
						    <input type="button" value=" 返 回 " onclick="return back();"/>						   
						    <input type="hidden" name="vehPlate" value="${car.vehPlate}"/>
						    <input type="hidden" name="cardNo" value="${account.cardNo}"/>
					</tr>
					<tr>
					
					  <td  colspan="2" class="pn-fbutton" ><input type="hidden" name="param_card_type.pvalue" value="${param_card_type.pvalue}"/></td>
					  <td colspan="2" class="pn-fcontent"><input type="hidden" name="param_accountCardNoLength.pvalue" value="${param_accountCardNoLength.pvalue}"/></td>
					</tr>
					
					 </table>
					
			</form>
		</div>
	</body>
</html>

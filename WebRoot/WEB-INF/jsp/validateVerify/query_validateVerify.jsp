<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>流水校验</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script language="javascript">
		 function reSet(){
			get("verify_startTime").value="";			 
			get("verify_endTime").value="";		
			get("accountTrade_account_user_userName").value="";	
			get("accountTrade_cardNo").value="";	
			get("accountTrade_vehPlate").value="";		
			get("accountTrade.tradeType").value="";			    	
		 }
		 function isEqualDay(beginTime,endTime){
			  var s1 = beginTime.replace(/-/g, "/");
			  var s2 = endTime.replace(/-/g, "/");
			  d1 = new Date(s1);
			  d2 = new Date(s2);
			  year1 = d1.getYear();
			  year2 = d2.getYear();
			  month1=d1.getMonth()+1;
			  month2=d2.getMonth()+1;
			  day1 = d1.getDay();
			  day2 = d2.getDay();
			  if(day1==day2&&month1==month2&&year1==year2){
				  return 1;			  
			  }else{
				  return 2;
			  }
		  }
      function check(){
      	if(get("startTime").value ==""|| get("endTime").value ==""){					
				alert("交易时间不能为空！");
				return false;					
		     }
       
	        if(get("startTime").value !=""&& get("endTime").value != ""){
			      if(get("startTime").value > get("endTime").value) {
			         alert("开始时间必须早于或等于结束时间");
			    	 return false;
			        }else{
				        if(isEqualDay(document.getElementById('startTime').value,document.getElementById('endTime').value)==2){
				        	alert("时间间隔不能超过1天！");
							return false;	
				        }
			        	<%--var months=compTime(get("startTime").value,get("endTime").value);
						if(months>3){
							alert("时间间隔不能超过3个月！");
							return false;	
						}--%>
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
			<form  name="tableForm"  method="post" action="accountTrade_queryvalidateVerify.do" onsubmit="return check();">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">用户名：</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <input style="width: 158px;" type="text" id="accountTrade_account_user_userName" name="user.userName" value="${user.userName}" /></td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">缴费卡号：</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"><input style="width: 158px;" type="text" id="accountTrade_cardNo" name="account.cardNo" value="${account.cardNo}"/></td>					    
					</tr>
					<tr>
					    <td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">车牌号：</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <input style="width: 158px;" type="text" id="accountTrade_vehPlate" name="car.vehPlate" value="${car.vehPlate}"/></td>
				    	<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">交易类型：</td>
						<td  style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent">  
						
							<select name="accountTrade.tradeType" style="width:150px">
								<option value="" <c:if test="${accountTrade.tradeType==null}">selected</c:if>>请选择</option>
							    <option value="0" <c:if test="${accountTrade.tradeType==0}">selected</c:if>>通行费扣费</option>
								<option value="1" <c:if test="${accountTrade.tradeType==1}">selected</c:if>>充值 </option>
								<option value="2" <c:if test="${accountTrade.tradeType==2}">selected</c:if>>冲正</option>
							    <option value="3" <c:if test="${accountTrade.tradeType==3}">selected</c:if>>销户</option>
								<option value="4" <c:if test="${accountTrade.tradeType==4}">selected</c:if>>开户 </option>
								<option value="5" <c:if test="${accountTrade.tradeType==5}">selected</c:if>>其他 </option>
							</select>															
						</td>
		               
				    </tr>
					<tr>					  
		                
						<td  style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">交易时间：</td>
						<td   style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> 
						 <input style="width: 158px;" type="text" id ="startTime" name="startTime" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input  style="width: 158px;" type="text" id ="endTime" name="endTime" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">		
						</td>
						 
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">输出条件：</td>
					    <td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> 
					    <c:if test="${validateCheck=='validateAll'}">
					    <select style="width: 161px;" id="validateCheck" name="validateCheck">
						     <option value="validateAll" selected="selected">校验全部流水</option>
						   <option value="correct">校验通过的流水</option>
			               <option value="incorrect" >校验不通过的流水</option>					               	          
		                </select>
					    </c:if>
					    <c:if test="${validateCheck=='correct'}">
					    <select style="width: 161px;" id="validateCheck" name="validateCheck">
						     <option value="validateAll">校验全部流水</option>
						   <option value="correct" selected="selected">校验通过的流水</option>
			               <option value="incorrect" >校验不通过的流水</option>					               	          
		                </select></c:if>
		                <c:if test="${validateCheck=='incorrect'}">
					    <select style="width: 161px;" id="validateCheck" name="validateCheck">
						   <option value="validateAll">校验全部流水</option>
						   <option value="correct">校验通过的流水</option>
			               <option value="incorrect" selected="selected">校验不通过的流水</option>					               	          
		                </select></c:if>
		                </td>						
					</tr>
					<tr >
						<td colspan="4" style="height: 22px;" class="pn-fbutton">
						<input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="submit" value=" 效 验 " />&nbsp;&nbsp;					
						<input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="button" value=" 重 置 " onclick="reSet();"/>	
						</td>
					</tr>
			
				</table>		
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">账&nbsp;&nbsp;号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">帐号状态</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">用户名</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">序号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车牌号</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">缴费卡号</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">金额（元）</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">余额（元）</th>							
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">交易类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">交易流水号</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">交易时间</th>
						 <th style="white-space:nowrap;padding-left:5px;padding-right:5px;">校验结果</th>
					
					</tr>
				</thead>
				<tbody class="pn-ltbody">
								<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
					    	<td>${item[0]}</td>
					    	<td><c:if test="${item[16]==0}">有效</c:if><c:if test="${item[16]==1}">挂失</c:if><c:if test="${item[16]==2}">预销户</c:if><c:if test="${item[16]==4}">其他</c:if><c:if test="${item[16]==5}">已销户</c:if><c:if test="${item[16]==7}">黑名单</c:if></td>
							<td>${item[14]}</td>							
							<td>${item[9]}</td>						
							<td>${item[2]}</td>							
							<td>${item[1]}</td>
							<td><fmt:formatNumber value="${item[6]/100}" pattern="#.##" type="number"/></td>
							<td><fmt:formatNumber value="${item[7]/100}" pattern="#.##" type="number"/></td>
							<td><c:if test="${item[3]==0}">通行费扣费</c:if><c:if test="${item[3]==1}">充值</c:if><c:if test="${item[3]==2}">冲正</c:if><c:if test="${item[3]==3}">销户</c:if><c:if test="${item[3]==4}">开户</c:if><c:if test="${item[3]==5}">其他</c:if></td>
						    <td>${item[8]}</td>
							<td>${item[4]}</td>							
							<td style="padding-left:5px;padding-right:5px;">${item[17]}</td>		
						</tr>
					</c:forEach><%--
				
				    <!-- 用户选择全部校验的Map循环 -->
				    <c:if test="${validateCheck=='validateAll'}">
				    <c:forEach items="${validateMap}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td style="padding-left:5px;padding-right:5px;">${item.value.account.sys_id}</td>
							<td style="padding-left:5px;padding-right:5px;">	
							<c:if test="${item.value.account.status==0}">有效</c:if>
							<c:if test="${item.value.account.status==1}">挂失</c:if>
							<c:if test="${item.value.account.status==2}">预销户</c:if>
							<c:if test="${item.value.account.status==3}">余额不足</c:if>
							<c:if test="${item.value.account.status==4}">其他</c:if>
							<c:if test="${item.value.account.status==5}">已销户</c:if>
							<c:if test="${item.value.account.status==6}">余额过低</c:if>
							<c:if test="${item.value.account.status==7}">黑名单</c:if></td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.account.user.userName}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.seqNo}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.vehPlate}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.cardNo}</td>
							<td style="padding-left:5px;padding-right:5px;">
                            <c:if test="${item.value.cardType==0}">缴费卡</c:if>
							<c:if test="${item.value.cardType==5}">缴费卡</c:if></td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.balance/100}</td>							
							<td style="padding-left:5px;padding-right:5px;"><c:if test="${item.value.tradeType==0}">通行费扣费</c:if>
							<c:if test="${item.value.tradeType==1}">充值</c:if>
							<c:if test="${item.value.tradeType==2}">冲正</c:if>
							<c:if test="${item.value.tradeType==3}">销户</c:if>
							<c:if test="${item.value.tradeType==4}">开户</c:if>
							<c:if test="${item.value.tradeType==5}">其他</c:if></td>								
							<td style="padding-left:5px;padding-right:5px;">${item.value.listNo}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.opTime}</td>	
							<td align="left" style="color:olive; padding-left:30px;padding-right:5px;">${item.key}</td>	
	                 
						</tr>
					</c:forEach>
				    </c:if>
				    
				    <!-- 用户选择校验通过或者不通过时的List循环 -->
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td style="padding-left:5px;padding-right:5px;">${item.account.sys_id}</td>
							<td style="padding-left:5px;padding-right:5px;">	
							<c:if test="${item.account.status==0}">有效</c:if>
							<c:if test="${item.account.status==1}">挂失</c:if>
							<c:if test="${item.account.status==2}">预销户</c:if>
							<c:if test="${item.account.status==3}">余额不足</c:if>
							<c:if test="${item.account.status==4}">其他</c:if>
							<c:if test="${item.account.status==5}">已销户</c:if>
							<c:if test="${item.account.status==6}">余额过低</c:if>
							<c:if test="${item.account.status==7}">黑名单</c:if></td>
							<td style="padding-left:5px;padding-right:5px;">${item.account.user.userName}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.seqNo}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.vehPlate}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.cardNo}</td>
							<td style="padding-left:5px;padding-right:5px;">
                            <c:if test="${item.cardType==0}">缴费卡</c:if>
							<c:if test="${item.cardType==5}">粤通卡</c:if></td>
							<td style="padding-left:5px;padding-right:5px;">${item.balance}</td>							
							<td style="padding-left:5px;padding-right:5px;"><c:if test="${item.tradeType==0}">通行费扣费</c:if>
							<c:if test="${item.tradeType==1}">充值</c:if>
							<c:if test="${item.tradeType==2}">冲正</c:if>
							<c:if test="${item.tradeType==3}">销户</c:if>
							<c:if test="${item.tradeType==4}">开户</c:if>
							<c:if test="${item.tradeType==5}">其他</c:if></td>								
							<td style="padding-left:5px;padding-right:5px;">${item.listNo}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.opTime}</td>	
	                        <c:if test="${validateCheck=='correct'}"><td align="left" style="color:olive; padding-left:30px;padding-right:5px;">已通过校验_[${item.account.sys_id}_${item.seqNo}]</td></c:if>
							<c:if test="${validateCheck=='incorrect'}"><td align="left" style="color:olive; padding-left:30px;padding-right:5px;">校验不通过_[${item.account.sys_id}_${item.seqNo}]</td></c:if>						
							
						</tr>
					</c:forEach>
				--%></tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>
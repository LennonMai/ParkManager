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

        if("${overCount}">10000){
            alert("提示：\n\n    流水校验记录已经超过10000条,为了不影响系统校验速度， \n\n建议缩短时间范围，页面将跳转，请稍后！");
            }
      //计算月期差
		  function compTime(beginTime,endTime){
		  	var s1 = beginTime.replace(/-/g, "/");
			var s2 = endTime.replace(/-/g, "/");
			d1 = new Date(s1);
			d2 = new Date(s2);
			year1 = d1.getYear();
			year2 = d2.getYear();
			years =parseInt(year2)-parseInt(year1);
			if(parseInt(years)==0){
				month1=d1.getMonth()+1;
				month2=d2.getMonth()+1;
				 months = parseInt(month2)-parseInt(month1)+1; 
				return months; 
			} else if(parseInt(years)==1){
				month1=d1.getMonth()+1;
				month2=d2.getMonth()+1;
				 months = parseInt(month2)+(12-parseInt(month1))+1; 
				 return months; 
			}else{					
				month1=d1.getMonth()+1;
				month2=d2.getMonth()+1;
				 months = (parseInt(years)-1)*12+parseInt(month2)+(12-parseInt(month1))+1;
				 return months; 
			}
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
				        if(isEqualDay(get("startTime").value,get("endTime").value)==2){
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
			<form  name="tableForm"  method="post" action="accountTrade_queryvalidateVerify.do" onsubmit="return check();" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;"  class="pn-flabel pn-flabel-h">用户名：</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <input style="width: 158px;" type="text" name="user.userName" value="${user.userName}" /></td>
						
						<td  style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">缴费卡号：</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"><input style="width: 158px;" type="text" name="account.cardNo"  value="${account.cardNo}"/></td>					    
					</tr>
					<tr>
					    <td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">车牌号：</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <input style="width: 158px;" type="text" name="car.vehPlate" value="${car.vehPlate}"/></td>
				    	
				    	<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">交易类型：</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <select class="required " style="width: 161px;" name="accountTrade.tradeType" >
						   <option value="" selected="selected">请选择</option>
			               <option value="0">通行费扣费</option>		
			               <option value="1">充值</option>
			               <option value="2">冲正</option>
			               <option value="3">销户</option>
			               <option value="4">开户</option>
			               <option value="5">其他</option>			               	          
		                </select></td>
				    </tr>
					<tr>					  
		                <td  style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">交易时间：</td>
						<td   style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> 
						 <input style="width: 158px;" type="text" name="startTime" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input  style="width: 158px;" type="text" name="endTime" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">		
						</td>
						
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;"  class="pn-flabel pn-flabel-h">输出条件：</td>
					    <td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <select style="width: 161px;" id="validateCheck" name="validateCheck">
						   <option value="validateAll" selected="selected">校验全部流水</option>
						   <option value="correct">校验通过的流水</option>
			               <option value="incorrect">校验不通过的流水</option>					               	          
		                </select></td>						
					</tr>
					<tr >
						<td colspan="4" style="height: 22px;" class="pn-fbutton">
						<input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="submit" value=" 校验 " />&nbsp;
						<%--<input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="button" value=" 校验 "  onclick="verify('${startTime}');"/>&nbsp;				
						--%><input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="reset"" value=" 重 置 " />	
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
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>
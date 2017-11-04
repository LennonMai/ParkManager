<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>��ˮУ��</title>
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
				alert("����ʱ�䲻��Ϊ�գ�");
				return false;					
		     }
       
	        if(get("startTime").value !=""&& get("endTime").value != ""){
			      if(get("startTime").value > get("endTime").value) {
			         alert("��ʼʱ��������ڻ���ڽ���ʱ��");
			    	 return false;
			        }else{
				        if(isEqualDay(document.getElementById('startTime').value,document.getElementById('endTime').value)==2){
				        	alert("ʱ�������ܳ���1�죡");
							return false;	
				        }
			        	<%--var months=compTime(get("startTime").value,get("endTime").value);
						if(months>3){
							alert("ʱ�������ܳ���3���£�");
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="accountTrade_queryvalidateVerify.do" onsubmit="return check();">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">�û�����</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <input style="width: 158px;" type="text" id="accountTrade_account_user_userName" name="user.userName" value="${user.userName}" /></td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">�ɷѿ��ţ�</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"><input style="width: 158px;" type="text" id="accountTrade_cardNo" name="account.cardNo" value="${account.cardNo}"/></td>					    
					</tr>
					<tr>
					    <td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">���ƺţ�</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <input style="width: 158px;" type="text" id="accountTrade_vehPlate" name="car.vehPlate" value="${car.vehPlate}"/></td>
				    	<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td  style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent">  
						
							<select name="accountTrade.tradeType" style="width:150px">
								<option value="" <c:if test="${accountTrade.tradeType==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${accountTrade.tradeType==0}">selected</c:if>>ͨ�зѿ۷�</option>
								<option value="1" <c:if test="${accountTrade.tradeType==1}">selected</c:if>>��ֵ </option>
								<option value="2" <c:if test="${accountTrade.tradeType==2}">selected</c:if>>����</option>
							    <option value="3" <c:if test="${accountTrade.tradeType==3}">selected</c:if>>����</option>
								<option value="4" <c:if test="${accountTrade.tradeType==4}">selected</c:if>>���� </option>
								<option value="5" <c:if test="${accountTrade.tradeType==5}">selected</c:if>>���� </option>
							</select>															
						</td>
		               
				    </tr>
					<tr>					  
		                
						<td  style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
						<td   style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> 
						 <input style="width: 158px;" type="text" id ="startTime" name="startTime" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input  style="width: 158px;" type="text" id ="endTime" name="endTime" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">		
						</td>
						 
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">���������</td>
					    <td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> 
					    <c:if test="${validateCheck=='validateAll'}">
					    <select style="width: 161px;" id="validateCheck" name="validateCheck">
						     <option value="validateAll" selected="selected">У��ȫ����ˮ</option>
						   <option value="correct">У��ͨ������ˮ</option>
			               <option value="incorrect" >У�鲻ͨ������ˮ</option>					               	          
		                </select>
					    </c:if>
					    <c:if test="${validateCheck=='correct'}">
					    <select style="width: 161px;" id="validateCheck" name="validateCheck">
						     <option value="validateAll">У��ȫ����ˮ</option>
						   <option value="correct" selected="selected">У��ͨ������ˮ</option>
			               <option value="incorrect" >У�鲻ͨ������ˮ</option>					               	          
		                </select></c:if>
		                <c:if test="${validateCheck=='incorrect'}">
					    <select style="width: 161px;" id="validateCheck" name="validateCheck">
						   <option value="validateAll">У��ȫ����ˮ</option>
						   <option value="correct">У��ͨ������ˮ</option>
			               <option value="incorrect" selected="selected">У�鲻ͨ������ˮ</option>					               	          
		                </select></c:if>
		                </td>						
					</tr>
					<tr >
						<td colspan="4" style="height: 22px;" class="pn-fbutton">
						<input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="submit" value=" Ч �� " />&nbsp;&nbsp;					
						<input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="button" value=" �� �� " onclick="reSet();"/>	
						</td>
					</tr>
			
				</table>		
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ʺ�״̬</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ƺ�</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ɷѿ���</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��Ԫ��</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��Ԫ��</th>							
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">������ˮ��</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ʱ��</th>
						 <th style="white-space:nowrap;padding-left:5px;padding-right:5px;">У����</th>
					
					</tr>
				</thead>
				<tbody class="pn-ltbody">
								<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
					    	<td>${item[0]}</td>
					    	<td><c:if test="${item[16]==0}">��Ч</c:if><c:if test="${item[16]==1}">��ʧ</c:if><c:if test="${item[16]==2}">Ԥ����</c:if><c:if test="${item[16]==4}">����</c:if><c:if test="${item[16]==5}">������</c:if><c:if test="${item[16]==7}">������</c:if></td>
							<td>${item[14]}</td>							
							<td>${item[9]}</td>						
							<td>${item[2]}</td>							
							<td>${item[1]}</td>
							<td><fmt:formatNumber value="${item[6]/100}" pattern="#.##" type="number"/></td>
							<td><fmt:formatNumber value="${item[7]/100}" pattern="#.##" type="number"/></td>
							<td><c:if test="${item[3]==0}">ͨ�зѿ۷�</c:if><c:if test="${item[3]==1}">��ֵ</c:if><c:if test="${item[3]==2}">����</c:if><c:if test="${item[3]==3}">����</c:if><c:if test="${item[3]==4}">����</c:if><c:if test="${item[3]==5}">����</c:if></td>
						    <td>${item[8]}</td>
							<td>${item[4]}</td>							
							<td style="padding-left:5px;padding-right:5px;">${item[17]}</td>		
						</tr>
					</c:forEach><%--
				
				    <!-- �û�ѡ��ȫ��У���Mapѭ�� -->
				    <c:if test="${validateCheck=='validateAll'}">
				    <c:forEach items="${validateMap}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td style="padding-left:5px;padding-right:5px;">${item.value.account.sys_id}</td>
							<td style="padding-left:5px;padding-right:5px;">	
							<c:if test="${item.value.account.status==0}">��Ч</c:if>
							<c:if test="${item.value.account.status==1}">��ʧ</c:if>
							<c:if test="${item.value.account.status==2}">Ԥ����</c:if>
							<c:if test="${item.value.account.status==3}">����</c:if>
							<c:if test="${item.value.account.status==4}">����</c:if>
							<c:if test="${item.value.account.status==5}">������</c:if>
							<c:if test="${item.value.account.status==6}">������</c:if>
							<c:if test="${item.value.account.status==7}">������</c:if></td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.account.user.userName}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.seqNo}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.vehPlate}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.cardNo}</td>
							<td style="padding-left:5px;padding-right:5px;">
                            <c:if test="${item.value.cardType==0}">�ɷѿ�</c:if>
							<c:if test="${item.value.cardType==5}">�ɷѿ�</c:if></td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.balance/100}</td>							
							<td style="padding-left:5px;padding-right:5px;"><c:if test="${item.value.tradeType==0}">ͨ�зѿ۷�</c:if>
							<c:if test="${item.value.tradeType==1}">��ֵ</c:if>
							<c:if test="${item.value.tradeType==2}">����</c:if>
							<c:if test="${item.value.tradeType==3}">����</c:if>
							<c:if test="${item.value.tradeType==4}">����</c:if>
							<c:if test="${item.value.tradeType==5}">����</c:if></td>								
							<td style="padding-left:5px;padding-right:5px;">${item.value.listNo}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.value.opTime}</td>	
							<td align="left" style="color:olive; padding-left:30px;padding-right:5px;">${item.key}</td>	
	                 
						</tr>
					</c:forEach>
				    </c:if>
				    
				    <!-- �û�ѡ��У��ͨ�����߲�ͨ��ʱ��Listѭ�� -->
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td style="padding-left:5px;padding-right:5px;">${item.account.sys_id}</td>
							<td style="padding-left:5px;padding-right:5px;">	
							<c:if test="${item.account.status==0}">��Ч</c:if>
							<c:if test="${item.account.status==1}">��ʧ</c:if>
							<c:if test="${item.account.status==2}">Ԥ����</c:if>
							<c:if test="${item.account.status==3}">����</c:if>
							<c:if test="${item.account.status==4}">����</c:if>
							<c:if test="${item.account.status==5}">������</c:if>
							<c:if test="${item.account.status==6}">������</c:if>
							<c:if test="${item.account.status==7}">������</c:if></td>
							<td style="padding-left:5px;padding-right:5px;">${item.account.user.userName}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.seqNo}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.vehPlate}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.cardNo}</td>
							<td style="padding-left:5px;padding-right:5px;">
                            <c:if test="${item.cardType==0}">�ɷѿ�</c:if>
							<c:if test="${item.cardType==5}">��ͨ��</c:if></td>
							<td style="padding-left:5px;padding-right:5px;">${item.balance}</td>							
							<td style="padding-left:5px;padding-right:5px;"><c:if test="${item.tradeType==0}">ͨ�зѿ۷�</c:if>
							<c:if test="${item.tradeType==1}">��ֵ</c:if>
							<c:if test="${item.tradeType==2}">����</c:if>
							<c:if test="${item.tradeType==3}">����</c:if>
							<c:if test="${item.tradeType==4}">����</c:if>
							<c:if test="${item.tradeType==5}">����</c:if></td>								
							<td style="padding-left:5px;padding-right:5px;">${item.listNo}</td>
							<td style="padding-left:5px;padding-right:5px;">${item.opTime}</td>	
	                        <c:if test="${validateCheck=='correct'}"><td align="left" style="color:olive; padding-left:30px;padding-right:5px;">��ͨ��У��_[${item.account.sys_id}_${item.seqNo}]</td></c:if>
							<c:if test="${validateCheck=='incorrect'}"><td align="left" style="color:olive; padding-left:30px;padding-right:5px;">У�鲻ͨ��_[${item.account.sys_id}_${item.seqNo}]</td></c:if>						
							
						</tr>
					</c:forEach>
				--%></tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>
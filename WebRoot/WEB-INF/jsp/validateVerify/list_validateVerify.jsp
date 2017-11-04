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

        if("${overCount}">10000){
            alert("��ʾ��\n\n    ��ˮУ���¼�Ѿ�����10000��,Ϊ�˲�Ӱ��ϵͳУ���ٶȣ� \n\n��������ʱ�䷶Χ��ҳ�潫��ת�����Ժ�");
            }
      //�������ڲ�
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
				alert("����ʱ�䲻��Ϊ�գ�");
				return false;					
		     }
         
	        if(get("startTime").value !=""&& get("endTime").value != ""){
			      if(get("startTime").value > get("endTime").value) {
			         alert("��ʼʱ��������ڻ���ڽ���ʱ��");
			    	 return false;
			        }else{
				        if(isEqualDay(get("startTime").value,get("endTime").value)==2){
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
			<form  name="tableForm"  method="post" action="accountTrade_queryvalidateVerify.do" onsubmit="return check();" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;"  class="pn-flabel pn-flabel-h">�û�����</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <input style="width: 158px;" type="text" name="user.userName" value="${user.userName}" /></td>
						
						<td  style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">�ɷѿ��ţ�</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"><input style="width: 158px;" type="text" name="account.cardNo"  value="${account.cardNo}"/></td>					    
					</tr>
					<tr>
					    <td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">���ƺţ�</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <input style="width: 158px;" type="text" name="car.vehPlate" value="${car.vehPlate}"/></td>
				    	
				    	<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <select class="required " style="width: 161px;" name="accountTrade.tradeType" >
						   <option value="" selected="selected">��ѡ��</option>
			               <option value="0">ͨ�зѿ۷�</option>		
			               <option value="1">��ֵ</option>
			               <option value="2">����</option>
			               <option value="3">����</option>
			               <option value="4">����</option>
			               <option value="5">����</option>			               	          
		                </select></td>
				    </tr>
					<tr>					  
		                <td  style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
						<td   style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> 
						 <input style="width: 158px;" type="text" name="startTime" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input  style="width: 158px;" type="text" name="endTime" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">		
						</td>
						
						<td style="white-space:nowrap;padding-left:5px;padding-right:5px;"  class="pn-flabel pn-flabel-h">���������</td>
					    <td style="white-space:nowrap;padding-left:5px;padding-right:5px;" class="pn-fcontent"> <select style="width: 161px;" id="validateCheck" name="validateCheck">
						   <option value="validateAll" selected="selected">У��ȫ����ˮ</option>
						   <option value="correct">У��ͨ������ˮ</option>
			               <option value="incorrect">У�鲻ͨ������ˮ</option>					               	          
		                </select></td>						
					</tr>
					<tr >
						<td colspan="4" style="height: 22px;" class="pn-fbutton">
						<input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="submit" value=" У�� " />&nbsp;
						<%--<input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="button" value=" У�� "  onclick="verify('${startTime}');"/>&nbsp;				
						--%><input style="padding-left: 8px;padding-right: 8px;padding-bottom: 1px;padding-top: 2px;" type="reset"" value=" �� �� " />	
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
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>
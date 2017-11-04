<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			if("${result}"=="FAIL")
				alert("û�д��˻�������Ϣ������������");
				if("${result}"=="FAIL1")
				alert("�˺�״̬Ϊ��ʧ�����ܳ�ֵ");
				if("${result}"=="FAIL2")
				alert("�˺�״̬ΪԤ���������ܳ�ֵ");
				if("${result}"=="FAIL3")
				alert("�˺�״̬Ϊ���������ܳ�ֵ");
				if("${result}"=="FAIL4")
				alert("�˺�״̬Ϊ�����������ܳ�ֵ");
			
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
			 
		       function check(){
		           if(get("account.sys_id").value!=""){
				   var partten = /^\+?[0-9][0-9]*$/;
				   if(partten.test(get("account.sys_id").value)){			             
                     }else{
                       alert("�û��˺�Ϊ���֣����������룡");
                       get("account.sys_id").focus();
					   return false;
                     }
                   }			
					if(get("startTime").value ==""|| get("endTime").value ==""){					
						alert("����ʱ�䲻��Ϊ�գ�");
						return false;					
				     }
		         
			        if(get("startTime").value !=""&& get("endTime").value != ""){
					      if(get("startTime").value > get("endTime").value) {
					         alert("��ʼʱ��������ڻ���ڽ���ʱ��");
					    	 return false;
					        }else{
								var months=compTime(document.getElementById('startTime').value,document.getElementById('endTime').value);
								if(months>3){
									alert("ʱ�������ܳ���3���£�");
									return false;	
								}
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
			<form name="tableForm" method="post" action="accountTrade_queryAccountToCorrect.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">�û��˺ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="account.sys_id" value="${account.sys_id}" /></td>
						<td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
						<td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}" /></td>
					</tr>
					 
					<tr>
						
						<td  class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;����</td>
						<td class="pn-fcontent"><input type="text" name="user.userName"  value="${user.userName}"/></td>
						<td   class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
						<td   class="pn-fcontent"> <input type="text" name="car.vehPlate"  value="${car.vehPlate}"/></td>
					</tr>
					<tr>
						<td  class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td  class="pn-fcontent">  
						
							<select name="accountTrade.tradeType" style="width:150px">
								<option value="" <c:if test="${accountTrade.tradeType==null}">selected</c:if>>��ѡ��</option>
								<option value="1" <c:if test="${accountTrade.tradeType==1}">selected</c:if>>��ֵ </option>
								<option value="2" <c:if test="${accountTrade.tradeType==2}">selected</c:if>>����</option>
							    
							</select>
							
								
						</td>
						<td  class="pn-flabel pn-flabel-h">֤�����룺</td>
						<td class="pn-fcontent"><input type="text" name="user.credentialsNo"  value="${user.credentialsNo}"/></td>
					</tr>	
					<tr>
					<td  class="pn-flabel pn-flabel-h">�˺�״̬��</td>
						<td   colspan="3" class="pn-fcontent"> 
						<select name="account.status" style="width:150px">
								<option value="" <c:if test="${account.status==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${account.status==0}">selected</c:if>>��Ч</option>
								<option value="1" <c:if test="${account.status==1}">selected</c:if>>��ʧ </option>
								<option value="2" <c:if test="${account.status==2}">selected</c:if>>Ԥ����</option>							  
								<option value="5" <c:if test="${account.status==5}">selected</c:if>>������</option>							
								<option value="7" <c:if test="${account.status==7}">selected</c:if>>������</option>
								<option value="4" <c:if test="${account.status==4}">selected</c:if>>���� </option>
							</select>	
						</td>
					</tr>			
						<tr>
						<td  class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
						<td   colspan="3" class="pn-fcontent"> 
						 <input type="text" name="startTime" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input type="text" name="endTime" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""><%--		
						  </td>
							
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						�˺�״̬��&nbsp;
						--%>
						
						<%--<td class="pn-flabel pn-flabel-h" >����ʱ�䣺</td>
						<td class="pn-fcontent" >
						  <input type="text" name="startTime" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input type="text" name="endTime" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">
						</td>
						--%></tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="reset" value=" �� �� "/>
						
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û��ʺ�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>					
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û���&nbsp;&nbsp;</th>				
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">֤������</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ƺ�&nbsp;&nbsp;</th>	
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>		
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ʱ��</th>		
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�˺�״̬</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���(Ԫ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���(Ԫ��</th>						
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					 

					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0]}</td>
							<td>${item[1]}</td>						
							<td>${item[9]}</td>						
							<td>${item[10]}</td>							
							<td>${item[2]}</td>
							<td><c:if test="${item[3]==0}">ͨ�зѿ۷�</c:if><c:if test="${item[3]==1}">��ֵ</c:if><c:if test="${item[3]==2}">����</c:if><c:if test="${item[3]==3}">����</c:if><c:if test="${item[3]==4}">����</c:if><c:if test="${item[3]==5}">����</c:if></td>
							<td>${item[4]}</td>
							<td><c:if test="${item[11]==0}">��Ч</c:if><c:if test="${item[11]==1}">��ʧ</c:if><c:if test="${item[11]==2}">Ԥ����</c:if><c:if test="${item[11]==4}">����</c:if><c:if test="${item[11]==5}">������</c:if><c:if test="${item[11]==7}">������</c:if></td>
							<td><fmt:formatNumber value="${item[5]/100}" pattern="#.##" type="number"/>Ԫ</td>
							<td><fmt:formatNumber value="${item[6]/100}" pattern="#.##" type="number"/>Ԫ</td>							
							 
                           <td> 
                           <c:if test="${item[11]==0&&item[7]!=0&&item[3]==1&&item[6]!=0}"> 
                           <a href="accountTrade_correct.do?account.sys_id=${item[0]}&accountTrade.opTime=${item[4]}&accountTrade.listNo=${item[8]}&accountTrade.fee=${item[5]}&accountTrade.cardNo=${item[1]}" class="pn-loperator">����</a></c:if>
                            <c:if test="${item[7]==0&&item[3]==1}">�ѱ�������</c:if>  
                                 </td>
                            
                            
                          
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>
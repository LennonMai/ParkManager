<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		if("${message}"!=""){
			alert("${message}");
		}
				jQuery(function(){
					jQuery.noConflict();
					if("${queryStatus}"=="1"){
						jQuery('#id1').css({display:'none'});
						//jQuery('#id2').css({display:'none'});
						jQuery('#id3').css({display:'none'});
						jQuery('#id4').css({display:'none'});
						jQuery('#id41').css({display:'none'});
						jQuery('#id5').css({display:'none'});
						jQuery('#id6').css({display:'none'});
						jQuery('#id7').css({display:'none'});
						jQuery('#id8').css({display:'none'});
						jQuery('#idDate').css({display:''});
						jQuery('#squadDate').css({display:''});
					}
					if("${queryStatus}"=="2"){
						jQuery('#id1').css({display:''});
						//jQuery('#id2').css({display:''});
						jQuery('#id3').css({display:''});
						jQuery('#id4').css({display:''});
						jQuery('#id41').css({display:''});
						jQuery('#id5').css({display:''});
						jQuery('#id6').css({display:''});
						jQuery('#id7').css({display:''});
						if(jQuery("input[name='statusOutIn']:checked").val()==2){
							jQuery('#id8').css({display:''});
						}else{
							jQuery('#id8').css({display:'none'});
						}
						jQuery('#squadDate').css({display:'none'});
						jQuery('#idDate').css({display:'none'});
					}
					if("${statusOutIn}"=="1"){
						jQuery('#id8').css({display:'none'});
						jQuery('#id9').css({display:'none'});
						jQuery('#id10').css({display:'none'});
					}
					if("${statusOutIn}"=="2"){
						jQuery('#id9').css({display:''});
						jQuery('#id10').css({display:''});
						if(jQuery("input[name='queryStatus']:checked").val()==2){
							jQuery('#id8').css({display:''});
						}else{
							jQuery('#id8').css({display:'none'});
						}
					}
					if("${queryStatus}"=="2" && "${timeStatus}"=="1"){
					jQuery('#id11').css({display:'none'});
					jQuery('#id12').css({display:''});
						//jQuery('#squadTime').css({display:'none'});
						//jQuery('#startTime').css({display:''});
						//jQuery('#endTime').css({display:''});
					}
					if("${queryStatus}"=="2" && "${timeStatus}"=="2"){
						jQuery('#id11').css({display:''});
						jQuery('#id12').css({display:'none'});
						//jQuery('#squadTime').css({display:''});
						//jQuery('#startTime').css({display:'none'});
						//jQuery('#endTime').css({display:'none'});
					}
					if("${timeStatus}"==""){
						jQuery('#id11').css({display:''});
						jQuery('#id12').css({display:'none'});
					}
				}); 
			//��ȡС��
			function getGate(){
			(function($) { 
  				$(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxGate.do?parkNo="+$(document.tableForm.parkNo).val(),
					success:function(res){
						$("#gateNo").empty();
						$("#laneNo").empty();
						var op = $("<option value=''>-��ѡ��-</option>");		
						$("#gateNo").append(op);
						var op1 = $("<option value=''>-��ѡ��-</option>");
						$("#laneNo").append(op1);
						$(res).find("gates > gate").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#gateNo").append(op);	
					});
					}
				});
				 });
				})(jQuery);
			}
			
			//��ȡ������Ϣ
			function getLane(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxLane.do?parkNo="+$(document.tableForm.parkNo).val()
					+ "&gateNo="+$(document.tableForm.gateNo).val(),
					success:function(res){
						$("#laneNo").empty();
						var op = $("<option value=''>-��ѡ��-</option>");		
						$("#laneNo").append(op);
						$(res).find("lanes > lane").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#laneNo").append(op);	
					});
					}
				});
			   });
			  })(jQuery);
			}
			function changeQuery(obj){
				if(obj.value==1){
					document.getElementById('id1').style.display='none';
					//document.getElementById('id2').style.display='none';
					document.getElementById('id3').style.display='none';
					document.getElementById('id4').style.display='none';
					document.getElementById('id41').style.display='none';
					document.getElementById('id5').style.display='none';
					document.getElementById('id6').style.display='none';
					document.getElementById('id7').style.display='none';
					document.getElementById('id8').style.display='none';
					document.getElementById('squadDate').style.display='';
					document.getElementById('idDate').style.display='';
					//document.getElementById('queryStatus').value="1";
				}
				if(obj.value==2){
					document.getElementById('id1').style.display='';
					//document.getElementById('id2').style.display='';
					document.getElementById('id3').style.display='';
					document.getElementById('id4').style.display='';
					document.getElementById('id41').style.display='';
					document.getElementById('id5').style.display='';
					document.getElementById('id6').style.display='';
					document.getElementById('id7').style.display='';
					if(jQuery("input[name='statusOutIn']:checked").val()==2){
						jQuery('#id8').css({display:''});
					}else{
						jQuery('#id8').css({display:'none'});
					}
					document.getElementById('squadDate').style.display='none';
					document.getElementById('idDate').style.display='none';
					//document.getElementById('queryStatus').value="2";
				}
			}
			
			
			
			function changeTime(){
				if(document.getElementsByName('timeStatus')[0].value==1){
					document.getElementById('id11').style.display='none'
					document.getElementById('id12').style.display='';
					//document.getElementById('squadTime').style.display='none';
					//document.getElementById('squadTime').value="";
					//document.getElementById('startTime').style.display='';
					//document.getElementById('endTime').style.display='';
				}
				if(document.getElementsByName('timeStatus')[0].value==2){
					document.getElementById('id11').style.display=''
					document.getElementById('id12').style.display='none';
					//document.getElementById('squadTime').style.display='';
					//document.getElementById('startTime').style.display='none';
					//document.getElementById('endTime').style.display='none';
					//document.getElementById('startTime').value="";
					//document.getElementById('endTime').value="";
				}				
			}
			//�������ڲ�
			  function compTime(beginTime,endTime){
			  	var s1 = beginTime.replace(/-/g, "/");
				var s2 = endTime.replace(/-/g, "/");
				d1 = new Date(s1);
				d2 = new Date(s2);
				d2.setDate(d2.getDate()+1); 
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
			//����ѯ����
			function check(){
				var temp_queryStatus = false;
				var temp_statusOutIn = false;
				var queryValue = "";
				var queryStatus_obj = document.getElementsByName('queryStatus'); 
				for(var i = 0; i < queryStatus_obj.length; i ++){    
					if(queryStatus_obj[i].checked){ 
						queryValue = queryStatus_obj[i].value;
						temp_queryStatus = true;    
						break;    
					}    
				}    
				if(temp_queryStatus == false){    
					alert('��ѡ���ѯ����');    
					return false;    
				}
				var statusOutIn_obj = document.getElementsByName('statusOutIn');
				for(var i = 0; i < statusOutIn_obj.length; i ++){    
					if(statusOutIn_obj[i].checked){  
						temp_statusOutIn = true;    
						break;    
					}    
				}    
				if(temp_statusOutIn == false){    
					alert('��ѡ������״̬');    
					return false;    
				}
				/*
				if(document.getElementById('cardNo').value !=""){
					var boolean = isNumber(document.getElementById('cardNo').value);
					if(boolean == false){
						alert("�������ȫΪ����");
						return false;
					}
					if(document.getElementById('cardNo').value>2147483647){
						alert("����������ֲ��ܴ���2147483647");
						return false;
					}
				}
				*/
				/*if(document.getElementById('operatorNo').value !=""){
					var boolean = isNumber(document.getElementById('operatorNo').value);
					if(boolean == false){
						alert("�շ�Ա����ȫΪ���֣�");
						return false;
					}
				}*/	
				if(jQuery('#cashMoneyMin').val() !=""){
					var decimal = /^\d+(\.\d{1,2})?$/;
				   if(!decimal.test(jQuery('#cashMoneyMin').val())){
						alert("�շѽ����Сֵ��������\nע�⣺ֻ������Ǹ����������пո񣩣�С����ྫȷ��С�����2λ");
						return false;
				   }
				}
				if(jQuery('#cashMoneyMax').val() !=""){
					var decimal = /^\d+(\.\d{1,2})?$/;
				   if(!decimal.test(jQuery('#cashMoneyMax').val())){
						alert("�շѽ�����ֵ��������\nע�⣺ֻ������Ǹ����������пո񣩣�С����ྫȷ��С�����2λ");
						return false;
				   }
				}
				if(jQuery('#cashMoneyMin').val() !="" && jQuery('#cashMoneyMax').val() !=""){
					if(Number(jQuery('#cashMoneyMin').val()) > Number(jQuery('#cashMoneyMax').val())){
						alert("�շѽ����Сֵ���ܴ������ֵ");
						return false;
					}
				}
				if(jQuery('#etcMoneyMin').val() !=""){
					var decimal = /^\d+(\.\d{1,2})?$/;
				   if(!decimal.test(jQuery('#etcMoneyMin').val())){
						alert("ETC�����Сֵ��������\nע�⣺ֻ������Ǹ����������пո񣩣�С����ྫȷ��С�����2λ");
						return false;
				   }
				}
				if(jQuery('#etcMoneyMax').val() !=""){
					var decimal = /^\d+(\.\d{1,2})?$/;
				   if(!decimal.test(jQuery('#etcMoneyMax').val())){
						alert("ETC������ֵ��������\nע�⣺ֻ������Ǹ����������пո񣩣�С����ྫȷ��С�����2λ");
						return false;
				   }
				}
				if(jQuery('#etcMoneyMin').val() !="" && jQuery('#etcMoneyMax').val()  !=""){
					if(Number(jQuery('#etcMoneyMin').val()) > Number(jQuery('#etcMoneyMax').val())){
						alert("ETC�����Сֵ���ܴ������ֵ");
						return false;
					}
				}				
				if(queryValue==2){
					if(document.getElementsByName('timeStatus')[0].value==2){
						if(document.getElementById('squadTime_start').value ==""&&document.getElementById('squadTime_end').value ==""){					
							alert("���ڲ���Ϊ�գ�");
							return false;					
						}
						if(document.getElementById('squadTime_start').value ==""){
							alert("��ʼ���ڲ���Ϊ�գ�");
							return false;
						}
						if(document.getElementById('squadTime_end').value ==""){
							alert("�������ڲ���Ϊ�գ�");
							return false;
						}	
					}
					if(document.getElementsByName('timeStatus')[0].value==1){
						if(document.getElementById('startTime').value ==""&&document.getElementById('endTime').value ==""){					
							alert("ʱ�䲻��Ϊ�գ�");
							return false;					
						}
						if(document.getElementById('startTime').value !=""&&document.getElementById('endTime').value ==""){					
							alert("����ʱ�䲻��Ϊ�գ�");
							return false;					
					    }
						if(document.getElementById('startTime').value ==""&&document.getElementById('endTime').value !=""){					
							alert("��ʼʱ�䲻��Ϊ�գ�");
							return false;					
					    }
						if(document.getElementById('startTime').value !=""&&document.getElementById('endTime').value !=""){
							if(document.getElementById('startTime').value>document.getElementById('endTime').value){
								alert("��ʼʱ�䲻�ܴ��ڽ�����");
								return false;	
							}  else{
								var months=compTime(document.getElementById('startTime').value,document.getElementById('endTime').value);
								if(months>12){
									alert("ʱ�������ܳ���12���£�");
									return false;	
								}	
							}		
					    }
					}
				}
				return true;
			}
			//����Ƿ�Ϊ����
			function isNumber(oNum){ 
  				if(!oNum) return false; 
  				var strP=/^\d+(\.\d+)?$/; 
  				if(!strP.test(oNum)) return false; 
  				try{ 
  					if(parseFloat(oNum)!=oNum) return false; 
  				}catch(ex){ 
   					return false; 
  				} 
  				return true; 
   			}
   			function changeType(obj){
   				if(obj.value == 1){
   					document.getElementById('id8').style.display='none';
   					document.getElementById('id9').style.display='none';
   					document.getElementById('id10').style.display='none';
   				}
   				if(obj.value == 2){
   					document.getElementById('id9').style.display='';
   					document.getElementById('id10').style.display='';
					if(jQuery("input[name='queryStatus']:checked").val()==2){
						jQuery('#id8').css({display:''});
					}else{
						jQuery('#id8').css({display:'none'});
					}
   				}
   			} 
   			function doExport() {
				var queryValue = "";
				var queryStatus_obj = document.getElementsByName('queryStatus'); 
				for(var i = 0; i < queryStatus_obj.length; i ++){    
					if(queryStatus_obj[i].checked){ 
						queryValue = queryStatus_obj[i].value;
						temp_queryStatus = true;    
						break;    
					}    
				}    
   				if(document.getElementById('cardNo').value !=""){
					var boolean = isNumber(document.getElementById('cardNo').value);
					if(boolean == false){
						alert("�������ȫΪ����");
						return false;
					}
   				}
   				if(queryValue==2) {
					if(document.getElementsByName('timeStatus')[0].value==2){
						if(document.getElementById('squadTime_start').value ==""){
							alert("��ʼ���ڲ���Ϊ�գ�");
							return false;
						}
						if(document.getElementById('squadTime_end').value ==""){
							alert("�������ڲ���Ϊ�գ�");
							return false;
						}	
					}
					if(document.getElementsByName('timeStatus')[0].value==1){
						if(document.getElementById('startTime').value ==""&&document.getElementById('endTime').value ==""){					
							alert("ʱ�䲻��Ϊ�գ�");
							return false;					
						}
						if(document.getElementById('startTime').value !=""&&document.getElementById('endTime').value ==""){					
							alert("����ʱ�䲻��Ϊ�գ�");
							return false;					
					    }
						if(document.getElementById('startTime').value ==""&&document.getElementById('endTime').value !=""){					
							alert("��ʼʱ�䲻��Ϊ�գ�");
							return false;					
					    }
					}
				}
				if(check()){
	   				document.getElementById("tableForm").action = "waterQuery_exportWater.do";
	   				document.getElementById("tableForm").submit();
	   				document.getElementById("tableForm").action = "waterQuery_query.do";
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
			<form id="tableForm"  name="tableForm" method="post" action="waterQuery_query.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">��ѯ���ͣ�</td>
						<td class="pn-fcontent">
							<label>
  								<input type="radio" name="queryStatus"  id="queryStatus" value="1" <c:if test="${queryStatus==1 }"> checked="checked" </c:if> onclick="changeQuery(this);"/>���ٲ�ѯ
  							</label>
  								&nbsp;&nbsp;&nbsp;&nbsp;
  							<label>
  								<input type="radio" name="queryStatus"  id="queryStatus" value="2" <c:if test="${queryStatus==2 }"> checked="checked" </c:if> onclick="changeQuery(this);"/>��ϸ��ѯ
  							</label>
						</td>
						<td class="pn-flabel pn-flabel-h">����/��ڣ�</td>
						<td class="pn-fcontent">
							<label>
  								<input type="radio" name="statusOutIn" id="statusOutIn" value="1" <c:if test="${statusOutIn==1 }"> checked="checked" </c:if> onclick="changeType(this);"/>���
  							</label>
  								&nbsp;&nbsp;&nbsp;&nbsp;
  							<label>
  								<input type="radio" name="statusOutIn" id="statusOutIn" value="2" <c:if test="${statusOutIn==2 }"> checked="checked" </c:if> onclick="changeType(this);"/>����
  							</label>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">������ţ�</td>
						<td class="pn-fcontent">
							<input type="text" name="cardNo" id="cardNo" value="${cardNo }" />
						</td>
						<td class="pn-flabel pn-flabel-h">�� �� �ţ�</td>
						<td class="pn-fcontent">
						 	<input type="text" name="vehPlate" value="${vehPlate }" />
						</td>
					</tr>
					
					<tr>
						<td class="pn-flabel pn-flabel-h">�� ˮ �ţ�</td>
						<td class="pn-fcontent">
							<input type="text" name="listNo" value="${listNo }" />
						</td>
						<td class="pn-flabel pn-flabel-h" id="idDate">����ʱ��Σ�</td>
						<td class="pn-fcontent" id="squadDate">
							<select name="squadDate" style="width:150px">
								<option value="3" <c:if test="${squadDate==3 }"> selected="selected" </c:if>>����</option>
								<option value="2" <c:if test="${squadDate==2 }"> selected="selected" </c:if>>����</option>	
								<option value="1" <c:if test="${squadDate==1 }"> selected="selected" </c:if>>����</option>															
								<option value="4" <c:if test="${squadDate==4 }"> selected="selected" </c:if>>���������</option>
								<option value="5" <c:if test="${squadDate==5 }"> selected="selected" </c:if>>���һ��</option>
							</select>
						</td>
						<td class="pn-flabel pn-flabel-h" id="id4" style="display: none">�� �� �ţ�</td>
						<td class="pn-fcontent" id="id41" style="display:none">
							<select name="squadNo" style="width:150px">
								<option value="">-��ѡ��-</option>
							 	<c:forEach items="${squadList}" var="squadItem">
							 		<option value="${squadItem.squadNo}" <c:if test="${squadNo==squadItem.squadNo}">selected</c:if>>${squadItem.squadName}</option>							 			
							 	</c:forEach>
							</select>
						</td>
					</tr>
					<tr id="id3" style="display:none">
						<td class="pn-flabel pn-flabel-h">�� &nbsp;&nbsp;   �ͣ�</td>
						<td class="pn-fcontent">
							<select name="vehType" style="width:150px">
								<option value="">-��ѡ��-</option>
							 	<c:forEach items="${vehTypeList}" var="item">
							 		<option value="${item.vehTypeNo}" <c:if test="${vehType==item.vehTypeNo}">selected</c:if>>${item.vehTypeName}</option>							 			
							 	</c:forEach>
							</select>
						</td>
						<td class="pn-flabel pn-flabel-h">�� &nbsp;&nbsp;   �֣�</td>
						<td class="pn-fcontent">
						 	<select name="vehClass" style="width:150px">
						 		<option value="">-��ѡ��-</option>
							 	<c:forEach items="${vehClassList}" var="item">
							 		<option value="${item.vehClassNo}" <c:if test="${vehClass==item.vehClassNo}">selected</c:if>>${item.vehClassName}</option>							 			
							 	</c:forEach>
						 	</select>
						</td>
					</tr>
					<tr id="id1" style="display:none">
						<td class="pn-flabel pn-flabel-h">�����¼���</td>
						<td class="pn-fcontent">
							<select name="spEvent" style="width:150px">
								<option value="">-��ѡ��-</option>
							 	<c:forEach items="${spEventList}" var="spItem">
							 		<option value="${spItem.spEventNo}" <c:if test="${spEvent==fn:trim(spItem.spEventNo)}">selected</c:if>>${spItem.spEventName}</option>							 			
							 	</c:forEach>
							</select>
						</td>
						<td class="pn-flabel pn-flabel-h">ͨ�о����ͣ�</td>
						<td class="pn-fcontent">
						 	<select name="ticketType" style="width:150px">
						 		<option value="">-��ѡ��-</option>
								<c:forEach items="${ticketTypeList}" var="item">
									<option value="${item.ticketTypeNo }"<c:if test="${item.ticketTypeNo==ticketType }"> selected="selected" </c:if>>${item.ticketTypeName }</option>
								</c:forEach>
						 	</select>
						</td>
					</tr>
					<tr id="id7" style="display:none">
						<td class="pn-flabel pn-flabel-h">�û������ͣ�</td>
						<td class="pn-fcontent">
							<select name="userCardType" style="width:150px">
								<option value="">-��ѡ��-</option>
							 	<c:forEach items="${userCardTypeList}" var="userItem">
							 		<option value="${userItem.userCardType}" <c:if test="${userCardType==fn:trim(userItem.userCardType)}">selected</c:if>>${userItem.typeName}</option>							 			
							 	</c:forEach>
							</select>
						</td>
						<td class="pn-flabel pn-flabel-h"><label id="id10">֧�������ͣ�</label></td>
						<td class="pn-fcontent">
							<label id="id9">
								<select name="cardType" style="width:150px">
								 	<option value="">-��ѡ��-</option>
									<c:forEach items="${cardTypeList}" var="item">
										<option value="${item.cardType}"<c:if test="${cardType == item.cardType }"> selected="selected" </c:if>>${item.typeName }</option>
									</c:forEach>
								</select>
							</label>
						</td>
					</tr>
					<tr id="id8" style="display:none">
						<td class="pn-flabel pn-flabel-h">�շѽ�</td>
						<td class="pn-fcontent"><input type="text" id="cashMoneyMin" name="cashMoneyMin" value="${cashMoneyMin }" maxlength="9" style="width:70px" /> -- <input type="text" id="cashMoneyMax" name="cashMoneyMax" value="${cashMoneyMax }" maxlength="9" style="width:70px"/>����λ��Ԫ��</td>
						<td class="pn-flabel pn-flabel-h">ETC��</td>
						<td class="pn-fcontent"><input type="text" id="etcMoneyMin" name="etcMoneyMin" value="${etcMoneyMin }" maxlength="9" style="width:70px"/> -- <input type="text" id="etcMoneyMax" name="etcMoneyMax" value="${etcMoneyMax }" maxlength="9" style="width:70px"/>����λ��Ԫ��</td>
					</tr>					
					<!-- <tr id="id2" style="display:none">
						<td class="pn-flabel pn-flabel-h">�շ�Ա�ţ�</td>
						<td class="pn-fcontent">
							<input type="text" name="operatorNo" id="operatorNo" value="${operatorNo }" />
						</td>
						<td class="pn-flabel pn-flabel-h">�շ�Ա������</td>
						<td class="pn-fcontent">
						 	<input type="text" name="operatorName" value="${operatorName }" />
						</td>
					</tr> -->
					<tr id="id5" style="display: none">
						<td class="pn-flabel pn-flabel-h">ʱ    �䣺</td>
						<td class="pn-fcontent" colspan="3">
						 	<select name="timeStatus" onchange="changeTime();">
						 		<option value="2" <c:if test="${timeStatus==2 }"> selected="selected" </c:if>>��������</option>
						 		<option value="1" <c:if test="${timeStatus==1 }"> selected="selected" </c:if>>����ʱ��</option>				 		
						 	</select>&nbsp;&nbsp;&nbsp;&nbsp;
						 	<span id="id11">
						 		<input type="text" name="squadTime_start" id ="squadTime_start" value= "${squadTime_start}" size="12" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'squadTime_end\')}'})" readonly="readonly"/>
						 		-- <input type="text" name="squadTime_end" id ="squadTime_end" value= "${squadTime_end}" size="12" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'squadTime_start\')}'})" readonly="readonly"/>
						 	</span>
						 	<span id="id12" style="display: none">
						 		<input type="text" name="startTime" id="startTime" value= "${startTime }" size="21" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')}'})" readonly="readonly"/>
						 		-- <input type="text" name="endTime" id="endTime" value= "${endTime }" size="21" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}'})" readonly="readonly"/>
						 	</span>
						 </td>
					</tr>
					<tr id="id6" style="display: none">
						<td class="pn-flabel pn-flabel-h">λ    �ã�</td>
						<td class="pn-fcontent" colspan="3">
							С����<select name="parkNo" id ="parkNo" onchange="getGate();">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${parkList}" var="item">
										<option value="${item.parkNo }"<c:if test="${item.parkNo==parkNo }"> selected="selected" </c:if>>${item.parkName }</option>
									</c:forEach>
								</select>&nbsp;
							���ţ�<select name="gateNo" id="gateNo" onchange="getLane();">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${gateList}" var="item">
										<option value="${item.gateNo }"<c:if test="${item.gateNo==gateNo }"> selected="selected" </c:if>>${item.gateName }</option>
									</c:forEach>
								</select>&nbsp;
							������<select name="laneNo" id="laneNo">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${laneList}" var="item">
										<option value="${item.laneNo }"<c:if test="${item.laneNo==laneNo }"> selected="selected" </c:if>>${item.laneNo }</option>
									</c:forEach>
								</select>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="checkbox" name="fuzzySearch" value="1" <c:if test="${fuzzySearch==1 }"> checked="checked" </c:if>/>�Ƿ�ģ����ѯ
								&nbsp;&nbsp;&nbsp;&nbsp;
								<!-- <input type="checkbox" name="autoImag" value="1" <c:if test="${autoImag==1 }"> checked="checked" </c:if>/>�Ƿ��Զ�ȡͼ -->
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� ѯ " /><!-- ���������ð�ť�Ļ�����Щ�ؼ��޷����� -->
						&nbsp;<input id="id15" type="button" value=" �� �� " onclick="doExport();"/>
						</td>
					</tr>
				</table>
			<!-- ��ʾlist����-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�� ˮ ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С    ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��    ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��    ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��    ��</th>					
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��    ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�� �� ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�� �� ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ʱ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ʱ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�����¼�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û�������</th>
						<c:if test="${statusOutIn == 2}">
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">֧��������</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">Ӧ���ֽ�</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ETC���</th>
						</c:if>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��    ��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0]}</td>
							<td>
								<c:forEach items="${parkList}" var="item1">
									<c:if test="${item1.parkNo==item[2]&&item1.areaNo==item[1]}">${item1.parkName}</c:if>
								</c:forEach>
							</td>
							<td>${item[3]}</td>
							<td>${item[4]}</td>
							<td>
								<c:forEach items="${vehTypeList}" var="Item1">
									<c:if test="${Item1.vehTypeNo==item[5]}">${Item1.vehTypeName}</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${vehClassList}" var="classItem">
									<c:if test="${classItem.vehClassNo==item[6]}">${classItem.vehClassName}</c:if>
								</c:forEach>
							</td>			
							<td>${item[7]}</td>	
							<td>
								<c:forEach items="${squadList}" var="squadListItem">
									<c:if test="${squadListItem.squadNo==item[8]}">${squadListItem.squadName}</c:if>
								</c:forEach>
							</td>					
							<td><fmt:formatDate value="${item[9]}" pattern="yyyy-MM-dd" /></td>
							<td>${item[12]}</td>
							<td>${item[13]}</td>
							<td>${item[14]}</td>
							<td>
								<c:forEach items="${userCardTypeList}" var="temp">
									<c:if test="${temp.userCardType == item[15]}">${temp.typeName}</c:if>
								</c:forEach>
							</td>
							<c:if test="${statusOutIn == 2}">
								<td>
									<c:if test="${item[16]==0}">�޿�</c:if>
									<c:forEach items="${cardTypeList}" var="temp">
										<c:if test="${temp.cardType == item[16]}">${temp.typeName}</c:if>
									</c:forEach>
								</td>
								<td>${item[17]}</td>
								<td>${item[18]}</td>	
							</c:if>
							<td style="white-space:nowrap;padding-left:5px;padding-right:5px;">
									<c:if test="${statusOutIn==2 }">
										<a href="waterQuery_complate.do?listNo=${item[0]}&statusOutIn=${statusOutIn }&squadTime=${item[9]}" class="pn-loperator">����ڶԱ�</a>��
									</c:if>
									<a href="waterQuery_show.do?listNo=${item[0]}&statusOutIn=${statusOutIn }&squadTime=${item[9]}" class="pn-loperator">��ϸ��Ϣ</a>
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
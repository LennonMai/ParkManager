<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			window.onload = function() {
		  	  var ifr_height = $(window).height() - $("#div1").height() - $("#div2").height() - 30;
		  	  var iframe = $("#iframe").height(ifr_height);
		    }
		    function changeSize() {
		  	  var ifr_height = $(window).height() - $("#div1").height() - $("#div2").height() - 30;
		  	  var iframe = $("#iframe").height(ifr_height);
		    }
		    
			var ids="";
			function share() {
				ids="";
				//�ж��Ƿ���ѡ��������
			  	var a = 0;
			  	for(i=0;i<document.getElementsByName("tradeType").length;i++) {
			  		if(document.getElementsByName("tradeType")[i].checked==false) {
			  			a = a+1;
			  		}
			  	}
			  	var b = 5;
			  	if(a==b) {
			  		alert("��ѡ��������");
			  		return false;
			  	}
			  	
			  	//ƴ��ѡȡ���ַ���ֵ
			  	for(i=0;i<document.getElementsByName("tradeType").length;i++) {
			  		if(document.getElementsByName("tradeType")[i].checked==true) {
			  			ids=ids+document.getElementsByName("tradeType")[i].value+",";
			  		} else {
			  			//���ûѡ��ֵ��Ϊ-1
			  			ids=ids+"-1"+",";
			  		}
			    }
			    //������0,1,2�ַ���
			    ids=ids.substring(0,ids.length-1);
			}
		  //����HTML����
		  function saveAndPrint(){
		  	share();
		    //�����������
			var countDay = compTime(get("startTime").value, get("endTime").value);
			if(countDay > 10) {
				if(confirm("��ѡ���ڳ���10�죬����HTML��ʽ���ɱ��������Ҫ�ϳ�ʱ�䣬�Ƿ����PDF��ʽ���ɱ���")) {
				  	saveAndPrintPDF();
				  	return true;
			  	}
		  	} 
		  	if(check() == false) {
			  	return false;
			} else {
			    window.open("tollsReport_payCardTradeReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids
			    	+"&account.cardNo="+get("account.cardNo").value+"&account.status="+get("account.status").value
		    		+"&car.vehPlate="+get("car.vehPlate").value+"&user.credentialsNo="+get("user.credentialsNo").value
		    		+"&user.userName="+get("user.userName").value+"&account.sys_id="+get("account.sys_id").value);
		      	//window.open("tollsReport_payCardTradeReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
		    }
		  }

		//���ɵ�ǰҳ��HTML����
		  function saveAndPrintCurrentPage(){
		  		share();
			    //�����������
				var countDay = compTime(get("startTime").value, get("endTime").value);
				if(countDay > 10) {
					if(confirm("��ѡ���ڳ���10�죬����HTML��ʽ���ɱ��������Ҫ�ϳ�ʱ�䣬�Ƿ����PDF��ʽ���ɱ���")) {
					  	saveAndPrintPDF();
					  	return true;
				  	}
			  	} 
			  	if(check() == false) {
				  	return false;
				} else {
					window.belowFrame.location.href="tollsReport_payCardTradeReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids
				    	+"&account.cardNo="+get("account.cardNo").value+"&account.status="+get("account.status").value
			    		+"&car.vehPlate="+get("car.vehPlate").value+"&user.credentialsNo="+get("user.credentialsNo").value
			    		+"&user.userName="+get("user.userName").value+"&account.sys_id="+get("account.sys_id").value;
			    }
		  }

		  
		  //����PDF����
		  function saveAndPrintPDF() {
		  	share();
		  	if(check() == false) {
			  	return false;
			} else {
		    	window.open("tollsReport_payCardTradeReportPDF.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids
		    		+"&account.cardNo="+get("account.cardNo").value+"&account.status="+get("account.status").value
		    		+"&car.vehPlate="+get("car.vehPlate").value+"&user.credentialsNo="+get("user.credentialsNo").value
		    		+"&user.userName="+get("user.userName").value+"&account.sys_id="+get("account.sys_id").value);
		    }
		  }
		  //У��
		  function check() {
		  	//У������
		  	if(get("startTime").value == null || get("startTime").value == "" || get("endTime").value == null || get("endTime").value == "" ) {
		      	alert("ͳ��ʱ�䲻��Ϊ��");
		      	return false;
		    }
		    if(get("startTime").value > get("endTime").value) {
		      	alert("��ʼʱ��������ڻ���ڽ���ʱ��");
		    	return false;
		    }
		    //���û��˺ŵ���֤
			if(get("account.sys_id").value != "") {
				var phone =/^\d+$/;
				var temp = document.getElementsByName("account.sys_id")[0];
				if(!phone.test(temp.value)) {
			    	alert("�û��˻�Ϊ���֣���������Ч���û��˺�");
			        get("account.sys_id").focus();
			        return false;
		        }
		    }
		  }
		  
		  //�������ڲ�
		  function compTime(beginTime,endTime){
		  	var s1 = beginTime.replace(/-/g, "/");
			var s2 = endTime.replace(/-/g, "/");
			d1 = new Date(s1);
			d2 = new Date(s2);
			
			var time= d2.getTime() - d1.getTime();
			var days = parseInt(time / (1000 * 60 * 60 * 24));
			
			//alert("�������: " + days);   
			return days;
		  }
		</script>
	</head>
	<body onResize="changeSize()">
		<div class="body-box">
			<div id="div1" class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<div id="div2">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">ͳ��ʱ�䷶Χ��</td>
						<td style="white-space:nowrap;" width="30%" class="pn-fcontent">
							 <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" value="${endTime }"  class="Wdate" onClick="WdatePicker()">
						</td>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;�ţ�</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="account.cardNo" value="${account.cardNo}" />
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td width="30%" class="pn-fcontent">
							<input type="checkbox" name="tradeType" value="0" checked="checked" />����
							<input type="checkbox" name="tradeType" value="1" checked="checked" />��ֵ
							<input type="checkbox" name="tradeType" value="2" checked="checked" />����
							<input type="checkbox" name="tradeType" value="3" checked="checked" />����
							<input type="checkbox" name="tradeType" value="4" checked="checked" />����
							&nbsp;<font style="color:red">*</font>
						</td>
						<td width="20%" class="pn-flabel pn-flabel-h">���ƺţ�</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="car.vehPlate" value="${car.vehPlate}"/>
						</td>
					</tr>
					<tr>
						<c:if test="${sysparamconf2.pvalue!=1}">
						<td width="20%" class="pn-flabel pn-flabel-h">�˻�״̬��</td>
						<td width="30%" class="pn-fcontent">
							<select name="account.status" style="width:150px">
								<option value="" <c:if test="${account.status==null}">selected</c:if>>��ѡ��</option>
							    <option value="0" <c:if test="${account.status==0}">selected</c:if>>��Ч</option>
								<option value="1" <c:if test="${account.status==1}">selected</c:if>>��ʧ </option>
								<option value="2" <c:if test="${account.status==2}">selected</c:if>>Ԥ����</option>
							    <option value="3" <c:if test="${account.status==3}">selected</c:if>>����</option>
								<option value="5" <c:if test="${account.status==5}">selected</c:if>>������</option>
							    <option value="6" <c:if test="${account.status==6}">selected</c:if>>������</option>
								<option value="7" <c:if test="${account.status==7}">selected</c:if>>������</option>
								<option value="4" <c:if test="${account.status==4}">selected</c:if>>���� </option>
							</select>
						</td>
						</c:if>
						<c:if test="${sysparamconf2.pvalue==1}">
						<td width="20%" class="pn-flabel pn-flabel-h">�˻�״̬��</td>
						<td width="30%" class="pn-fcontent">
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
						</c:if>
						<td width="20%" class="pn-flabel pn-flabel-h">֤�����룺</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="user.credentialsNo" value="${user.credentialsNo}"/>
						</td>
					</tr>
					
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;����</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="user.userName" value="${user.userName}"/>
						</td>	
						<td width="20%" class="pn-flabel pn-flabel-h">�û��˺ţ�</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="account.sys_id" value="${account.sys_id}" />
						</td>
					</tr>
					<tr align="center">
						<td style="padding-top: 5px;padding-bottom: 5px;" colspan="4" class="pn-fcontent">
						  <input type="button" value="����HTML����" onclick="return saveAndPrint()">&nbsp;
						  <input type="button" value="����PDF����" onclick="return saveAndPrintPDF()">&nbsp;
						  <input type="button" value="&nbsp;��&nbsp;&nbsp;ѯ&nbsp;" onclick="return saveAndPrintCurrentPage()">
						</td>
					</tr>
				</table>
			</div>
			<iframe id="iframe" frameborder="0" src="" name="belowFrame" scrolling="auto"  width="100%">
			</iframe>
		</div>
	</body>
</html>
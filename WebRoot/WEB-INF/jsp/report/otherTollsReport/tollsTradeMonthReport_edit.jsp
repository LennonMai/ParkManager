<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
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
		  
		  //����HTML����
		  function saveAndPrint(){
			var countMonth = compMonth(get("startTime").value,get("endTime").value) + 1;
			if(countMonth > 10) {
				if(confirm("��ѡ�·ݳ���10�£�����HTML��ʽ���ɱ��������Ҫ�ϳ�ʱ�䣬�Ƿ����PDF��ʽ���ɱ���")) {
				  	saveAndPrintPDF();
				  	return true;
			  	}
		  	} 
		  	if(checkTime() == false) {
			  	return false;
			} else {
			    window.open("otherTollsReport_tollsTradeMonthReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value);
		      //window.open("otherTollsReport_tollsTradeMonthReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
		    }
		  }

		  //���ɵ�ǰҳ��HTML����
		  function saveAndPrintCurrentPage(){
			    var countMonth = compMonth(get("startTime").value,get("endTime").value) + 1;
				if(countMonth > 10) {
					if(confirm("��ѡ�·ݳ���10�£�����HTML��ʽ���ɱ��������Ҫ�ϳ�ʱ�䣬�Ƿ����PDF��ʽ���ɱ���")) {
					  	saveAndPrintPDF();
					  	return true;
				  	}
			  	} 
			  	if(checkTime() == false) {
				  	return false;
				} else {
				    window.belowFrame.location.href="otherTollsReport_tollsTradeMonthReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value;
			    }
		  }
		  
		  //����PDF����
		  function saveAndPrintPDF(){
		  	if(checkTime() == false) {
			  	return false;
			} else {
		    	window.open("otherTollsReport_tollsTradeMonthReportPDF.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value);
		    }
		  }
		  //У������
		  function checkTime() {
		  	if(get("startTime").value == null || get("startTime").value == "" || get("endTime").value == null || get("endTime").value == "" ) {
		      	alert("ͳ��ʱ�䲻��Ϊ��");
		      	return false;
		    }
		    if(get("startTime").value > get("endTime").value) {
		      	alert("��ʼʱ��������ڻ���ڽ���ʱ��");
		    	return false;
		    }
		  }
		  //�����·ݲ�
		  function compMonth(startDate,endDate){
			var s1 = startDate.replace(/-/g, "/");
			var s2 = endDate.replace(/-/g, "/");
			startDate = new Date(s1);
			endDate = new Date(s2);    
			  
			number = 0;    
			yearToMonth = (endDate.getFullYear() - startDate.getFullYear()) * 12;    
			number += yearToMonth;    
			monthToMonth = endDate.getMonth() - startDate.getMonth();    
			number += monthToMonth;    
			endDay = endDate.getDate();    
			startDay = startDate.getDate();    
			dayStep = endDay - startDay;    
			if (dayStep >= 0) {    
			    if (dayStep >= 15) {    
			        number += 1;    
			    }    
			} else {    
			    if (dayStep <= -15) {    
			        number -= 1;    
			    }    
			}    
			return number;
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
						<td style="padding-top: 5px;padding-bottom: 5px;" width="40%" class="pn-flabel pn-flabel-h">ͳ��ʱ�䷶Χ��</td>
						<td style="padding-top: 5px;padding-bottom: 5px;" width="60%" class="pn-fcontent">
						  <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" value="${endTime }" class="Wdate" onClick="WdatePicker()">
						  &nbsp;<font style="color:red">*</font>
						</td>
					</tr>
					<tr align="center">
						<td style="padding-top: 5px;padding-bottom: 5px;" colspan="2" class="pn-fcontent">
						  <input type="button" value="����HTML����" onclick="return saveAndPrint()">&nbsp;
						  <input type="button" value="����PDF����" onclick="return saveAndPrintPDF()">&nbsp;
						  <input type="button" value="&nbsp;��&nbsp;&nbsp;ѯ&nbsp;" onclick="return saveAndPrintCurrentPage()">
						</td>
					</tr>
				</table>
			</div>
			<iframe id="iframe" frameborder="0" src="" name="belowFrame" scrolling="auto"  width="100%" style="height: 500px">
			</iframe>
		</div>
	</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				ids = "";
				//�ж��Ƿ���ѡ��������
			  	var a = 0;
			  	for(i=0;i<document.getElementsByName("tradeType").length;i++) {
			  		if(document.getElementsByName("tradeType")[i].checked==false) {
			  			a = a+1;
			  		}
			  	}
			  	var b = 2;
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
			    //������0,1�ַ���
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
		  	if(checkTime() == false) {
			  	return false;
			} else {
			    window.open("otherTollsReport_printBillReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids);
		      	//window.open("otherTollsReport_printBillReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
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
			  	if(checkTime() == false) {
				  	return false;
				} else {
					window.belowFrame.location.href="otherTollsReport_printBillReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids;
			      	//window.open("otherTollsReport_printBillReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
			    }
		  }
		  
		  //����PDF����
		  function saveAndPrintPDF() {
		  	share();
		  	if(checkTime() == false) {
			  	return false;
			} else {
		    	window.open("otherTollsReport_printBillReportPDF.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids);
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
		  //�������ڲ�
		  function compTime(beginTime,endTime){
		  	var s1 = beginTime.replace(/-/g, "/");
			var s2 = endTime.replace(/-/g, "/");
			d1 = new Date(s1);
			d2 = new Date(s2);
			
			var time= d2.getTime() - d1.getTime();
			var days = parseInt(time / (1000 * 60 * 60 * 24));
			
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
						<td width="40%" class="pn-flabel pn-flabel-h">ͳ��ʱ�䷶Χ��</td>
						<td width="60%" class="pn-fcontent">
						   <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" value="${endTime }"  class="Wdate" onClick="WdatePicker()">
						</td>
					</tr>
					<tr>
						<td width="40%" class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td width="60%" class="pn-fcontent">
						  <input type="checkbox" name="tradeType" value="0" checked="checked" />����
						  <input type="checkbox" name="tradeType" value="1" checked="checked" />��ֵ
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
			<iframe id="iframe" frameborder="0" src="" name="belowFrame" scrolling="auto"  width="100%">
			</iframe>
		</div>
	</body>
</html>
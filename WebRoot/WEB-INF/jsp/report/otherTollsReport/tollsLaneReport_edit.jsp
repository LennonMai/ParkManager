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
		    
			var pSquadNo="";
			var pOperatorNo = "";
			function share() {
				pLaneNo="";
			    
			    //��������
			  	if(document.getElementById("right").length == 0) {
			  		alert("��ѡ�񳵵�");
			  		return false;
			  	} else {
			  		for(i=0;i<document.getElementById("right").length;i++) {
			  			pLaneNo = pLaneNo + document.getElementById("right")[i].value + ",";
			  		}
			  		//������0,1�ַ���
			  		pLaneNo = pLaneNo.substring(0,pLaneNo.length-1);
			  	}
			}
		  	//����HTML����
		  	function saveAndPrint(){
				var tempBool = share();
				if(tempBool == false) {
					return false;
				}
			    //�����������
				var countDay = compTime(get("startTime").value, get("endTime").value);
				if(countDay > 10) {
					if(confirm("��ѡ���ڳ���10�죬����HTML��ʽ���ɱ��������Ҫ�ϳ�ʱ�䣬�Ƿ����PDF��ʽ���ɱ���")) {
					  	saveAndPrintPDF();
					  	return true;
				  	}
			  	}
			  	
			  	//��֤����
			  	if(checkTime() == false) {
				  	return false;
				} else {
					window.open("otherTollsReport_tollsLaneReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&pLaneNo="+pLaneNo);
			    }
		  	}

		  	 //���ɵ�ǰҳ��HTML����
			  function saveAndPrintCurrentPage(){
					var tempBool = share();
					if(tempBool == false) {
						return false;
					}
				    //�����������
					var countDay = compTime(get("startTime").value, get("endTime").value);
					if(countDay > 10) {
						if(confirm("��ѡ���ڳ���10�죬����HTML��ʽ���ɱ��������Ҫ�ϳ�ʱ�䣬�Ƿ����PDF��ʽ���ɱ���")) {
						  	saveAndPrintPDF();
						  	return true;
					  	}
				  	}
				  	
				  	//��֤����
				  	if(checkTime() == false) {
					  	return false;
					} else {
						window.belowFrame.location.href="otherTollsReport_tollsLaneReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&pLaneNo="+pLaneNo;
				    }
			  }
		  	
		  	//����PDF����
		  	function saveAndPrintPDF() {
		  		var tempBool = share();
				if(tempBool == false) {
					return false;
				}
		  		if(checkTime() == false) {
			  		return false;
				} else {
					window.open("otherTollsReport_tollsLaneReportPDF.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&pLaneNo="+pLaneNo);
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
		  	//�ƶ�������ѡ��ѡ��
			function moveOption(e1, e2) {
				for(var i=0;i<e1.options.length;i++){
					if(e1.options[i].selected) {
				   		var e = e1.options[i];
				   		e2.options.add(new Option(e.text, e.value));
				   		e1.remove(i);
				   		i=i-1;
				  	}
				}
			}
			//�ƶ����и�ѡ��ѡ��
			function moveAllOption(e1, e2) {
				for(var i=0;i<e1.options.length;i++){
				   	if(e1.options[i]) {
				   		var e = e1.options[i];
				   		e2.options.add(new Option(e.text, e.value));
				   		e1.remove(i);
				   		i=i-1;
				  	}
				}
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
						<td width="30%" class="pn-flabel pn-flabel-h">ͳ��ʱ�䷶Χ��</td>
						<td width="70%" class="pn-fcontent">
						  <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime"  value="${endTime }"  class="Wdate" onClick="WdatePicker()">
						  &nbsp;<font style="color:red">*</font>
						  <!-- <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" class="Wdate" onClick="WdatePicker()"> -->
						</td>
					</tr>
					<%-- <tr>
						<td width="30%" class="pn-flabel pn-flabel-h">��Σ�</td>
						<td width="70%" class="pn-fcontent">
						<c:forEach items="${squadList}" var="item">
							<input type="checkbox" name="squadNo" value="${item.squadNo }" checked="checked" />${item.squadName }
						</c:forEach>
						&nbsp;<font style="color:red">*</font>
						</td>
					</tr> --%>
					<tr>
						<td width="30%" class="pn-flabel pn-flabel-h">������</td>
						<td  width="70%" class="pn-fcontent">
						<table border="1" width="400">
							<tr>
								<td>
									<CENTER>
										��ѡ�񳵵�
									</CENTER>
								</td>
								<td></td>
								<td>
									<CENTER>
										��ѡ�񳵵�
									</CENTER>
								</td>
							</tr>
							<tr>
								<td width="40%">
									<select style="width: 100%;" multiple name="left" size="8" id="left"
										ondblclick="moveOption(document.getElementById('left'), document.getElementById('right'))">
										<c:forEach items="${laneList}" var="item">
											<option value="${item.laneNo}">${item.laneNo}</option>
							 			</c:forEach> 
									</select>
								</td>
								<td width="20%" align="center">
									<input type="button" value=" >>>> "
										onClick="moveAllOption(document.getElementById('left'), document.getElementById('right'))">
									<br>
									<input type="button" value="  >>  "
										onClick="moveOption(document.getElementById('left'), document.getElementById('right'))">
									<br>
									<br>
									<input type="button" value="  <<  "
										onClick="moveOption(document.getElementById('right'), document.getElementById('left'))">
									<br>
									<input type="button" value=" <<<< "
										onClick="moveAllOption(document.getElementById('right'), document.getElementById('left'))">
								</td>
								<td width="40%">
									<select style="width: 100%;" multiple name="right" size="8" id="right"
										ondblclick="moveOption(document.getElementById('right'), document.getElementById('left'))">
									</select>
								</td>
							</tr>
						</table>
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
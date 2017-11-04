<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<link type="text/css" rel="stylesheet" media="screen" href="css/validate-css/showmgs.css"/>		
        <script type="text/javascript" src="js/util.js"></script>
        <script type="text/javascript" src="js/validate/jquery.js" charset="UTF-8"></script> 
	    <script type="text/javascript" src="js/validate/jquery.validate.js" charset="UTF-8"></script> 
	    <script type="text/javascript" src="js/validate/messages_cn.js" charset="UTF-8"></script> 	
		<script type="text/javascript">
		
	if ("${result}" == "SUCCESS")
		alert("Ʊ�����ɹ�");

	 $(document).ready(function(){
	 	 $("#dataform").validate({
			submitHandler:function(form){
	 		var positionval=document.getElementsByName("position")[0].value;      
			var transactor = document.getElementsByName("billTransfer.transactor")[0].value;
			var squadDatevar = document.getElementsByName("squadDate")[0].value;
			var squadNo = document.getElementsByName("billTransfer.squadNo")[0].value;
			var remark = document.getElementsByName("billTransfer.remark")[0].value;
			var temp = new Array();
			if (document.getElementById("right").length == 0) {
				alert("��ѡ��Ҫ����Ʊ��");
				return false;
			} else {
				for (i = 0; i < document.getElementById("right").length; i++) {
					temp[i] = document.getElementById("right")[i].value;
				}
 		
				 window.location="bill_moveInEdit.do?right="+temp+"&billStorage.position="+positionval+"&billTransfer.transactor="+transactor+"&squadDate="+squadDatevar+"&billTransfer.squadNo="+squadNo+"&billTransfer.remark="+remark;		  		
			  	}	 		 
		    }});
	 	jQuery.validator.addMethod("positiveInteger", function(value, element) {					     
		    var decimal = /^[1-9]\d*$/;
		    return this.optional(element) || (decimal.test(value));
	       }, $.validator.format("������������."));	
	 	jQuery.validator.addMethod("max2147483647", function(value, element) {
		      return this.optional(element) || (value <= 2147483647);
	         }, $.validator.format("���ܴ���2147483647"));	
	 	jQuery.validator.addMethod("maxlengthForty", function(value, element) {
		      return this.optional(element) || ((Len(value.trim()) <= 40));
	         }, $.validator.format("���Ȳ��ܴ���40������������)"));	
	  });
	  
	  <%--function commit() {
		if ((document.getElementsByName("billTransfer.transactor")[0].value).trim() == "") {
			alert("�����˲���Ϊ�գ���ѡ��.");
			document.getElementsByName("billTransfer.transactor")[0].focus();
			return false;
		}
		if (Len((document.getElementsByName("billTransfer.remark")[0].value).trim()) > 40) {
			alert("��ע���Ȳ��ܴ���40����һ��������������");
			document.getElementsByName("billTransfer.remark")[0].focus();
			return false;
		}
		if ((document.getElementsByName("billTransfer.squadNo")[0].value).trim() != "") {
			var partten = /^\d*$/;
			if (partten.test((document.getElementsByName("billTransfer.squadNo")[0].value).trim())) {
				if (document.getElementsByName("billTransfer.squadNo")[0].value > 2147483647) {
					alert("��β��ܴ���2147483647������������.");
					document.getElementsByName("billTransfer.squadNo")[0].focus();
					return false;
				}
			} else {
				alert("���Ҫ������������������.");
				document.getElementsByName("billTransfer.squadNo")[0].focus();
				return false;
			}
		}
		var positionval=document.getElementsByName("position")[0].value;      
		var transactor = document.getElementsByName("billTransfer.transactor")[0].value;
		var squadDatevar = document.getElementsByName("squadDate")[0].value;
		var squadNo = document.getElementsByName("billTransfer.squadNo")[0].value;
		var remark = document.getElementsByName("billTransfer.remark")[0].value;
		var temp = new Array();
		if (document.getElementById("right").length == 0) {
			alert("��ѡ��Ҫ����Ʊ��");
			return false;
		} else {
			for (i = 0; i < document.getElementById("right").length; i++) {
				temp[i] = document.getElementById("right")[i].value;
			}
			 window.location="bill_moveInEdit.do?right="+temp+"&billStorage.position="+positionval+"&billTransfer.transactor="+transactor+"&squadDate="+squadDatevar+"&billTransfer.squadNo="+squadNo+"&billTransfer.remark="+remark;		  		
		}
	}--%>
	function moveOption(e1, e2) {
		for ( var i = 0; i < e1.options.length; i++) {
			if (e1.options[i].selected) {
				var e = e1.options[i];
				e2.options.add(new Option(e.text, e.value));
				e1.remove(i);
				i = i - 1;
			}
		}
	}
	function moveAllOption(e1, e2) {
		for ( var i = 0; i < e1.options.length; i++) {
			if (e1.options[i]) {
				var e = e1.options[i];
				e2.options.add(new Option(e.text, e.value));
				e1.remove(i);
				i = i - 1;
			}
		}
	}

	function showBillStorageByposition() {
		var positionval = document.getElementsByName("position")[0].value;
		window.location = "bill_moveIn.do?position=" + positionval;
	}
	function getStartBillNo() {
		var val = document.getElementsByName("left")[0].value;
		jQuery.ajax( {
			type : "post",
			url : "bill_getStartBillNo.do?billStorage.hankNo=" + val,
			async : false,
			success : function(data, textStatus) {
				if (data != "") {
					document.getElementById("startBillNo").value = "";
					document.getElementById("startBillNo").value = data;
				}
			}
		});
	}

	var xmlHttp;
	function createXmlHttpRequest() {
		if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	function setStartBillNo() {
		if ((document.getElementsByName("billStorage.startBillNo")[0].value).trim() != "") {
			var partten = /^\d*$/;
			if (partten.test((document.getElementsByName("billStorage.startBillNo")[0].value).trim())) {
				if (document.getElementsByName("billStorage.startBillNo")[0].value > 2147483647) {
					alert("��ʼƱ�Ų��ܴ���2147483647������������.");
					document.getElementsByName("billStorage.startBillNo")[0].focus();
					return false;
				}
			} else {
				alert("��ʼƱ��Ҫ������������������.");
				document.getElementsByName("billStorage.startBillNo")[0].focus();
				return false;
			}
		} else {
			alert("��ʼƱ�Ų���Ϊ�գ�����������.");
			document.getElementsByName("billStorage.startBillNo")[0].focus();
			return false;
		}
		var temp = new Array();
		for (i = 0; i < document.getElementById("left").length; i++) {
			temp[i] = document.getElementById("left")[i].value;
		}
		createXmlHttpRequest();
		var val = document.getElementsByName("left")[0].value;
		if (val == "") {
			alert("��ѡ����Ҫ�޸Ŀ�ʼƱ�ŵ�Ʊ��");
			return false;
		} else {
			var valStartBillNo = document.getElementsByName("billStorage.startBillNo")[0].value;
			var valposition = document.getElementsByName("position")[0].value;
			var url = "bill_setStartBillNo.do?billStorage.hankNo=" + val
					+ "&billStorage.startBillNo=" + valStartBillNo
					+ "&position=" + valposition + "&right=" + temp;
			xmlHttp.open("GET", url, true);
			xmlHttp.onreadystatechange = getBillStorageList;
			xmlHttp.send(null);
		}

	}
	function getBillStorageList() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				projectData();
			}
		}
	}
	function projectData() {
		var xmlDoc = xmlHttp.responseXML;
		var billStorageList = xmlDoc.getElementsByTagName("billStorageList")[0];
		var select = document.getElementById('left');
		if (select.options.length > 0) {
			var a = select.options.length;
			while (a > 0) {
				select.removeChild(select.options[--a]);
			}
		}
		if (billStorageList != null) {
			var billStorages = billStorageList.getElementsByTagName("billStorage");
			for ( var i = 0; i < billStorages.length; i++) {
				select.options.add(new Option(
								billStorages[i].getElementsByTagName("hankNo")[0].firstChild.nodeValue
										+ "["
										+ billStorages[i].getElementsByTagName("amount")[0].firstChild.nodeValue
										+ "]["
										+ billStorages[i].getElementsByTagName("billHead")[0].firstChild.nodeValue
										+ ":"
										+ billStorages[i].getElementsByTagName("usedBillNo")[0].firstChild.nodeValue
										+ "--"
										+ billStorages[i].getElementsByTagName("endBillNo")[0].firstChild.nodeValue
										+ "]",
								billStorages[i].getElementsByTagName("hankNo")[0].firstChild.nodeValue));

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
			 <form id="dataform" name="form" method="post">  		
					<table width="700"  cellpadding="2" cellspacing="1" border="0.5" height="250">
	
						
							<tr>
							<td >��Դ�ص㣺
								 <select name="position" style="width:100px" onchange="showBillStorageByposition()" class="required">	
						       	   <option value="" <c:if test="${position==null}">selected</c:if>>��ѡ��</option>							
							         <c:forEach items="${listgatewayInformation}" var="item">
								      <option value="${item.gateNo}" <c:if test="${position==item.gateNo}">selected</c:if>>${item.gateName}</option>
							         </c:forEach> 															
						        </select>	
								&nbsp;<font style="color:red">*</font></td>								
								<td ></td>
								<td >���Ʊ��									
								</td>
								
							</tr>
							<tr>
								<td width="40%" >
									<select style="width: 100%;" multiple name="left" size="15" id="left" 
										ondblclick="moveOption(document.getElementById('left'), document.getElementById('right'))" onchange="getStartBillNo()">
										<c:forEach items="${list}" var="item">
							          <option value="${item.hankNo}"  <c:if test="${left==item.hankNo}">selected</c:if>>${item.hankNo}[${item.amount-item.usedAmount}][${item.billHead}:${item.usedBillNo}--${item.endBillNo}]</option>
							        </c:forEach>  								
									</select>
								</td>
								<td width="20%" align="center" >
									<input type="button" value=" &nbsp;> &nbsp;&nbsp;" 
										onClick="moveOption(document.getElementById('left'), document.getElementById('right'))">
										<br>
										<br>
									<input type="button" value=" &nbsp;>> &nbsp;"
										onClick="moveAllOption(document.getElementById('left'), document.getElementById('right'))">
									<br>
									<br>
									<input type="button" value="&nbsp; <&nbsp; &nbsp;"
										onClick="moveOption(document.getElementById('right'), document.getElementById('left'))">
									<br>
									<br>
									<input type="button" value="&nbsp; << &nbsp;"
										onClick="moveAllOption(document.getElementById('right'), document.getElementById('left'))">
								</td>
								<td width="40%">
									<select style="width: 100%;" multiple name="right" size="15" id="right" 
										ondblclick="moveOption(document.getElementById('right'), document.getElementById('left'))" >										
									</select>
								</td>
							</tr>
							<tr>
							 <td >��ʼƱ�ţ�&nbsp;<input id="startBillNo" type="text" name="billStorage.startBillNo" value="${billStorage.usedBillNo}" size="20"> <input type="button" value="�޸�" onclick="setStartBillNo()"/></td>
							 <td ></td>
							<td >�����ˣ�
								 <select name="billTransfer.transactor" style="width:120px" class="required">
							        <option value="">��ѡ��</option>
							        <c:forEach items="${listTemp}" var="itemTemp">
							          <option value="${itemTemp.operatorNo}">${itemTemp.operatorName}</option>
							        </c:forEach>  
						         </select>&nbsp;<font style="color:red">*</font>
							</td>
							</tr>
							<tr>
							<td colspan="3">�������ڣ�
							<input type="text" name="squadDate" value="${squadDate}" class="Wdate" onClick="WdatePicker()" size="28.5">
							</td>
							</tr>
							<tr>							
							 <td colspan="3" >
							 	��&nbsp;&nbsp;&nbsp;&nbsp;�Σ�
							 	<select name="billTransfer.squadNo" class="required" style="width:205px">
							 		<option value="">��ѡ��</option>
							 		<c:forEach items="${squadList}" var="squadItem">
							 			<option value="${squadItem.squadNo }">${squadItem.squadName }</option>
							 		</c:forEach>	
							 	</select>
							 	<!-- <input type="text" name="billTransfer.squadNo" size="28" class="positiveInteger max2147483647"> -->
							 </td>
							</tr>
							<tr>
					          <td colspan="3">��&nbsp;&nbsp;&nbsp;&nbsp;ע��
					            <textarea rows='2' cols='55' name="billTransfer.remark" class="maxlengthForty"></textarea>
					          </td>
					       </tr>
					
							
					<tr>
						<td colspan="3" class="pn-fbutton">
							<input type="submit" value=" &nbsp;ȷ�� &nbsp;" /> &nbsp;
						<input type="reset" value=" &nbsp;ȡ��&nbsp; "/></td>
						<input type="hidden" name="amountTemp" value="${billStorage.endBillNo}"/>
					</tr>
					
					 </table>
					
			</form>
		</div>
	</body>
</html>

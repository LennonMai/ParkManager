<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title></title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
        <script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>		
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
						
		<script type="text/javascript">
		 
		<%--function check(){
			if(document.getElementsByName("squadDate")[0].value==""){
				alert("�������ڲ���Ϊ�գ�������ѡ������."); 
				document.getElementsByName("squadDate")[0].focus();
				return false;
			}

			if(document.getElementsByName("cardHandOutIn.parkNo")[0].value==""){
				alert("С������Ϊ�գ�������ѡ������."); 
				document.getElementsByName("cardHandOutIn.parkNo")[0].focus();
				return false;
			}
			if(document.getElementsByName("cardHandOutIn.gateNo")[0].value==""){
				alert("���Ų���Ϊ�գ�������ѡ������."); 
				document.getElementsByName("cardHandOutIn.gateNo")[0].focus();
				return false;
			}
			if(document.getElementsByName("cardHandOutIn.laneNo")[0].value==""){
				alert("��������Ϊ�գ�������ѡ������."); 
				document.getElementsByName("cardHandOutIn.laneNo")[0].focus();
				return false;
			}
		}--%>	    

		 <%-- var xmlHttp;
		    function createXmlHttpRequest(){
		      if(window.XMLHttpRequest){
		        xmlHttp = new XMLHttpRequest();
		      }
		      else if(window.ActiveXObject){
		        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		      }
		    }
		    function getGate(){
		      createXmlHttpRequest();
		      var parkNo=document.getElementsByName("cardHandOutIn.parkNo")[0].value; 
		      var url = "passCard_ajaxGate.do?cardHandOutIn.parkNo="+parkNo;
		      xmlHttp.open("GET",url,true);
		      xmlHttp.onreadystatechange = getProjectList;
		      xmlHttp.send(null);
		    }
		    function getProjectList(){
		      if(xmlHttp.readyState == 4){
		        if(xmlHttp.status == 200){
		          projectData();
		        }
		      }
		    }
		    function projectData(){
		      var xmlDoc = xmlHttp.responseXML;
		      var gatewayList = xmlDoc.getElementsByTagName("gatewayList")[0];
		      var selectLane = document.getElementById('laneNo');
		      if(selectLane.options.length > 0){
		        var a = selectLane.options.length;
		        while(a > 0){
		        	selectLane.removeChild(selectLane.options[--a]);
		        }
		      }
		      selectLane.options.add(new Option("-��ѡ��-","")); 
		      var select = document.getElementById('gateNo');
		      if(select.options.length > 0){
		        var a = select.options.length;
		        while(a > 0){
		          select.removeChild(select.options[--a]);
		        }
		      }
		      select.options.add(new Option("-��ѡ��-","")); 
		      if(gatewayList != null){
		        var gateway = gatewayList.getElementsByTagName("gateway");        
		        for(var i = 0;i < gateway.length;i++){
				  select.options.add(new Option(gateway[i].getElementsByTagName("gateName")[0].firstChild.nodeValue,gateway[i].getElementsByTagName("gateNo")[0].firstChild.nodeValue));
		        }
		      }
		      
		    }

		    function getLane(){
			      createXmlHttpRequest();
			  	  var parkNo=document.getElementsByName("cardHandOutIn.parkNo")[0].value; 
				  var gateNo=document.getElementsByName("cardHandOutIn.gateNo")[0].value;
			      var url = "passCard_ajaxLane.do?cardHandOutIn.parkNo="+parkNo+"&cardHandOutIn.gateNo="+gateNo;
			      xmlHttp.open("GET",url,true);
			      xmlHttp.onreadystatechange = getProjectListLane;
			      xmlHttp.send(null);
			    }
			    function getProjectListLane(){
			      if(xmlHttp.readyState == 4){
			        if(xmlHttp.status == 200){
			          projectDataLane();
			        }
			      }
			    }
			    function projectDataLane(){
			      var xmlDoc = xmlHttp.responseXML;
			      var laneList = xmlDoc.getElementsByTagName("laneList")[0];
			      var select = document.getElementById('laneNo');
			      if(select.options.length > 0){
			        var a = select.options.length;
			        while(a > 0){
			          select.removeChild(select.options[--a]);
			        }
			      }
			      select.options.add(new Option("-��ѡ��-","")); 
			      if(laneList != null){
			    	  
			        var lane = laneList.getElementsByTagName("lane");       
			        for(var i = 0;i < lane.length;i++){
					  select.options.add(new Option(lane[i].getElementsByTagName("name")[0].firstChild.nodeValue,lane[i].getElementsByTagName("laneNo")[0].firstChild.nodeValue));
			        }
			      }
			      
			    }--%>
			    function getGate(){
					 var parkNo=document.getElementsByName("cardHandOutIn.parkNo")[0].value; 
						$.ajax({
							type:"post",
							url:"passCard_ajaxGate.do?cardHandOutIn.parkNo="+parkNo,
							success:function(res){
								$("#gateNo").empty();
								var op = $("<option value=''>-��ѡ��-</option>");
								$("#laneNo").empty();
								var op1 = $("<option value=''>-��ѡ��-</option>");		
								$("#laneNo").append(op1);		
								$("#gateNo").append(op);
								$(res).find("gates > gate").each(function(){								
								var op = $("<option value=" + $(this).attr("id") + ">" 
										+ $(this).attr("name") + "</option>");
								$("#gateNo").append(op);	
							});
							}
						});
					}
					function getLane(){
						var parkNo=document.getElementsByName("cardHandOutIn.parkNo")[0].value; 
						  var gateNo=document.getElementsByName("cardHandOutIn.gateNo")[0].value;
						$.ajax({
							type:"post",
							url:"passCard_ajaxLane.do?cardHandOutIn.parkNo="+parkNo+"&cardHandOutIn.gateNo="+gateNo,
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
					}

			  <%-- function getGate(){
			var parkNo=document.getElementsByName("cardHandOutIn.parkNo")[0].value; 
			$.ajax({
				type:"post",
				url:"passCard_ajaxGate.do?cardHandOutIn.parkNo="+parkNo,
				success:function(res){
					$("#laneNo").empty();
					var op1 = $("<option value=''>-��ѡ��-</option>");		
					$("#laneNo").append(op1);
					$("#gateNo").empty();				
					var op = $("<option value=''>-��ѡ��-</option>");	
					$("#gateNo").append(op);
					$(res).find("gatewayList > gate").each(function(){								
					var op = $("<option value=" + $(this).attr("gateName") + ">" 
							+ $(this).attr("gateNo") + "</option>");
					$("#gateNo").append(op);	
				});
				}
			});
		}
		function getLane(){
			var parkNo=document.getElementsByName("cardHandOutIn.parkNo")[0].value; 
			var gateNo=document.getElementsByName("cardHandOutIn.gateNo")[0].value; 
			$.ajax({
				type:"post",
				url:"passCard_ajaxLane.do?cardHandOutIn.parkNo="+parkNo+"&cardHandOutIn.gateNo="+gateNo,
				success:function(res){
					$("#laneNo").empty();
					var op = $("<option value=''>-��ѡ��-</option>");		
					$("#laneNo").append(op);
					$(res).find("gatewayList > gate").each(function(){								
					var op = $("<option value=" + $(this).attr("gateName") + ">" 
							+ $(this).attr("name") + "</option>");
					$("#laneNo").append(op);	
				});
				}
			});
		}  --%> 
			
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="passCard_addCardHandOutInEdit.do">  				   
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" height="200">					 					
					<tr>
					  <td class="pn-flabel pn-flabel-h">�������ڣ�</td>
					  <td  class="pn-fcontent"> <input type="text" name="squadDate"  value="${squadDate}" class="Wdate required" onClick="WdatePicker()" >&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">����ţ�</td>
					  <td  class="pn-fcontent"> 
					  <select name="cardHandOutIn.squadNo" style="width:150px" class="required">
							 		<option value="">��ѡ��</option>
							 		<c:forEach items="${squadList}" var="squadItem">
							 			<option value="${squadItem.squadNo }">${squadItem.squadName }</option>
							 		</c:forEach>	
							 	</select><%-- 
					   <select name="cardHandOutIn.squadNo" style="width:150px" class="required">								
								<option value="" <c:if test="${cardHandOutIn.squadNo==null}">selected</c:if>>��ѡ��</option>						
								<option value="1" <c:if test="${cardHandOutIn.squadNo==1}">selected</c:if>>��һ���� </option>
								<option value="2" <c:if test="${cardHandOutIn.squadNo==2}">selected</c:if>>�ڶ����� </option>
								<option value="3" <c:if test="${cardHandOutIn.squadNo==3}">selected</c:if>>�������� </option>						
						  </select>&nbsp;--%><font style="color:red">*</font>
					 </td>				 
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</td>
					   <td  class="pn-fcontent">
						  <select name="cardHandOutIn.type" style="width:150px" class="required">								
								<option value="" <c:if test="${cardHandOutIn.type==null}">selected</c:if>>��ѡ��</option>						
								<option value="1" <c:if test="${cardHandOutIn.type==1}">selected</c:if>>�쿨 </option>
								<option value="2" <c:if test="${cardHandOutIn.type==2}">selected</c:if>>���� </option>						
						  </select>&nbsp;<font style="color:red">*</font>
						  </td>
					   <td class="pn-flabel pn-flabel-h">������</td>
					   <td class="pn-fcontent"><input type="text" name="cardHandOutIn.amount" class="required positiveInteger max2147483647" />&nbsp;<font style="color:red">*</font></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">λ&nbsp;&nbsp;&nbsp;&nbsp;�ã�</td>
					    <td  class="pn-fcontent" colspan="3">С����:				    	   
					      <select name="cardHandOutIn.parkNo" style="width:100px" onchange="getGate();" class="required">
								<option value="" <c:if test="${cardHandOutIn.parkNo==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${parkList}" var="itemPark">
								<option value="${itemPark.parkNo}" <c:if test="${cardHandOutIn.parkNo==itemPark.parkNo}">selected</c:if>>${itemPark.parkName}</option>
							    </c:forEach>  
						   </select>&nbsp;<font style="color:red">*</font>
						
						
						��������
						
						      <select name="cardHandOutIn.gateNo" id="gateNo" style="width:100px" onchange="getLane();" class="required">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${gateList}" var="itemGate">
										<option value="${itemGate.gateNo }"<c:if test="${itemGate.gateNo==cardHandOutIn.gateNo}"> selected</c:if>>${itemGate.gateName }</option>
									</c:forEach>
							 </select>&nbsp;<font style="color:red">*</font>
                       
						������
						
						   <select name="cardHandOutIn.laneNo" id="laneNo" style="width:100px" class="required">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${laneList}" var="itemLane" >
										<option value="${itemLane.laneNo }"<c:if test="${itemLane.laneNo==cardHandOutIn.laneNo }"> selected</c:if>>${itemLane.laneNo }</option>
									</c:forEach>
						 </select>&nbsp;<font style="color:red">*</font>
						 </td>					 				 
					</tr>
					<tr>
					 <td class="pn-flabel pn-flabel-h">��/�����ˣ�</td>
					      <td  colspan="3" class="pn-fcontent">
						    <select name="cardHandOutIn.operatorNo" style="width:150px" class="required">
								<option value="" <c:if test="${cardHandOutIn.operatorNo==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listOperator}" var="item">
								   <option value="${item.operatorNo}" <c:if test="${cardHandOutIn.operatorNo==item.operatorNo}">selected</c:if>>${item.operatorName}</option>
							    </c:forEach>  
						   </select>&nbsp;<font style="color:red">*</font>
						</td>		
					</tr>
	
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� "/> &nbsp;
						<input type="reset" value=" �� �� "/>	&nbsp;
						<input type="button" value=" �� �� " onclick="history.back();"/>
						</td>
					</tr>
					
	          </table>
					
			</form>
		</div>
	</body>
</html>

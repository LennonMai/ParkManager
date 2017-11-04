 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>		
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript">
		if("${result}"=="SUCCESS")
			alert("�Ǽǳɹ�"); 
		if("${result}"=="SUCCESS1")
			alert("���ĳɹ�"); 
		if("${result}"=="SUCCESS2")
			alert(" ɾ���ɹ�"); 
		function deleteCardHandOutIn(recordNo) {
			if(confirm("ȷ��Ҫɾ����")) {													
				window.location = "passCard_deleteCardHandOutIn.do?cardHandOutIn.recordNo=" + recordNo;		
			}
		}
		

		
		function addCardHandOutIn(){
			window.location = "passCard_addCardHandOutIn.do";
		}

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

			function getRowIndex(obj){
					get("pager.rowIndex").value=obj.rowIndex;
					}
			function updateCardHandOutIn(recordNo,pageSize,currentPage) {														
				window.location = "passCard_updateCardHandOutIn.do?cardHandOutIn.recordNo=" + recordNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;	
		    }
			function setRowBGcolor(){
					var rowIndex="${rowIndex}";
					var pageSize="${pageSize}";
					var currentPage="${currentPage}";
					if(rowIndex!=""&&pageSize!=""&&currentPage!=""){
						var trs=document.getElementById("tb").getElementsByTagName("tr");
						for(var i=0;i<trs.length;i++){
							if(i==rowIndex&&get("pager.pageSize").value==pageSize&&get("pager.currentPage").value==currentPage){
								trs[i].style.backgroundColor="#E6E6E6";
							}
						}
					}
				}		 
		</script>
		
	</head>
	<body onload="setRowBGcolor();">
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="passCard_queryCardHandOutIn.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    <tr>
					    <td  class="pn-flabel pn-flabel-h">��������&nbsp;��</td>
						<td  class="pn-fcontent"> <input type="text" name="squadDate" value="${squadDate}" class="Wdate" onClick="WdatePicker()" ></td>
						<td  class="pn-flabel pn-flabel-h">����ţ�</td>
						<td  class="pn-fcontent">
						<select name="cardHandOutIn.squadNo" style="width:150px" class="required">
							 		<option value="">��ѡ��</option>
							 		<c:forEach items="${squadList}" var="squadItem">
							 		   <option value="${squadItem.squadNo}" <c:if test="${cardHandOutIn.squadNo==squadItem.squadNo}">selected</c:if>>${squadItem.squadName}</option>							 			
							 		</c:forEach>	
							 	</select> 
						<%--<select name="cardHandOutIn.squadNo" style="width:150px">								
								<option value="" <c:if test="${cardHandOutIn.squadNo==null}">selected</c:if>>��ѡ��</option>						
								<option value="1" <c:if test="${cardHandOutIn.squadNo==1}">selected</c:if>>��һ���� </option>
								<option value="2" <c:if test="${cardHandOutIn.squadNo==2}">selected</c:if>>�ڶ����� </option>
								<option value="3" <c:if test="${cardHandOutIn.squadNo==3}">selected</c:if>>�������� </option>						
						  </select>
						 --%></td>	
						<td  class="pn-flabel pn-flabel-h">���ͣ�</td>
						<td  class="pn-fcontent">
						  <select name="cardHandOutIn.type" style="width:150px">								
								<option value="" <c:if test="${cardHandOutIn.type==null}">selected</c:if>>��ѡ��</option>						
								<option value="1" <c:if test="${cardHandOutIn.type==1}">selected</c:if>>�쿨 </option>
								<option value="2" <c:if test="${cardHandOutIn.type==2}">selected</c:if>>���� </option>						
						  </select>
						</td>							
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">��/�����ˣ�</td>
						<td  class="pn-fcontent">
						   <select name="cardHandOutIn.operatorNo" style="width:150px">
								<option value="" <c:if test="${cardHandOutIn.operatorNo==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listOperator}" var="item">
								   <option value="${item.operatorNo}" <c:if test="${cardHandOutIn.operatorNo==item.operatorNo}">selected</c:if>>${item.operatorName}</option>
							    </c:forEach>  
						  </select>
						</td>
						<td  class="pn-flabel pn-flabel-h">�Ǽ��ˣ�</td>
						<td  colspan="3" class="pn-fcontent"> 
						   <select name="cardHandOutIn.recorderNo" style="width:150px">
								<option value="" <c:if test="${cardHandOutIn.recorderNo==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listAdmin}" var="item">
								   <option value="${item.id}" <c:if test="${cardHandOutIn.recorderNo==item.id}">selected</c:if>>${item.name}</option>
							    </c:forEach>  
						  </select>
						 </td>	
										
					</tr>				
					<tr>
					<td class="pn-flabel pn-flabel-h">λ�ã�</td>
					    <td  class="pn-fcontent" colspan="5">С����:				    	   
					      <select name="cardHandOutIn.parkNo" style="width:150px" onchange="getGate();">
								<option value="" <c:if test="${cardHandOutIn.parkNo==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${parkList}" var="itemPark">
								<option value="${itemPark.parkNo}" <c:if test="${cardHandOutIn.parkNo==itemPark.parkNo}">selected</c:if>>${itemPark.parkName}</option>
							    </c:forEach>  
						   </select>&nbsp;
						
						
						��������
						
						      <select name="cardHandOutIn.gateNo" id="gateNo" style="width:150px" onchange="getLane();">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${gateList}" var="itemGate">
										<option value="${itemGate.gateNo }"<c:if test="${itemGate.gateNo==cardHandOutIn.gateNo}"> selected</c:if>>${itemGate.gateName }</option>
									</c:forEach>
							 </select>&nbsp;
                       
						������
						
						   <select name="cardHandOutIn.laneNo" id="laneNo" style="width:150px">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${laneList}" var="itemLane" >
										<option value="${itemLane.laneNo }"<c:if test="${itemLane.laneNo==cardHandOutIn.laneNo }"> selected</c:if>>${itemLane.laneNo }</option>
									</c:forEach>
						 < select>
						 </td>	
                      						
					</tr>
						
									 					
					<tr>
						<td colspan="6" class="pn-fbutton">
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="button" value=" &nbsp;���� &nbsp;" onclick="addCardHandOutIn()"/>						
						<input type="reset" value=" �� �� "/>
						
						
						</td>
					</tr>
				</table>
					<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>��¼��</th>
						<th>��������</th>						
						<th>�����</th>
						<th>����</th>						
						<th>����</th>
						<th>С��</th>
						<th>����</th>						
						<th>����</th>
						<th>��/������</th>						
						<th>�Ǽ���</th>
						<th>�Ǽ�ʱ��</th>									
						<th>����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.recordNo}</td>
							<td><fmt:formatDate value="${item.squadDate}" pattern="yyyy-MM-dd" /></td>								
							<td><c:if test="${item.squadNo==1}">��һ����</c:if><c:if test="${item.squadNo==2}">�ڶ�����</c:if><c:if test="${item.squadNo==3}">��������</c:if></td>							
							<td><c:if test="${item.type==1}">�쿨</c:if><c:if test="${item.type==2}">����</c:if></td>	
							<td>${item.amount}</td>
							<td><c:forEach items="${parkList}" var="itemPark"><c:if test="${item.parkNo==itemPark.parkNo}">${itemPark.parkName}</c:if></c:forEach></td>					
							<td><c:forEach items="${gatewayList}" var="itemGateway"><c:if test="${item.gateNo==itemGateway.gateNo}">${itemGateway.gateName}</c:if></c:forEach></td>													
							<td>${item.laneNo}</td>	
							<td>${item.operatorName}</td>
							<td>${item.recorderName}</td>								
							<td><fmt:formatDate value="${item.recordTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>																	
                            <td><a href="javascript:updateCardHandOutIn(${item.recordNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>��<a href="javascript:deleteCardHandOutIn(${item.recordNo})" class="pn-loperator">ɾ��</a></td>                                         
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>
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
			alert("登记成功"); 
		if("${result}"=="SUCCESS1")
			alert("更改成功"); 
		if("${result}"=="SUCCESS2")
			alert(" 删除成功"); 
		function deleteCardHandOutIn(recordNo) {
			if(confirm("确定要删除吗？")) {													
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
						var op = $("<option value=''>-请选择-</option>");
						$("#laneNo").empty();
						var op1 = $("<option value=''>-请选择-</option>");		
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
						var op = $("<option value=''>-请选择-</option>");		
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="passCard_queryCardHandOutIn.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    <tr>
					    <td  class="pn-flabel pn-flabel-h">工班日期&nbsp;：</td>
						<td  class="pn-fcontent"> <input type="text" name="squadDate" value="${squadDate}" class="Wdate" onClick="WdatePicker()" ></td>
						<td  class="pn-flabel pn-flabel-h">工班号：</td>
						<td  class="pn-fcontent">
						<select name="cardHandOutIn.squadNo" style="width:150px" class="required">
							 		<option value="">请选择</option>
							 		<c:forEach items="${squadList}" var="squadItem">
							 		   <option value="${squadItem.squadNo}" <c:if test="${cardHandOutIn.squadNo==squadItem.squadNo}">selected</c:if>>${squadItem.squadName}</option>							 			
							 		</c:forEach>	
							 	</select> 
						<%--<select name="cardHandOutIn.squadNo" style="width:150px">								
								<option value="" <c:if test="${cardHandOutIn.squadNo==null}">selected</c:if>>请选择</option>						
								<option value="1" <c:if test="${cardHandOutIn.squadNo==1}">selected</c:if>>第一工班 </option>
								<option value="2" <c:if test="${cardHandOutIn.squadNo==2}">selected</c:if>>第二工班 </option>
								<option value="3" <c:if test="${cardHandOutIn.squadNo==3}">selected</c:if>>第三工班 </option>						
						  </select>
						 --%></td>	
						<td  class="pn-flabel pn-flabel-h">类型：</td>
						<td  class="pn-fcontent">
						  <select name="cardHandOutIn.type" style="width:150px">								
								<option value="" <c:if test="${cardHandOutIn.type==null}">selected</c:if>>请选择</option>						
								<option value="1" <c:if test="${cardHandOutIn.type==1}">selected</c:if>>领卡 </option>
								<option value="2" <c:if test="${cardHandOutIn.type==2}">selected</c:if>>交卡 </option>						
						  </select>
						</td>							
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">领/交卡人：</td>
						<td  class="pn-fcontent">
						   <select name="cardHandOutIn.operatorNo" style="width:150px">
								<option value="" <c:if test="${cardHandOutIn.operatorNo==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listOperator}" var="item">
								   <option value="${item.operatorNo}" <c:if test="${cardHandOutIn.operatorNo==item.operatorNo}">selected</c:if>>${item.operatorName}</option>
							    </c:forEach>  
						  </select>
						</td>
						<td  class="pn-flabel pn-flabel-h">登记人：</td>
						<td  colspan="3" class="pn-fcontent"> 
						   <select name="cardHandOutIn.recorderNo" style="width:150px">
								<option value="" <c:if test="${cardHandOutIn.recorderNo==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listAdmin}" var="item">
								   <option value="${item.id}" <c:if test="${cardHandOutIn.recorderNo==item.id}">selected</c:if>>${item.name}</option>
							    </c:forEach>  
						  </select>
						 </td>	
										
					</tr>				
					<tr>
					<td class="pn-flabel pn-flabel-h">位置：</td>
					    <td  class="pn-fcontent" colspan="5">小区名:				    	   
					      <select name="cardHandOutIn.parkNo" style="width:150px" onchange="getGate();">
								<option value="" <c:if test="${cardHandOutIn.parkNo==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${parkList}" var="itemPark">
								<option value="${itemPark.parkNo}" <c:if test="${cardHandOutIn.parkNo==itemPark.parkNo}">selected</c:if>>${itemPark.parkName}</option>
							    </c:forEach>  
						   </select>&nbsp;
						
						
						大门名：
						
						      <select name="cardHandOutIn.gateNo" id="gateNo" style="width:150px" onchange="getLane();">
									<option value="">-请选择-</option>
									<c:forEach items="${gateList}" var="itemGate">
										<option value="${itemGate.gateNo }"<c:if test="${itemGate.gateNo==cardHandOutIn.gateNo}"> selected</c:if>>${itemGate.gateName }</option>
									</c:forEach>
							 </select>&nbsp;
                       
						车道：
						
						   <select name="cardHandOutIn.laneNo" id="laneNo" style="width:150px">
									<option value="">-请选择-</option>
									<c:forEach items="${laneList}" var="itemLane" >
										<option value="${itemLane.laneNo }"<c:if test="${itemLane.laneNo==cardHandOutIn.laneNo }"> selected</c:if>>${itemLane.laneNo }</option>
									</c:forEach>
						 < select>
						 </td>	
                      						
					</tr>
						
									 					
					<tr>
						<td colspan="6" class="pn-fbutton">
						<input type="submit"   value=" 查 询 " />&nbsp;
						<input type="button" value=" &nbsp;增加 &nbsp;" onclick="addCardHandOutIn()"/>						
						<input type="reset" value=" 重 置 "/>
						
						
						</td>
					</tr>
				</table>
					<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>记录号</th>
						<th>工班日期</th>						
						<th>工班号</th>
						<th>类型</th>						
						<th>数量</th>
						<th>小区</th>
						<th>大门</th>						
						<th>车道</th>
						<th>领/交卡人</th>						
						<th>登记人</th>
						<th>登记时间</th>									
						<th>操作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.recordNo}</td>
							<td><fmt:formatDate value="${item.squadDate}" pattern="yyyy-MM-dd" /></td>								
							<td><c:if test="${item.squadNo==1}">第一工班</c:if><c:if test="${item.squadNo==2}">第二工班</c:if><c:if test="${item.squadNo==3}">第三工班</c:if></td>							
							<td><c:if test="${item.type==1}">领卡</c:if><c:if test="${item.type==2}">交卡</c:if></td>	
							<td>${item.amount}</td>
							<td><c:forEach items="${parkList}" var="itemPark"><c:if test="${item.parkNo==itemPark.parkNo}">${itemPark.parkName}</c:if></c:forEach></td>					
							<td><c:forEach items="${gatewayList}" var="itemGateway"><c:if test="${item.gateNo==itemGateway.gateNo}">${itemGateway.gateName}</c:if></c:forEach></td>													
							<td>${item.laneNo}</td>	
							<td>${item.operatorName}</td>
							<td>${item.recorderName}</td>								
							<td><fmt:formatDate value="${item.recordTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>																	
                            <td><a href="javascript:updateCardHandOutIn(${item.recordNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>┆<a href="javascript:deleteCardHandOutIn(${item.recordNo})" class="pn-loperator">删除</a></td>                                         
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>
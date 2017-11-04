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
		<script type="text/javascript" src="${basePath}/js/jquery.js" charset="UTF-8"></script> 
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		
		<script type="text/javascript" src="${basePath}/js/showWin.js"></script>
		<script type="text/javascript">
		
			if("${result}"=="SUCCESS") {
				if(confirm("ע��ɹ�,�Ƿ��ӡ��")){
					window.open("parkCard_printsUserCardInfo.do?userCardInfo.cardNo="+"${cardNo}");
					/* window.location="parkCard_printsUserCardInfo.do?userCardInfo.cardNo="+"${cardNo}"; */
				}
			}
			if("${result}"=="SUCCESS1") {
				if(confirm("�޸ĳɹ����Ƿ��ӡ��")) {
					window.open("parkCard_printsUserCardInfo.do?userCardInfo.cardNo="+"${cardNo}")
					//window.location="parkCard_printsUserCardInfo.do?userCardInfo.cardNo="+"${cardNo}";
				}
			}		
			if("${result}"=="SUCCESS2") {
				alert("ע���ɹ�");
			}
			function register(){
		    	window.location="parkCard_register.do";
			}
			 			  
			function cancel(cardNo) {	
				if(confirm("ȷ��Ҫע����")) {								
					window.location = "parkCard_parkCardCancel.do?userCardInfo.cardNo=" + cardNo;	
				}	
			}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
			}
			function userCardInfoList(recNo,pageSize,currentPage){
				window.location.href ="parkCard_userCardInfoList.do?userCardInfo.recNO="+recNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			function doPrint(cardNo) {
				window.open("parkCard_printsUserCardInfo.do?userCardInfo.cardNo="+cardNo);
				//window.location="parkCard_printsUserCardInfo.do?userCardInfo.cardNo="+cardNo; 
				//document.getElementById("tableForm").submit();
				//document.getElementById("tableForm").action="parkCard_queryParkCard.do";
			}	
			
			function getCarSmallType(){
				var carType = document.getElementsByName("userCardInfo.carType")[0].value; 
				$.ajax({
					type:"post",
					url:"parkCard_findCarSmallType.do?carType="+carType,
					success:function(res){
						$("#parkingSpace").empty();
						var op = $("<option value=''>��ѡ��</option>");		
						$("#parkingSpace").append(op);
						$(res).find("CarSmallTypes > CarSmallType").each(function(){
							var o = $("<option value="+$(this).attr("id") +">"
									+$(this).attr("name")+"</option>");
							$("#parkingSpace").append(o);
						});
					}
				});
			}
			
			function doExport(){
				var length = $("input[name='filed']:checked").length;
				if(length==0){
					alert("��ѡ��Ҫ�������ֶΣ�");
					return false;
				}
				document.getElementById("idBoxCancel").click();
				document.getElementById("tableForm").action = "parkCard_expWhite.do";   
				document.getElementById("tableForm").submit();
				document.getElementById("tableForm").action = "parkCard_queryParkCard.do";
			}
			
			function checkAll(){
				var checkAll = document.getElementById("all");
				var fileds = document.getElementsByName("filed");
				
				if(checkAll.checked==true){
					for(var i=0; i<fileds.length; i++){
						fileds[i].checked = true;
					}
				}else{
					for(var i=0; i<fileds.length; i++){
						fileds[i].checked = false;
					}
				}
			}
			
			function check(){
				var checkAll = document.getElementById("all");
				var fileds = document.getElementsByName("filed");
				var flag = true;
				for(var i=0; i<fileds.length; i++){
					if(fileds[i].checked==false){
						flag = false;
						break;
					}
				}
				checkAll.checked = flag;
			}
			

			$(document).ready(function(){//����div�����㣬��������¼�
			 	var box = new LightBox("idBox");
			 	box.Center = true;
			 	$("#idBoxCancel").click(
			 		function(){ box.Close(); }
			 	);
			 	$("#exprot").click(
			 		function(){box.Show(); 
			 	});
			 });
			
			
		</script>
<style>
.lightbox{width:620px;background:#FFFFFF;border:1px solid #ccc;line-height:25px; top:30%; left:30%;}
.lightbox dt{background:#f4f4f4; padding:5px;}
</style>
	</head>
<body onload="setRowBGcolor();">


		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" id="tableForm" method="post" action="parkCard_queryParkCard.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">				    
					<tr>
						<td class="pn-flabel pn-flabel-h">������ţ�</td>
						<td class="pn-fcontent"> 
							<input type="text" name="userCardInfo.cardNo" value="${userCardInfo.cardNo}" />
						</td>
						<td class="pn-flabel pn-flabel-h">��&nbsp;״&nbsp;̬��</td>
						<td class="pn-fcontent">
						<select name="userCardInfo.status" style="width:150px">
							<option value="" <c:if test="${userCardInfo.status==null}">selected</c:if>>��ѡ��</option>
							<option value="0" <c:if test="${userCardInfo.status==0}">selected</c:if>>����</option>
							<option value="1" <c:if test="${userCardInfo.status==1}">selected</c:if>>��ʧ </option>
							<option value="9" <c:if test="${userCardInfo.status==9}">selected</c:if>>δ�ɷ� </option>
						</select>	
						</td>
					</tr>					 
					<tr>						
						<td class="pn-flabel pn-flabel-h">�û����ͣ�</td>
						<td class="pn-fcontent">
						<select name="userCardInfo.userCardType" style="width:150px">
							<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>��ѡ��</option>
							<c:forEach items="${listUserCardType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							</c:forEach>  
						</select>
						</td>
						<td class="pn-flabel pn-flabel-h">���ƺ��룺</td>
						<td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate"  value="${userCardInfo.vehPlate}"/></td>
					</tr>
					<tr>	  
						<td class="pn-flabel pn-flabel-h">����������</td>				
						<td class="pn-fcontent"> <input type="text" name="userCardInfo.owner"  value="${userCardInfo.owner}"/></td>				
						<td class="pn-flabel pn-flabel-h">���֤�ţ�</td>						
						<td class="pn-fcontent"><input type="text" name="userCardInfo.idcard"  value="${userCardInfo.idcard}"/></td>
					</tr>
					<c:if test="${param_whtherPayType.pvalue!=1}">					
						<tr>						
						    <td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
							<td class="pn-fcontent"> 
						    	<select name="userCardInfo.feeRuleType" style="width:150px">
									<option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>��ѡ��</option>
									<c:forEach items="${listFeeRuleTypeDef}" var="item">
										<option value="${item.feeRuleType}" <c:if test="${userCardInfo.feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
									</c:forEach>  
								</select>
							</td>
							<td class="pn-flabel pn-flabel-h">�ƶ��绰��</td>						
							<td class="pn-fcontent">
								<input type="text" name="userCardInfo.mobileNumber"  value="${userCardInfo.mobileNumber}"/>
							</td>
						</tr>
					</c:if>
					<tr>						
						<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td class="pn-fcontent">
							<select name="userCardInfo.carType" style="width:150px" onchange="getCarSmallType()">
								<option value="" <c:if test="${userCardInfo.carType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listCarType}" var="item">
									<option value="${item.carType}" <c:if test="${userCardInfo.carType==item.carType}">selected</c:if>>${item.carTypeName}</option>
								</c:forEach>  
						</select>
						</td>
						 <td class="pn-flabel pn-flabel-h">ͣ&nbsp;��&nbsp;λ��</td>
					   	 <td class="pn-fcontent">
							<select name="userCardInfo.parkingSpace" id="parkingSpace" style="width:150px" >
								<option value=""  <c:if test="${userCardInfo.parkingSpace==null}">selected</c:if>>��ѡ��</option>
								<c:forEach items="${listCarSmallTypeInCarType}" var="CarSmallType">
									<option value="${CarSmallType.carSmallType}" 
									  <c:if test="${userCardInfo.parkingSpace==CarSmallType.carSmallType}">selected</c:if>>${CarSmallType.carSmallName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<td class="pn-flabel pn-flabel-h">������ݣ�</td>
						<td class="pn-fcontent">
							<select name="userCardInfo.ownerIdentity"  style="width:150px">
								<option value="">��ѡ��</option>
								<c:forEach items="${listIdentity}" var="identity">
									<option value="${identity.identityType}" <c:if test="${identity.identityType==userCardInfo.ownerIdentity}">selected</c:if> >${identity.identityName}</option>
								</c:forEach>
							</select>
						</td>
						<td class="pn-flabel pn-flabel-h"> </td>
						<td class="pn-flabel pn-flabel-h"> </td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit"   value=" �� ѯ " />&nbsp;
							<input type="button"  value=" ע�� "  onclick="register();"/> &nbsp;
							<input type="button" value=" �� �� " id="exprot"/>&nbsp;
							<input type="reset" value=" �� �� "/>
						</td>
					</tr>
				</table>
				<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
					<thead class="pn-lthead">
						<tr>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û����</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��״̬</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>	
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>						
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���֤����</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ƶ��绰</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ƺ���</th>						
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">OBU��</th>						
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û�����</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�ɷ�����</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ͣ��λ</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ͣ��λ���</th>
							<c:if test="${param_whtherPayType.pvalue!=1}">
								<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շ�����</th>
							</c:if>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ע��ʱ��</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�û�סַ</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
						</tr>
					</thead>
					<tbody class="pn-ltbody">
						<c:forEach items="${listUserCardInfo}" var="itemUserCardInfo">
							<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)"> 
								<td>${itemUserCardInfo.recNO}</td>
								<td>${itemUserCardInfo.cardNo}</td>	
								<td>
									<c:if test="${itemUserCardInfo.status==0}">����</c:if>
									<c:if test="${itemUserCardInfo.status==1}">��ʧ</c:if>
									<c:if test="${itemUserCardInfo.status==9}">δ�ɷ�</c:if>
								</td>						
								<td>${itemUserCardInfo.owner}</td>
								<td>
									<c:forEach items="${listIdentity}" var="identity">
										<c:if test="${itemUserCardInfo.ownerIdentity==identity.identityType}">${identity.identityName}</c:if>
									</c:forEach>
								</td>
								<td>${itemUserCardInfo.idcard}</td>
								<td>${itemUserCardInfo.mobileNumber}</td>
								<td>${itemUserCardInfo.vehPlate}</td>
								<td>${itemUserCardInfo.obu}</td>
								<td>
									<c:forEach items="${listUserCardType}" var="itemlistUserCardType">
										<c:if test="${itemUserCardInfo.userCardType==itemlistUserCardType.userCardType}">${itemlistUserCardType.typeName}</c:if>
									</c:forEach>
	                            </td>
	                            <td>
	                            	<fmt:formatDate value="${itemUserCardInfo.payEndTime}" pattern="yyyy-MM-dd" />
	                            </td>             
	                            <td>
									<c:forEach items="${listCarType}" var="itemlistCarType">
										<c:if test="${itemlistCarType.carType==itemUserCardInfo.carType}">${itemlistCarType.carTypeName}</c:if>
									</c:forEach>
								</td>
								<td>
									<c:forEach items="${listCarSmallType}" var="CarSmallType">
										<c:if test="${itemUserCardInfo.carType==CarSmallType.carType && itemUserCardInfo.parkingSpace==CarSmallType.carSmallType}">${CarSmallType.carSmallName}</c:if>
									</c:forEach>
								</td>
								<td>${itemUserCardInfo.parkingSpaceNo}</td>
	                            <c:if test="${param_whtherPayType.pvalue!=1}">
									<td>
										<c:forEach items="${listFeeRuleTypeDef}" var="itemFeeRuleTypeDef">
											<c:if test="${itemUserCardInfo.feeRuleType==itemFeeRuleTypeDef.feeRuleType}">${itemFeeRuleTypeDef.name}</c:if>
										</c:forEach>
									</td>					
								</c:if>
								<td>
									<fmt:formatDate value="${itemUserCardInfo.registerTime}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td >
									<input type="text"  value="${itemUserCardInfo.address}" size="20" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
								</td>
								<td style="white-space:nowrap;padding-left:5px;padding-right:5px;">
									<a href="javascript:userCardInfoList(${itemUserCardInfo.recNO},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
									��<a href="javascript:cancel('${itemUserCardInfo.cardNo}')" class="pn-loperator">ע��</a>
									��<a href="javascript:doPrint('${itemUserCardInfo.cardNo}')" class="pn-loperator">��ӡ</a>
								</td>                               
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<jsp:include page="../../../include/pager.jsp"/>
				
				<table id="idBox" class="lightbox">
					<tr>
						<th id="idBoxHead" align="left">��ѡ�񵼳��ֶ�</th>
					</tr>
					<tr>
						<td>&nbsp;
						<input name="all"  type="checkbox" id="all" value="checkAll" checked="checked" onclick="checkAll()"/>ȫѡ&nbsp;
						</td>
					</tr>
					<tr>
						<td>&nbsp;
							<input name="filed" type="checkbox" value="CardNO" checked="checked" onclick="check()"/>�������
						  	<input name="filed" type="checkbox" value="Status" checked="checked" onclick="check()"/>��״̬&nbsp;&nbsp;
						  	<input name="filed" type="checkbox" value="Owner" checked="checked" onclick="check()"/>��������
						  	<input name="filed" type="checkbox" value="OwnerIdentity" checked="checked" onclick="check()"/>�������
						  	<input name="filed" type="checkbox" value="IDCard" checked="checked" onclick="check()"/>���֤����
						  	<input name="filed" type="checkbox" value="MobileNumber" checked="checked" onclick="check()"/>�ƶ��绰
						  	<input name="filed" type="checkbox" value="VehPlate" checked="checked" onclick="check()"/>���ƺ�&nbsp;&nbsp;
						  	<input name="filed" type="checkbox" value="OBU" checked="checked" onclick="check()"/>obu��
						</td>
					</tr>
					<tr>
						<td>&nbsp;
						  	<input name="filed" type="checkbox" value="UserCardType" checked="checked" onclick="check()"/>�û�����
						  	<input name="filed" type="checkbox" value="PayEndTime" checked="checked" onclick="check()"/>�ɷ�����
						  	<input name="filed" type="checkbox" value="carType" checked="checked" onclick="check()"/>��������
						  	<input name="filed" type="checkbox" value="ParkingSpace" checked="checked" onclick="check()"/>ͣ��λ&nbsp;&nbsp;
						  	<input name="filed" type="checkbox" value="ParkingSpaceNo" checked="checked" onclick="check()"/>ͣ��λ���
						  	<input name="filed" type="checkbox" value="FeeRuleType" checked="checked" onclick="check()"/>�շ�����
						  	<input name="filed" type="checkbox" value="RegisterTime" checked="checked" onclick="check()"/>ע��ʱ��
						  	<input name="filed" type="checkbox" value="Address" checked="checked" onclick="check()"/>�û���ַ
						</td>
					</tr>
					<tr>
						<td align="center"><input name="" type="button" value=" ȷ �� " onclick="doExport()" />&nbsp;
						<input name="" type="button" value=" �� �� " id="idBoxCancel" /></td>
					</tr>
				</table>
				
				
			</form> 
		</div>
	</body>
</html>
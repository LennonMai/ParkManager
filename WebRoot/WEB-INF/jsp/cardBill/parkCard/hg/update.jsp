<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title></title>
		<%@include file="../../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
        <script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>	
       
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>					
		<script type="text/javascript">
			var isIE = false;
     		var isFF = false;
     		var isSa = false;
     		if((navigator.userAgent.indexOf("MSIE")>0) && (parseInt(navigator.appVersion) >=4))isIE = true;
     		if(navigator.userAgent.indexOf("Firefox")>0)isFF = true;
     		if(navigator.userAgent.indexOf("Safari")>0)isSa = true;
     		window.onload = function(){
     			var flag = ${userCardInfo.vehPlateImagePath!=null};
         		if(flag){
         			var mp=document.getElementsByName('isUseImage');
         			mp[0].checked=true;
         		}
         		
         		//控制月租卡类型的显示
         		var userCardType = ${userCardInfo.userCardType};
         		showDiv(userCardType);
     		}
     		function setIsUseImageNull(){
         		if((document.getElementsByName("userCardInfo.vehPlate")[0].value).trim()!=(document.getElementsByName("vehPlateHidden")[0].value).trim()){
         			var mp=document.getElementsByName('isUseImage');
         			mp[0].checked=false;
         		}
         		
     		}               
			window.onbeforeunload = function(){ //删除图片			 
					var valPath=(document.getElementsByName("path")[0].value).trim();
					 jQuery.ajax({type:"post",url:"parkCard_deleteImage.do?pathTemp="+valPath,async:false, success:function(data,textStatus){				    	   	
					     }
					     }); 
					 }   
			
			function check(){
				if((document.getElementsByName("userCardInfo.vehPlate")[0].value).trim()!=(document.getElementById('vehPlateHidden').value).trim()){
					if((document.getElementsByName("userCardInfo.vehPlate")[0].value).trim()!=""){			 
						var v="succuss";
						var val=(document.getElementsByName("userCardInfo.vehPlate")[0].value).trim();			  
					    jQuery.ajax({type:"post",url:"parkCard_getUserCardInfoByVehPlate.do?userCardInfo.vehPlate="+val,async:false, success:function(data,textStatus){	//同步提交，为了防止网络慢而提交多次验证不成功，插入相同的数据		    
					    	if(data=="fail") {
					    		v="fail";
					    		alert("此车牌已被注册."); 
					    	}			   
						}
						});	
						if(v=="fail") {
							document.getElementsByName("userCardInfo.vehPlate")[0].focus();
							return false;
						}
					}
				}

				if((document.getElementsByName("userCardInfo.cardNo")[0].value).trim()!=(document.getElementById('cardNo').value).trim()) {
					if(document.getElementsByName("userCardInfo.cardNo")[0].value!=""){
						var v1="succuss";
						var val=(document.getElementsByName("userCardInfo.cardNo")[0].value).trim();				   	
					    jQuery.ajax({type:"post",url:"parkCard_getUserCardInfoByCardNo.do?userCardInfo.cardNo=" +val,async:false, success:function(data,textStatus){		    
					    	if(data=="fail"){ 
					    		v1="No";
					    		alert("此卡已被运用。"); 
					    	}
					        if(data=="statusNoUse") { 
					        	v1="No";
					        	alert("该卡在卡信息中不是正常卡，不能运用"); 
					        }	
					        if(data=="secondUse") {
					        	v1="No";
					        	alert("该卡存在于储值卡黑名单中"); 
					        }
					        //if(data=="NoRegister"){alert("该卡还没进行登记，请开户成功后进行登记使用"); }				   
						}
						});
						if(v1=="No") {
							document.getElementsByName("userCardInfo.cardNo")[0].focus();
							return false;
						}				 
					} 
				}
			}	

			function getImage(obj){
				document.getElementById('srcPath').value = "";
				if(isIE)
         		{
            		var url = obj.value;
            		url = " file:///" + url.replace("\\",'/');
            	}
				else if(isFF)
         		{
             		var url = obj.files.item(0).getAsDataURL();
         		}
				document.getElementById('file').src=url;
				document.getElementById('userCardInfo.vehPlateImagePath').value=url;
			}
			function getFeeRuleTypeDef(){
				 var userCardType=document.getElementsByName("userCardInfo.userCardType")[0].value;
					$.ajax({
						type:"post",
						url:"parkCard_ajaxFeeRuleTypeDefByUserCardType.do?userCardInfo.userCardType="+userCardType,
						success:function(res){
							$("#feeRuleType").empty();
							$(res).find("feeRuleTypeDefs > feeRuleTypeDef").each(function(){								
							var op = $("<option value=" + $(this).attr("feeRuleType") + ">" 
									+ $(this).attr("name") + "</option>");
							$("#feeRuleType").append(op);	
						});
						}
					});
				}
			//显示查询图片时间段
			function showSearchTime(){
				document.getElementById('searchTime').style.display='';
			}
			//检查搜索时间，符合条件的话就提交，否则提示错误
			function checkSearch(){
				var startTime = document.getElementById('startTime').value;
				var endTime = document.getElementById('endTime').value;
				var vehPlate = document.getElementById('vehPlate').value;
				if(startTime == ""){
					alert("开始时间不能为空！");
					return false;
				}
				if(endTime == ""){
					alert("结束时间不能为空！");
					return false;
				}
				if(startTime > endTime){
					alert("开始时间不能大于结束时间！");
					return false;
				}
				var months = compTime(startTime,endTime);
				if(months > 3){
					alert("时间间隔不能超过3个月！");
					return false;
				}
				if(vehPlate == ""){
					alert("车牌号不能为空！");
					return false;
				}
				document.getElementById('waiting').style.display='';
				$.ajax({
					type:"post",
					url:"parkCard_ajaxQueryImage.do?startTime="+startTime+"&endTime="+endTime+"&vehPlate="+encodeURI(encodeURI(vehPlate)),
					success:function(res,status){
						document.getElementById('waiting').style.display='none';
						$("#showImag").empty();
						$(res).find("images > image").each(function(){
							var op =$("<a class='pn-loperator' href=\"javascript:selectFile('"+ $(this).attr("imgSrc") +"')\">"+$(this).attr("name")+"</a><br>");
							$("#showImag").append(op);
						});
					}
				});
			}
			//计算月期差
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
			//点击显示图片
			function selectFile(f){
				$("#myFile").remove();
				$("#upFile").append("<input id='myFile' type='file' name='myFile' class='jpg' onchange='getImage(this);'/>"); 
				document.getElementById('userCardInfo.vehPlateImagePath').value="";
				document.getElementById('srcPath').value=f;
				document.getElementById('file').src="lostCard_readImg.do?imagSrc="+f;
			}
			function returnBack(){
				window.location.href = "parkCard_queryParkCardToManage.do";
			}

			function showDiv(val){
				//如果是有区分月租卡类型，但又选了业主卡，则隐藏月租类型选框
				
				var isDisFlag = ${param_isDis.pvalue==1};
				if(isDisFlag){
					if(val == 14){
						document.getElementById('disTr').style.display='';
					}else{
						document.getElementById('disTr').style.display='none';
					}
				}
			}
			
			function getCarSmallType(){
				var carType = document.getElementsByName("userCardInfo.carType")[0].value; 
				$.ajax({
					type:"post",
					url:"parkCard_findCarSmallType.do?carType="+carType,
					success:function(res){
						$("#parkingSpace").empty();
						var op = $("<option value=''>请选择</option>");		
						$("#parkingSpace").append(op);
						$(res).find("CarSmallTypes > CarSmallType").each(function(){
							var o = $("<option value="+$(this).attr("id") +">"
									+$(this).attr("name")+"</option>");
							$("#parkingSpace").append(o);
						});
					}
				});
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<table width="1100" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				<tr>
					<td class="pn-fcontent" width="871">
						<form id="dataform" method="post" enctype="multipart/form-data" action="parkCard_update.do" onsubmit="return check();">  				   
							<table width="871" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" height="345">					 					
								<tr>
								  <td class="pn-flabel pn-flabel-h">用户编号：</td>
								  <td   colspan="3" class="pn-fcontent"><input type="text" name="userCardInfo.recNO" value="${userCardInfo.recNO}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>					   				 
								  
								</tr>
								<tr>
								  <td class="pn-flabel pn-flabel-h">车主姓名：</td>
								  <td   class="pn-fcontent"><input type="text" name="userCardInfo.owner" value="${userCardInfo.owner}" class="required maxlengthThirtyTwo"/>&nbsp;<font style="color:red">*</font></td>
								    <td class="pn-flabel pn-flabel-h">身份证号：</td>
								     <td   class="pn-fcontent"><input type="text" name="userCardInfo.idcard" value="${userCardInfo.idcard}" class="maxlengthTwenty"/></td>
								 
								</tr>
								
								<tr>
									<td class="pn-flabel pn-flabel-h">车主身份：</td>
									<td class="pn-fcontent">
										<select name="userCardInfo.ownerIdentity"  style="width:150px" class="required" >
											<option value="">请选择</option>
											<c:forEach items="${listIdentity}" var="identity">
												<option value="${identity.identityType}" <c:if test="${identity.identityType==userCardInfo.ownerIdentity}">selected</c:if> >${identity.identityName}</option>
											</c:forEach>
										</select><font style="color:red">*</font>
									</td>
									 <td class="pn-flabel pn-flabel-h">联&nbsp;系&nbsp;人：</td>
								    <td  class="pn-fcontent"><input type="text" name="userCardInfo.linkMan"  value="${userCardInfo.linkMan}" class="maxlengthTwenty"/></td>
								</tr>
								<tr>
								   <td class="pn-flabel pn-flabel-h">固定号码：</td>
								   <td class="pn-fcontent"><input type="text" name="userCardInfo.telePhone" value="${userCardInfo.telePhone}" class="maxlengthTwenty"/></td>
								   <td class="pn-flabel pn-flabel-h">移动电话：</td>
								   <td class="pn-fcontent"><input type="text" name="userCardInfo.mobileNumber" value="${userCardInfo.mobileNumber}" class="maxlengthTwenty"/></td>
								</tr>
								<tr>
								  <td class="pn-flabel pn-flabel-h">车&nbsp;辆&nbsp;类&nbsp;型</td>
					   				<td  class="pn-fcontent">
					  					<select name="userCardInfo.carType" style="width:150px" class="required" onchange="getCarSmallType()">
											<option value="" <c:if test="${userCardInfo.carType==null}">selected</c:if>>请选择</option>
							    			<c:forEach items="${listCarType}" var="item">
											<option value="${item.carType}" <c:if test="${userCardInfo.carType==item.carType}">selected</c:if>>${item.carTypeName}</option>
							   				</c:forEach>  
										</select>&nbsp;<font style="color:red">*</font>
									</td>
								   <td class="pn-flabel pn-flabel-h">停&nbsp;车&nbsp;位：</td>
								   <td class="pn-fcontent">
								   		<select name="userCardInfo.parkingSpace" id="parkingSpace" style="width:150px" >
								   			<option value=""  <c:if test="${userCardInfo.parkingSpace==null}">selected</c:if>>请选择</option>
								   			<c:forEach items="${listCarSmallType}" var="CarSmallType">
								   				<option value="${CarSmallType.carSmallType}" 
								   				<c:if test="${userCardInfo.parkingSpace==CarSmallType.carSmallType}">selected</c:if>>${CarSmallType.carSmallName}</option>
								   			</c:forEach>
								   		</select>
								   </td>
								</tr>
								<tr>
									<td class="pn-flabel pn-flabel-h">停车位编号：</td>
					    			<td  class="pn-fcontent"><input type="text" name="userCardInfo.parkingSpaceNo" value="${userCardInfo.parkingSpaceNo}"  class="maxlengthTwenty"/></td>
								   
								    <td class="pn-flabel pn-flabel-h">押&nbsp;&nbsp;&nbsp;&nbsp;金：</td>
								    <td  class="pn-fcontent"><input type="text" name="userCardInfo.deposit" value="${userCardInfo.deposit}" class="required number isNo_NotOverValueInt"/>&nbsp;<font style="color:red">*</font></td> 
								</tr>
								<tr>
								    <td class="pn-flabel pn-flabel-h">用户住址：</td>
					     			<td class="pn-fcontent"><input type="text" name="userCardInfo.address"  class="maxlength255"/></td>
					     			 <td class="pn-flabel pn-flabel-h">用户房号：</td>
								   <td class="pn-fcontent"><input type="text" name="userCardInfo.roomNo" value="${userCardInfo.roomNo}" class="maxlengthTwenty"/></td>
					     			
								</tr>
								
								<tr>
								 <td class="pn-flabel pn-flabel-h">卡表面号：</td>
								    <td class="pn-fcontent">
								    	<input type="text" name="userCardInfo.cardNo" value="${userCardInfo.cardNo}" class="required numberDeleteNull cardNomaxlength20"/>&nbsp;<font style="color:red">*</font>
								    </td>
								    <td class="pn-flabel pn-flabel-h">OBU&nbsp;&nbsp;&nbsp;号：</td>
								    <td class="pn-fcontent"><input type="text" name="userCardInfo.obu" value="${userCardInfo.obu}" class="maxlength16" /></td>					  
								</tr>
						
								<tr>
								  <td class="pn-flabel pn-flabel-h">车&nbsp;牌&nbsp;号：</td>
								  <td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate" id="vehPlate" value="${userCardInfo.vehPlate}" class="required maxlengthTen" onkeyup="setIsUseImageNull();"/>&nbsp;<font style="color:red">*</font></td>
								  <td class="pn-flabel pn-flabel-h">车辆品牌：</td>
								  <td class="pn-fcontent"><input type="text" name="userCardInfo.vehBrand" value="${userCardInfo.vehBrand}" class="maxlengthSixteen"/></td>					  
								</tr>
								<!-- 判断是否为缴费类型 0:需要缴费 1：不需要； 默认值 为0-->	
								<!-- 缴费类型为0 即需要缴费  start-->
							    <c:if test="${param_whtherPayType.pvalue!=1}">
							    <tr>
							        <td class="pn-flabel pn-flabel-h">用户类型：</td>
								    <td  class="pn-fcontent">
								    <select name="userCardInfo.userCardType" style="width:150px" class="required" onchange="showDiv(this.value);">
								       <option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>请选择</option>
							           <!-- listUserCardType 中 不含 1，2，3 类型 -->
							           <c:forEach items="${listUserCardType}" var="item">
								         <option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							          </c:forEach>  
						           </select>&nbsp;
									 <%--<select name="userCardInfo.userCardType" style="width:150px" onchange="getFeeRuleTypeDef();" class="required" >
											<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>请选择</option>
										    <c:forEach items="${listUserCardFeeRuleType}" var="item">
											<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
										   </c:forEach>  
									 </select>&nbsp;--%>
									 <font style="color:red">*</font>
									</td>
									
								 <td class="pn-flabel pn-flabel-h">收费类型：</td>					  
								   <td  class="pn-fcontent">
								   <select name="userCardInfo.feeRuleType" style="width:150px" class="required">
								    <option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>请选择</option>
							        <c:forEach items="${listFeeRuleTypeDef}" var="item">
								      <option value="${item.feeRuleType}" <c:if test="${userCardInfo.feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
							        </c:forEach>  
						          </select>&nbsp;
								   <%--
								    <select id ="feeRuleType" name="userCardInfo.feeRuleType" style="width:150px" class="required" >
										    <c:forEach items="${listFeeRuleTypeDef}" var="item">
											<option value="${item.feeRuleType}" <c:if test="${userCardInfo.feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
										   </c:forEach>  
									</select>&nbsp;--%>
									<font style="color:red">*</font>
									</td>
								</tr>
								<tr>				 
								   <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
								   <td  colspan="3" class="pn-fcontent"><input type="text"  size="62" name="userCardInfo.remark"  value="${userCardInfo.remark}" class="maxlengthForty"/></td>
							  	</tr>
								</c:if>
								<!-- 缴费类型为0 即需要缴费  end-->
								<!-- 缴费类型为1 即不需要缴费  start-->
								<c:if test="${param_whtherPayType.pvalue==1}">
								<tr>
								<td class="pn-flabel pn-flabel-h">用户类型：</td>
								  <td  class="pn-fcontent">
									<select name="userCardInfo.userCardType" style="width:150px"  class="required" onchange="showDiv(this.value);">
											<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>请选择</option>
										    <c:forEach items="${listUserCardType}" var="item">
											<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
										   </c:forEach>  
									</select>&nbsp;<font style="color:red">*</font>
									</td>
									 <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
								    <td  class="pn-fcontent"><input type="text" name="userCardInfo.remark" value="${userCardInfo.remark}" class="maxlengthForty"/></td>				   
								 </tr>
								 </c:if>				  
							  	<!-- 缴费类型为1 即不需要缴费  end-->
					
				  				<!-- 月租卡是否区分为业主月租卡和非业主月租卡 0不区分 1区分 -->
							   <c:if test="${param_isDis.pvalue==1}">
				 				<tr id="disTr"  >
							  		<td class="pn-flabel pn-flabel-h">月租卡类型</td>
					 		 		<td   class="pn-fcontent" colspan="3">
					 			 		<input type="radio" name="userCardInfo.feeCardType"  value='0' 
							 			 <c:if test="${userCardInfo.feeCardType==0}">checked="checked"</c:if>
							 			 />业主月租卡&nbsp;
						 				<input type="radio" name="userCardInfo.feeCardType" 
						 				<c:if test="${userCardInfo.feeCardType==1}">checked="checked"</c:if>
						 				 value='1'/>非业主月租卡&nbsp;<font style="color:red">*</font></td>
								 </tr>
							 </c:if>
							  <tr>				 
								   <td class="pn-flabel pn-flabel-h">图片设置：</td>
								   		<td  class="pn-fcontent" align="center">
								   		<span id="upFile">
								   			<input id="myFile" type="file" name="myFile" class="jpg" onchange="getImage(this);"/>
								   		</span>
								   		<br/>
								   		<input type="text" name="srcPath" id="srcPath" value="" style="display: none"/>
								   		<br/>
								   		<input type="checkbox" id="isUseImage" name="isUseImage" value="1"/>是否使用该显示图片							   		
								   		<br/>
								   		<br/>
								   		<br/>
								   		<input type="button" value="查询图片" onclick="showSearchTime();"/>
								   		</td>
							       		<td class="pn-flabel pn-flabel-h"></td>
								  <c:choose> 
			                      	<c:when test="${userCardInfo.vehPlateImagePath==null}"> 
			                        	<td  class="pn-fcontent"><img id="file" src="${basePath}/image/parkCard.jpg" width="355" height="280"/></td>
			                        </c:when> 
			                        <c:otherwise> 
			                        	<td  class="pn-fcontent">
			                            	<img id="file" src="${basePath}/image/${userCardInfo.vehPlateImagePath}" width="355" height="280"/> 
			                            </td>
			                        </c:otherwise> 
			                     </c:choose>		
							  </tr>
							  <tr>				 
								   <td style="height:0px;" class="pn-flabel pn-flabel-h"></td>
								   <td style="height:0px;" class="pn-fcontent"><input id="vehPlateHidden" type="hidden" name="vehPlateHidden" value="${userCardInfo.vehPlate}"/></td>
								   <td style="height:0px;" class="pn-flabel pn-flabel-h"></td>
								   <td style="height:0px;" class="pn-fcontent"><input id="cardNo" type="hidden" name="cardNo" value="${userCardInfo.cardNo}"/></td>
							  </tr>				 									
							  <tr>
									<td colspan="4" class="pn-fbutton">
										<input type="submit" value=" 保 存 "/> &nbsp;
										<input type="reset" value=" 重 置 "/> &nbsp;
										<input type="button" value=" 返 回 " onclick="returnBack();"/>
										<input id="path" type="hidden" name="path"  value="${userCardInfo.vehPlateImagePath}"/>
										<input id="userCardInfo.vehPlateImagePath" type="hidden" name="userCardInfo.vehPlateImagePath"  value=""/>
										<input type="hidden" name="param_userCardInfoCardNoLength.pvalue" value="${param_userCardInfoCardNoLength.pvalue}"/>
										<input type="hidden" name="pager.pageSize" value="${pager.pageSize}" />
										<input type="hidden" name="pager.currentPage" value="${pager.currentPage }" />
									</td>
								</tr>
							</table>
						</form>
					</td>
					<td class="pn-fcontent" width="400" valign="top" align="center">
						<table class="pn-ftable" cellpadding="2" cellspacing="1" border="0" id="searchTime" style="display: none;" width="100%">
							<tr>
								<td class="pn-fcontent" nowrap>
									<div >
										时间段：<input type="text" name="startTime" id="startTime" class="Wdate" size="12" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
										-- <input type="text" name="endTime" id="endTime" class="Wdate" size="12" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
										&nbsp;&nbsp;<input type="button" value="搜索" onclick="checkSearch();"/>
										<label id="waiting" style="display: none"> 
											<br/><br/><font color="red">正在搜索中...</font>
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td class="pn-fcontent">
									<label id="showImag" style="font-size: 18px">
									</label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>

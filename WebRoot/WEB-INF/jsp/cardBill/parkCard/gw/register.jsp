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
			     
              
				
				//window.onbeforeunload = function(){ //ɾ��ͼƬ			 
					//var valPath=(document.getElementsByName("path")[0].value).trim();
					 //jQuery.ajax({type:"post",url:"parkCard_deleteImage.do?pathTemp="+valPath,async:false, success:function(data,textStatus){				    	   	
					    // }
					    // }); 
					 //}     
		
			function check(){			   		
			if((document.getElementsByName("userCardInfo.vehPlate")[0].value).trim()!=""){			 
				var v="succuss";
				var val=(document.getElementsByName("userCardInfo.vehPlate")[0].value).trim();			  
			    jQuery.ajax({type:"post",url:"parkCard_getUserCardInfoByVehPlate.do?userCardInfo.vehPlate="+val,async:true, success:function(data,textStatus){//ͬ���ύ��Ϊ�˷�ֹ���������ύ�����֤���ɹ���������ͬ������		    
			    if(data=="fail"){v="fail";alert("�˳����ѱ�ע��."); }			   
				 }
				 });				 					 
				 if(v=="fail"){document.getElementsByName("userCardInfo.vehPlate")[0].focus();return false;}
				 }				 
			if(document.getElementsByName("userCardInfo.cardNo")[0].value!=""){
			     var v1="succuss";
			     var val=(document.getElementsByName("userCardInfo.cardNo")[0].value).trim();				   	
		        jQuery.ajax({type:"post",url:"parkCard_getUserCardInfoByCardNo.do?userCardInfo.cardNo=" +val,async:true, success:function(data,textStatus){		    
		        if(data=="fail"){v1="No";alert("�˿��ѱ����á�"); }
		        if(data=="statusNoUse"){v1="No";alert("�ÿ��ڿ���Ϣ�в�������������������"); }	
		        if(data=="secondUse"){alert("�ÿ������ڴ�ֵ����������"); }
		        //if(data=="NoRegister"){alert("�ÿ���û���еǼǣ��뿪���ɹ�����еǼ�ʹ��"); }				   
			     }
			     });
			    		 					 
			   if(v1=="No"){document.getElementsByName("userCardInfo.cardNo")[0].focus();return false;}				 
		          }	
		}
	       //function setImage(){	
	    	   //var valPath=(document.getElementsByName("path")[0].value).trim();
	    	   //var val=(document.getElementsByName("userCardInfo.vehPlateImagePath")[0].value).trim();	
	    	
	    		  // jQuery.ajax({type:"post",url:"parkCard_setImage.do?userCardInfo.vehPlateImagePath=" +val+"&pathTemp="+valPath,async:false, success:function(data,textStatus){	    	
					      //document.getElementById("file").src="";
				    	   //document.getElementById("file").src="${basePath}/image/"+data;
				    	   //document.getElementById("path").value="";
				    	   //document.getElementById("path").value=data;
				    	   	
					     //}
					     //}); 	   		   
	       //}
			
			function getImage(obj){
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
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" enctype="multipart/form-data" action="parkCard_save.do" onsubmit="return check();">  				   
				<table width="871" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" height="345">					 					
					<tr>
					  <td class="pn-flabel pn-flabel-h">����������</td>
					  <td   class="pn-fcontent"><input type="text" name="userCardInfo.owner"  class="required maxlengthThirtyTwo" />&nbsp;<font style="color:red">*</font></td>
					    <td class="pn-flabel pn-flabel-h">���֤�ţ�</td>
					     <td   class="pn-fcontent"><input type="text" name="userCardInfo.idcard"  class="maxlengthTwenty"/></td>
					 
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">�̶��绰��</td>
					   <td class="pn-fcontent"><input type="text" name="userCardInfo.telePhone"  class="maxlengthTwenty"/></td>
					   <td class="pn-flabel pn-flabel-h">�ƶ��绰��</td>
					   <td class="pn-fcontent"><input type="text" name="userCardInfo.mobileNumber" class="maxlengthTwenty"/></td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">�û����ţ�</td>
					   <td class="pn-fcontent"><input type="text" name="userCardInfo.roomNo" class="maxlengthTwenty"/></td>
					   <td class="pn-flabel pn-flabel-h">ͣ&nbsp;��&nbsp;λ��</td>
					   <td class="pn-fcontent"><input type="text" name="userCardInfo.parkingSpace" class="maxlengthFifty"/></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">�̹�������</td>
					    <td  class="pn-fcontent"><input type="text" name="staff.staffName"  class="staff.staffName"/></td>
					    <td class="pn-flabel pn-flabel-h">�̹�������ϵ��</td>
					    <td class="pn-fcontent"><input type="text" name="staff.relation"  class="maxlengthThirtyTwo"/></td>				   
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">�̹���λ��</td>
					     <td colspan="3" class="pn-fcontent"><input type="text" name="staff.staffAddress"  size="73" class="maxlength255"/></td>
					</tr>
					
					<tr>
					 <td class="pn-flabel pn-flabel-h">������ţ�</td>
					    <td class="pn-fcontent">
					    <c:if test="${param_userCardInfoCardNoLength.pvalue==10}">
					    <input type="text" name="userCardInfo.cardNo" class="required numberDeleteNull cardNomaxlengthTem"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==9}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForNine"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==8}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForEight"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==7}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForSeven"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==6}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForSix"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==5}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForFive"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==4}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForFour"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==3}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForThree"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==2}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForTwo"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					     <c:if test="${param_userCardInfoCardNoLength.pvalue==1}">
					     <input type="text" name="userCardInfo.cardNo" class="required digitForOne"/>&nbsp;<font style="color:red">*</font>
					    </c:if>
					    </td>
					    <td class="pn-flabel pn-flabel-h">OBU&nbsp;&nbsp;&nbsp;�ţ�</td>
					    <td class="pn-fcontent"><input type="text" name="userCardInfo.obu" class="maxlengthTen"/></td>			  
					</tr>
			
					<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="userCardInfo.vehPlate" class="required maxlengthTen"/>&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">����Ʒ�ƣ�</td>
					  <td class="pn-fcontent"><input type="text" name="userCardInfo.vehBrand" class="maxlengthSixteen"/></td>					  			  
					</tr>
					<tr>				  
				      <td class="pn-flabel pn-flabel-h">Ѻ&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				      <td class="pn-fcontent"><input type="text" name="userCardInfo.deposit" value="0" class="required number isNo_NotOverValueInt"/>&nbsp;<font style="color:red">*</font></td>				   
				      <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
				      <td  class="pn-fcontent"><input type="text"  name="userCardInfo.remark"  class="maxlengthForty"/></td>
				  </tr>
					<tr>					
					<c:if test="${param_whtherPayType.pvalue!=1}">
					<td class="pn-flabel pn-flabel-h">�û����ͣ�</td>
					  <td  class="pn-fcontent">
						<select name="userCardInfo.userCardType" style="width:150px"  class="required" >
								<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listUserCardType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>&nbsp;<font style="color:red">*</font>
						</td>
					  <td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>					  
					   <td  class="pn-fcontent">
					  <select id ="feeRuleType" name="userCardInfo.feeRuleType" style="width:150px" class="required" >
					            <option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listFeeRuleTypeDef}" var="item">
								<option value="${item.feeRuleType}" <c:if test="${userCardInfo.feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
							   </c:forEach>  
								<%--<option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listFeeRuleTypeDef}" var="item">
								<option value="${item.feeRuleType}" <c:if test="${userCardInfo.feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
							   </c:forEach>  
						--%></select>&nbsp;<font style="color:red">*</font>
						</td>					   
					  </c:if>
					 <c:if test="${param_whtherPayType.pvalue==1}">
					<td class="pn-flabel pn-flabel-h">�û����ͣ�</td>
					  <td  colspan="3" class="pn-fcontent">
						<select name="userCardInfo.userCardType" style="width:150px"  class="required" >
								<option value="" <c:if test="${userCardInfo.userCardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${listUserCardType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userCardInfo.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>&nbsp;<font style="color:red">*</font>
						</td>				   
					  </c:if>
				  </tr>				  
				  
				   <tr>				 
					   <td class="pn-flabel pn-flabel-h">����ͼƬ��</td>
					   <td  class="pn-fcontent"><input id="myFile"   type="file" name="myFile" class="jpg" onchange="getImage(this);"/></td>
				        <td  class="pn-flabel pn-flabel-h"></td>
				         
				           
				      <%--   <c:choose> 
                            <c:when test="${userCardInfo.vehPlateImagePath==null}"> 
                              <td  class="pn-fcontent"><img id="file" src="${basePath}/image/parkCard.jpg" width="225" height="225"/></td>
                             </c:when>                            
                             <c:otherwise>                              
                              <td  class="pn-fcontent"><img id="file1" src="${basePath}/image/VehPlateImage.jpg" width="225" height="225"/>                                                                                                   
                              </td>
                             </c:otherwise> 
                               </c:choose>	--%>	 
                        <td  class="pn-fcontent"><img id="file" src="${basePath}/image/parkCard.jpg" width="355" height="280"/>       					   
				 </tr>
				  
					
					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� �� "/> &nbsp;
						<input type="reset" value=" �� �� "/>&nbsp;
						<input type="button" value=" �� �� " onclick="history.back();"/>
							<input id="userCardInfo.vehPlateImagePath" type="hidden" name="userCardInfo.vehPlateImagePath"  value=""/>
							<input type="hidden" name="param_userCardInfoCardNoLength.pvalue" value="${param_userCardInfoCardNoLength.pvalue}"/>
						</td>
					</tr>					
					</table>
					
			</form>
		</div>
	</body>
</html>

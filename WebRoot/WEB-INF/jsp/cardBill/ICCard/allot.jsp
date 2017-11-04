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
		if ("${result}" == "SUCCESS")
			alert("调拨成功");	
			function check(){
				
				if((document.getElementsByName("ICCardStorageLeft.position")[0].value).trim()==""){
					alert("出库地点不能为空，请选择.");
					return false;
				}
				if((document.getElementsByName("ICCardStorageRight.position")[0].value).trim()==""){
					alert("入库地点不能为空，请选择.");
					return false;
				}
				if((document.getElementsByName("ICCardStorageRight.position")[0].value).trim()==(document.getElementsByName("ICCardStorageLeft.position")[0].value).trim()){
					alert("出库地点和入库地点不能相同，请重新选择.");
					return false;
				}
				<%--if((document.getElementsByName("ICCardStorageTemp.amount")[0].value).trim()==""){
					alert("调拨数量不能为空，请输入调拨数量.");
					document.getElementsByName("ICCardStorageTemp.amount")[0].focus();
					return false;
				} else {
				    var partten=/^[1-9]\d*$/;
				    if(partten.test((document.getElementsByName("ICCardStorageTemp.amount")[0].value).trim())){
				    }else{
				     alert("调拨数量只能是正整数（例如1，或者50），请重新输入.");
				     document.getElementsByName("ICCardStorageTemp.amount")[0].focus();
					 return false;
				    }
				}
				
				if((document.getElementsByName("id")[0].value).trim()==""){
					alert("经手人不能为空，请选择.");
					document.getElementsByName("id")[0].focus();
					return false;
				}
					if(Len((document.getElementsByName("ICCardTransferTemp.remark")[0].value).trim())>40){
					alert("备注长度不能大于40个（一个汉字算两个）");
					document.getElementsByName("ICCardTransferTemp.remark")[0].focus();
					return false;
				}--%>
				if((document.getElementsByName("ICCardStorageTemp.amount")[0].value).trim()!=""){		 
				var v="succuss";
				var valPosition=(document.getElementsByName("ICCardStorageLeft.position")[0].value).trim();
				var valAmount=(document.getElementsByName("ICCardStorageTemp.amount")[0].value).trim();
			    jQuery.ajax({type:"post",url:"iCCard_getAmount.do?ICCardStorageLeft.position="+valPosition+"&ICCardStorageTemp.amount="+valAmount,async:false, success:function(data,textStatus){			    
			    if(data=="fail"){v="fail";alert("调拨数量大于库存数量，请重新输入调拨数量."); }			   
				 }
				 });				 					 
				 if(v=="fail"){document.getElementsByName("ICCardStorageTemp.amount")[0].focus();return false;}
				 }

               }	
				
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <form id="dataform" method="post" action="iCCard_allotEdit.do" onsubmit="return check();">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="580" class="pn-ftable"  border="0" bordercolor="black" cellspacing="0" rules="none"height="120" >			
					<tr>
					  <td  class="pn-fcontent"><font size=3>出库地点:</font></td>
					  <td   class="pn-fcontent"></td>
					   <td   class="pn-fcontent"></td>
					  <td  class="pn-fcontent"><font size=3>入库地点:</font></td>	  
					</tr>
					<tr>
					<td   class="pn-fcontent"> 					 
						  <select name="ICCardStorageLeft.position" style="width:250px" size="15" >
						  <option value="${ICCardStoragePosition.position}">管理中心(${ICCardStoragePosition.amount})</option>
						   <c:forEach items="${list}" var="item">
								<option value="${item[0].position}">${item[1].gateName}(${item[0].amount})</option>
							 </c:forEach>   
							</select>								 
						</td>
						
					 <td   class="pn-fcontent" align="right"><font size=6 color="red" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt;</font></td>  
					  <td   class="pn-fcontent">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td   class="pn-fcontent"> 					 
						  <select name="ICCardStorageRight.position" style="width:250px" size="15">
						   <option value="${ICCardStoragePosition.position}">管理中心(${ICCardStoragePosition.amount})</option>
						   <c:forEach items="${list}" var="item">
								<option value="${item[0].position}">${item[1].gateName}(${item[0].amount})</option>
							 </c:forEach>    
							</select>								 
						</td>
					</tr>
					<tr>
					 <td   class="pn-fcontent"></td>
					  <td   class="pn-fcontent"></td>
					   <td   class="pn-fcontent"></td>
					    <td   class="pn-fcontent"></td>
					</tr>
					<tr>
					 <td   class="pn-fcontent"></td>
					  <td   class="pn-fcontent"></td>
					   <td   class="pn-fcontent"></td>
					    <td   class="pn-fcontent"></td>
					</tr>
					<tr>
					<td colspan="4" class="pn-fcontent">调拨数量：
					  <input type="text" name="ICCardStorageTemp.amount"   class="required positiveInteger max2147483647"/>&nbsp;<font style="color:red">*</font></td>
					 </tr>
					 <tr>
					  <td colspan="4" class="pn-fcontent">经&nbsp;手&nbsp;人：
					  <select name="id" style="width:150px" class="required">
							<option value="">请选择</option>
							<c:forEach items="${listTemp}" var="itemTemp">
							<option value="${itemTemp.operatorNo}">${itemTemp.operatorName}</option>
							 </c:forEach>  
						</select>&nbsp;<font style="color:red">*</font>
					</td>
					</tr>
				
					<tr>
					<td colspan="4" class="pn-fcontent">备&nbsp;&nbsp;&nbsp;&nbsp;注：
					  <textarea rows='2' cols='54' name="ICCardTransferTemp.remark" class="maxlengthForty"></textarea></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" &nbsp;确定 &nbsp;" /> &nbsp;
						<input type="reset" value=" &nbsp;取消&nbsp; "/></td>
					</tr>
					 </table>
					
			</form>
		</div>
	</body>
</html>

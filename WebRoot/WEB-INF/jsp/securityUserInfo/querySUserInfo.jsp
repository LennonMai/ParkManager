<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript">
			if("${message}"=="0"){
				alert("注册失败");
			}
			if("${message}"=="1"){
				alert("注册成功");
			}
			if("${message}"=="3"){
				alert("更新失败");
			}
			if("${message}"=="4"){
				alert("更新成功");
			}
			if("${message}"=="5"){
				alert("删除成功");
			}
			if("${message}"=="6"){
				alert("删除成功");
			}
			function del(id,sizes,crrPage){
				if(confirm("确认要删除吗？")){
					window.location.href = "securityUserInfo_delete.do?regId="+id+"&pager.pageSize="+sizes+"&pager.currentPage="+crrPage;
				}
			}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
			}
			function toUpdate(regId,pageSize,currentPage) {														
				window.location = "securityUserInfo_toUpdate.do?regId="+regId+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;		
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
			<form name="tableForm" method="post" action="securityUserInfo_querySecurityUserInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">用户姓名：</td>
						<td class="pn-fcontent">
						  <input type="text" name="owner" value="${owner}" />
						</td>
						<td class="pn-flabel pn-flabel-h">身份证号：</td>
						<td class="pn-fcontent">
						  <input type="text" name="IDCard" value="${IDCard}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">车&nbsp;牌&nbsp;号：</td>
						<td class="pn-fcontent">
						  <input type="text" name="vehPlate" value="${vehPlate}" />
						</td>
						<td class="pn-flabel pn-flabel-h">O&nbsp;B&nbsp;U&nbsp;号：</td>
						<td class="pn-fcontent">
						  <input type="text" name="OBU" value="${OBU}" />
						</td>
					</tr>
					<tr>
					<td  class="pn-flabel pn-flabel-h">用户类型：</td>
						<td  class="pn-fcontent">
						<select name="userType" style="width:150px">
								<option value="" <c:if test="${userType==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listUserCardFeeRuleType}" var="item">
								<option value="${item.userCardType}" <c:if test="${userType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach>  
						</select>
						</td>
						<td class="pn-flabel pn-flabel-h">卡表面号：</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNO" value="${cardNO}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">卡&nbsp;状&nbsp;态：</td>
						<td class="pn-fcontent">
							<select name="status" style="width:150px">
								<option value="" <c:if test="${status==null}">selected</c:if>>-请选择-</option>
								<option value="0" <c:if test="${status==0}">selected</c:if>>正常</option>
								<option value="1" <c:if test="${status==1}">selected</c:if>>挂失</option>
								<option value="9" <c:if test="${status==9}">selected</c:if>>未缴费</option>
							</select>
						</td>
						<c:if test="${param_whtherPayType.pvalue!=1}">							
						    <td class="pn-flabel pn-flabel-h">收费类型：</td>
							<td class="pn-fcontent"> 
						    	<select name="feeRuleType" style="width:150px">
									<option value="" <c:if test="${userCardInfo.feeRuleType==null}">selected</c:if>>请选择</option>
								    	<c:forEach items="${listFeeRuleTypeDef}" var="item">
											<option value="${item.feeRuleType}" <c:if test="${feeRuleType==item.feeRuleType}">selected</c:if>>${item.name}</option>
								   		</c:forEach>  
								</select>
							</td>
						</c:if>
						<c:if test="${param_whtherPayType.pvalue == 1}">
							<td class="pn-flabel pn-flabel-h">是否已注册</td>
							 <td class="pn-fcontent">
								<select name="whtherRegister" style="width:150px">
									<option value="" <c:if test="${whtherRegister==null}">selected</c:if>>-请选择-</option>
									<option value="0" <c:if test="${whtherRegister==0}">selected</c:if>>已注册</option>
									<option value="1" <c:if test="${whtherRegister==1}">selected</c:if>>末注册</option>
								</select>
							</td>
						</c:if>
					</tr>
					<c:if test="${param_whtherPayType.pvalue!=1}">
						<tr>
							 <td class="pn-flabel pn-flabel-h">是否已注册</td>
							 <td colspan="3" class="pn-fcontent">
								<select name="whtherRegister" style="width:150px">
									<option value="" <c:if test="${whtherRegister==null}">selected</c:if>>-请选择-</option>
									<option value="0" <c:if test="${whtherRegister==0}">selected</c:if>>已注册</option>
									<option value="1" <c:if test="${whtherRegister==1}">selected</c:if>>末注册</option>
								</select>
							</td>
						</tr>
					</c:if>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" 查 询 " />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" 重 置 " />		
						</td>
					</tr>
				</table>
			<!-- 显示list数据-->
			<table  id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>用户编号</th>
						<th>用户姓名</th>
						<th>身份证号</th>
						<th>车牌号码</th>
						<th>停 车 场</th>
						<th>OBU  号</th>
						<th>卡 状 态</th>
						<th>押金(元)</th>
						<th>卡表面号</th>
						<th>用户类型</th>
						 <c:if test="${param_whtherPayType.pvalue!=1}">
						<th>收费类型</th>
						</c:if>
						<th>操作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item[1].recNO }</td>
							<td>${item[1].owner }</td>
							<td>${item[1].idcard }</td>
							<td>${fn:trim(item[1].vehPlate)}</td>
							<td>${item[1].parkingSpace }</td>
							<td>${item[1].obu }</td>
							<td>
								<c:if test="${item[1].status==0}">正常</c:if>
								<c:if test="${item[1].status==1}">挂失</c:if>
								<c:if test="${item[1].status==9}">未缴费</c:if>
							</td>
							<td>${item[1].deposit }</td>
							<td>${item[1].cardNo }</td>
							<td>
								<c:forEach items="${listUserCardFeeRuleType}" var="itemCardType">
                                	<c:if test="${item[1].userCardType==itemCardType.userCardType}">${itemCardType.typeName}</c:if>
                                </c:forEach>
							</td>
                            <c:if test="${param_whtherPayType.pvalue!=1}">
							<td>
								<c:forEach items="${listFeeRuleTypeDef}" var="itemFeeRuleTypeDef">
									<c:if test="${item[1].feeRuleType==itemFeeRuleTypeDef.feeRuleType}">${itemFeeRuleTypeDef.name}</c:if>
								</c:forEach>
							</td>					
							</c:if>
							<td>
								<c:if test="${item[0]==null}">
									<a href="securityUserInfo_toRegister.do?cardNo=${item[1].cardNo }&pager.pageSize=${pager.pageSize}'&pager.currentPage=${pager.currentPage }" class="pn-loperator">注册</a>
								</c:if>
								<c:if test="${item[0]!=null}">
									<a  href="javascript:toUpdate(${item[0].regId },${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>┆
									<a href="javascript:del(${item[0].regId },${pager.pageSize},${pager.currentPage });" class="pn-loperator">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>
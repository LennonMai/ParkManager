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
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript">
		if("${result}"=="SUCCESS")
			alert("登记成功"); 
		if("${result}"=="SUCCESS1")
			alert("修改成功"); 
		if("${result}"=="SUCCESS2")
			alert("删除成功");
		
	function check() {
		if (get("billStorage.hankNo").value != "") {
			var partten = /^\+?[0-9][0-9]*$/;
			if (partten.test(get("billStorage.hankNo").value)) {

			} else {
				alert("票据号为数字，请重新输入！");
				get("billStorage.hankNo").focus();
				return false;
			}
		}
	}
	function add() {
		window.location = "bill_add.do";
	}
	 function cancel(hankNo) {	
		 if(confirm("确定要删除吗？")) {								
				window.location = "bill_cancel.do?billStorage.hankNo=" + hankNo;	
		 }	
	  }
	function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
	function update(hankNo,pageSize,currentPage){
			window.location.href ="bill_update.do?billStorage.hankNo="+hankNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form name="tableForm" method="post" action="bill_queryBillStorageToAdd.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
						<td  class="pn-flabel pn-flabel-h">票&nbsp;据&nbsp;号：</td>
						<td  class="pn-fcontent"> <input type="text" name="billStorage.hankNo" value="${billStorage.hankNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">位&nbsp;&nbsp;&nbsp;&nbsp;置：</td>
						<td  class="pn-fcontent">
						<select name="billStorage.position" style="width:150px">	
							<option value="" <c:if test="${billStorage.position==null}">selected</c:if>>请选择</option>
							<option value="99" <c:if test="${billStorage.position==99}">selected</c:if>>管理中心</option>
							   <c:forEach items="${listgatewayInformation}" var="item">
								 <option value="${item.gateNo}" <c:if test="${billStorage.position==item.gateNo}">selected</c:if>>${item.gateName}</option>
							    </c:forEach> 															
						</select>	
						</td>
					</tr>					 
					<tr>
						
						<td  class="pn-flabel pn-flabel-h">类&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
						<td  class="pn-fcontent">
						<select name="billStorage.billType" style="width:150px">
								<option value="" <c:if test="${billStorage.billType==null}">selected</c:if>>请选择</option>
							    <option value="1" <c:if test="${billStorage.billType==1}">selected</c:if>>手撕票</option>
								<option value="2" <c:if test="${billStorage.billType==2}">selected</c:if>>发 &nbsp;票 </option>
							</select>
						</td>
						<td  class="pn-flabel pn-flabel-h">票据代码：</td>
						<td class="pn-fcontent"><input type="text" name="billStorage.billHead"  value="${billStorage.billHead}"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" 查 询 " />&nbsp;
						<input type="button"  value=" 登记 "  onclick="add();"/> &nbsp;
						<input type="reset" value=" 重 置 "/>
						
						</td>
					</tr>
				</table>
					<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>票据号</th>
						<th>位置</th>
						<th>票据类型</th>
						<th>票据代码</th>						
						<th>开始票号</th>
						<th>结束票号</th>
						<th>总数量</th>						
						<th>可用开始票号</th>					
						<th>已经使用数量</th>						
						<th>更新时间</th>
						<th>操作</th>						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.hankNo}</td>
							<td>
							  <c:choose> 
                                 <c:when test="${item.position==99}">管理中心                  
                                  </c:when>                           
                                  <c:otherwise> 
                                     <c:forEach items="${listgatewayInformation}" var="itemgatewayInformation"><c:if test="${item.position==itemgatewayInformation.gateNo}">${itemgatewayInformation.gateName}</c:if></c:forEach>
                                  </c:otherwise>                            
                              </c:choose>
							</td>	
							<td><c:if test="${item.billType==1}">手撕票</c:if><c:if test="${item.billType==2}">发 &nbsp;票</c:if></td>						
							<td>${item.billHead}</td>
							<td>${item.startBillNo}</td>
							<td>${item.endBillNo}</td>
							<td>${item.amount}</td>
							<td>${item.usedBillNo}</td>
							<td>${item.usedAmount}</td>							
							<td><fmt:formatDate value="${item.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><a href="javascript:update(${item.hankNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>┆<a href="javascript:cancel(${item.hankNo})" class="pn-loperator">删除</a></td> 							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>
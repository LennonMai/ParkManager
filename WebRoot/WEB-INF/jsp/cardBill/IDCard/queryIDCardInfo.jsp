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
			alert("注册成功"); 
		if("${result}"=="SUCCESS1")
			alert("修改成功"); 
		if("${result}"=="SUCCESS2")
			alert(" 删除成功"); 
		function deleteIDCardInfo(idcardNo) {
			if(confirm("确定要删除吗？")) {													
				window.location = "iDCard_deleteIDCardInfo.do?idCardInfoTemp.idcardNo=" + idcardNo;		
			}
		}
		
		
		function addIDCardInfo(){
			window.location = "iDCard_addIDCardInfo.do";
		}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
		}
		function updateIDCardInfo(idcardNo,pageSize,currentPage) {														
			window.location = "iDCard_updateIDCardInfo.do?idCardInfoTemp.idcardNo=" + idcardNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;		
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
			<form name="tableForm" method="post" action="iDCard_queryIDCardInfoToAdd.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    <tr>
					    <td  class="pn-flabel pn-flabel-h">姓名：</td>
						<td  class="pn-fcontent"> <input type="text" name="idCardInfoTemp.userName" value="${idCardInfoTemp.userName}"></td>
						<td  class="pn-flabel pn-flabel-h">卡号：</td>
						<td  class="pn-fcontent"> <input type="text" name="idCardInfoTemp.idcardNo" value="${idCardInfoTemp.idcardNo}"></td>																					 					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" 查 询 " />&nbsp;
						<input type="button" value=" &nbsp;注册 &nbsp;" onclick="addIDCardInfo()"/>						
						<input type="reset" value=" 重 置 "/>
						
						
						</td>
					</tr>
				</table>
					<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>姓名</th>
						<th>卡号</th>
						<th>操作</th>						
						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.userName}</td>
							<td>${item.idcardNo}</td>																	
                            <td><a href="javascript:updateIDCardInfo(${item.idcardNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>┆<a href="javascript:deleteIDCardInfo(${item.idcardNo})" class="pn-loperator">删除</a></td>                                         
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>
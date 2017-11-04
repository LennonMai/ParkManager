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
			alert("添加成功"); 
		if("${result}"=="SUCCESS1")
			alert("修改成功"); 
		if("${result}"=="SUCCESS2")
			alert("删除成功"); 
	function deleteCardGroupInfo(groupNo) {
		if (confirm("确定要删除吗？")) {
			window.location = "parkCard_deleteCardGroupInfo.do?cardGroupInfo.groupNo="
					+ groupNo;
		}
	}
	
	function addCardGroupInfo() {
		window.location = "parkCard_addCardGroupInfo.do";
	}
	function deleteGroupMember() {
		window.location = "parkCard_deleteGroupMember.do";
	}

	function check() {
		if (get("cardGroupInfo.groupNo").value != "") {
			var partten = /^\d*$/;
			if (partten.test(get("cardGroupInfo.groupNo").value)) {

			} else {
				alert("组编号为数字，请重新输入！");
				get("cardGroupInfo.groupNo").focus();
				return false;
			}
		}
	}
	function getRowIndex(obj){
		get("pager.rowIndex").value=obj.rowIndex;
	}
	function updateCardGroupInfo(groupNo,pageSize,currentPage) {
		window.location = "parkCard_updateCardGroupInfo.do?cardGroupInfo.groupNo="
				+ groupNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;		
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
			<form name="tableForm" method="post" action="parkCard_queryCGInfoToManage.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
					    <td  class="pn-flabel pn-flabel-h">组编号：</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupNo" value="${cardGroupInfo.groupNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">组名：</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupName" value="${cardGroupInfo.groupName}" /></td>						
					</tr>					 					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" 查 询 " />&nbsp;
						<input type="button" value=" &nbsp;新增 &nbsp;" onclick="addCardGroupInfo()"/>
						<input type="button" value="删除组成员" onclick="deleteGroupMember()"/>&nbsp;
						<input type="reset" value=" 重 置 "/>	&nbsp;
						<input type="button" value=" 返 回 " onclick="history.back();"/>											
						</td>
					</tr>
				</table>
					<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>组编号</th>
						<th>组名</th>						
						<th>车位数</th>
						<th>剩余车位数</th>						
						<th>操作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.groupNo}</td>
							<td>${item.groupName}</td>								
							<td>${item.parkSum}</td>							
							<td>${item.parkRemant}</td>						
                            <td><a href="javascript:updateCardGroupInfo(${item.groupNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>┆<a href="javascript:deleteCardGroupInfo(${item.groupNo})" class="pn-loperator">删除</a></td>                                         
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>
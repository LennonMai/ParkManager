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
			alert("��ӳɹ�"); 
		if("${result}"=="SUCCESS1")
			alert("�޸ĳɹ�"); 
		if("${result}"=="SUCCESS2")
			alert("ɾ���ɹ�"); 
	function deleteCardGroupInfo(groupNo) {
		if (confirm("ȷ��Ҫɾ����")) {
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
				alert("����Ϊ���֣����������룡");
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>				
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryCGInfoToManage.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
					    <td  class="pn-flabel pn-flabel-h">���ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupNo" value="${cardGroupInfo.groupNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">������</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupName" value="${cardGroupInfo.groupName}" /></td>						
					</tr>					 					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="button" value=" &nbsp;���� &nbsp;" onclick="addCardGroupInfo()"/>
						<input type="button" value="ɾ�����Ա" onclick="deleteGroupMember()"/>&nbsp;
						<input type="reset" value=" �� �� "/>	&nbsp;
						<input type="button" value=" �� �� " onclick="history.back();"/>											
						</td>
					</tr>
				</table>
					<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>����</th>
						<th>����</th>						
						<th>��λ��</th>
						<th>ʣ�೵λ��</th>						
						<th>����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.groupNo}</td>
							<td>${item.groupName}</td>								
							<td>${item.parkSum}</td>							
							<td>${item.parkRemant}</td>						
                            <td><a href="javascript:updateCardGroupInfo(${item.groupNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>��<a href="javascript:deleteCardGroupInfo(${item.groupNo})" class="pn-loperator">ɾ��</a></td>                                         
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>
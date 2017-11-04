<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>ͨ�п��������б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("ͨ�п���������ӳɹ���");
			}

		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
			function del(cardNo,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "cardInfo_passCardBlackList_delete.do?passCardBlackList.cardNo="+cardNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}			
			function add(){
				window.location.href = "cardInfo_passCardBlackList_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(cardNo,pageSize,currentPage){
				window.location.href ="cardInfo_passCardBlackList_edit.do?passCardBlackList.cardNo="+cardNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="cardInfo_passCardBlackList_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				<tr>
						<td  class="pn-flabel pn-flabel-h">ͨ�п����룺</td>
						<td  class="pn-fcontent"> <input type="text" name="passCardBlackList.cardNo" value="${passCardBlackList.cardNo}" size="24"/></td>
					    <td  class="pn-flabel pn-flabel-h">ʧЧԭ��</td>
						<td  class="pn-fcontent">
						<select name="passCardBlackList.inValidTypeNo" style="width: 178px;height: 24px;">
						  <option value="" <c:if test="${passCardBlackList.inValidTypeNo==null}">selected="selected"</c:if> >- ��ѡ�� -</option>
						   <option value="1" <c:if test="${passCardBlackList.inValidTypeNo==1}">selected="selected"</c:if> >��ʧ��</option>
						   <option value="2" <c:if test="${passCardBlackList.inValidTypeNo==2}">selected="selected"</c:if> >ע����</option>
						   <option value="3" <c:if test="${passCardBlackList.inValidTypeNo==3}">selected="selected"</c:if> >α��</option>
						   <option value="4" <c:if test="${passCardBlackList.inValidTypeNo==4}">selected="selected"</c:if> >ֹ����</option>
						
						</select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">����&nbsp;&nbsp;���ڣ�</td>
						<td  colspan="3" class="pn-fcontent"> 
						<input style="width: 174px;" type="text" name="passCardBlackList.opTime" value="<fmt:formatDate value="${passCardBlackList.opTime }" pattern="yyyy-MM-dd" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  />
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button"  value=" �� �� "  onclick="add();"/> &nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� " />	
						</td>
					</tr>
			</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ͨ�п�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ʧЧԭ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>

				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.cardNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
							<c:if test="${item.inValidTypeNo!=1&&item.inValidTypeNo!=2&&item.inValidTypeNo!=3&&item.inValidTypeNo!=4}">${item.inValidTypeNo}</c:if>
							<c:if test="${item.inValidTypeNo==1}">��ʧ��</c:if>
							<c:if test="${item.inValidTypeNo==2}">ע����</c:if>
							<c:if test="${item.inValidTypeNo==3}">α��</c:if>
							<c:if test="${item.inValidTypeNo==4}">ֹ����</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.opTime}</td>
							
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="cardInfo_passCardBlackList_edit.do?passCardBlackList.cardNo=${item.cardNo}&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage}" class="pn-loperator">�޸�</a>-->
							<a href="javascript:edit('${item.cardNo}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del('${item.cardNo}',${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>

		</div>

	</body>
</html>
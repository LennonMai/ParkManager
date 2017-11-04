<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>�շ�����Ӱ���б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">
			if("${result}"=="SUCCESS"){
				alert("�û���������ӳɹ���");
			}
			if("${message}"=="updateSuccess"){
				alert("�޸ĳɹ���");
			}
			if("${message}"=="deleteSuccess"){
				alert("ɾ���ɹ���");
			}
			function del(parkNo,inGateNo,outGateNo,feeType,verNo,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "pricepasstype_delete.do?pricepasstype.parkNo="+parkNo
						+"&pricepasstype.inGateNo="+inGateNo+"&pricepasstype.outGateNo="+outGateNo
						+"&pricepasstype.feeType="+feeType+"&pricepasstype.verNo="+verNo
						+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}			
			function add(){
				window.location.href = "pricepasstype_add.do";
			}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
			}
			function edit(parkNo,inGateNo,outGateNo,feeType,verNo,pageSize,currentPage){
				window.location.href ="pricepasstype_edit.do?pricepasstype.parkNo="+parkNo
						+"&pricepasstype.inGateNo="+inGateNo+"&pricepasstype.outGateNo="+outGateNo
						+"&pricepasstype.feeType="+feeType+"&pricepasstype.verNo="+verNo
						+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
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
			<form  name="tableForm"  method="post" action="pricepasstype_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				<tr>
					<td  class="pn-flabel pn-flabel-h">С����ţ�</td>
					<td  class="pn-fcontent"> <input type="text" name="pricepasstype.parkNo" value="${pricepasstype.parkNo}" size="24"/></td>
					<td class="pn-flabel pn-flabel-h">��ڴ��źţ�</td>
					<td class="pn-fcontent"> <input type="text" name="pricepasstype.inGateNo" value="${pricepasstype.inGateNo}" size="24"/></td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
					<td class="pn-fcontent">
						<select style="width: 180px;height: 22px;"  class="required " name="pricepasstype.feeType">
							<option value="">- ��ѡ�� -</option>
							<option value="2" <c:if test="${pricepasstype.feeType==2}">selected="selected"</c:if>>ͬ��</option>
							<option value="3" <c:if test="${pricepasstype.feeType==3}">selected="selected"</c:if>>����</option>
							<option value="4" <c:if test="${pricepasstype.feeType==4}">selected="selected"</c:if>>�Żݳ�</option>
						</select>
					</td>
					<td class="pn-flabel pn-flabel-h">���ڴ��źţ�</td>
					<td class="pn-fcontent"> <input type="text" name="pricepasstype.outGateNo" value="${pricepasstype.outGateNo}" size="24"/></td>
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
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ڴ��ź�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ڴ��ź�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շ�����</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�汾��</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.parkNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.inGateNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.outGateNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
								<c:if test="${item.feeType==2}">ͬ��</c:if>
								<c:if test="${item.feeType==3}">����</c:if>
								<c:if test="${item.feeType==4}">�Żݳ�</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.verNo}</td>
							
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!-- <a href="javascript:edit(${item.parkNo},${item.inGateNo},${item.outGateNo},${item.feeType},${item.verNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							��--><a href="javascript:del(${item.parkNo},${item.inGateNo},${item.outGateNo},${item.feeType},${item.verNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a>
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
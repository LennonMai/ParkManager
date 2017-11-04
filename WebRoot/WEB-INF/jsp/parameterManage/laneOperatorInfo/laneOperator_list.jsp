<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>����Ա��Ϣ�б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
			
		<script language="javascript">
		
		if("${result}"=="SUCCESS"){
			alert("����Ա��Ϣ��ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
		function del(operatorNo,pageSize,currentPage){
			if(confirm("ȷ��Ҫɾ����")){
				window.location.href = "laneOperator_delete.do?laneOperator.operatorNo="+operatorNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
			}
		}
		function add(){
			window.location.href = "laneOperator_add.do";
			}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
		function edit(operatorNo,pageSize,currentPage){
			window.location.href ="laneOperator_edit.do?laneOperator.operatorNo="+operatorNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form  name="tableForm"  method="post" action="laneOperator_query.do" onsubmit="">
						<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
					    <td  class="pn-flabel pn-flabel-h">С�����룺</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.parkNo" value="${laneOperator.parkNo}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">״&nbsp;&nbsp;&nbsp;&nbsp;̬��</td>
						<td  class="pn-fcontent">
						<c:if test="${laneOperator.status==null}">
						<select  name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="" selected="selected"> - ��ѡ�� -</option>
						   <option value="0" > ��Ч</option>
						   <option value="1" > ����</option>
						</select>
						</c:if>
						<c:if test="${laneOperator.status==''}">
						<select  name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="" selected="selected"> - ��ѡ�� -</option>
						   <option value="0" > ��Ч</option>
						   <option value="1" > ����</option>
						</select>
						</c:if>
						<c:if test="${laneOperator.status=='0'}">
						<select  name="laneOperator.status"  style="width: 178px;height: 24px;">
						   <option value="0" selected="selected"> ��Ч</option>
						   <option value="1" > ����</option>
						</select>
						</c:if>
						<c:if test="${laneOperator.status=='1'}">
						<select  name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="0" > ��Ч</option>
						   <option value="1" selected="selected"> ����</option>
						</select>
						</c:if>
						</td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">����Ա���룺</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.operatorNo" value="${laneOperator.operatorNo}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">��ݿ��ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.opCardId" value="${laneOperator.opCardId}" size="24"/></td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">����Ա���ƣ�</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.operatorName" value="${laneOperator.operatorName}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">��ݿ��Ա�ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="laneOperator.opCardNo" value="${laneOperator.opCardNo}" size="24"/></td>
					</tr>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button" value=" �� �� " onclick="add();"/>	
						</td>
					</tr>
			</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����Ա����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����Ա����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ݿ���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ݿ��Ա��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��¼����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">״̬</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.parkNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.operatorNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.operatorName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.opCardId}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.opCardNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.password}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.status==0}">��Ч</c:if>
							<c:if test="${item.status==1}">����</c:if>
							</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							 <!--<a href="laneOperator_edit.do?laneOperator.operatorNo=${item.operatorNo}&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage}" class="pn-loperator">�޸�</a>-->
							 <a href="javascript:edit(${item.operatorNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.operatorNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">ɾ��</a>							
							</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		</div>		
	</body>
</html>
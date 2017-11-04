<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>�����б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
			
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("�������óɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
		function del(paraClass,item,pageSize,currentPage){
			if(confirm("ȷ��Ҫɾ����")){
				window.location.href = "systemPara_delete.do?systemPara.paraClass="+paraClass+"&systemPara.item="+item+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
			}
		}
		
		function add(){
			window.location.href = "systemPara_add.do";
			}
		function dataToExcel(){
			window.location.href = "systemPara_dataToExcel.do";
			}
		//���˿ո�
		function Trim() {
            return this.replace(/\s+$|^\s+/g,"");
		}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
		function edit(paraClass,item,pageSize,currentPage){
			window.location.href ="systemPara_edit.do?systemPara.paraClass="+paraClass+"&systemPara.item="+item+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form  name="tableForm"  method="post" action="systemPara_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td  class="pn-fcontent"> <input type="text" name="systemPara.item" value="${systemPara.item}" size="24"/></td>
					    <td  class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td  class="pn-fcontent">
						<select name="systemPara.paraClass" style="width: 178px;height: 24px;">
						  <option value="" <c:if test="${systemPara.paraClass==null}">selected="selected"</c:if> >- ��ѡ�� -</option>
						   <option value="-1" <c:if test="${systemPara.paraClass==-1}">selected="selected"</c:if> >������</option>
						   <option value="0" <c:if test="${systemPara.paraClass==0}">selected="selected"</c:if> >ȫ�ֲ���</option>
						   <option value="1" <c:if test="${systemPara.paraClass==1}">selected="selected"</c:if> >�·�����</option>
						   <option value="2" <c:if test="${systemPara.paraClass==2}">selected="selected"</c:if> >���������</option>
						
						</select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;ֵ��</td>
						<td  class="pn-fcontent"> <input type="text" name="systemPara.itemValue" value="${systemPara.itemValue }" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<%-- <td  class="pn-fcontent"><input type="text" name="systemPara.groupName" value="${systemPara.groupName }" size="24"/></td> --%>
						<td class="pn-fcontent">
						<select name="systemPara.groupName" style="width: 178px;height: 24px;">
							<option value="" <c:if test="${systemPara.groupName==''}">selected="selected"</c:if> >- ��ѡ�� -</option>
						<c:forEach items="${groupNameList}" var="gName">
							<option value="${gName.item}" <c:if test="${systemPara.groupName eq gName.item}">selected="selected"</c:if> >${gName.item}</option>
						</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button"  value=" �� �� "  onclick="add();"/> &nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� "/>	
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;ֵ</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��˳��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�����·�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.paraClass==-1}">������</c:if>
							<c:if test="${item.paraClass==0}">ȫ�ֲ���</c:if>
							<c:if test="${item.paraClass==1}">�·�����</c:if>
							<c:if test="${item.paraClass==2}">���������</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.item}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.itemValue}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.groupName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.itemOrder}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.paraClass==1}">
								<c:if test="${item.sendControl==0}">���·�</c:if>
								<c:if test="${item.sendControl==1}">��Ч�·�</c:if>
							</c:if>
							</td>
						
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:edit(${item.paraClass},'${item.item}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.paraClass},'${item.item}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">ɾ��</a>							
											
							</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		<div class=pn-sp>
		<input type="button" name="" style="padding-left: 5px;padding-right: 5px;padding-bottom: 1px;padding-top: 2px;" value="�����ݵ���Excel" onclick="dataToExcel();"/> 
		<div class="clear"></div>
        </div>
		</div>		
	</body>
</html>
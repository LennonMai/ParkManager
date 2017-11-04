<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>���������б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("����������ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
		function del(verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo,pageSize,currentPage){
			if(confirm("ȷ��Ҫɾ����")){
				window.location.href = "zjuPriceConfig_delete.do?zju_PriceBase.verNo="+verNo+"&zju_PriceBase.feeNo="+feeNo+"&zju_PriceBase.rebateType="+rebateType+"&zju_PriceBase.inOutSign="+inOutSign+"&zju_PriceBase.timesSign="+timesSign+"&zju_PriceBase.vehTypeNo="+vehTypeNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
			}
		}			
		function add(){
			window.location.href = "zjuPriceConfig_priceBase_add.do";
			}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
		function edit(verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo,pageSize,currentPage){
			window.location.href ="zjuPriceConfig_priceBase_edit.do?zju_PriceBase.verNo="+verNo+"&zju_PriceBase.feeNo="+feeNo+"&zju_PriceBase.rebateType="+rebateType+"&zju_PriceBase.inOutSign="+inOutSign+"&zju_PriceBase.timesSign="+timesSign+"&zju_PriceBase.vehTypeNo="+vehTypeNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
			<form  name="tableForm"  method="post" action="zjuPriceConfig_priceBase_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr align="right">
					    <td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;��ӻ�������"  onclick="add();"/>
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ʰ汾</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ʱ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ʱ��α�־</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�����ڱ�־</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ͣ��ʱ�䣨���ӣ�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��λ�շ�ʱ�䣨���ӣ�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��λ�շѽ��֣�</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����շѽ��֣�</th>					
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ʱ��</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;ע</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.verNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.feeNo}</td>
				
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
							<c:if test="${item.timesSign==0}">�������</c:if>
							<c:if test="${item.timesSign==1}">ҹ�����</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >
							<c:if test="${item.inOutSign==0}">ͬ��</c:if>
							<c:if test="${item.inOutSign==1}">����</c:if></td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.vehTypeNo==1}">Ħ�г�</c:if>
							<c:if test="${item.vehTypeNo==2}">С��</c:if>
							<c:if test="${item.vehTypeNo==3}">�����ͳ�</c:if>
							<c:if test="${item.vehTypeNo==4}">�����ͳ�</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.allowStayTime}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.stayAdd}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.addFee}</td>					
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.maxFee}</td>						
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.startTime}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.remark}</td>
							
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="zjuPriceConfig_priceBase_edit.do?zju_PriceBase.verNo=${item.verNo}&zju_PriceBase.feeNo=${item.feeNo}&zju_PriceBase.rebateType=${item.rebateType}&zju_PriceBase.inOutSign=${item.inOutSign}&zju_PriceBase.timesSign=${item.timesSign}&zju_PriceBase.vehTypeNo=${item.vehTypeNo}" class="pn-loperator">�޸�</a>-->
							<a href="javascript:edit(${item.verNo},${item.feeNo},${item.rebateType},${item.inOutSign},${item.timesSign},${item.vehTypeNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.verNo},${item.feeNo},${item.rebateType},${item.inOutSign},${item.timesSign},${item.vehTypeNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>

		</div>

	</body>
</html>
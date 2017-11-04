<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
        <script type="text/javascript">
          	function doPrint(){ 
            	bdhtml=window.document.body.innerHTML; 
                sprnstr="<!--startprint-->"; 
                eprnstr="<!--endprint-->"; 
                prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17); 
                prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr)); 
                window.document.body.innerHTML=prnhtml; 
                window.print(); 
         	}
        </script>
        <style>
        	.tb_print{border-top: black 1px solid;border-left: black 1px solid;font-size: 12px;}
			.tb_print tr td{border-bottom: black 1px solid;border-right: black 1px solid;height: 30px;}
			.tb_print tr th{border-bottom: black 1px solid;border-right: black 1px solid;height: 30px;}
        </style>
  </head>
  <body>
  	<table width="100%" class="pn-ftable" cellpadding="3" cellspacing="3" border="0">
		<tr>
			<td class="pn-fcontent" align="center">
				<input type="button" value="����" onclick="history.back();"></input> 
				<input name="b_print" type="button" class="ipt" onclick="doPrint();" value="��ӡ" />
			</td>
		</tr>
	</table>
   	<div style="margin: auto; width: 710px; margin-top: 30px;">
		<!--startprint-->
		<div id="div_print">
			<div style="margin: auto;">
				<p style="margin: auto; display: block; text-align: center; line-height: 30px; font-size: 20px">
					������
				</p>
			</div>
		<div>
		<table id="tb_p" class="tb_print" width="100%" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th>�������</th>
					<th>�� �� ��</th>
					<th>��������</th>
					<th>OBU  ��</th>
					<th>����ʱ��</th>
					<th>����ʱ��</td>	
					<th>�û�������</th>
					<th>�ʺ�״̬</th>	
					<th>�Ƿ���ͼƬ</th>
					<th>��������</th>	
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="item">
					<tr align="center">
						<td>${item["CardNO"]}</td>
						<td>${item["VehPlate"]}</td>
						<td>${item["OwnerName"]}</td>
						<td>
							${item["OBUID"]}&nbsp;
						</td>	
						<td>
							<fmt:formatDate value="${item['FirTime']}" pattern="yyyy-MM-dd" />
						</td>
						<td>
							<fmt:formatDate value="${item['InvaliDateTime']}" pattern="yyyy-MM-dd" />
						</td>	
						<td>
							<c:forEach items="${userCardTypeList}" var="item1">
								<c:if test="${item['CARDTYPE']==item1.userCardType}">${item1.typeName}</c:if>
							</c:forEach>
						</td>
						<td>
							<c:if test="${item['Status']==0}">����</c:if>
							<c:if test="${item['Status']==1}">��ʧ</c:if>
							<c:if test="${item['Status']==9}">δ�ɷ�</c:if>
						</td>	
						<td>
							<c:if test="${item['HasVehPic']==0}">��</c:if>
							<c:if test="${item['HasVehPic']==1}">��</c:if>
						</td>
						<td>
							<c:forEach items="${listFeeRuleTypeDef}" var="item1">
								<c:if test="${item['FeeRuleType']==item1.feeRuleType}">${item1.name}</c:if>
							</c:forEach>
						</td>
					</tr>
				</c:forEach>			
			</tbody>
		</table>
		<!--endprint-->
	</div>
  </body>
</html>

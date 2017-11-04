<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java"
	pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>����ͣ��ʱ���ѯ</title>
<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css" />
<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css" />
<%@include file="../include/common.jsp"%>
<script type="text/javascript" src="${basePath}/js/showWin.js"></script>
<script type="text/javascript"
	src="${basePath}/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${basePath}/js/util.js"></script>
<script language="javascript">
	function getRowIndex(obj) {
		get("pager.rowIndex").value = obj.rowIndex;
	}

	function doExport() {
		var length = $("input[name='filed']:checked").length;
		if (length == 0) {
			alert("��ѡ��Ҫ�������ֶΣ�");
			return false;
		}

		document.getElementById("idBoxCancel").click();
		document.getElementById("dataform").action = "carStopTimeQuery_exportParkCard.do";
		document.getElementById("dataform").submit();
		document.getElementById("dataform").action = "carStopTimeQuery_list.do";
	}
	function checkAll() {
		var checkAll = document.getElementById("all");
		var fileds = document.getElementsByName("filed");

		if (checkAll.checked == true) {
			for (var i = 0; i < fileds.length; i++) {
				fileds[i].checked = true;
			}
		} else {
			for (var i = 0; i < fileds.length; i++) {
				fileds[i].checked = false;
			}
		}
	}
	function check() {
		var checkAll = document.getElementById("all");
		var fileds = document.getElementsByName("filed");
		var flag = true;
		for (var i = 0; i < fileds.length; i++) {
			if (fileds[i].checked == false) {
				flag = false;
				break;
			}
		}
		checkAll.checked = flag;
	}
	$(document).ready(function() {//����div�����㣬��������¼�
		var box = new LightBox("idBox");
		box.Center = true;
		$("#idBoxCancel").click(function() {
			box.Close();
		});
		$("#exprot").click(function() {
			if ($("#dataform").valid() == false) {
				return false;
			} else {
				box.Show();
			}
		});
	});
</script>
<style>
.lightbox {
	width: 620px;
	background: #FFFFFF;
	border: 1px solid #ccc;
	line-height: 25px;
	top: 30%;
	left: 30%;
}

.lightbox dt {
	background: #f4f4f4;
	padding: 5px;
}
</style>
</head>
<body>
	<div class="body-box">
		<div class="rhead">
			<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
			<div class="clear"></div>
		</div>
		<form id="dataform" name="tableForm" method="post"
			action="carStopTimeQuery_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1"
				border="0">
				<tr>
					<td class="pn-flabel pn-flabel-h">ͣ��ʱ��������</td>
					<td class="pn-fcontent"><input type="text" id="stopTime"
						class="required isNo_NotOverValueIntOne" name="stopTime" value="${stopTime}"
						size="24" /></td>
					<td class="pn-flabel pn-flabel-h">�·ݣ�</td>
					<td class="pn-fcontent"><input readonly="readonly"
						style="width: 174px;" type="text" name="groupByMonth"
						value="${groupByMonth }" class="required Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM'})" /></td>
				</tr>
				<tr>

					<td class="pn-flabel pn-flabel-h">�����ﵽ��</td>
					<td class="pn-fcontent"><input type="text"
						class="required isNo_NotOverValueIntOne" name="stopCount" value="${stopCount}"
						size="24" /></td>
					<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
					<td class="pn-fcontent"><select name="carType"
						style="height: 21px;">
							<option value=""
								<c:if test="${carType==''}">selected="selected"</c:if>>-
								��ѡ�� -</option>
							<option value="0"
								<c:if test="${carType=='0'}">selected="selected"</c:if>>У�ڳ�</option>
							<option value="1"
								<c:if test="${carType=='1'}">selected="selected"</c:if>>У�⳵</option>

					</select></td>
				</tr>
				<tr>
					<td colspan="4" class="pn-fbutton"><input
						style="padding-left: 5px; padding-right: 5px;" type="submit"
						value=" �� ѯ " />&nbsp; <input
						style="padding-left: 5px; padding-right: 5px;" type="reset"
						value=" �� �� " /> &nbsp; <input
						style="padding-left: 5px; padding-right: 5px;" type="button"
						value=" ���� " id="exprot" /></td>
				</tr>
			</table>
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1"
				cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">���ƺ�</th>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">ͣ��ʱ������</th>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">�����ﵽ</th>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">��������</th>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'"
							onmouseout="this.className=''" align="center"
							onclick="getRowIndex(this)">
							<td
								style="word-break: break-all; padding-left: 5px; padding-right: 5px;">${item.vehPlate}</td>
							<td
								style="word-break: break-all; padding-left: 5px; padding-right: 5px;">${item.stopTime}</td>
							<td
								style="word-break: break-all; padding-left: 5px; padding-right: 5px;">${item.stopCount}</td>
							<td
								style="word-break: break-all; padding-left: 5px; padding-right: 5px;">
								<c:if test="${item.carType=='0'}">У�ڳ�</c:if> <c:if
									test="${item.carType=='1'}">У�⳵</c:if>
							</td>
							<td
								style="word-break: break-all; padding-left: 5px; padding-right: 5px;">${item.groupByMonth}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp" />
			<table id="idBox" class="lightbox">
				<tr>
					<th id="idBoxHead" align="left">��ѡ�񵼳��ֶ�</th>
				</tr>
				<tr>
					<td>&nbsp; <input name="all" type="checkbox" id="all"
						value="checkAll" checked="checked" onclick="checkAll()" />ȫѡ&nbsp;
					</td>
				</tr>
				<tr>
					<td>&nbsp; <input name="filed" type="checkbox"
						value="vehPlate" checked="checked" onclick="check()" />���ƺ� <input
						name="filed" type="checkbox" value="stopTime" checked="checked"
						onclick="check()" />ͣ��ʱ�� <input name="filed" type="checkbox"
						value="stopCount" checked="checked" onclick="check()" />ͣ������ <input
						name="filed" type="checkbox" value="carType" checked="checked"
						onclick="check()" />�������� <input name="filed" type="checkbox"
						value="groupByMonth" checked="checked" onclick="check()" />�·�
					</td>
				</tr>
				<tr>
					<td align="center"><input name="" type="button" value=" ȷ �� "
						onclick="doExport()" />&nbsp; <input name="" type="button"
						value=" �� �� " id="idBoxCancel" /></td>
				</tr>
			</table>
		</form>

	</div>

</body>
</html>
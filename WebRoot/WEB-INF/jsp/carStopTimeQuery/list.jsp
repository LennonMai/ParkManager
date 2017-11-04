<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java"
	pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>车辆停留时间查询</title>
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
			alert("请选择要导出的字段！");
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
	$(document).ready(function() {//创建div弹出层，并绑定相关事件
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
			<div class="rpos">当前位置： ${currentPosition}</div>
			<div class="clear"></div>
		</div>
		<form id="dataform" name="tableForm" method="post"
			action="carStopTimeQuery_list.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1"
				border="0">
				<tr>
					<td class="pn-flabel pn-flabel-h">停留时长超过：</td>
					<td class="pn-fcontent"><input type="text" id="stopTime"
						class="required isNo_NotOverValueIntOne" name="stopTime" value="${stopTime}"
						size="24" /></td>
					<td class="pn-flabel pn-flabel-h">月份：</td>
					<td class="pn-fcontent"><input readonly="readonly"
						style="width: 174px;" type="text" name="groupByMonth"
						value="${groupByMonth }" class="required Wdate"
						onclick="WdatePicker({dateFmt:'yyyy-MM'})" /></td>
				</tr>
				<tr>

					<td class="pn-flabel pn-flabel-h">次数达到：</td>
					<td class="pn-fcontent"><input type="text"
						class="required isNo_NotOverValueIntOne" name="stopCount" value="${stopCount}"
						size="24" /></td>
					<td class="pn-flabel pn-flabel-h">车辆类型：</td>
					<td class="pn-fcontent"><select name="carType"
						style="height: 21px;">
							<option value=""
								<c:if test="${carType==''}">selected="selected"</c:if>>-
								请选择 -</option>
							<option value="0"
								<c:if test="${carType=='0'}">selected="selected"</c:if>>校内车</option>
							<option value="1"
								<c:if test="${carType=='1'}">selected="selected"</c:if>>校外车</option>

					</select></td>
				</tr>
				<tr>
					<td colspan="4" class="pn-fbutton"><input
						style="padding-left: 5px; padding-right: 5px;" type="submit"
						value=" 查 询 " />&nbsp; <input
						style="padding-left: 5px; padding-right: 5px;" type="reset"
						value=" 重 置 " /> &nbsp; <input
						style="padding-left: 5px; padding-right: 5px;" type="button"
						value=" 导出 " id="exprot" /></td>
				</tr>
			</table>
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1"
				cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">车牌号</th>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">停留时长超过</th>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">次数达到</th>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">车辆类型</th>
						<th
							style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">月&nbsp;&nbsp;份</th>
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
								<c:if test="${item.carType=='0'}">校内车</c:if> <c:if
									test="${item.carType=='1'}">校外车</c:if>
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
					<th id="idBoxHead" align="left">请选择导出字段</th>
				</tr>
				<tr>
					<td>&nbsp; <input name="all" type="checkbox" id="all"
						value="checkAll" checked="checked" onclick="checkAll()" />全选&nbsp;
					</td>
				</tr>
				<tr>
					<td>&nbsp; <input name="filed" type="checkbox"
						value="vehPlate" checked="checked" onclick="check()" />车牌号 <input
						name="filed" type="checkbox" value="stopTime" checked="checked"
						onclick="check()" />停留时长 <input name="filed" type="checkbox"
						value="stopCount" checked="checked" onclick="check()" />停留次数 <input
						name="filed" type="checkbox" value="carType" checked="checked"
						onclick="check()" />车辆类型 <input name="filed" type="checkbox"
						value="groupByMonth" checked="checked" onclick="check()" />月份
					</td>
				</tr>
				<tr>
					<td align="center"><input name="" type="button" value=" 确 定 "
						onclick="doExport()" />&nbsp; <input name="" type="button"
						value=" 关 闭 " id="idBoxCancel" /></td>
				</tr>
			</table>
		</form>

	</div>

</body>
</html>
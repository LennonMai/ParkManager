<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>		
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script type="text/javascript">
			jQuery.noConflict();
			if("${message}"=="1"){
				alert("车牌号修改成功");
			}
			if("${message}"=="2"){
				alert("车牌号修改失败");
			}
			
			//获取大门
			function getGate(){
			(function($) { 
  				$(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxGate.do?parkNo="+$(document.tableForm.parkNo).val(),
					success:function(res){
						$("#gateNo").empty();
						var op = $("<option value=''>-请选择-</option>");		
						$("#gateNo").append(op);
						$("#laneNo").empty();
						var op1 = $("<option value=''>-请选择-</option>");		
						$("#laneNo").append(op1);
						$(res).find("gates > gate").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#gateNo").append(op);	
					});
					}
				});
				 });
				})(jQuery);
			}
			//获取车道
			function getLane(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxLane.do?parkNo="+$(document.tableForm.parkNo).val()
					+ "&gateNo="+$(document.tableForm.gateNo).val(),
					success:function(res){
						$("#laneNo").empty();
						var op = $("<option value=''>-请选择-</option>");		
						$("#laneNo").append(op);
						$(res).find("lanes > lane").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#laneNo").append(op);	
					});
					}
				});
			   });
			  })(jQuery);
			}
			//弹出层
			function showDiv(){
				var start = document.getElementById('startTime').value;
				var end = document.getElementById('endTime').value;
				if(start != "" && end != ""){
					if(start > end){
						alert("开始时间不能大于结束时间！");
						return false;
					}
				}
				document.getElementById('parkNo').style.display="none";
				document.getElementById('gateNo').style.display="none";
				document.getElementById('laneNo').style.display="none";
				document.getElementById('popDiv').style.display='';
				document.getElementById('bg').style.display='';  
  				document.getElementById('bg').style.width = window.screen.width; 
  				document.getElementById('bg').style.height=window.screen.height;
				return true;
			}
			function gotoPage(pageNo) {
				if(pageNo>0)
					get("pager.currentPage").value = pageNo;
					showDiv();
				document.tableForm.submit();
			}
		</script>
		<style type="text/css">
			<!--
			.mydiv {
				background-color: #FFCC66;
				border: 1px solid #f00;
				text-align: center;
				line-height: 40px;
				font-size: 12px;
				font-weight: bold;
				z-index:999;
				width: 200px;
				height: 40px;
				left:50%;
				top:50%;
				margin-left:-150px!important;/*FF IE7 该值为本身宽的一半 */
				margin-top:-60px!important;/*FF IE7 该值为本身高的一半*/
				margin-top:0px;
				position:fixed!important;/* FF IE7*/
				position:absolute;/*IE6*/
				_top:       expression(eval(document.compatMode &&
							document.compatMode=='CSS1Compat') ?
							documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
							document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/
			}
			-->
		</style>
	</head>
	<body style="width: 100%;height: 100%;">
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="lostCard_queryIndentify.do" onsubmit="return showDiv();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">出口/入口：</td>
						<td class="pn-fcontent" width="35%">
							<label>
  								<input type="radio" name="sign"  value="1" <c:if test="${sign==1 }"> checked="checked" </c:if>/>入口
  							</label>
  							<label>
  								<input type="radio" name="sign"  value="2" <c:if test="${sign==2 }"> checked="checked" </c:if>/>出口
  							</label>
						</td>
						<td class="pn-flabel pn-flabel-h">时 间 段：</td>
						<td class="pn-fcontent">
						  <input type="text" name="startTime" id ="startTime" value= "${startTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
						  	--<input type="text" name="endTime" id ="endTime" value="${endTime }" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">位    置：</td>
						<td class="pn-fcontent" colspan="3">
							小区：<select name="parkNo" id ="parkNo" onchange="getGate();">
									<option value="">-请选择-</option>
									<c:forEach items="${parkList}" var="item">
										<option value="${item.parkNo }"<c:if test="${item.parkNo==parkNo }"> selected="selected" </c:if>>${item.parkName }</option>
									</c:forEach>
								</select>&nbsp;
							大门：<select name="gateNo" id="gateNo" onchange="getLane();">
									<option value="">-请选择-</option>
									<c:forEach items="${gateList}" var="item">
										<option value="${item.gateNo }"<c:if test="${item.gateNo==gateNo }"> selected="selected" </c:if>>${item.gateName }</option>
									</c:forEach>
								</select>&nbsp;
							车道：<select name="laneNo" id="laneNo">
									<option value="">-请选择-</option>
									<c:forEach items="${laneList}" var="item">
										<option value="${item.laneNo }"<c:if test="${item.laneNo==laneNo }"> selected="selected" </c:if>>${item.laneNo }</option>
									</c:forEach>
								</select>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" 查 询 " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" 重 置 " />
						</td>
					</tr>
				</table>
			<!-- 显示list数据-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>流 水 号</th>
						<th>车 牌 号</th>
						<th>时    间</th>
						<th>小 区 名</th>
						<th>大 门 名</th>
						<th>车 道 号</th>					
						<th>操    作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0].listNo }</td>
							<td>${item[0].vehPlate }</td>
							<td><fmt:formatDate value="${item[1].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:forEach items="${parkList}" var ="temp">
									<c:if test="${temp.parkNo == item[1].parkNo}">${temp.parkName}</c:if>
								</c:forEach>
							</td>
							<td id="${item[1].gateNo}">
								<c:forEach items="${gates}" var ="temp">
									<c:if test="${temp.gateNo == item[1].gateNo}">${temp.gateName}</c:if>
								</c:forEach>
							</td>
							<td>${item[1].laneNo }</td>
							<td>
								<a href="lostCard_toUpdateIdentify.do?listNo=${item[0].listNo }&listTable=${item[1].listNo }&sign=${sign }&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage }&startTimeTemp=${startTime }&endTimeTemp=${endTime }" class="pn-loperator">修 改</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="popDiv" class="mydiv" align="center" style="position: absolute; z-index: 3; left: expression((document.body.offsetWidth-540)/1); top: expression((document.body.offsetHeight-170)/2);
        background-color: #fff; display: none;">数据正在查询，请等待...</div>
			<div id="bg" style="position: absolute; top: 0px; filter: alpha(opacity=60); background-color: #777;z-index: 2; left: 0px; display: none;"></div>
			
			<div class="pn-sp">
				<div class="pn-sp-left">共 ${pager.totalSize} 条 &nbsp;每页
				<input type="text" name="pager.pageSize" value="${pager.pageSize}" size="2" onfocus="this.select();"/> 条</div>
				<div class="pn-sp-right">
					<input type="button" value=" 首 页 " onclick="gotoPage('1');" <s:if test="pager.hasFirst==false">disabled</s:if>/>&nbsp;
					<input type="button" value=" 上一页 " onclick="gotoPage('${pager.currentPage-1}');"
					<s:if test="pager.hasPrevious==false">disabled</s:if> />&nbsp;
					<input type="button" value=" 下一页 " onclick="gotoPage('${pager.currentPage+1}');"
				  <s:if test="pager.hasNext==false">disabled</s:if> />&nbsp;
					<input type="button" value=" 尾 页 " onclick="gotoPage('${pager.totalPage}');"
					<s:if test="pager.hasLast==false">disabled</s:if> />&nbsp;
					当前 ${pager.currentPage}/${pager.totalPage} 页 &nbsp;转到第 
						<input type="text" name="pager.currentPage" size="2" value="${pager.currentPage}" onfocus="this.select();"/> 页
					<input type="button" value=" 转 " onclick="gotoPage(-1);"/>
					<input type="hidden" name="pager.rowIndex" size="2" value="${pager.rowIndex}"/>
				</div>
				<div class="clear"></div>
			</div>
			
			</form>
		</div>
	</body>
</html>
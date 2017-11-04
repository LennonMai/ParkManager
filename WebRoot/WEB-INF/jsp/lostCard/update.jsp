<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript"><!--
			var arr = new Array;//存放数据
			var imgArr = new Array;//存放图片操作
			var i = 0;
			var queryStatus = "";
			function Len(str) {	//计算输入字符长度
                var i,sum;
                sum=0;
                for(i=0;i<str.length;i++) {
                	if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255)) {
                		sum=sum+1;
                	} else {
                		sum=sum+2;
                	}
                }
                return sum;
            }
			//修改车牌号
			function updateVehPlate(){
				if($(document.getElementById('vehPlate')).val()==""){
					alert("车牌号不能为空");
					return false;
				}
				if(Len($(document.getElementById('vehPlate')).val())>10){
					alert("车牌长度不能大于10位");
					return false;
				}
				$.ajax({
					type:"post",
					url:"lostCard_updateVehPlate.do?cardNo="+$(document.getElementById('cardNo1')).val()
					+ "&vehPlate="+encodeURI(encodeURI($(document.getElementById('vehPlate')).val())),
					success:function(res){
						$(res).find("massages > massage").each(function(){
							var op = $(this).attr("content");
							alert("   "+op);
								
						});
					}
				});
			}
			//修改状态
			function updateStatus(){
				var temp = $(document.getElementById('status')).val();
				if(temp ==""){
					alert("请选择卡状态");
					return false;
				}
				if(temp==13 || temp ==16){
					if(queryStatus==""){
						alert("需要该车的出口信息");
						return false;
					}
				}
				$.ajax({
					type:"post",
					url:"lostCard_updateStatus.do?cardNo="+$(document.getElementById('cardNo1')).val()+"&cardOpTime="+$(document.getElementById('qOpTime')).val()
					+ "&status="+$(document.getElementById('status')).val()+"&outListNo="+$('#outListNo').text(),
					success:function(res){			
						$(res).find("massages > massage").each(function(){
							var op = $(this).attr("content");
							alert("   "+op);
							if(op=="卡状态修改成功"){
								$("#ListStatus").empty();
								var tempStatus = $("#status");
								var tempSelect = document.getElementById('status');
								$("#ListStatus").append(tempSelect.options[tempSelect.selectedIndex].text);
							}
						});
					}
				});
			}
			//选择卡状态时，控制提示是否显示
			function toChange(obj){
				if(obj.value==13 || obj.value==16){
					alert("需要对比出口信息");
				}
			}
			//查询出口信息
			function search(){
				if(document.getElementById('qOpTime').value==""){
					alert("时间格式有误！");
					return;
				}
				if(document.getElementById('days').value==""){
					alert("间隔天数不能为空！");
					return;
				} else {
					if(document.getElementById('days').value>365){
						alert("间隔天数不大于365！");
					    return;
					}
					var partten=/^[0-9]*$/;
					if(!partten.test((document.getElementById('days').value))){
						alert("间隔天数格式不符号，请重新输入（比如：30或者300）");
					    return;
					}
					
				}
				document.getElementById('waiting').style.display='inline';
				$.ajax({
					type:"post",
					url:"lostCard_queryByOpTimeAndVehPlate.do?days="+$(document.getElementById('days')).val()
						+ "&backNums="+$(document.getElementById('backNums')).val()
						+ "&vehPlate="+encodeURI(encodeURI($(document.getElementById('qVehPlate')).val()))
						+ "&opTime="+$(document.getElementById('qOpTime')).val(),
					success:function(res, status){
						document.getElementById('waiting').style.display='none';
						$("#dataId").empty();
						i = 0;
						arr = arr.splice(0);//将数组清空
						imgArr = imgArr.splice(0);//将图片操作数字清空
						$(res).find("allOutLists > allOutList").each(function(){
							var op = $("<table cellspacing='1' class='pn-ftable' bodercolor='#ffaa00'><tr><td width='10%' class='pn-flabel pn-flabel-h'>流 水 号：</td><td width='15%' class='pn-fcontent' id='outListNo'>"+$(this).attr("listNo")+"</td><td width='10%' class='pn-flabel pn-flabel-h'>小 区 名：</td><td width='15%' class='pn-fcontent'>"+$(this).attr("parkName")+"</td></tr><tr><td width='10%' class='pn-flabel pn-flabel-h'>用户卡号：</td><td width='15%' class='pn-fcontent'>"
								+$(this).attr("cardNo")+"</td><td width='10%' class='pn-flabel pn-flabel-h'>大 门 名：</td><td width='15%' class='pn-fcontent'>"+$(this).attr("gateName")+"</td></tr><tr><td width='10%' class='pn-flabel pn-flabel-h'>车 牌 号：</td><td width='15%' class='pn-fcontent'>"
								+$(this).attr("vehplate")+"</td><td width='10%' class='pn-flabel pn-flabel-h'>车 道 号：</td><td width='15%' class='pn-fcontent'>"+$(this).attr("laneNo")+"</td></tr><tr><td width='10%' class='pn-flabel pn-flabel-h'>时    间：</td><td width='15%' class='pn-fcontent'>"
								+$(this).attr("opTime")+"</td><td width='10%' class='pn-flabel pn-flabel-h'>操 作 员：</td><td width='15%' class='pn-fcontent'>"+$(this).attr("operatorName")+"</td></tr><tr><td width='10%' class='pn-flabel pn-flabel-h'>备   注：</td><td colspan='3'class='pn-fcontent'>"
								+$(this).attr("outRemark")+"</td></tr><tr><td colspan='4'class='pn-fcontent'>&nbsp;&nbsp;<br/><b>出口图像</b><br/><br/><img id='imgSrc'/></td></tr></table>");
							arr[i] = op;
							imgArr[i] = $(this).attr("pic");
							i = i+1;
						});
						if(arr.length > 0){
							$("#dataId").append(arr[0]);
							document.getElementById('imgSrc').src="lostCard_readImg.do?imagSrc="+imgArr[0];
							document.getElementById('nowRecord').value=1;
						}else{
							document.getElementById('nowRecord').value=0;
						}
						i=0;
						queryStatus = "0";
						if(arr.length ==1 || arr.length == 0){
							document.getElementById('currRecord').style.display='none';
							document.getElementById('nextRecord').style.display='none';
						}else{
							document.getElementById('currRecord').style.display='none';
							document.getElementById('nextRecord').style.display='inline';
						}	
						document.getElementById('totalRecord').value=arr.length;
						document.getElementById('countsId').style.display='inline';
					}
				});
			}
			//获取下一条数据
			function getNextRecord(){
				for(n=0;n<arr.length;n++){
					if(i==n){
						document.getElementById('imgSrc').src="";
						$("#dataId").empty();
						$("#dataId").append(arr[i+1]);
						document.getElementById('imgSrc').src="lostCard_readImg.do?imagSrc="+imgArr[i+1];
						break;
					}
				}
				document.getElementById('nowRecord').value=i+2;
				if((i+2)==arr.length){
					document.getElementById('currRecord').style.display='inline';
					document.getElementById('nextRecord').style.display='none';
				}else{
					document.getElementById('currRecord').style.display='inline';
					document.getElementById('nextRecord').style.display='inline';
				}
				i=i+1;
			}
			//获得上一条数据
			function getCurrRecord(){
				for(n=0;n<arr.length;n++){
					if(i==n){
						document.getElementById('imgSrc').src="";
						$("#dataId").empty();
						$("#dataId").append(arr[i-1]);
						document.getElementById('imgSrc').src="lostCard_readImg.do?imagSrc="+imgArr[i-1];
						break;
					}
				}
				document.getElementById('nowRecord').value=i;
				if((i-1)==0){
					document.getElementById('currRecord').style.display='none';
					document.getElementById('nextRecord').style.display='inline';
				}else{
					document.getElementById('currRecord').style.display='inline';
					document.getElementById('nextRecord').style.display='inline';
				}
				i=i-1;
			}
			function back(id,count,startTime,endTime,cardNo,status,vehPlate){
				window.location.href = "lostCard_queryCardDynamic.do?pager.currentPage="+id+"&pager.pageSize="+count+"&startTime="+startTime+"&endTime="+endTime+"&cardNo="+cardNo+"&status="+status+"&vehPlate="+vehPlate;
			}
		--></script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" 返 回 " onclick="back(${pager.currentPage },${pager.pageSize },'${startTime}','${endTime}','${cardNo}','${status}','${vehPlate}');"/>
				</form>
				<div class="clear"></div>
			</div>
			<table width="850" cellspacing="1" class="pn-ftable" bodercolor="#ffaa00">
				<tr>
					<!-- 放入口信息 -->
					<td class="pn-fcontent" width="50%">
						<table cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
							<tr>
								<td class="pn-fcontent">
									<table cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
										<tr>									
											<td width="13%" class="pn-flabel pn-flabel-h">车牌号：</td>
											<td class="pn-fcontent">
												<input type="text" name="vehPlate" id="vehPlate" value="${cardDynamic.vehPlate }" style="width: 60px"/>&nbsp;
												<input type="button" value="修 改" onclick="updateVehPlate();"/>
											</td>		
											<td width="13%" class="pn-flabel pn-flabel-h">卡状态：</td>
											<td class="pn-fcontent">
												<select name="status" id="status" onchange="toChange(this);">
													<option value="">-请选择-</option>
													<option value="13">&nbsp;丢 卡</option>
													<option value="14">&nbsp;未 知</option>
													<option value="15">&nbsp;坏 卡</option>
													<option value="16">&nbsp;已罚款</option>
													<option value="12">&nbsp;已回收</option>
												</select>
												<input type="button" value="确 认" onclick="updateStatus();"/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="pn-fcontent">
									<table width="100%" cellspacing="1" class="pn-ftable" bodercolor="#ffaa00">
										<tr>
											<td colspan="4" class="pn-fcontent">
											<br/>入口信息：<br/>
											</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">流 水 号：</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.inListNo }</td>
											<td width="10%" class="pn-flabel pn-flabel-h">小 区 名：</td>
											<td width="15%" class="pn-fcontent">
												<c:forEach items="${parkList}" var="temp">
													<c:if test="${temp.parkNo == cardDynamic.parkNo}">${temp.parkName}</c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">卡表面号：</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.cardNo }</td>
											<td width="10%" class="pn-flabel pn-flabel-h">大 门 名：</td>
											<td width="15%" class="pn-fcontent">
												<c:forEach items="${gateList}" var="temp">
													<c:if test="${temp.gateNo == cardDynamic.gateNo}">${temp.gateName}</c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">车 牌 号：</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.vehPlate }</td>
											<td width="10%" class="pn-flabel pn-flabel-h">车 道 号：</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.laneNo }</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">时    间：</td>
											<td width="15%" class="pn-fcontent"><fmt:formatDate value="${cardDynamic.opTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td width="10%" class="pn-flabel pn-flabel-h">发 卡 员：</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.operatorName }</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">卡 状 态：</td>
											<td width="15%" class="pn-fcontent" id="ListStatus">
												<c:if test="${cardDynamic.status == 11}">入口发卡</c:if>
												<c:if test="${cardDynamic.status == 12}">出口回收</c:if>
												<c:if test="${cardDynamic.status == 13}">丢卡(丢失数据不足，无法追回)</c:if>
												<c:if test="${cardDynamic.status == 14}">未知</c:if>
												<c:if test="${cardDynamic.status == 15}">坏卡</c:if>
												<c:if test="${cardDynamic.status == 16}">已罚款</c:if>
											</td>
											<td width="10%" class="pn-flabel pn-flabel-h">车 主 名：</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.owner}</td>
										</tr>
										<tr>
											<td class="pn-fcontent" colspan="4">
												&nbsp;&nbsp;<br/><b>入口图像：</b><br/><br/>
												<img src="lostCard_readImg.do?imagSrc=${imagSrc }" alt="无图片"/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<!-- 放出口信息 -->
					<td class="pn-fcontent" valign="top">
						<table  cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
							<tr>
								<td class="pn-fcontent">
									<table cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
										<tr>									
											<td class="pn-fcontent" align="left">
												&nbsp;&nbsp;天数：
												<input type="text" name="days" id="days" value="${days }" style="width: 20px;height: 13px"/>&nbsp;天，返回条数：
												<select name="backNums" id="backNums" style="width: 40px">
													<option value="10"<c:if test="${backNums==10 }"> selected </c:if>>10</option>
													<option value="20"<c:if test="${backNums==20 }"> selected </c:if>>20</option>
													<option value="30"<c:if test="${backNums==30 }"> selected </c:if>>30</option>
													<option value="40"<c:if test="${backNums==40 }"> selected </c:if>>40</option>
													<option value="50"<c:if test="${backNums==50 }"> selected </c:if>>50</option>
												</select>&nbsp;条&nbsp;&nbsp;
												<input type="button" value="查询" onclick="search();"/> &nbsp; <span id="waiting" style="display: none"><font color="red">查询中...</font></span>
												<input type="hidden" name="qOpTime" id="qOpTime" value="${cardDynamic.opTime }"/><!-- 操作时间 -->
												<input type="hidden" name="qVehPlate" id="qVehPlate" value="${cardDynamic.vehPlate }" /><!-- 车牌号 -->
												<input type="hidden" name="cardNo1" id="cardNo1" value="${cardDynamic.cardNo }"><!-- 卡表面号 -->
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="pn-fcontent">
									<table cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
										<tr>
											<td class="pn-fcontent">
												<br/>出口信息：						
												<div id="dataId">
												
												</div>
											</td>
										</tr>
										<tr>
											<td class="pn-fcontent">
												<div id="countsId" style="display: none;">
													当前第<input type="text" id="nowRecord" size="1" style="border-left:0px;border-top:0px;border-right:0px;border-bottom:0px"/>条
													/共有<input type="text" id="totalRecord" size="1" style="border-left:0px;border-top:0px;border-right:0px;border-bottom:0px"/>条
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="button" value="上一条" onclick="getCurrRecord();" style="display: none;" id="currRecord"/>
													&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="下一条" onclick="getNextRecord();" style="display: none;" id="nextRecord"/>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
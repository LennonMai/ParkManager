<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			window.onload = function() {
		  	  var ifr_height = $(window).height() - $("#div1").height() - $("#div2").height() - 30;
		  	  var iframe = $("#iframe").height(ifr_height);
		    }
		    function changeSize() {
		  	  var ifr_height = $(window).height() - $("#div1").height() - $("#div2").height() - 30;
		  	  var iframe = $("#iframe").height(ifr_height);
		    }
		    
		    var pLaneNo="";
		    var parks="";
		    
			function share() {
				pLaneNo="";
				parks="";
				var parkString = "${parkString}";
				
				//拼接选取的字符串值
			  	for(i=0;i<document.getElementsByName("parkNo").length;i++) {
			  		if(document.getElementsByName("parkNo")[i].checked==true) {
			  			parks=parks+document.getElementsByName("parkNo")[i].value+",";
			  		}
			    }
			    //判断是否有选择校区
			    if(parks == "") {
			    	alert("请选择校区");
			    	return false;
			    } else {
			    	//返回如0,1,2字符串
			    	parks=parks.substring(0,parks.length-1);
			    }
			   // alert(parks);
			    
			    //车道数组
			    var idTemp;
			  	if("" != parkString) {
			  		parkList = parkString.split(",");
			  		for(p=0; p<parkList.length; p++) {
			  			idTemp = "right" + parkList[p];
			  			for(i=0;i<document.getElementById(idTemp).length;i++) {
			  				pLaneNo = pLaneNo + document.getElementById(idTemp)[i].value + ",";
			  			}
			  		}
			  		//返回如0,1字符串
			  		pLaneNo = pLaneNo.substring(0,pLaneNo.length-1);
			  	}
			  	if("" == pLaneNo) {
			  		alert("请选择车道");
			  		return false;
			  	}
		  	} 

			
		  	//生成HTML报表
		  	function saveAndPrint(){
				var tempBool = share();
				if(tempBool == false) {
					return false;
				}
			    //计算相差天数
				var countDay = compTime(get("startTime").value, get("endTime").value);
				if(countDay > 10) {
					if(confirm("所选日期超过10天，采用HTML方式生成报表可能需要较长时间，是否采用PDF方式生成报表？")) {
					  	saveAndPrintPDF();
					  	return true;
				  	}
			  	}
			  	
			  	//验证日期
			  	if(checkTime() == false) {
				  	return false;
				} else {
					window.open("tollsReport_tollsLaneReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&pLaneNo="+pLaneNo+"&parkNo="+parks);
			    }
		  	}

		  	 //生成当前页面HTML报表
			  function saveAndPrintCurrentPage(){
					var tempBool = share();
					if(tempBool == false) {
						return false;
					}
				    //计算相差天数
					var countDay = compTime(get("startTime").value, get("endTime").value);
					if(countDay > 10) {
						if(confirm("所选日期超过10天，采用HTML方式生成报表可能需要较长时间，是否采用PDF方式生成报表？")) {
						  	saveAndPrintPDF();
						  	return true;
					  	}
				  	}
				  	
				  	//验证日期
				  	if(checkTime() == false) {
					  	return false;
					} else {
						window.belowFrame.location.href="tollsReport_tollsLaneReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&pLaneNo="+pLaneNo+"&parkNo="+parks;
				    }
			  }
		  	
		  	//生成PDF报表
		  	function saveAndPrintPDF() {
		  		var tempBool = share();
				if(tempBool == false) {
					return false;
				}
		  		if(checkTime() == false) {
			  		return false;
				} else {
					window.open("tollsReport_tollsLaneReportPDF.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&pLaneNo="+pLaneNo+"&parkNo="+parks);
		    	}
		  	}
		  	//校验日期
		  	function checkTime() {
		  		if(get("startTime").value == null || get("startTime").value == "" || get("endTime").value == null || get("endTime").value == "" ) {
		      		alert("统计时间不能为空");
		      		return false;
		    	}
		    	if(get("startTime").value > get("endTime").value) {
		      		alert("开始时间必须早于或等于结束时间");
		    		return false;
		    	}
		  	}
		  	//计算日期差
		  	function compTime(beginTime,endTime){
		  		var s1 = beginTime.replace(/-/g, "/");
				var s2 = endTime.replace(/-/g, "/");
				d1 = new Date(s1);
				d2 = new Date(s2);
			
				var time= d2.getTime() - d1.getTime();
				var days = parseInt(time / (1000 * 60 * 60 * 24));
			
				return days;
		  	}
		  	//移动两个复选框选项
			function moveOption(e1, e2) {
				for(var i=0;i<e1.options.length;i++){
					if(e1.options[i].selected) {
				   		var e = e1.options[i];
				   		e2.options.add(new Option(e.text, e.value));
				   		e1.remove(i);
				   		i=i-1;
				  	}
				}
			}
			//移动所有复选框选项
			function moveAllOption(e1, e2) {
				for(var i=0;i<e1.options.length;i++){
				   	if(e1.options[i]) {
				   		var e = e1.options[i];
				   		e2.options.add(new Option(e.text, e.value));
				   		e1.remove(i);
				   		i=i-1;
				  	}
				}
			}
			//隐藏、显示结构
			function secBoard(n){
				var mainTable = document.getElementById('mainTable');
				for(i=0;i<mainTable.tBodies.length;i++){
					mainTable.tBodies[i].style.display="none";
				}
				var tempId = document.getElementById(n);
				tempId.style.display="block";
				
				var mainTableMid = document.getElementById('mainTableMid');
				for(i=0;i<mainTableMid.tBodies.length;i++){
					mainTableMid.tBodies[i].style.display="none";
				}
				var midN = "M"+n;
				var tempId = document.getElementById(midN);
				tempId.style.display="block";
				
				var mainTableRight = document.getElementById('mainTableRight');
				for(i=0;i<mainTableRight.tBodies.length;i++){
					mainTableRight.tBodies[i].style.display="none";
				}
				var rightN = "R"+n;
				var tempIdR = document.getElementById(rightN);
				tempIdR.style.display="block";
			}
		</script>
	</head>
	<body onResize="changeSize()">
		<div class="body-box">
			<div id="div1" class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<div id="div2">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="30%" class="pn-flabel pn-flabel-h">
							校&nbsp;&nbsp;&nbsp;&nbsp;区：
						</td>
						<td width="70%" class="pn-fcontent">
						<c:forEach items="${parkList}" var="park">
							<input type="radio" name="parkNo" value="${park.parkNo}" onclick="secBoard('tbody${park.parkNo }')" />${park.parkName }
						</c:forEach>
					</td>
					</tr>
					<tr>
						<td width="30%" class="pn-flabel pn-flabel-h">统计时间范围：</td>
						<td width="70%" class="pn-fcontent">
						  <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime"  value="${endTime }"  class="Wdate" onClick="WdatePicker()">
						  &nbsp;<font style="color:red">*</font>
						  <!-- <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" class="Wdate" onClick="WdatePicker()"> -->
						</td>
					</tr>
					<tr>
						<td width="30%" class="pn-flabel pn-flabel-h">车道：</td>
						<td  width="70%" class="pn-fcontent">
						<table width="400" height="165" style="display: inline" border="1">
										<tr>
											<td>
												<CENTER>可选择车道</CENTER>
											</td>
											<td></td>
											<td>
												<CENTER>已选择车道</CENTER>
											</td>
										</tr>
										<tr>
											<td height="150">
												<table cellPadding="0" cellSpacing="0" border="0">
													<tr>
														<td height="100%">
															<TABLE id=mainTable cellSpacing=0 cellPadding=0 border=0 width="100%">
																<c:forEach items="${list}" var="lane">
																	<!--关于TBODY标记-->
																	<c:forEach items="${lane}" var="temp" begin="0" end="0">
																		<TBODY style="DISPLAY: none" id="tbody${temp.parkNo }">
																	</c:forEach>
																	<TR>
																		<TD vAlign=top>
																			<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
																				<TBODY>
																					<TR>
																						<TD>
																							<c:forEach items="${lane}" var="temp1" begin="0" end="0">
																								<select multiple name="left" size="9" id="left${temp1.parkNo }" style="width:150px" ondblclick="moveOption(document.getElementById('left${temp1.parkNo }'), document.getElementById('right${temp1.parkNo }'))">
																							</c:forEach>
																							<c:forEach items="${lane}" var="item" begin="1">
																								<option value="${item.laneNo}">
																									${item.laneNo}
																								</option>
																							</c:forEach>
																								</select>
																						</TD>
																					</TR>
																				</TBODY>
																			</TABLE>
																		</TD>
																	</TR>
																		</TBODY>
																	</c:forEach>
															</TABLE>
														</td>
													</tr>
												</table>
											</td>
											<td width="20%" align="center">
												<TABLE id=mainTableMid cellSpacing=0 cellPadding=0 border=0
													width="100%">
													<c:forEach items="${list}" var="lane">
														<!--关于TBODY标记-->
														<c:forEach items="${lane}" var="temp" begin="0" end="0">
															<TBODY style="DISPLAY: none" id="Mtbody${temp.parkNo }">
														</c:forEach>
														<TR>
															<TD vAlign=top>
															<c:forEach items="${lane}" var="temp1" begin="0" end="0">
																<input type="button" value=" >>>> "
																	onClick="moveAllOption(document.getElementById('left${temp1.parkNo }'), document.getElementById('right${temp1.parkNo }'))">
																<input type="button" value="  >>  "
																	onClick="moveOption(document.getElementById('left${temp1.parkNo }'), document.getElementById('right${temp1.parkNo }'))">
																<br>
																<br>
																<input type="button" value="  <<  "
																	onClick="moveOption(document.getElementById('right${temp1.parkNo }'), document.getElementById('left${temp1.parkNo }'))">
																<input type="button" value=" <<<< "
																	onClick="moveAllOption(document.getElementById('right${temp1.parkNo }'), document.getElementById('left${temp1.parkNo }'))">
															</c:forEach>
															</TD>
														</TR>
														</TBODY>
													</c:forEach>
												</TABLE>
											</td>
											<td width="40%">
												<table>
													<tr>
														<td height="100%" width="50%">
															<TABLE id=mainTableRight cellSpacing=0 cellPadding=0
																border=0 width="100%">
																<c:forEach items="${list}" var="lane">
																	<!--关于TBODY标记-->
																	<c:forEach items="${lane}" var="temp" begin="0" end="0">
																		<TBODY style="DISPLAY: none" id="Rtbody${temp.parkNo }">
																	</c:forEach>
																	<TR>
																		<TD vAlign=top>
																			<TABLE border=0 cellPadding=0 cellSpacing=0 width="100%">
																				<TBODY>
																					<TR>
																						<TD>
																							<c:forEach items="${lane}" var="temp1" begin="0" end="0">
																								<select multiple name="right" size="9" style="width:150px"
																								id="right${temp1.parkNo }"
																								ondblclick="moveOption(document.getElementById('right${temp1.parkNo }'), document.getElementById('left${temp1.parkNo }'))">
																							</select>
																						</c:forEach>
																					</TD>
																				</TR>
																			</TBODY>
																		</TABLE>
																	</TD>
																</TR>
																</TBODY>
															</c:forEach>
														</TABLE>
													</td>
												</tr>
											</table>
									</tr>
								</table>
					</td>
					</tr>
					<tr align="center">
						<td style="padding-top: 5px;padding-bottom: 5px;" colspan="2" class="pn-fcontent">
						  <input type="button" value="生成HTML报表" onclick="return saveAndPrint()">&nbsp;
						  <input type="button" value="生成PDF报表" onclick="return saveAndPrintPDF()">&nbsp;
						  <input type="button" value="&nbsp;查&nbsp;&nbsp;询&nbsp;" onclick="return saveAndPrintCurrentPage()">
					</td>
					</tr>
				</table>
			</div>
			<iframe id="iframe" frameborder="0" src="" name="belowFrame" scrolling="auto"  width="100%">
			</iframe>
		</div>
	</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
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
            //数据提交前进行检测
			function check(){	
				if(document.getElementsByName('securityCommand.type')[0].value==""){
					$("#securityCommandType").empty();
					$("#securityCommandType").append("请选择指令类型");
					return false;
				}else{
					$("#securityCommandType").empty();
				}
				if(document.getElementsByName('securityCommand.cardNo')[0].value==""){
					$("#securityCommandCardNo").empty();
					$("#securityCommandCardNo").append("卡号不能为空");
					return false;
				}else{
					$("#securityCommandCardNo").empty();
				}
				if(document.getElementsByName('vehPlate1')[0].value == ""){
					$("#vehPlate2").empty();
					$("#vehPlate2").append("车牌号不能为空");
					return false;
				}else{
					$("#vehPlate2").empty();
				}
				if(document.getElementsByName('securityCommand.validType')[0].value=='1'){
					if(document.getElementById('dayStartTime').value==""){
						$("#tishiTime").empty();
						$("#tishiTime").append("每日有效开始时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('dayEndTime').value==""){
						$("#tishiTime").empty();
						$("#tishiTime").append("每日有效结束时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('dayStartTime').value>document.getElementById('dayEndTime').value){
						$("#tishiTime").empty();
						$("#tishiTime").append("开始时间不能大于结束时间");
						return false;
					}else{
						$("#tishiTime").empty();
					}
				}
				if(document.getElementsByName('securityCommand.validType')[0].value=='2'){
					if(document.getElementsByName('securityCommand.startTime')[0].value==""){
						$("#tishiTime").empty();
						$("#tishiTime").append("当次有效开始时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementsByName('securityCommand.endTime')[0].value==""){
						$("#tishiTime").empty();
						$("#tishiTime").append("当次有效结束时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementsByName('securityCommand.startTime')[0].value>document.getElementsByName('securityCommand.endTime')[0].value){
						$("#tishiTime").empty();
						$("#tishiTime").append("开始时间不能大于结束时间");
						return false;
					}else{
						$("#tishiTime").empty();
					}
				}
				if(document.getElementsByName('securityCommand.validType')[0].value=='9'){
					if(document.getElementById('times').value==""){
						$("#tishiTime").empty();
						$("#tishiTime").append("快速操作时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
				}
				return true;
			}
			//选择指令类型时进行检测
			function addType(obj){
				if(obj.value==1){
					var objSelect = document.getElementsByName('securityCommand.validType')[0];
					objSelect.options.length = 0;
					var varItem1 = new Option('每日有效','1');
					var varItem2 = new Option('当次有效','2');
					var varItem3 = new Option('永久有效','3');
					var varItem4 = new Option('不定时','4');
         			objSelect.options.add(varItem2);
         			objSelect.options.add(varItem1);
         			objSelect.options.add(varItem3);
         			objSelect.options.add(varItem4);
         			
         			document.getElementById('startTime').style.display = "inline";
					document.getElementById('endTime').style.display = "inline";
					document.getElementById('times').style.display = "none";
					document.getElementById('dayStartTime').style.display = "none";
					document.getElementById('dayEndTime').style.display = "none";
				}
				if(obj.value==2){
					var objSelect = document.getElementsByName('securityCommand.validType')[0];
					objSelect.options.length = 0;
					var varItem2 = new Option('当次有效','2');
					var varItem4 = new Option('不定时','4');
					objSelect.options.add(varItem2);
					objSelect.options.add(varItem4);
					
					document.getElementById('startTime').style.display = "inline";
					document.getElementById('endTime').style.display = "inline";
					document.getElementById('times').style.display = "none";
					document.getElementById('dayStartTime').style.display = "none";
					document.getElementById('dayEndTime').style.display = "none";
				}
				if(obj.value==""){
					var objSelect = document.getElementsByName('securityCommand.validType')[0];
					objSelect.options.length = 0;
					var varItem2 = new Option('-请选择-','');
					objSelect.options.add(varItem2);
				}
			}
			//选择有效类型
			function changeValid(obj){
				if(obj.value==1){
					document.getElementById('startTime').style.display = "none";
					document.getElementById('endTime').style.display = "none";
					document.getElementById('times').style.display = "none";
					document.getElementById('dayStartTime').style.display = "inline";
					document.getElementById('dayEndTime').style.display = "inline";
				}
				if(obj.value==2){
					document.getElementById('startTime').style.display = "inline";
					document.getElementById('endTime').style.display = "inline";
					document.getElementById('times').style.display = "none";
					document.getElementById('dayStartTime').style.display = "none";
					document.getElementById('dayEndTime').style.display = "none";
				}
				if(obj.value==3){
					document.getElementById('startTime').style.display = "none";
					document.getElementById('endTime').style.display = "none";
					document.getElementById('times').style.display = "none";
					document.getElementById('dayStartTime').style.display = "none";
					document.getElementById('dayEndTime').style.display = "none";
				}
				if(obj.value==4){
					document.getElementById('startTime').style.display = "none";
					document.getElementById('endTime').style.display = "none";
					document.getElementById('times').style.display = "none";
					document.getElementById('dayStartTime').style.display = "none";
					document.getElementById('dayEndTime').style.display = "none";
				}
			}
			//点击快速锁车
			function qucklyColse(){
				document.getElementsByName('securityCommand.type')[0].options[1].selected="true";
				var objSelect = document.getElementsByName('securityCommand.validType')[0];
				objSelect.options.length = 0;
				var varItem2 = new Option('当次有效','9');
				objSelect.options.add(varItem2);
				document.getElementById('startTime').style.display = "none";
				document.getElementById('endTime').style.display = "none";
				document.getElementById('times').style.display = "inline";
				document.getElementById('dayStartTime').style.display = "none";
				document.getElementById('dayEndTime').style.display = "none";		
			}
			//点击快速解锁
			function qucklyOpen(){
				document.getElementsByName('securityCommand.type')[0].options[2].selected="true";
				var objSelect = document.getElementsByName('securityCommand.validType')[0];
				objSelect.options.length = 0;
				var varItem2 = new Option('当次有效','9');
				objSelect.options.add(varItem2);
				document.getElementById('startTime').style.display = "none";
				document.getElementById('endTime').style.display = "none";
				document.getElementById('times').style.display = "inline";
				document.getElementById('dayStartTime').style.display = "none";
				document.getElementById('dayEndTime').style.display = "none";
			}
			function back(id,count){
				window.location.href = "securityCommand_query.do?pager.currentPage="+id+"&pager.pageSize="+count;
			}		
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<form class="ropt" method="post">
					
				</form>
				<div class="clear"></div>
			</div>
			<form method="post" action="securityCommand_addCommand.do" onsubmit="return check();">
				<table width="800" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">指令类型：</td>
						<td width="80%" class="pn-fcontent">
							<select name="securityCommand.type" onchange="addType(this);">
								<option value="">-请选择-</option>
								<option value="1">锁定</option>
								<option value="2">解锁</option>
							</select>&nbsp;<font style="color:red">*<label id="securityCommandType"></label></font>
							<input type="button" value="快速锁定" onclick="qucklyColse()"/>&nbsp;&nbsp;<input type="button" value="快速解锁" onclick="qucklyOpen()">
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
						<td width="80%" class="pn-fcontent">
							<input type="text" name="securityCommand.cardNo" size="20"/>&nbsp;<font style="color:red">*<label id="securityCommandCardNo"></label></font>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">车 牌 号：</td>
						<td width="80%" class="pn-fcontent">
							<input type="text" name="vehPlate1" size="20"/>&nbsp;<font style="color:red">*<label id="vehPlate2"></label></font>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">有效类型：</td>
						<td width="80%" class="pn-fcontent">
							<select name="securityCommand.validType" onchange="changeValid(this);">
								<option value="">-请选择-</option>
							</select>&nbsp;<font style="color:red">*</font>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">时 间 段：</td>
						<td width="80%" class="pn-fcontent">
							<input type="text" name="securityCommand.startTime" id ="startTime" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
							<input type="text" name="securityCommand.endTime" id="endTime" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
							<input name="times" id="times" type="text" class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" style="display: none" readonly="readonly"/>
							<input name="dayStartTime" id="dayStartTime" type="text" class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" style="display: none" readonly="readonly"/>
							<input name="dayEndTime" id="dayEndTime" type="text" class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" style="display: none" readonly="readonly"/>
							&nbsp;<font style="color:red"><label id="tishiTime"></label></font>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="submit" value=" 添 加 "/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value=" 返 回 " onclick="back(${pager.currentPage },${pager.pageSize });"/>
						</td>	
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
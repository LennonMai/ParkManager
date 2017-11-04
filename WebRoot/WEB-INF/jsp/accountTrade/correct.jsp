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
			if("${result}"=="SUCCESS")
				alert("更改成功");
				if("${result}"=="FAIL")
				alert("此类型卡已有此卡号");
				if("${result}"=="FAIL4")
				alert("账户余额不足（冲正后余额不能小于0），不可冲正");
				if("${result}"=="FAIL5")
					alert("账户卡号已换，不可冲正");
				
			//function correct1(){
			// if(check()==false){}
			 // else{
		     // window.location="accountTrade_correct1Edit.do?account.sys_id="+$("account.sys_id").value+"&accountTrade2.seqNo="+$("accountTrade2.seqNo").value+"&accountTrade.fee="+$("accountTrade.fee").value
		     // +"&accountTrade3.balance="+$("accountTrade3.balance").value+"&accountTrade2.fee="+$("accountTrade2.fee").value+"&accountTrade3.cardBalance="+$("accountTrade3.cardBalance").value;		       		  
		     //  }
		      // }
               function Run(strPath)
            {   if(document.getElementsByName("fee")[0].value>document.getElementsByName("account.balance")[0].value){
                  alert("账户卡余额不足（冲正后卡余额不能小于0）,不可冲正");}
                  else{
	           try   
	            {   
		    var objShell = new ActiveXObject("wscript.shell");   
		   // objShell.Run(strPath); 
		    objShell.Run('\"' + strPath + '\"');    
		    objShell = null;   
	        }   
	        catch(e)
	       {
	       	 
	         alert('找不到文件"'+strPath+'"(或它的组件之一)。请参照页面中文字说明')
	      
	       }   
	       }
       }   	
				
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <form method="post" action="accountTrade_correctEdit.do" >  
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">				
			
					<tr>
					  <td class="pn-flabel pn-flabel-h"> 账号：</td>
					  <td class="pn-fcontent"><input type="text" name="account.sys_id" value="${account.sys_id}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h">账号状态：</td>
					  <c:if test="${account.status==0}"><td class="pn-fcontent"><input type="text" name="account.status" value="有效"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==1}"><td class="pn-fcontent"><input type="text" name="account.status" value="挂失"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==2}"><td class="pn-fcontent"><input type="text" name="account.status" value="预销户"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==3}"><td class="pn-fcontent"><input type="text" name="account.status" value="余额不足"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==4}"><td class="pn-fcontent"><input type="text" name="account.status" value="其他"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==5}"><td class="pn-fcontent"><input type="text" name="account.status" value="已销户"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==6}"><td class="pn-fcontent"><input type="text" name="account.status" value="余额过低"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==7}"><td class="pn-fcontent"><input type="text" name="account.status" value="黑名单"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>					 
					 </tr>
					 <tr>
					  <td class="pn-flabel pn-flabel-h">卡号：</td>
					  <td  class="pn-fcontent"><input type="text" name="accountTrade.cardNo" value="${accountTrade.cardNo}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>	
					  <td class="pn-flabel pn-flabel-h">车牌号：</td>
					  <td  class="pn-fcontent"><input type="text" name="account.car.vehPlate" value="${account.car.vehPlate}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>	
					 </tr>
					 <tr>
					  <td class="pn-flabel pn-flabel-h">交易类型：</td>
					  <td class="pn-fcontent"> <input type="text" name="accountTrade.tradeType" value="冲正"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h"> 交易时间：</td>
					  <td class="pn-fcontent"><input type="text" name="accountTrade.opTime"  value="${accountTrade.opTime}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					 </tr>
					 <tr>
					  <td class="pn-flabel pn-flabel-h"> 交易流水号：</td>
					  <td colspan="3" class="pn-fcontent"><input type="text" name="accountTrade.listNo" value="${accountTrade.listNo}"   size="27" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>					
					 </tr>
					<tr>
					  <td class="pn-flabel pn-flabel-h">金额（元）：</td>
					  <td  class="pn-fcontent"><input type="text" name="fee" value="<fmt:formatNumber value="${accountTrade.fee/100}" pattern="#.##" type="number"/>"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>	
					  <td class="pn-flabel pn-flabel-h"> 账号当前的余额（元）：</td>
					 <td class="pn-fcontent"><input type="text" name="account.balance" value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>			
					</tr>
					<tr>
					 <c:if test="${param_card_type.pvalue!=1}"> <td colspan="4" class="pn-fbutton"><input type="submit" value=" 冲 正 "/> &nbsp;<input type="button" value=" 返 回 " onclick="history.back();"/></td></c:if>
					 <c:if test="${param_card_type.pvalue==1}"><td  colspan="4" class="pn-fbutton"><input type="button"   value=" 冲 正 " onclick="Run('${param_cardRechargeSystem_path.pvalue}');"/>&nbsp;<input type="button" value=" 返 回 " onclick="history.back();"/></td></c:if>						    
					</tr>													 
				</table>
					  <c:if test="${param_card_type.pvalue==1}">
					 如果无法从页面访问外部冲正程序，可能是与IE浏览器的设置有关,请尝试以下步骤，看看能否解决问题：<br>一.确认冲正程序已经安装在本机上且读卡器已连接到本机。<br><br>二.设置外部冲正程序路径<br>通过浏览器登录小区车辆中心管理应用后<br>在左边菜单选择："参数管理"-"其他参数配置"
	         <br>修改参数"CardRechargeSystem_path"的值为冲正程序安装路径即可，例如"E:\用户卡充值\CardRechargeSystem.exe"<br><br>三.清除浏览器的缓存<br>清除浏览器的缓存可能会解决遇到的问题。在 Internet Explorer 6.0 或更高版本中清除缓存的方法如下：<br>1. 打开 IE 并点击"工具"。<br>2. 选择"Internet 选项"。<br>3. 如果"常规"标签尚未选中，请点击此标签。
	         <br>4. 在"Internet 临时文件"标题下方，点击"删除文件"。<br>5. 点击"确定"退出。<br><br>四.确保 JavaScript、ActiveX 以及"二进制行为"已启用<br>在 IE 中启用上述浏览器设置：<br>1. 点击"工具" > "Internet 选项"。<br>2. 点击"安全"标签。<br>3. 点击"自定义级别"按钮。<br>4. 确认"运行 ActiveX 控件和插件"旁边的"启用"按钮已被选中。<br>5. 确认"二进制和脚本行为"旁边的"启用"按钮已被选中。'
	        <br>6. 确认"活动脚本"下的"启用"按钮已被选中。<br>7. 点击"确定"，然后再次点击"确定"保存更改。<br>另一种办法是，将应用服务的网址加入 Internet Explorer 的受信任站点列表。具体方法如下：<br>1. 点击"工具" > "Internet 选项"。<br>2. 点击"安全"标签。<br>3. 选择"受信任的站点"图标，然后点击"站点"按钮。<br>4. 取消选中"对该区域中的所有站点要求服务器验证 ( https:)"框'
	         <br>5. 在"将该网站添加到区域中:"文本框内，输入应用服务的网址，然后点击"添加"。<br>6. 点击"确定"，然后再次点击"确定"保存更改。<br>7. 将可信站点的安全级别调为"低"，点击"确定"保存更改。<br><br>五.为保证以上设置生效，需要重新启动浏览器。
	         </c:if>
			</form>
		</div>
	</body>
</html>

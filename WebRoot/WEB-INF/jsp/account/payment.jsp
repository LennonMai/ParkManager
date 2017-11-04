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
				String.prototype.trim = function() { 
                		// 用正则表达式将前后空格，用空字符串替代。 
                        return this.replace(/(^\s*)|(\s*$)/g, ""); 
              	} 		      		
			function check(){				
				if(document.getElementsByName("fee")[0].value==""){
					alert("充值金额不能为空，请重新输入.");
					document.getElementsByName("fee")[0].focus();
					return false;
				}				
				if(document.getElementsByName("fee")[0].value!=""){				
					var partten=/^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
					if(partten.test(document.getElementsByName("fee")[0].value)){
						if(document.getElementsByName("fee")[0].value>90000){				     
					    	alert("充值金额不能大于90000，请重新输入.");
					     	document.getElementsByName("fee")[0].focus();
						  	return false;
					    }
					    var partten1=/^[0]$/;
					    if(partten1.test(document.getElementsByName("fee")[0].value)){
					       alert("充值金额为正实数（例如50.5），请重新输入.");
					       document.getElementsByName("fee")[0].focus();
						   return false;
					    }              
					}
					else{
	                    alert("充值金额为正实数（例如50.5），请重新输入.");
	                    document.getElementsByName("fee")[0].focus();
						return false;
	                }
            	}			
        	}
           	function Run(strPath){  
	        	try{   
		    		var objShell = new ActiveXObject("wscript.shell");   
		   			// objShell.Run(strPath); 
		   			objShell.Run('\"' + strPath + '\"');   
		    		objShell = null;   
	       		} catch(e) {
	       			alert('找不到文件"'+strPath+'"(或它的组件之一)。请参照页面中文字说明')
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
			 <form method="post" action="account_paymentEdit.do" onsubmit="return check();">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">				
			
					<tr>
					  <td class="pn-flabel pn-flabel-h"> 账&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
					  <td class="pn-fcontent"><input type="text" name="account.sys_id" value="${account.sys_id}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h"> 卡&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
					  <td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    
					</tr>
					<tr>
					 
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
					 <td class="pn-flabel pn-flabel-h">交易类型：</td>
					 <td class="pn-fcontent"> <input type="text" name="accountTrade.tradeType" value="充值"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<c:if test="${param_card_type.pvalue!=1}">
					<tr>					
					<td class="pn-flabel pn-flabel-h"> 余额（元）：</td>
					<td class="pn-fcontent"><input type="text" name="account.balance" value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					<td class="pn-flabel pn-flabel-h">充值金额（元）：</td>
					<td  class="pn-fcontent"><input type="text" name="fee" />&nbsp;<font style="color:red">*</font></td>								
					</tr>
					</c:if>
					<c:if test="${param_card_type.pvalue==1}">
					<tr>					
					<td class="pn-flabel pn-flabel-h"> 余额（元）：</td>
					<td colspan="3" class="pn-fcontent"><input type="text" name="account.balance" value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>								
					</tr>
					</c:if>
					
					<tr>
						    <c:if test="${param_card_type.pvalue!=1}"> <td colspan="4" class="pn-fbutton"><input type="submit" value=" 充 值 "/> &nbsp;<input type="button" value=" 返 回 " onclick="history.back();"/></td></c:if>
							<c:if test="${param_card_type.pvalue==1}"><td  colspan="4" class="pn-fbutton"><input type="button"   value=" 充 值 " onclick="Run('${param_cardRechargeSystem_path.pvalue}');"/>&nbsp;<input type="button" value=" 返 回 " onclick="history.back();"/></td></c:if>						   																								    
					</tr>
					
					 </table>
				 <c:if test="${param_card_type.pvalue==1}">
					 如果无法从页面访问外部充值程序，可能是与IE浏览器的设置有关,请尝试以下步骤，看看能否解决问题：<br>一.确认充值程序已经安装在本机上且读卡器已连接到本机。<br><br>二.设置外部充值程序路径<br>通过浏览器登录小区车辆中心管理应用后<br>在左边菜单选择："参数管理"-"其他参数配置"
	              <br>修改参数"CardRechargeSystem_path"的值为冲正程序安装路径即可，例如"E:\用户卡充值\CardRechargeSystem.exe"<br><br>三.清除浏览器的缓存<br>清除浏览器的缓存可能会解决遇到的问题。在 Internet Explorer 6.0 或更高版本中清除缓存的方法如下：<br>1. 打开 IE 并点击"工具"。<br>2. 选择"Internet 选项"。<br>3. 如果"常规"标签尚未选中，请点击此标签。
	             <br>4. 在"Internet 临时文件"标题下方，点击"删除文件"。<br>5. 点击"确定"退出。<br><br>四.确保 JavaScript、ActiveX 以及"二进制行为"已启用<br>在 IE 中启用上述浏览器设置：<br>1. 点击"工具" > "Internet 选项"。<br>2. 点击"安全"标签。<br>3. 点击"自定义级别"按钮。<br>4. 确认"运行 ActiveX 控件和插件"旁边的"启用"按钮已被选中。<br>5. 确认"二进制和脚本行为"旁边的"启用"按钮已被选中。'
	             <br>6. 确认"活动脚本"下的"启用"按钮已被选中。<br>7. 点击"确定"，然后再次点击"确定"保存更改。<br>另一种办法是，将应用服务的网址加入 Internet Explorer 的受信任站点列表。具体方法如下：<br>1. 点击"工具" > "Internet 选项"。<br>2. 点击"安全"标签。<br>3. 选择"受信任的站点"图标，然后点击"站点"按钮。<br>4. 取消选中"对该区域中的所有站点要求服务器验证 ( https:)"框'
	             <br>5. 在"将该网站添加到区域中:"文本框内，输入应用服务的网址，然后点击"添加"。<br>6. 点击"确定"，然后再次点击"确定"保存更改。<br>7. 将可信站点的安全级别调为"低"，点击"确定"保存更改。<br><br>五.为保证以上设置生效，需要重新启动浏览器。					 
				</c:if>	
			</form>
		</div>
	</body>
</html>

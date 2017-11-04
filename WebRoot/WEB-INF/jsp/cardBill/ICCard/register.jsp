<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>IC卡登记</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script> 
		<script type="text/javascript" src="${basePath}/js/CJL.0.1.min.js"></script>  
		<script type="text/javascript" src="${basePath}/js/MSGalert.js"></script>
		<script language="javascript">
		if("${result}" == "SUCCESS") {
			alert("导入IC卡登记信息记录总数为"+(${countSuccess}+${countFail})+"条，"+${countSuccess}+"条记录导入成功，"+'${countFail}'+"条记录失败！");
		}
		
		if("${result}" == "FAIL") {
			alert("txt文件内容格式不正确，请重新选择！");
		}
		//运行exe
	    function runExe(strPath) {
	    	try {
	    		var objShell = new ActiveXObject("wscript.shell");
	    		objShell.Run('\"' + strPath + '\"');
	    		objShell = null;
	    	} catch(e) {
	    		alert('找不到文件"'+strPath+'"(或它的组件之一)。请参照页面中文字说明');
	    	}
	    }
	    //检查文件
	    function checkFile() {
	    	if(!isTXT(get("txtFile").value)) {
	    		alert("请选择一个txt文件！");
	    		return false;
	    	}
	    }
	    //判断txt文件
	    function isTXT(file) {
	    	if(file.indexOf(".")>0) {
	    		var arr = file.split(".");
	    		var type = arr[arr.length-1].toLowerCase();
	    		if(type == "txt") {
	    			showMsgAlert();
	    			return true;
	    		} else {
	    			return false;
	    		}
	    	}
	    }
	    //1-6记录数
			var count=1;
            function insert(){
            	var text="参数数据正在导入中，请稍候";
            	if(count<=6&&count>0){
            		if(count==1)text=text+".";
            		if(count==2)text=text+"..";
            		if(count==3)text=text+"...";
            		if(count==4)text=text+"....";
            		if(count==5)text=text+".....";
            		if(count==6)text=text+"......";
            		count++;
                	}else {
                		count=1;
                    }
                $$("MSGtext").innerHTML ='<b>'+text+'</b>';
                } 
			function showMsgAlert(){
				var ab = new MSGalert("idMSG");
				var lock = true;
				
				//锁定键盘
				function lockup(e){ e.preventDefault(); }
				//高亮层不锁定
				function lockout(e){ e.stopPropagation(); }

				ab.onShow = function(){
					if (lock) {
						$$E.addEvent( document, "keydown", lockup );
						$$E.addEvent( this.box, "keydown", lockout );
						OverLay.show();
					}
				}
				ab.onClose = function(){
					$$E.removeEvent( document, "keydown", lockup );
					$$E.removeEvent( this.box, "keydown", lockout );
					OverLay.close();
				}
				ab.center = true;
				$$("MSGtext").innerHTML ='<b>参数数据正在导入中，请稍候</b>';
				ab.show();
				//定时更新导入提示内容
                setInterval("insert()",500);
                $$("idMSGClose").onclick = function(){if(confirm("\n确认要取消导入提示吗？取消后不影响数据导入，请耐心等待数据导入完毕！ ")){ ab.close();}}
				//$$("importExcle").onclick = function(){}
				}				
		</script>
		<style>
.MSGalert {
	width: 360px;
	background: #FFFFFF;
	border:1px solid #9DBCEA;
	line-height: 30px;
	display: none;
	margin: 0;
}

.MSGalert dt {
	/**PADDING-RIGHT: 2px;  PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#FFFFFF, EndColorStr=#9DBCEA);  CURSOR: hand; PADDING-TOP: 2px; */
	PADDING-LEFT: 5px;
	PADDING-TOP: 2px;
	padding-bottom: 5px; 
	FONT-SIZE: 12px; 
	font-weight:bold; 
	background-image:url(image/MSGalert.png);
	height: 24px;
}

.MSGalert dd {
	padding: 20px;
	margin: 0;
}

.btn {
	PADDING-RIGHT: 2px;  PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#FFFFFF, EndColorStr=#9DBCEA);   PADDING-TOP: 2px;
}
</style>
	</head> 
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">
					当前位置： ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" name="tableForm" method="post"
				action="iCCard_insertTxtData.do" enctype="multipart/form-data" onsubmit="return checkFile();">
				<table align="center" id="controltb" class="pn-ltable" width="100%"
					cellspacing="1" cellpadding="0" border="0">
					<thead class="pn-lthead">
						<tr>
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;"></th>
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;"></th>
						</tr>
					</thead>
					<tbody class="pn-ltbody">
						<tr>
							<td align="right" width="40%">
								IC卡登记：
							</td>
							<td style="font-weight: bold; padding-left: 20px;"  width="60%">
								<input type="button" value="开始登记" onclick="runExe('${param_cardInit.pvalue }')" />
							</td>
						</tr>
						<tr>
							<td align="right"  width="40%">
								选择导入文件：
							</td>
							<td style="font-weight: bold; padding-left: 20px;"  width="60%">
								<input type="file" name="txtFile" />&nbsp;&nbsp;&nbsp;&nbsp;
          					</td>  
   						</tr>
		  				<tr>
							<td colspan="2" class="pn-fbutton" style="padding-top: 5px;padding-bottom: 5px;">
								<input type="submit" value="导入数据库" />
								<!-- <input type="button" value="  返 回  " onclick="history.back();" /> -->
							</td>	    
						</tr> 
				</tbody>
				</table>
				<dl id="idMSG" class="MSGalert" style="top:10%;left:5%;">
					<dt>导入提示&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<img id="idMSGClose" src="image/MSGalert_C1.png" onmouseout="this.src='image/MSGalert_C1.png'" onmousemove="this.src='image/MSGalert_C2.png'" />
					</dt>
					<dd id="MSGtext">
					</dd>
				</dl>
				<br/>
				如果无法从页面访问外部登记程序，可能是与IE浏览器的设置有关,请尝试以下步骤，看看能否解决问题：<br>一.确认登记程序已经安装在本机上且读卡器已连接到本机。<br><br>二.确认登记程序已经安装在弹出的路径中。<br><br>三.清除浏览器的缓存<br>清除浏览器的缓存可能会解决遇到的问题。在 Internet Explorer 6.0 或更高版本中清除缓存的方法如下：<br>1. 打开 IE 并点击"工具"。<br>2. 选择"Internet 选项"。<br>3. 如果"常规"标签尚未选中，请点击此标签。
	         	<br>4. 在"Internet 临时文件"标题下方，点击"删除文件"。<br>5. 点击"确定"退出。<br><br>四.确保 JavaScript、ActiveX 以及"二进制行为"已启用<br>在 IE 中启用上述浏览器设置：<br>1. 点击"工具" > "Internet 选项"。<br>2. 点击"安全"标签。<br>3. 点击"自定义级别"按钮。<br>4. 确认"运行 ActiveX 控件和插件"旁边的"启用"按钮已被选中。<br>5. 确认"二进制和脚本行为"旁边的"启用"按钮已被选中。'
	        	<br>6. 确认"活动脚本"下的"启用"按钮已被选中。<br>7. 点击"确定"，然后再次点击"确定"保存更改。<br>另一种办法是，将应用服务的网址加入 Internet Explorer 的受信任站点列表。具体方法如下：<br>1. 点击"工具" > "Internet 选项"。<br>2. 点击"安全"标签。<br>3. 选择"受信任的站点"图标，然后点击"站点"按钮。<br>4. 取消选中"对该区域中的所有站点要求服务器验证 ( https:)"框'
	         	<br>5. 在"将该网站添加到区域中:"文本框内，输入应用服务的网址，然后点击"添加"。<br>6. 点击"确定"，然后再次点击"确定"保存更改。<br>7. 将可信站点的安全级别调为"低"，点击"确定"保存更改。<br><br>五.为保证以上设置生效，需要重新启动浏览器。
			</form>
		</div>
	</body>
</html>
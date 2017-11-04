<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>ImportExcel</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script> 
		<script type="text/javascript" src="${basePath}/js/CJL.0.1.min.js"></script>  
		<script type="text/javascript" src="${basePath}/js/MSGalert.js"></script>   
		<script language="javascript">

		if("${excelFormat}"=="noPrimarykey"){		
		alert("无法完成更新： \n\n    更新到编号为 "+"${startFailRefleshNum}"+" 的行停止更新，导入的 Excel 表格中编号与该\n    参数对应的ID不一致，请将编号改成该参数在页面中对应的编号！");
	    }
		if("${excelFormat}"=="noThisFormate"){
			alert("无法完成更新，导入的Excel表格格式存在问题，请检查！");
		    }
		function IsNumber(num){
			  var reNum=/^\d*$/;
			  return(reNum.test(num));
			}
					
		if("${message}"!=""&&IsNumber("${message}")){
			if("${rowsNum}"=="0")
				alert("成功导入"+"${message}"+"条数据！");
			else
				alert("成功导入"+"${message}"+"条数据，"+"不符合导入规范的数据有"+"${rowsNum}"+"条！"); 
		    }
		if("${message}"=="ExcelToDBfail"){
			alert("导入不成功，不符合导入规范的数据有"+"${rowsNum}"+"条！");
		    }
    
			function checkFile(){  
				if(!isXLS(get("excelFile").value)){				
					alert("请选择一个Excel文件！");
					return false;  
					}
					
			}
			function isXLS(file){
				if(file.indexOf(".")>0){ 
					var o = file.split("."); 
					var e = o[o.length-1].toLowerCase(); 
					if(e == "xls"){
					showMSGalert();
					return true;} 
					else{ return false; }
					} 
					
				}
			function back(){
				history.back();
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
			function showMSGalert(){
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
		<div class="pn-sp">
		<form action="paramconf_excelDataToDB.do" method="post" enctype="multipart/form-data" onsubmit="return checkFile();">
        <input align="top" name="excelFile" type="file" size="32" style="height:22px" id="excelFile" value="dd"/>&nbsp;
		<input type="submit" style="padding-left: 8px;padding-right: 8px;" value="导入数据" />&nbsp;
		<input type="button" style="padding-left: 8px;padding-right: 8px;" value=" 返 回 " onclick="return back()"/>
	     <label id="importProcess" style="padding-left:580px;font-weight: bold;"></label>
	    <div class="clear"></div>
	     </form>
        </div>
        <table><tr><td>成功导入excel数据规范：</td></tr>
               <tr><td> &nbsp;&nbsp;&nbsp;&nbsp;第一行为按[编号、参数名、参数值、类型、备注]顺序的表头<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、[编号、参数名、参数值、类型]不为空<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、[编号]为数字<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、[参数名]命名符合标识符规范（由字母、数字、$ 或下划线组成，不以数字或$开头）<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、[类型]为0或者1时<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5、成功导入[只支持到2003版本]。
               </td></tr>
               <tr><td> &nbsp;&nbsp;&nbsp;&nbsp;当导入Excel数据时，[参数名]已存在，则系统默认为更新操作，当Excel表格中[编号]与页面中的编号（主键）不一致，则停止更新。
               </td>
               </tr>
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
	</div>
	</body>
</html>
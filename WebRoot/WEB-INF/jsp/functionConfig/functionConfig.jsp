<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>���ܳ�ʼ������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>	
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script language="javascript">
		//���js��jQuery��ͻ
		 jQuery.noConflict();
		//�첽�����·�����	
		 function  createInitMenuInsertSQL(){
			 (function($) {
				 $(function() {
						$.ajax({
							type:"post",
							url:"functionConfig_createInitMenuInsertSQL.do",
							dataType : "json", 
							success:function(res){
								//���·���Ϣд����־
								document.getElementById("initMenu").innerText=res.initMenuInsertSQL;
							}
						});
				 }); 	
				})(jQuery);
			 }
		</script>
	</head> 
	<body>
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="functionConfig_outInitMenuInsertSQL.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td width="152" style="padding-left: 10px;padding-right: 10px;" class="pn-flabel pn-flabel-h">
						<input style="padding-top:2px;" type="button"  value=" ���ɲ˵���ʼ��SQL��� " onclick=" createInitMenuInsertSQL()"/>&nbsp;<br/><br/>
						<input style="padding-top:2px;" type="submit"  value=" �����˵���ʼ��SQL��� "  />&nbsp;
						</td>
						<td  class="pn-fcontent"><textarea id="initMenu" cols="158" rows="26" style=" color:#4F4F4F;font-family:������; font-size:12px;border-color: white;border-left-color: white;border-top-color: white;"></textarea></td>
					</tr>
			
				</table>		
			</form>
		</div>		
	</body>
</html>
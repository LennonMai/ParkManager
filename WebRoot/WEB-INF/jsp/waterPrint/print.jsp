<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<html>
	<head>
		<title>��ӡҳ��</title>
		<!--<link href="${basePath}/css/admin.css" rel="stylesheet" type="text/css"/>-->
		<!-- <link href="${basePath}/css/theme.css" rel="stylesheet" type="text/css"/> -->
		<link href="${basePath}/css/validate-css/printList.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script type="text/javascript" src="${basePath}/js/PrintArea.js"></script>
	

		<script language="javascript">
		window.onload=function (){
			get("myDiv").innerHTML = window.opener.document.getElementById("div0").innerHTML;

			//alert(window.dialogArguments.document.getElementById("div0").innerHTML);
			};
			function tryprint()
			  {
				bdhtml=window.document.body.innerHTML;//��ȡ��ǰҳ��html���� 
				prnhtml=document.getElementById("myDiv").innerHTML;
				window.document.body.innerHTML=prnhtml; 
				window.focus();
				window.print(); 
				window.close();
			//	window.document.body.innerHTML=bdhtml; 
			 }
		    $(function(){  
		            //��ӡ  (֮ǰ��ӡ��������汾��ʹ�ã�ע��ID��)
		            $("#btnPrint").bind("click",function(event){  
		                $("#myDiv").printArea();  
		            });  
		        });  
		</script>
	</head>
	<body>
		<div id ="myDiv" align="center"></div>
		<div align="center"><input id="btnPrint1" type="button" value="��ӡ" onclick="tryprint()"/>  </div> 
	</body>
</html>
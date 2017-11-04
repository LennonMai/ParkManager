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
		alert("�޷���ɸ��£� \n\n    ���µ����Ϊ "+"${startFailRefleshNum}"+" ����ֹͣ���£������ Excel ����б�����\n    ������Ӧ��ID��һ�£��뽫��Ÿĳɸò�����ҳ���ж�Ӧ�ı�ţ�");
	    }
		if("${excelFormat}"=="noThisFormate"){
			alert("�޷���ɸ��£������Excel����ʽ�������⣬���飡");
		    }
		function IsNumber(num){
			  var reNum=/^\d*$/;
			  return(reNum.test(num));
			}
					
		if("${message}"!=""&&IsNumber("${message}")){
			if("${rowsNum}"=="0")
				alert("�ɹ�����"+"${message}"+"�����ݣ�");
			else
				alert("�ɹ�����"+"${message}"+"�����ݣ�"+"�����ϵ���淶��������"+"${rowsNum}"+"����"); 
		    }
		if("${message}"=="ExcelToDBfail"){
			alert("���벻�ɹ��������ϵ���淶��������"+"${rowsNum}"+"����");
		    }
    
			function checkFile(){  
				if(!isXLS(get("excelFile").value)){				
					alert("��ѡ��һ��Excel�ļ���");
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
			//1-6��¼��
			var count=1;
            function insert(){
            	var text="�����������ڵ����У����Ժ�";
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
				
				//��������
				function lockup(e){ e.preventDefault(); }
				//�����㲻����
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
				$$("MSGtext").innerHTML ='<b>�����������ڵ����У����Ժ�</b>';
				ab.show();
				//��ʱ���µ�����ʾ����
                setInterval("insert()",500);
                $$("idMSGClose").onclick = function(){if(confirm("\nȷ��Ҫȡ��������ʾ��ȡ����Ӱ�����ݵ��룬�����ĵȴ����ݵ�����ϣ� ")){ ab.close();}}
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
		<div class="pn-sp">
		<form action="paramconf_excelDataToDB.do" method="post" enctype="multipart/form-data" onsubmit="return checkFile();">
        <input align="top" name="excelFile" type="file" size="32" style="height:22px" id="excelFile" value="dd"/>&nbsp;
		<input type="submit" style="padding-left: 8px;padding-right: 8px;" value="��������" />&nbsp;
		<input type="button" style="padding-left: 8px;padding-right: 8px;" value=" �� �� " onclick="return back()"/>
	     <label id="importProcess" style="padding-left:580px;font-weight: bold;"></label>
	    <div class="clear"></div>
	     </form>
        </div>
        <table><tr><td>�ɹ�����excel���ݹ淶��</td></tr>
               <tr><td> &nbsp;&nbsp;&nbsp;&nbsp;��һ��Ϊ��[��š�������������ֵ�����͡���ע]˳��ı�ͷ<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1��[��š�������������ֵ������]��Ϊ��<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2��[���]Ϊ����<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3��[������]�������ϱ�ʶ���淶������ĸ�����֡�$ ���»�����ɣ��������ֻ�$��ͷ��<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4��[����]Ϊ0����1ʱ<br/>
               			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5���ɹ�����[ֻ֧�ֵ�2003�汾]��
               </td></tr>
               <tr><td> &nbsp;&nbsp;&nbsp;&nbsp;������Excel����ʱ��[������]�Ѵ��ڣ���ϵͳĬ��Ϊ���²�������Excel�����[���]��ҳ���еı�ţ���������һ�£���ֹͣ���¡�
               </td>
               </tr>
        </table>	
		<dl id="idMSG" class="MSGalert" style="top:10%;left:5%;">
			<dt>������ʾ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
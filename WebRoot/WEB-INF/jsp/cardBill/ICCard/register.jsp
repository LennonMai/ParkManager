<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>IC���Ǽ�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script> 
		<script type="text/javascript" src="${basePath}/js/CJL.0.1.min.js"></script>  
		<script type="text/javascript" src="${basePath}/js/MSGalert.js"></script>
		<script language="javascript">
		if("${result}" == "SUCCESS") {
			alert("����IC���Ǽ���Ϣ��¼����Ϊ"+(${countSuccess}+${countFail})+"����"+${countSuccess}+"����¼����ɹ���"+'${countFail}'+"����¼ʧ�ܣ�");
		}
		
		if("${result}" == "FAIL") {
			alert("txt�ļ����ݸ�ʽ����ȷ��������ѡ��");
		}
		//����exe
	    function runExe(strPath) {
	    	try {
	    		var objShell = new ActiveXObject("wscript.shell");
	    		objShell.Run('\"' + strPath + '\"');
	    		objShell = null;
	    	} catch(e) {
	    		alert('�Ҳ����ļ�"'+strPath+'"(���������֮һ)�������ҳ��������˵��');
	    	}
	    }
	    //����ļ�
	    function checkFile() {
	    	if(!isTXT(get("txtFile").value)) {
	    		alert("��ѡ��һ��txt�ļ���");
	    		return false;
	    	}
	    }
	    //�ж�txt�ļ�
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
			function showMsgAlert(){
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
				<div class="rpos">
					��ǰλ�ã� ${currentPosition}
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
								IC���Ǽǣ�
							</td>
							<td style="font-weight: bold; padding-left: 20px;"  width="60%">
								<input type="button" value="��ʼ�Ǽ�" onclick="runExe('${param_cardInit.pvalue }')" />
							</td>
						</tr>
						<tr>
							<td align="right"  width="40%">
								ѡ�����ļ���
							</td>
							<td style="font-weight: bold; padding-left: 20px;"  width="60%">
								<input type="file" name="txtFile" />&nbsp;&nbsp;&nbsp;&nbsp;
          					</td>  
   						</tr>
		  				<tr>
							<td colspan="2" class="pn-fbutton" style="padding-top: 5px;padding-bottom: 5px;">
								<input type="submit" value="�������ݿ�" />
								<!-- <input type="button" value="  �� ��  " onclick="history.back();" /> -->
							</td>	    
						</tr> 
				</tbody>
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
				<br/>
				����޷���ҳ������ⲿ�Ǽǳ��򣬿�������IE������������й�,�볢�����²��裬�����ܷ������⣺<br>һ.ȷ�ϵǼǳ����Ѿ���װ�ڱ������Ҷ����������ӵ�������<br><br>��.ȷ�ϵǼǳ����Ѿ���װ�ڵ�����·���С�<br><br>��.���������Ļ���<br>���������Ļ�����ܻ������������⡣�� Internet Explorer 6.0 ����߰汾���������ķ������£�<br>1. �� IE �����"����"��<br>2. ѡ��"Internet ѡ��"��<br>3. ���"����"��ǩ��δѡ�У������˱�ǩ��
	         	<br>4. ��"Internet ��ʱ�ļ�"�����·������"ɾ���ļ�"��<br>5. ���"ȷ��"�˳���<br><br>��.ȷ�� JavaScript��ActiveX �Լ�"��������Ϊ"������<br>�� IE ������������������ã�<br>1. ���"����" > "Internet ѡ��"��<br>2. ���"��ȫ"��ǩ��<br>3. ���"�Զ��弶��"��ť��<br>4. ȷ��"���� ActiveX �ؼ��Ͳ��"�Աߵ�"����"��ť�ѱ�ѡ�С�<br>5. ȷ��"�����ƺͽű���Ϊ"�Աߵ�"����"��ť�ѱ�ѡ�С�'
	        	<br>6. ȷ��"��ű�"�µ�"����"��ť�ѱ�ѡ�С�<br>7. ���"ȷ��"��Ȼ���ٴε��"ȷ��"������ġ�<br>��һ�ְ취�ǣ���Ӧ�÷������ַ���� Internet Explorer ��������վ���б����巽�����£�<br>1. ���"����" > "Internet ѡ��"��<br>2. ���"��ȫ"��ǩ��<br>3. ѡ��"�����ε�վ��"ͼ�꣬Ȼ����"վ��"��ť��<br>4. ȡ��ѡ��"�Ը������е�����վ��Ҫ���������֤ ( https:)"��'
	         	<br>5. ��"������վ��ӵ�������:"�ı����ڣ�����Ӧ�÷������ַ��Ȼ����"���"��<br>6. ���"ȷ��"��Ȼ���ٴε��"ȷ��"������ġ�<br>7. ������վ��İ�ȫ�����Ϊ"��"�����"ȷ��"������ġ�<br><br>��.Ϊ��֤����������Ч����Ҫ���������������
			</form>
		</div>
	</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>下发参数列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
<style type=text/css>
<!--
.page{padding-top:5px;width:880px;clear:both;}
.left{float:left;width:480px;}
.right{float:right;width:390px;}
.clear{clear:both;}
.line{width:870px;font-size:10px;border-top-color:#556b2f;bordor-top-style:dotted}
-->
</style>
		<script language="javascript">
		//解决js与jQuery冲突
		 jQuery.noConflict();
		//异步条件下发请求	
		 function  _sendPara(){
			 (function($) {
				 $(function() {
						$.ajax({
							type:"post",
							url:"sendPara_send.do?Ips="+Ips+"&TableNames="+TableNames,
							dataType : "json", 
							success:function(res){
								//将下发信息写入日志
								document.getElementById("sendMassage").innerText=res.sendMeg;
								document.getElementById("sendParaid").disabled = false;
							}
						});
				 }); 	
				})(jQuery);
			 }
		//执行下发操作      
		  function sendPara(){			
			if(TableNames==""||Ips==""){
				alert("请选择参数选项或下发车道！");
				}
			if(TableNames!=""&&Ips!=""){
				document.getElementById("sendParaid").disabled = true;
				var _Ips=new Array();
				var _TableNames=new Array();
				_Ips=trimArray(Ips);
				_TableNames=trimArray(TableNames);
				Ips.splice(0); 
				TableNames.splice(0); 
				Ips=_Ips;
				TableNames=_TableNames;
				//alert(Ips);
				//alert(TableNames);
				_sendPara();
				}
			  
		   }
		
		//参数导出TXT
		  function paraToTXT(){
			var _temp=new Array();
			_temp=trimArray(TableNames);
			TableNames.splice(0); 
			TableNames=_temp;
			//alert(TableNames);
			if(TableNames=="")alert("请选择需导出的参数选项！");
			else {
				if(TableNames.length>1)alert("每次仅限导出一项参数！");
				else window.location.href = "sendPara_paraToTXT.do?TableNames="+TableNames;
				}	
		  }

		  //刷新日志
		  function refleshText(){
			  document.getElementById("sendMassage").value="";
			  }
			
		 //创建保持车道号的数组
	      var Ips=new Array();
	     //创建保持下发参数键值的数组
	      var TableNames=new Array();
	      
		  var Ips_count;
		  var TableNames_count;

		  //根据下标删除某个数组元素	
		  Array.prototype.remove=function(dx) 
		  { 
		      if(isNaN(dx)||dx>this.length){return false;} 
		      for(var i=0,n=0;i<this.length;i++) 
		      { 
		          if(this[i]!=this[dx]) 
		          { 
		              this[n++]=this[i] 
		          } 
		      } 
		      this.length-=1 
		  }
		  Array.prototype.baoremove = function(dx) 
		  { 
		      if(isNaN(dx)||dx>this.length){return false;} 
		      this.splice(dx,1); 
		  } 
		  		   	
		  //过滤数组中为空项
		   function trimArray(obj){
			   var _arr=new Array();
			   var j=0;
               for(var i=0;i<obj.length;i++){
                   //if(null==obj[i]){obj.baoremove(i);}
                   if(null!=obj[i]||obj[i]!=undefined){_arr[j]=obj[i];j++;}
                   }
               //for(var i=0;i<_arr.length;i++){alert(_arr[i]);}
               return _arr;
			   }	
		  
		  //点击的车道checkbox值赋给数组Ips
		  function setIps(obj){
			  Ips_count=Ips.length;
			  //alert(Ips_count);
			  if(obj.checked){
				 Ips[Ips_count]=obj.value;
				 Ips_count++;
				}else{ 
					//当第一次选择checkbox后，再取消，则出数组中去掉该值
					var del=obj.value;
					for(var i=0;i<Ips.length;i++){
						  if(del==Ips[i]){
							  Ips.baoremove(i);
							  Ips_count--;}
						}
					}
	         }

		  //点击的参数checkbox值赋给数组TableNames
		  function setTableNames(obj){
			     TableNames_count=TableNames.length;
				 if(obj.checked){
				  TableNames[TableNames_count]=obj.value;
				  TableNames_count++;
				}else{ 
					//当第一次选择checkbox后，再取消，则出数组中去掉该值
					var del=obj.value;
					for(var i=0;i<TableNames.length;i++){
						  if(del==TableNames[i]){
							  TableNames.baoremove(i);
							  TableNames_count--; }
						}
					
					}
		  }
		  //全选/反选参数	
		  function allTableNames(obj){
			  var str="_"+obj.value
			  if(obj.checked){
				  //alert(TableNames.length);		 
				  var a = document.getElementsByName(str);  
				  var n = a.length+TableNames.length;
				  var k=TableNames.length;
				   
				  //全选赋值
				  for (var i=TableNames.length; i<n; i++){
					  //a[i-k].checked = window.event.srcElement.checked; 
					  a[i-k].checked = true; 
                      //当数组中存在该项时不插入
                      if(isSame(TableNames,a[i-k].value)==false){
                    	  TableNames[i]=a[i-k].value;
                          }                	  
					  } 
				  }else{ 
					  //alert(str);
					  var a = document.getElementsByName(str);   
					  var n = a.length;
					  
					  for (var i=0; i<n; i++){
						  if(a[i].checked){
							  a[i].checked = false;
							  //alert(a[i].value);
							  for(var j=0;j<TableNames.length;j++){
								  if(a[i].value==TableNames[j]){
									  TableNames.baoremove(j);
									 }
								}							  
							  }
						  }
					  //alert(TableNames);
					  //清空数据Ips	
					  //TableNames = TableNames.splice(0);   
					  } 
			 
			  }

		  //全选/反选车道
		  function _allIP(obj){ 
			  if(obj.checked){
				  Ips = Ips.splice(0);  
				  var a = document.getElementsByName("IPName");   
				  var n = a.length;
				  for (var i=0; i<n; i++){
						//a[i].checked = window.event.srcElement.checked; 
						a[i].checked = true;
						//当数组中存在该项时不插入
	                      if(isSame(Ips,a[i].value)==false){
	                    	  Ips[i]=a[i].value;
	                          }       
					  }   
				  }else{
					  var a = document.getElementsByName("IPName");   
					  var n = a.length;
					  for (var i=0; i<n; i++){
						  if(a[i].checked){
							  a[i].checked = false;
							  }
						  }
					  //清空数据Ips	
					  Ips = Ips.splice(0);   
					  } 
			  //alert(Ips);
		  }
		  //判断数组是否存在相同的项
		  function isSame(obj,value){
			for(var i=0;i<obj.length;i++){
                if(obj[i]==value)return true;
				}
			 return false;
			  } 
		</script>
	</head> 
	<body>
	<div class="body-box">
    <div class="rhead">
	<div class="rpos">当前位置： ${currentPosition}
	</div>
	<div class="clear"></div>
	</div>
	
	<form  name="tableForm"  method="post" action="sendPara_list.do" >
	<div class="page">
	<div class="left">
	<table width="482px;" style="border:1px solid #B4CFCF;border-bottom-color: white;"  cellspacing="0" cellpadding="0"  >
    <tbody>
        <tr style="padding: 5px;border:1px; font-family:宋体; font-size:14px; font-weight:bold;" ><td style="padding-left:5px;padding-top: 5px;padding-bottom: 5px;">参数选项</td></tr>
    </tbody>
    </table>
	<table style="border-collapse: collapse;border:1px solid #B4CFCF;"  cellspacing="0" cellpadding="0"  >
    <tbody >
        <tr>
            <td >
            <div  style=" overflow: scroll; width: 480px;  height: 320px;" >
              <!-- 遍历组别名，根据每一个组别键 名创建一个表格 ，表格id对应每一个组别键名-->
              <c:forEach items="${list}" var="item">
              <table id="${item.item}"  width="463px;">
              <tbody>
              	<tr align="left" bgcolor="#BAC2DA">
              	    <td align="center" width="68"><input type="checkbox" id="${item.item}" name="${item.item}" value="${item.item}" onclick="allTableNames(this);"/>&nbsp;<strong>选择</strong></td>
              		<td style="padding-left: 28px;"><strong>${item.itemValue} </strong>-[${item.item}]</td>
             	</tr>
                <script language="javascript">
             	jsonrpc = new JSONRpcClient("JSON-RPC");
				var groupName='${item.item}';
             	var result = jsonrpc.ajax.getItemsByGroupName(groupName);
				var item;
				var itemValue
				for (var i=0;i<result.length;i++){
					if(result[i][0]!=""&&result[i][1]!=""){
						item = result[i][0];
						itemValue = result[i][1];
						document.write("<tr><td align='center' width='68'><input type='checkbox' id='"+itemValue+"' name='_${item.item}' value='"+itemValue+"' onclick='setTableNames(this);'/></td><td>&nbsp;"+item+"</td></tr>");                                         
						}
					}
				</script>				
				<tr><td></td></tr>
				</tbody>
             </table>
             </c:forEach>
            </div>
            </td>
        </tr>
    </tbody>
    </table>
    <div style="height: 5px;"></div>
     <table width="482px;" style="border:1px solid #B4CFCF;border-bottom-color: white;" cellspacing="0" cellpadding="0" >
        <tr style="padding: 5px;border:1px;font-family:宋体; font-size:14px; font-weight:bold;" ><td style="padding-left:5px;padding-top:5px;padding-bottom: 5px;">下发车道</td></tr>
    </table>
    <table style="border-collapse: collapse;border:1px solid #B4CFCF;" cellspacing="0" cellpadding="0" >
        <tr>
            <td>
            <div style="overflow: scroll; width: 480px;  height: 223px;">
 			<table width="463px;">
 				<thead>
					<tr bgcolor="#BAC2DA">
						<th width="68" style="white-space:nowrap;"><input type="checkbox" id="allIP" name="allIP" onclick="_allIP(this);"/>&nbsp;选择</th>
						<th style="white-space:nowrap;">小&nbsp;&nbsp;区</th>
						<th style="white-space:nowrap;">大&nbsp;&nbsp;门</th>
						<th style="white-space:nowrap;">车&nbsp;&nbsp;道</th>
						<th style="white-space:nowrap;">车道IP</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${laneList}" var="item">
             	<tr>
             	<td align="center"><input type="checkbox" name="IPName" id="${item.laneNo}" value="${item.laneNo}_${item.laneComputerIp}" onclick="setIps(this);" /></td>
             	<td align="center"  style="white-space:nowrap;">
             	<c:forEach  items="${parkList}" var="park" >
             		<c:if test="${item.parkNo==park.parkNo}">${park.parkName}</c:if> 
             	</c:forEach>
             	</td>
             	<td align="center"  style="white-space:nowrap;">
             	<c:forEach  items="${gateList}" var="gate">
             		 <c:if test="${item.gateNo==gate.gateNo}">${gate.gateName}</c:if> 
             	</c:forEach>
             	</td>
                <td align="center"  style="white-space:nowrap;">${item.laneNo}</td>
             	<td style="padding-left:60px;">${item.laneComputerIp}</td>		
             	</tr>
             	</c:forEach>
				</tbody>
             </table>
 			
            </div>
            </td>
        </tr>
    </table>
	</div>
	
	<div class="right">
	<div style="float:left;">
	 <table width="289px;" style="border:1px solid #B4CFCF;border-bottom-color: white;"  cellspacing="0" cellpadding="0" >
        <tr style="padding: 5px;border:1px ;font-family:宋体; font-size:14px;font-weight:bold;" ><td style="padding-left:5px;padding-top: 5px;padding-bottom: 5px;">日志 </td></tr>
    </table>
	 <table style="border-collapse: collapse;border:1px solid #B4CFCF;"  cellspacing="0" cellpadding="0" >
        <tr>
            <td>
            <textarea rows="41" cols="38" style=" color:#4F4F4F;font-family:新宋体; font-size:12px;font-weight:bold;border-color: white;border-left-color: white;border-top-color: white;" id="sendMassage" name="sendMassage" ></textarea>
            </td>
        </tr>
    </table>
    </div>
    <div style="float: right;">
    <input style="width:80px;padding-left: 10px;padding-right: 10px;" type="button" id="sendParaid" value="下发参数" onclick=" sendPara();"/> <br /> <br />
	<input style="width:80px;padding-left: 10px;padding-right: 10px;" type="button" value="导出参数"  onclick="paraToTXT();"/> <br /> <br />
	<input style="width:80px;padding-left: 10px;padding-right: 10px;" type="button" value="刷新日志"  onclick="refleshText();"/> <br /> <br />
	<input style="width:80px;padding-left: 10px;padding-right: 10px;" type="submit" value="刷新页面"  />	
	</div>	
	</div>
	</div>
	</form>
</div>
</body>
</html>
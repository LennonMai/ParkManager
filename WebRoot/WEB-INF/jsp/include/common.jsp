<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<link href="css/style.css" rel="stylesheet" media="screen" />
	<link type="text/css" rel="stylesheet" media="screen" href="css/validate-css/showmgs.css"/>		
    <script type="text/javascript" src="js/util.js"></script>
    <script type="text/javascript" src="js/validate/jquery.js" charset="UTF-8"></script> 
	<script type="text/javascript" src="js/validate/jquery.validate.js" charset="UTF-8"></script> 
	<script type="text/javascript" src="js/validate/messages_cn.js" charset="UTF-8"></script> 	
		<script type="text/javascript">	
		String.prototype.trim = function() 
        { 
             // ��������ʽ��ǰ��ո��ÿ��ַ�������� 
             return this.replace(/(^\s*)|(\s*$)/g, ""); 
        } 	
		 function Len(str)
	        {
	        var i,sum;
	        sum=0;
	        for(i=0;i<str.length;i++)
	          {   
	             if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255)){
	                 if(str.charCodeAt(i)==183)
	                 {
	                     sum=sum+2;
	                 }else{
	                	 sum=sum+1;
	                 }
	               
	                } else{
	                	 sum=sum+2;
	                }
	               
	           }
	        return sum;
	        }
        //�ж��Ƿ�Ϊ���ֺ��Ƿ��пո�
        function numAndKong(value){
        	var reg=/^\s+|\s+/g;   
  			if(reg.test(value)){
   				return false; 
  			}
  			if(isNaN(value)){
  				return false;
  			} 
  			return true;
        }

        //�ж�IP��ַ��ʽ�Ƿ���ȷ
         function isIP(str){   
  			var ip= /^([1-9]|[1-9]\d|1\d{2}|2[0-1]\d|22[0-3])(\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){3}$/;
  			if(Len(str)<=15&&ip.test(str.trim())) return true;
  			else return false;   
 		 }
		//�жϲ������Ƿ�Ϸ�����ʶ���淶�� ��ĸ �� _ ��ͷ
		function isValidIdentifier(str){   
		    try{   
		        eval("var "+str+"=0;");
		        if(str.charCodeAt(0)==36)
			        return false;
		        else  return true;      	       
		    }catch(e){   
		        return false;   
		    }   
		} 
		//�ж��Ƿ������� 
		function isInt(str){
			if(str.search("^-?\\d+$")==0)return true;
			else return false;
			}	
		/**
		 * �����dataform��form��id
		 */		 
		$(document).ready(function() {
					$("#dataform").validate({			
						success: function(label) {					
							label.html("&nbsp;").addClass("checked");
						}
					});	
				jQuery.validator.addMethod("positiveInteger", function(value, element) {					     
						    var decimal = /^[1-9]\d*$/;
						    return this.optional(element) || (decimal.test(value));
					       }, $.validator.format("������������."));	

				 jQuery.validator.addMethod("numberDeleteNull", function(value, element) {					     
						    var decimal = /^\d*$/;
						    return this.optional(element) || (decimal.test(value.trim()));
					       }, $.validator.format("����������."));
				 jQuery.validator.addMethod("digitForOne", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{1}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("����Ϊ1λ����."));		
				 jQuery.validator.addMethod("digitForTwo", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{2}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("����Ϊ2λ����."));			
				 jQuery.validator.addMethod("digitForThree", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{3}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("����Ϊ3λ����."));		
				 jQuery.validator.addMethod("digitForFour", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{4}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("����Ϊ4λ����."));		
				 jQuery.validator.addMethod("digitForFive", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{5}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("����Ϊ5λ����."));		
				 jQuery.validator.addMethod("digitForSix", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{6}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("����Ϊ6λ����."));													
				 jQuery.validator.addMethod("digitForSeven", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{7}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("����Ϊ7λ����."));
				 jQuery.validator.addMethod("digitForEight", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{8}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("����Ϊ8λ����."));
		          jQuery.validator.addMethod("digitForNine", function(value, element) {
			     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
				    var decimal = /^\d{9}$/;
				    return this.optional(element) || (decimal.test(value.trim()));
			       }, $.validator.format("����Ϊ9λ����."));
			       
	            jQuery.validator.addMethod("cardNomaxlengthTem", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 10));
			         }, $.validator.format("���ų��Ȳ��ܴ���10λ"));
	            
	            jQuery.validator.addMethod("cardNomaxlength20", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 20));
			         }, $.validator.format("���ų��Ȳ��ܴ���20λ"));   
	            
                jQuery.validator.addMethod("maxlengthNine", function(value, element) {
			      return this.optional(element) || ((Len(value.trim()) <= 9));
		         }, $.validator.format("���Ȳ��ܴ���9"));
		         
		        jQuery.validator.addMethod("maxlengthTen", function(value, element) {
			      return this.optional(element) || ((Len(value.trim()) <= 10));
		         }, $.validator.format("���Ȳ��ܴ���10������������)"));

		        jQuery.validator.addMethod("maxlengthSixteen", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 16));
			         }, $.validator.format("���Ȳ��ܴ���16������������)"));
		         
		         jQuery.validator.addMethod("maxlengthTwenty", function(value, element) {
			      return this.optional(element) || ((Len(value.trim()) <= 20));
		         }, $.validator.format("���Ȳ��ܴ���20������������)"));
		         
		         jQuery.validator.addMethod("maxlengthThirtyTwo", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 32));
			         }, $.validator.format("���Ȳ��ܴ���32������������)"));
		         
		         jQuery.validator.addMethod("maxlengthForty", function(value, element) {
			      return this.optional(element) || ((Len(value.trim()) <= 40));
		         }, $.validator.format("���Ȳ��ܴ���40������������)"));

		         jQuery.validator.addMethod("maxlengthFifty", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 50));
			         }, $.validator.format("���Ȳ��ܴ���50������������)"));
			         
			     jQuery.validator.addMethod("maxlength255", function(value, element) {
					      return this.optional(element) || ((Len(value.trim()) <= 255));
				     }, $.validator.format("���Ȳ��ܴ���255������������)"));
			         
		         jQuery.validator.addMethod("jpg", function(value, element) {
		                var temp=new Array();
			    	    var temp=value.split(".");
			      return this.optional(element) || (temp[1]=="jpg");
		         }, $.validator.format("������.jpg��ʽͼƬ"));

		         jQuery.validator.addMethod("max100", function(value, element) {
				      return this.optional(element) || (value <= 100);
			         }, $.validator.format("���ܴ���100"));
		         jQuery.validator.addMethod("min-100", function(value, element) {
				      return this.optional(element) || (value >= -100);
			         }, $.validator.format("����С��-100"));
		         
		         jQuery.validator.addMethod("max2147483647", function(value, element) {
				      return this.optional(element) || (value <= 2147483647);
			         }, $.validator.format("���ܴ���2147483647"));		
			         
			     /**
			     *�������� ��֤ startisInt
			     */ 
			     jQuery.validator.addMethod("isInt", function(value, element) {
				      return this.optional(element) || ((isInt(value.trim())));
			         }, $.validator.format("����������"));
			     jQuery.validator.addMethod("maxlength1", function(value, element) {
				      return this.optional(element) || ((Len(value.trim())<=1&&isInt(value.trim())));
			         }, $.validator.format("����������,���Ȳ��ܳ���1���ַ�"));
			     jQuery.validator.addMethod("maxlength6", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 6));
			         }, $.validator.format("���Ȳ��ܳ���6���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength8", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 8));
			         }, $.validator.format("���Ȳ��ܳ���8���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength10", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 10));
			         }, $.validator.format("���Ȳ��ܳ���10���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength15", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 15));
			         }, $.validator.format("���Ȳ��ܳ���15���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength16", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 16));
			         }, $.validator.format("���Ȳ��ܳ���16���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength20", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 20));
			         }, $.validator.format("���Ȳ��ܳ���20���ַ�������ռ2���ַ���"));

			     jQuery.validator.addMethod("maxlength24", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 24));
			         }, $.validator.format("���Ȳ��ܳ���24���ַ�������ռ2���ַ���"));
		         
			     jQuery.validator.addMethod("maxlength30", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 30));
			         }, $.validator.format("���Ȳ��ܳ���30���ַ�������ռ2���ַ���"));
			    
			     jQuery.validator.addMethod("maxlength32", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 32));
			         }, $.validator.format("���Ȳ��ܳ���32���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength40", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 50));
			         }, $.validator.format("���Ȳ��ܳ���40���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength50", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 50));
			         }, $.validator.format("���Ȳ��ܳ���50���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength60", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 60));
			         }, $.validator.format("���Ȳ��ܳ���60���ַ�������ռ2���ַ���"));
			     jQuery.validator.addMethod("maxlength150", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 150));
			         }, $.validator.format("���Ȳ��ܳ���150���ַ�������ռ2���ַ���"));

			     jQuery.validator.addMethod("maxlength100", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 100));
			         }, $.validator.format("���Ȳ��ܳ���100���ַ�������ռ2���ַ���"));
		         
			     jQuery.validator.addMethod("maxlength200", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 200));
			         }, $.validator.format("���Ȳ��ܳ���200���ַ�������ռ2���ַ���"));

			     jQuery.validator.addMethod("isRightName", 
					     function(value, element) {
				      		return this.optional(element) || ((isValidIdentifier(value.trim())==true));
			         }, $.validator.format("���������ϱ�ʶ���淶��������ĸ ��  _ ��ͷ"));
			     jQuery.validator.addMethod("isNo", 
					     function(value, element) {
				      		return this.optional(element) || ((!isNaN(value.trim())));
			         }, $.validator.format("����������"));
			     jQuery.validator.addMethod("isNo_Tinyint", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&0<=value&&value<=255)&&isInt(value.trim()));
			         }, $.validator.format("��������������Χ��0~255֮��"));
			     jQuery.validator.addMethod("isNo_smallint", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&0<=value&&value<=32767)&&isInt(value.trim()));
			         }, $.validator.format("��������������Χ��0~32767֮��"));
			     jQuery.validator.addMethod("isNo_NotOverValue", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&0<=value&&value<=32767)&&isInt(value.trim()));
			         }, $.validator.format("��������������Χ��0~32767֮��"));
		         
			     jQuery.validator.addMethod("isNo_NotOverValueInt", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&0<=value&&value<=2147483647)&&isInt(value.trim()));
			         }, $.validator.format("��������������Χ��0~2147483647֮��"));
			     jQuery.validator.addMethod("isNo_NotOverValueIntOne", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&1<=value&&value<=2147483647)&&isInt(value.trim()));
			         }, $.validator.format("��������������Χ��1~2147483647֮��"));
			     jQuery.validator.addMethod("isIP", 
					     function(value, element) {
				      		return this.optional(element) || ((isIP(value.trim())));
			         }, $.validator.format("��������ȷ��IP��ַ��������15���ַ������磺192.168.1.1"));
			     jQuery.validator.addMethod("versonNoFormat", 
					     function(value, element) {
			    	        var reg = /^(-|\+)?\d+$/ ;		     
				      		return this.optional(element) || ((reg.test(value)&&value>=0));
			         }, $.validator.format("�汾�ű�������������"));
			      /**
			     *�������� ��֤ end
			     */
			     
			     /**
			     *������� ��֤ start
			     */  
			     jQuery.validator.addMethod("isNo_NotOverDecimal", 
					     function(value, element) {
				      		return this.optional(element) || ((!isNaN(value.trim())&&0<=value&&value<=90000000));
			         }, $.validator.format("���������֣��ҷ�Χ��0~90000000֮��"));
			     jQuery.validator.addMethod("zeroAndInteger", function(value, element) {					     
						    var decimal = /^[0-9]\d*$/;
						    return this.optional(element) || (decimal.test(value));
					       }, $.validator.format("������0����������."));
			     /**
			     *������� ��֤ end
			     */             
	  });

	/**
	 * �����Զ��巽�� У��������С��
	 */
</script>

<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<script language="javascript">
function gotoPage(pageNo) {
	if(pageNo>0)
		get("pager.currentPage").value = pageNo;
	document.tableForm.submit();
}
</script>
	
<div class="pn-sp">
	<div class="pn-sp-left">�� ${pager.totalSize} �� &nbsp;ÿҳ
	<input type="text" name="pager.pageSize" value="${pager.pageSize}" size="2" onfocus="this.select();"/> ��</div>
	<div class="pn-sp-right">
		<input type="button" value=" �� ҳ " onclick="gotoPage('1');" <s:if test="pager.hasFirst==false">disabled</s:if>/>&nbsp;
		<input type="button" value=" ��һҳ " onclick="gotoPage('${pager.currentPage-1}');"
		<s:if test="pager.hasPrevious==false">disabled</s:if> />&nbsp;
		<input type="button" value=" ��һҳ " onclick="gotoPage('${pager.currentPage+1}');"
	  <s:if test="pager.hasNext==false">disabled</s:if> />&nbsp;
		<input type="button" value=" β ҳ " onclick="gotoPage('${pager.totalPage}');"
		<s:if test="pager.hasLast==false">disabled</s:if> />&nbsp;
		��ǰ ${pager.currentPage}/${pager.totalPage} ҳ &nbsp;ת���� 
			<input type="text" name="pager.currentPage" size="2" value="${pager.currentPage}" onfocus="this.select();"/> ҳ
		<input type="button" value=" ת " onclick="gotoPage(-1);"/>
		<input type="hidden" name="pager.rowIndex" size="2" value="${pager.rowIndex}"/>
	</div>
	<div class="clear"></div>
</div>
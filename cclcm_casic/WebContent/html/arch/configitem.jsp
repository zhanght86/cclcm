<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/_css/css200603.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="${ctx}/_css/displaytag.css" type="text/css" media="screen"/>
<script language="JavaScript" src="${ctx}/_script/function.js"></script>
<script language="javascript" src="${ctx}/_script/casic304_common.js"></script>
<script language="javascript">
	<!--
    //-->
</script>
</head>
<body oncontextmenu="self.event.returnValue=false">
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_box">
    <tr>
        <td colspan="4" class="title_box">子项目基本信息</td>
    </tr>
    <tr>
      	<td nowrap="nowrap" width="10%">子项代号:</td>
        <td colspan="3">${item.item_code}</td>
    </tr>
	<tr>
		<td nowrap="nowrap" width="10%">备注:</td>
	   	<td colspan="3">${item.summ}</td>
	</tr>
    <tr>
        <td colspan="4" class="bottom_box">
            <input type="button" class="button_2003" value="添加案卷" onclick="go('${ctx}/arch/adddos.action?item_id=${item.id}')"/>&nbsp;
        </td>
    </tr>
</table>
</body>
</html>
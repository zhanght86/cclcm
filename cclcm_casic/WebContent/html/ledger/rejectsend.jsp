<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>外发拒收单</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="${ctx}/_css/displaytag.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/_css/css200603.css"  media="screen"/>
	<script language="JavaScript" src="${ctx}/_script/function.js"></script>
	<script language="javascript" src="${ctx}/_script/casic304_common.js"></script>	
	<script language="javascript" src="${ctx}/_script/jquery/jquery.min.js"></script>	
	<script language="javascript" src="${ctx}/_script/casic304_ajax.js"></script>
	<script>
	function chk(){
		if($(":radio:checked").size() == 0){
			alert("请选择拒收方式");
			return false;
		}	
		if($("#comment").val() == ""){
			alert("请填写拒收说明");
			$("#comment").focus();
			return false;
		}		
	    return true;
	}	
	function onOK(){
		if(chk()) 
		{
			var result = new Object();
			result.reject_type=$("input[name='reject_type'][checked]").val();
			result.comment = $("#comment").val();
			window.returnValue=result;	
			window.close();  
		}
	}	
	function onCancel(){
		window.close();
	}
	</script>
</head>
<body oncontextmenu="self.event.returnValue=false">
<center>
<table width="95%" border="1" cellspacing="0" cellpadding="0" align="center" class="table_box" style="margin-top:30px">
	<tr>
		<td class="title_box" colspan="2">&nbsp;</td>
	</tr>
	<tr >
		<td align="center"><font color="red">*</font>拒收方式：</td>
		<td align="center">
			<label style="width: 80">
				<input type="radio" name="reject_type"  value="UNREAD"/>未阅
			</label>
			<label style="width: 80">
				<input type="radio" name="reject_type"  value="READ"/>已阅
			</label>
			<label style="width: 80">
				<input type="radio" name="reject_type" value="COPY"/>复制
			</label>			
		</td>
	</tr>
	<tr> 
		<td align="center"><font color="red">*</font>拒收说明：</td>
    	<td align="center"><textarea name="comment" rows="3" cols="30" id="comment"></textarea></td>   	
	</tr>
	<tr> 
		<td colspan="2" align="center">
			<input type="button" class="button_2003" value="提交" onclick="onOK();" />&nbsp;
			<input type="button" class="button_2003" value="取消" onclick="onCancel();" />
		</td>
	</tr>
</table>
</center>
</body>
</html>
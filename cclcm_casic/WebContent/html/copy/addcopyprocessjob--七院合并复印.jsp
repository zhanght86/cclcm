<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="${ctx}/_css/displaytag.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/_css/css200603.css"  media="screen"/>
	<script language="javascript" src="${ctx}/_script/casic304_common.js"></script>
	<script language="javascript" src="${ctx}/_script/casic304_ajax.js"></script>
 	<script type="text/javascript" src="${ctx}/_script/jquery/jquery.min.js"></script>
<script>
<!--
$(document).ready(function(){
	onHover();
	$("#seclv_code option").last().attr("selected",true);
	$("#tr_send input").attr("disabled",true);
	$("#tr_send").hide();
	selectNextApprover();
});
function chkSubmit()
{	
	if($("#seclv_code").val() == ""){
		alert("请选择作业审批密级");
		$("#seclv_code").focus();
		return false;
	}
	if($("#cycle_type").val() == ""){
		alert("请选择状态");
		$("#cycle_type").focus();
		return false;
	}
	//是否填写了接收人
	if($("#cycle_type").val() == "SEND"){
		if($("#output_dept_name").val().trim() == ""){
			alert("请填写接收单位");
			$("#output_dept_name").focus();
			return false;
		}
		if($("#output_dept_name").val().length>100){
			alert("接收单位名字长度不能超过100个字符");
			$("#output_dept_name").focus();
			return false;
		}
		if($("#output_user_name").val().trim() == ""){
			alert("请填写接收人");
			$("#output_user_name").focus();
			return false;
		}
	}
	//是否选择合并复印
	if($("#cycle_type").val() == "REMAIN"){
		if($("#copy_merge").val().trim() == ""){
			alert("请选择是否为合并复印");
			$("#copy_merge").focus();
			return false;
		}
	}
	
	if($("#usage_code").val() == ""){
		alert("请选择用途");
		$("#usage_code").focus();
		return false;
	}
	if($("#period").val() == ""){
		alert("请选择使用期限");
		$("#period").focus();
		return false;
	}
	/* if($("#copy_merge").val() == ""){
		alert("请选择是否合并打印");
		$("#copy_merge").focus();
		return false;
	} */
	
	if($("#next_approver_all option").size() > 0 && $("#next_approver_sel option").size() == 0){
		alert("请选择审批人员");
		$("#next_approver_all").focus();
		return false;
	}
	//判断复印份数输入是否合理
	var copy_num_blank = null;
	var copy_num_wrong = null;
	var copy_num_zero = null;
	$("input[name='copy_num_input']").each(function(){
		if(this.value.trim() == ""){
			copy_num_blank = this;
			return false;
		}
		if(!isInteger(this.value)){
			copy_num_wrong = this;
			return false;
		}
	});
/* 	if(copy_num_blank != null){
		alert("请填写复印份数");
		$(copy_num_blank).focus();
		return false;
	} */
	if(copy_num_wrong != null){
		alert("复印份数只能填写1到10000之间的整数");
		$(copy_num_wrong).focus();
		return false;
	}
	//审批人信息
	var next_approver = "";
	$("#next_approver_sel option").each(function(){
		next_approver += this.value+",";
	});
	var len = next_approver.length;
	if (next_approver.lastIndexOf(",") == len - 1){
		next_approver = next_approver.substring(0, len - 1);
	}
	$("#next_approver").val(next_approver);
	//复印份数信息
	
/* if($("#copy_merge").val()!="yes"){ */
	$("input[name='copy_num']").each(function(){
		this.value=this.id+":"+document.getElementById(this.id+":").value;
	});
	var copy_nums = "";
	$("input[name='copy_num']").each(function(){
		copy_nums += this.value+",";
	});
	var len = copy_nums.length;
	if (copy_nums.lastIndexOf(",") == len - 1){
		copy_nums = copy_nums.substring(0, len - 1);
	}
	$("#copy_nums").val(copy_nums);
/* 	} */
	
	
	//如果密级不改变就不会给jobType赋值，将赋值放在提交时
	if($("#cycle_type").val()=="REMAIN"){
	if($("#copy_merge").val()=="yes"){
	   $("#jobType").val("COPY_MERGE");
	}else{
		$("#jobType").val("COPY");
	  }
	}else{
		$("#jobType").val("COPY_"+$("#cycle_type").val());
	}
	
	//ajax提交
	var url = "${ctx}/copy/addcopyprocessjob.action";
	callServerPostForm1(url,document.forms[0]);
	$("#submit_btn").attr("disabled",true);
    return true;
}
function getAjaxResult1(){
	if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
		if(xmlHttp.responseText == "ok"){
			alert("任务添加完成");
			window.location="${ctx}/copy/submitcopyeventbyledger.action";
		}else{
			alert(xmlHttp.responseText);
			$("#submit_btn").attr("disabled",false);
		}
	}
}
function selectNextApprover(){
	del_all_True('next_approver_sel');
	var url = "${ctx}/basic/getnextapprover.action";
	
	if($("#cycle_type").val()=="REMAIN" ){
		if($("#copy_merge").val()=="yes"){
	   $("#jobType").val("COPY_MERGE");
	}else{
		$("#jobType").val("COPY");
	  }
	}else{
		$("#jobType").val("COPY_"+$("#cycle_type").val());
	}
	
	callServerPostForm(url,document.forms[0]);
}
function selectSeclv(seclv){
	if(seclv == ""){
		alert("请选择作业审批密级,以确认审批流程");
		$("#seclv_code").focus();
		return false;
	}else if($("#cycle_type").val() != "" && $("#usage_code").val() != ""){
		selectNextApprover();
	}
}
function selectCycle(cycle){
	if(cycle == ""){
		alert("请选择复印状态,以确认审批流程");
		$("#cycle_type").focus();
		return false;
	}else if($("#seclv_code").val() != "" && $("#usage_code").val() != "" && $("#copy_merge").val() != ""){
		selectNextApprover();
	}
	if(cycle == "SEND"){
		if($("input[name='copy_num']").size() > 5){
			alert("由于外发回执单篇幅有限，一次外发的文件数不能超过5个，请返回申请页面重新勾选");
			$("#submit_btn").attr("disabled",true);
			return false;
		}
		$("#tr_send input").attr("disabled",false);
		$("#tr_send").show();
	}else{
		$("#submit_btn").attr("disabled",false);
		$("#tr_send input").attr("disabled",true);
		$("#tr_send").hide();
	}
	if(cycle == "REMAIN"){
		$("#period").show();
		$("#tr_merge input").attr("disabled",false);
		$("#tr_merge").show();
	}else{
		$("#period").val("L");
		$("#period").hide();
		$("#tr_merge input").attr("disabled",true);
		$("#tr_merge").hide();
	}
}
function selectUsage(usage){
	if(usage == ""){
		alert("请选择用途,以确认审批流程");
		$("#usage_code").focus();
		return false;
	}else if($("#seclv_code").val() != "" && $("#cycle_type").val() != ""){
		selectNextApprover();
	}
}

 function selectCopyMerge(merge){
	if(merge == ""){
		alert("请选择是否合并复印,以确认审批流程");
		$("#copy_merge").focus();
		return false;
	}else if($("#seclv_code").val() != "" && $("#cycle_type").val() != ""&& $("#usage_code").val() != ""){
		selectNextApprover();
	}
	if($("#copy_merge").val() == "yes") {
	 var oTable=document.getElementById("item");
	 for(i=0;i<oTable.rows.length;i++){
		oTable.rows[i].cells[5].style.display='none';
	 }
	}else{
	 var oTable=document.getElementById("item");
	 for(i=0;i<oTable.rows.length;i++){
		oTable.rows[i].cells[5].style.display='';
	} 
} 
}

function getAjaxResult(){
	if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
		if(xmlHttp.responseText.indexOf("<SELECT") != -1){
			$("#tr_approver").show();
			document.getElementById("allApprovers").innerHTML=xmlHttp.responseText;
			$("#submit_btn").attr("disabled",false);
		}else{
			$("#tr_approver").hide();
			alert(xmlHttp.responseText);
			$("#submit_btn").attr("disabled",true);
		}
		if($("#next_approver_all").size() > 0 && $("#next_approver_all").children().size() == 0){
			$("#tr_approver").hide();
		}
	}
}
//-->
</script>
</head>
<body >
<table width="95%" border="1" cellspacing="0" cellpadding="0" align="center" class="table_box">
<form action="${ctx}/copy/addcopyprocessjob.action" method="post">
	<input type="hidden" name="submit" value="Y"/>
	<input type="hidden" name="dept_id" value="${curUser.dept_id}"/>
	<input type="hidden" name="jobType" id="jobType"/>
	<input type="hidden" name="event_ids" value="${event_ids}"/>
	<input type="hidden" name="next_approver" id="next_approver"/>
	<input type="hidden" name="copy_nums" id="copy_nums"/>
	<input type="hidden" name="barcode_codes" id="barcode_codes" value="${barcode_codes}"/>
	<tr>
	    <td colspan="6" class="title_box">生成审批单</td>
	</tr>
	<tr> 
    	<td width="15%" align="center">申请用户： </td>
    	<td width="35%"><font color="blue"><b>${curUser.user_name}</b></font></td>
    	<td width="15%" align="center">用户部门： </td>
    	<td width="35%"><font color="blue"><b>${curUser.dept_name}</b></font></td>
    </tr>
    <tr>
    	<td align="center"><font color="red">*</font>&nbsp;作业审批密级：</td>
	    <td>
			<select name="seclv_code" id="seclv_code" onchange="selectSeclv(this.value);">
				<option value="">--请选择--</option>
				<s:iterator value="#request.seclvList" var="item">
					<c:if test="${highest_seclv >= item.seclv_rank}">
						<option value="${item.seclv_code}">${item.seclv_name}</option>
					</c:if>
				</s:iterator>
			</select>
		</td>
		<td align="center"><font color="red">*</font>&nbsp;状态： </td>
    	<td><select name="cycle_type" id="cycle_type" onchange="selectCycle(this.value);">
				<option value="REMAIN">留用</option>
				<option value="FILE">归档</option>
				<option value="SEND">外发</option>
    		</select>&nbsp;&nbsp;	
    		<select name="period" id="period">
    			<option value="L">长期留用</option>
    			<option value="S">短期留用</option>   			
    		</select>
    	</td> 
	</tr>
	<tr>
		<td align="center"><font color="red">*</font>&nbsp;用途： </td>
    	<td><select name="usage_code" id="usage_code" onchange="selectUsage(this.value);">
    			<option value="">--请选择--</option>
    			<s:iterator value="#request.usageList" var="usage">
					<option value="${usage.usage_code}">${usage.usage_name}</option>
				</s:iterator>
    		</select>
    	</td>	
    	<td align="center">具体说明： </td>
	   	<td><textarea name="comment" rows="3" cols="50"></textarea></td>
    	</tr>	
    <tr id="tr_merge">
    	<td align="center"><font color="red">*</font>&nbsp;是否合并复印： </td>
    	<td><select name="copy_merge" id="copy_merge" onchange="selectCopyMerge(this.value);">
				<option value="">--请选择--</option>
				<option value="yes">是</option>
				<option value="no">否</option>
    		</select>&nbsp;&nbsp;	
    	</td>
    	<td align="center"><font color="red">*</font>&nbsp;复印份数：(合并复印填写)</td>
    	<td><input type="text" name="copy_number" value="${copy_number}"/></td>
	</tr>
	<tr id="tr_send"> 
    	<td align="center"><font color="red">*</font>接收单位： </td>
    	<td><textarea name="output_dept_name" id="output_dept_name" title="复印状态为外发时，才需要填写接收单位和接收人"> </textarea></td> 
    	<td align="center"><font color="red">*</font>接收人： </td>
    	<td><input type="text" name="output_user_name" id="output_user_name" title="复印状态为外发时，才需要填写接收单位和接收人"/></td>
	</tr>
</form>
  	<tr id="tr_approver" style="display: none">
  		<td align="center" id="selApprover1">选择审批人：</td>
  		<td id="selApprover2" colspan="3">
  			<table width="300" border="0" cellspacing="0" cellpadding="0" align="left" class="table_box_border_empty">
				<tr>
					<td id="allApprovers">
						<SELECT ondblclick="add_True('next_approver_all','next_approver_sel');" style="WIDTH: 100px" multiple="true" size="8" id="next_approver_all">
							<c:forEach var="item" items="${userList}" varStatus="status">
								<option value="${item.user_iidd}">${item.user_name}</option>
							</c:forEach>
						</SELECT>
					</td>
					<td aling="center" valign="middle">
						<INPUT class="button_2003" onclick="add_MoreTrue('next_approver_all','next_approver_sel');" type="button" value="增加-->" name="btnAddItem" /><br/>
						<br/>
						<INPUT class="button_2003" onclick="del_MoreTrue('next_approver_sel');" type="button" value="删除<--" name="btnDelItem"><br/>
					</td>
					<td>
						<SELECT size="8" multiple="true" style="WIDTH: 100px" ondblclick="del_True('next_approver_sel');" id="next_approver_sel">
						</SELECT>
					</td>
				</tr>
			</table>
		</td>
  	</tr>
	<tr>
		<td colspan="4">
			<display:table uid="item" class="displaytable" name="eventList" id = "item" >
				<display:column title="序号">
					<c:out value="${item_rowNum}"/>
				</display:column>
				<display:column title="密级" property="seclv_name" />
				<display:column title="文件名称" property="file_name" maxLength="30"/>
				<display:column title="源文件编号" property="originalid"/>
				<display:column title="页数" property="page_num"/>
				<display:column title="份数">
					<font color="red">*</font>
					<input type="hidden" name="copy_num" value="${item.originalid}:${item.copy_num}" id="${item.originalid}"/>
					<input type="text" name="copy_num_input" value="${item.copy_num}" size="3" id="${item.originalid}:"/>
				</display:column>
			</display:table>
		</td>
	</tr>
  	<tr>
	    <td colspan="6" align="center"> 
	      <input type="button" class="button_2003" value="提交" onclick="chkSubmit();" id="submit_btn"/>&nbsp;
	      <input class="button_2003" type="button" value="返回" onclick="javascript:history.go(-1)">&nbsp;
	    </td>
	</tr>
</table>
</body>
</html>

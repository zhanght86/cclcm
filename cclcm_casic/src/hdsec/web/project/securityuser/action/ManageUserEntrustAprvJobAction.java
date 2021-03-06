package hdsec.web.project.securityuser.action;

import hdsec.web.project.activiti.model.JobTypeEnum;
import hdsec.web.project.activiti.model.ProcessJob;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户待审批任务
 * 
 * @author gj
 */
public class ManageUserEntrustAprvJobAction extends SecurityUserBaseAction {
	private static final long serialVersionUID = 1L;
	private List<ProcessJob> candidateList = null;
	private List<ProcessJob> applyList = null;

	public List<ProcessJob> getApplyList() {
		return applyList;
	}

	@Override
	public String executeFunction() throws Exception {
		applyList = new ArrayList<ProcessJob>();
		candidateList = basicService.getCandidateListByUserId(getCurUser().getUser_iidd(), JobTypeEnum.SECUSER_ENTRUST);
		applyList.addAll(candidateList);
		basicService.setClientMsgRead(getCurUser().getUser_iidd(), "SECUSER_ENTRUST", 1);
		return SUCCESS;
	}

}

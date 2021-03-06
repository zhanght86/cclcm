package hdsec.web.project.secmanage.action;

import hdsec.web.project.activiti.model.JobTypeEnum;
import hdsec.web.project.activiti.model.ProcessJob;
import hdsec.web.project.user.model.SecLevel;

import java.util.ArrayList;
import java.util.List;

/**
 * 论文申请专利发表审批详情
 * 
 * @author gaoximin 2015-9-17
 */
public class ViewPaperPatentAprvJobAction extends SecManageBaseAction {

	private static final long serialVersionUID = 1L;
	private String user_name = "";
	private Integer seclv_code = null;
	private List<ProcessJob> jobList = null;

	public List<ProcessJob> getJobList() {
		return jobList;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public void setSeclv_code(Integer seclv_code) {
		this.seclv_code = seclv_code;
	}

	public List<SecLevel> getSeclvList() {
		return userService.getSecLevel();
	}

	@Override
	public String executeFunction() throws Exception {
		List<ProcessJob> tempList = null;
		jobList = new ArrayList<ProcessJob>();
		tempList = basicService.getApprovedJobByUserId(getCurUser().getUser_iidd(), JobTypeEnum.PAPER_RESEARCH,
				user_name, seclv_code);
		jobList.addAll(tempList);
		tempList = basicService.getApprovedJobByUserId(getCurUser().getUser_iidd(), JobTypeEnum.PAPER_OTHERS,
				user_name, seclv_code);
		jobList.addAll(tempList);
		tempList = basicService.getApprovedJobByUserId(getCurUser().getUser_iidd(), JobTypeEnum.PAPERPATENT, user_name,
				seclv_code);
		jobList.addAll(tempList);
		return SUCCESS;
	}

}
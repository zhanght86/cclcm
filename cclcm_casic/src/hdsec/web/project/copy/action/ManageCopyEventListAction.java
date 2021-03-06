package hdsec.web.project.copy.action;

import hdsec.web.project.activiti.model.JobTypeEnum;
import hdsec.web.project.copy.model.CopyEvent;
import hdsec.web.project.user.model.SecLevel;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 管理复印申请列表
 * 
 * @author lixiang
 * 
 */
public class ManageCopyEventListAction extends CopyBaseAction {
	private static final long serialVersionUID = 1L;
	private Date startTime = null;
	private Date endTime = null;
	private String job_status = "";// 审批状态
	private Integer copy_status = 0;// 复印状态
	private Integer is_barcode = null;// 是否已打印条码
	private String seclv_code = "";
	private String user_name = "";
	private String dept_name = "";
	private List<CopyEvent> eventList = null;
	private final JobTypeEnum jobType = JobTypeEnum.COPY;
	private String copy_merge = "";
	private String originalid = "";
	private String file_name = "";

	public JobTypeEnum getJobType() {
		return jobType;
	}

	public String getStartTime_str() {
		return startTime == null ? "" : sdf.format(startTime);
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public String getEndTime_str() {
		return endTime == null ? "" : sdf.format(endTime);
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getJob_status() {
		return job_status;
	}

	public void setJob_status(String job_status) {
		this.job_status = job_status;
	}

	public Integer getCopy_status() {
		return copy_status;
	}

	public void setCopy_status(Integer copy_status) {
		this.copy_status = copy_status;
	}

	public Integer getIs_barcode() {
		return is_barcode;
	}

	public void setIs_barcode(Integer is_barcode) {
		this.is_barcode = is_barcode;
	}

	public String getSeclv_code() {
		return seclv_code;
	}

	public void setSeclv_code(String seclv_code) {
		this.seclv_code = seclv_code;
	}

	public List<CopyEvent> getEventList() {
		return eventList;
	}

	public List<SecLevel> getSeclvList() {
		return userService.getCopySecLevelByUser(getCurUser().getUser_iidd());
	}

	public String getActionContext() {
		return "/copy/managecopyeventlist.action";
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getCopy_merge() {
		return copy_merge;
	}

	public void setCopy_merge(String copy_merge) {
		this.copy_merge = copy_merge;
	}

	public String getOriginalid() {
		return originalid;
	}

	public void setOriginalid(String originalid) {
		this.originalid = originalid;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	@Override
	public String executeFunction() throws Exception {
		String web_url = getModuleName().toLowerCase() + "/" + getTitleName().toLowerCase() + ".action";
		List<String> dept_ids = basicService.getAdminDeptIdList(getCurUser().getUser_iidd(), web_url);
		if (dept_ids == null || dept_ids.size() == 0) {
			throw new Exception("没有配置管理部门,请联系系统管理员进行配置");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		map.put("seclv_code", seclv_code);
		map.put("submitable", false);
		map.put("job_status", "true");
		map.put("copy_status", copy_status);
		map.put("admin_dept_ids", dept_ids);
		// map.put("copy_type", "internal");
		map.put("user_name", user_name);
		map.put("dept_name", dept_name);
		map.put("copy_types", "true");
		eventList = copyService.getCopyEventList(map);

		return SUCCESS;
	}
}

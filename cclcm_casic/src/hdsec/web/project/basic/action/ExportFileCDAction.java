package hdsec.web.project.basic.action;

import hdsec.web.project.ledger.action.AutoCommonExportAction;
import hdsec.web.project.ledger.action.CommonExportAction;
import hdsec.web.project.ledger.model.ExportCDEnum;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 导出已回收cd台账
 * 
 * @author lixiang
 * 
 */
public class ExportFileCDAction extends AutoCommonExportAction {
	private static final long serialVersionUID = 1L;

	private String cd_barcode = "";
	private String duty_user_name = "";
	private String seclv_code = "";
	private Date start_time;
	private Date end_time;
	private String dept_ids = "";
	private String conf_code = "";
	private final String filename = "已归档光盘台账记录-" + sdf1.format(new Date()) + ".xls";
	private final String sheetName = "已归档光盘台账记录";
	private String cols= "";
	private List<String> tempTitles =new ArrayList<String>();

	public String getCols() {
		return cols;
	}

	public void setCols(String cols) {
		this.cols = cols;
	}

	public List<String> getTempTitles() {
		return tempTitles;
	}

	public void setTempTitles(List<String> tempTitles) {
		tempTitles.add("序号");
		String [] tempcols=cols.split(",");
		for (String string : tempcols) {
			for (ExportCDEnum item : ExportCDEnum.values()) {
				if (item.getKey().intValue() == Integer.parseInt(string.trim())) {
					tempTitles.add(item.getName());
					break;
				}
			}
		}
	}
	
	public String getCd_barcode() {
		return cd_barcode;
	}

	public void setCd_barcode(String cd_barcode) {
		this.cd_barcode = cd_barcode;
	}

	public String getDuty_user_name() {
		return duty_user_name;
	}

	public void setDuty_user_name(String duty_user_name) {
		this.duty_user_name = duty_user_name.trim();
	}

	public String getSeclv_code() {
		return seclv_code;
	}

	public void setSeclv_code(String seclv_code) {
		this.seclv_code = seclv_code;
	}

	public String getStart_time() {
		return sdf.format(start_time);
	}

	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return sdf.format(end_time);
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public String getConf_code() {
		return conf_code;
	}

	public void setConf_code(String conf_code) {
		this.conf_code = conf_code.trim();
	}

	public void setDept_ids(String dept_ids) {
		this.dept_ids = dept_ids;
	}

	@Override
	public String executeFunction() throws Exception {
		cols=basicService.getSysConfigItemValue("exportfilecd").getItem_value();
		setTempTitles(tempTitles);
		String []titles=(String[]) tempTitles.toArray(new String[tempTitles.size()]);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cd_barcode", cd_barcode);
		map.put("duty_user_name", duty_user_name);
		map.put("seclv_code", seclv_code);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		map.put("cd_state", 3);// 类型为已归档
		map.put("admin_dept_ids", dept_ids.split(","));
		map.put("retrieve_time_sortable", true);
		map.put("conf_code", conf_code);
		OutputStream os = createFile(filename);
		exportFile(os, map, sheetName, titles, "cd",cols);
		return null;
	}
}

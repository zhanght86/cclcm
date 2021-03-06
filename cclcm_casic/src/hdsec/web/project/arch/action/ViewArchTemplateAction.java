package hdsec.web.project.arch.action;

import hdsec.web.project.arch.model.ArchDict;
import hdsec.web.project.arch.model.ArchKey;
import hdsec.web.project.arch.model.TemplateProperty;

import java.util.ArrayList;
import java.util.List;

/**
 * @author hd304 查看模板 2015-7-27/
 */
public class ViewArchTemplateAction extends ArchBaseAction {
	private String template_id;
	private List<TemplateProperty> list;
	private int record_count;
	private List<ArchDict> dictList = null;

	public List<ArchDict> getDictList() {
		return dictList;
	}

	public int getRecord_count() {
		return record_count;
	}

	public void setRecord_count(int record_count) {
		this.record_count = record_count;
	}

	public String getTemplate_id() {
		return template_id;
	}

	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}

	public List<TemplateProperty> getList() {
		return list;
	}

	public void setList(List<TemplateProperty> list) {
		this.list = list;
	}

	@Override
	public String executeFunction() throws Exception {
		ArchKey archKey = new ArchKey();
		archKey = archService.getTemplateBySystemCode(template_id);
		list = dealTableTitle(archKey);
		record_count = archKey.getRecord_count();
		dictList = archService.getAllArchDictList();
		return SUCCESS;
	}

	private List<TemplateProperty> dealTableTitle(ArchKey archKey) {
		List<TemplateProperty> list = new ArrayList<TemplateProperty>();
		String T01 = archKey.getT01();
		if (T01 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T01, "T01");
			list.add(templateProperty);
		}
		String T02 = archKey.getT02();
		if (T02 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T02, "T02");
			list.add(templateProperty);
		}
		String T03 = archKey.getT03();
		if (T03 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T03, "T03");
			list.add(templateProperty);
		}
		String T04 = archKey.getT04();
		if (T04 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T04, "T04");
			list.add(templateProperty);
		}
		String T05 = archKey.getT05();
		if (T05 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T05, "T05");
			list.add(templateProperty);
		}
		String T06 = archKey.getT06();
		if (T06 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T06, "T06");
			list.add(templateProperty);
		}
		String T07 = archKey.getT07();
		if (T07 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T07, "T07");
			list.add(templateProperty);
		}
		String T08 = archKey.getT08();
		if (T08 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T08, "T08");
			list.add(templateProperty);
		}
		String T09 = archKey.getT09();
		if (T09 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T09, "T09");
			list.add(templateProperty);
		}
		String T10 = archKey.getT10();
		if (T10 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T10, "T10");
			list.add(templateProperty);
		}
		String T11 = archKey.getT11();
		if (T11 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T11, "T11");
			list.add(templateProperty);
		}
		String T12 = archKey.getT12();
		if (T12 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T12, "T12");
			list.add(templateProperty);
		}
		String T13 = archKey.getT13();
		if (T13 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T13, "T13");
			list.add(templateProperty);
		}
		String T14 = archKey.getT14();
		if (T14 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T14, "T14");
			list.add(templateProperty);
		}
		String T15 = archKey.getT15();
		if (T15 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T15, "T15");
			list.add(templateProperty);
		}
		String T16 = archKey.getT16();
		if (T16 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T16, "T16");
			list.add(templateProperty);
			;
		}
		String T17 = archKey.getT17();
		if (T17 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T17, "T17");
			list.add(templateProperty);
		}
		String T18 = archKey.getT18();
		if (T18 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T18, "T18");
			list.add(templateProperty);
		}
		String T19 = archKey.getT19();
		if (T19 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T19, "T19");
			list.add(templateProperty);
		}
		String T20 = archKey.getT20();
		if (T20 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T20, "T20");
			list.add(templateProperty);
		}
		String T21 = archKey.getT21();
		if (T21 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T21, "T21");
			list.add(templateProperty);
		}
		String T22 = archKey.getT22();
		if (T22 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T22, "T22");
			list.add(templateProperty);
		}
		String T23 = archKey.getT23();
		if (T23 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T23, "T23");
			list.add(templateProperty);
		}
		String T24 = archKey.getT24();
		if (T24 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T24, "T24");
			list.add(templateProperty);
		}
		String T25 = archKey.getT25();
		if (T25 != null) {
			TemplateProperty templateProperty = getTemplateProperty(T25, "T25");
			list.add(templateProperty);
		}
		return list;
	}

	private TemplateProperty getTemplateProperty(String header, String property) {
		String[] propertys = header.split("\\^");
		TemplateProperty templateProperty = new TemplateProperty();
		if (propertys.length == 3) {
			templateProperty.setName(propertys[0]);
			templateProperty.setType(propertys[1]);
			templateProperty.setType_name(typeChangeTypeName(propertys[1]));
			templateProperty.setDirc_name(archService.getDictById(
					Integer.parseInt(propertys[2])).getDict_name());
			templateProperty.setDirc(propertys[2]);

		} else if (propertys.length == 2) {
			templateProperty.setName(propertys[0]);
			templateProperty.setType(propertys[1]);
			templateProperty.setType_name(typeChangeTypeName(propertys[1]));
		} else if (propertys.length == 1) {
			templateProperty.setName(propertys[0]);
		}
		templateProperty.setProperty_name(property);
		return templateProperty;
	}

	private String typeChangeTypeName(String type) {
		String type_name = null;
		switch (type) {
		case "s":
			type_name = "文　字";
			break;
		case "i":
			type_name = "数　值";
			break;
		case "d":
			type_name = "日　期";
			break;
		case "e":
			type_name = "下划框";
			break;
		default:
			break;
		}
		return type_name;
	}
}

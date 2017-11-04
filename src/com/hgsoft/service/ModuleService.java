package com.hgsoft.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.ModuleDao;
import com.hgsoft.entity.Module;
import com.hgsoft.util.Order;
import com.hgsoft.util.Property;

@Service
public class ModuleService extends BaseService<Module> {

	@Autowired
	public void setDao(@Qualifier("moduleDao") ModuleDao dao) {
		super.setDao(dao);
	}

	private ModuleDao getModuleDao() {
		return (ModuleDao) this.getDao();
	}

	Order[] orders = new Order[] { Order.asc("level"), Order.asc("priority") };

	public void deleteModuleById(int id) {
		getModuleDao().deleteModuleById(id);
	}

	public boolean isHasChild(int id) {
		return getModuleDao().isHasChild(id);
	}

	public List<Module> findAll() {
		return getModuleDao().findAll(orders);
	}

	public List<Module> findChildren(Integer id) {
		return getModuleDao().findAll(orders, Property.eq("parent.id", id));
	}

	public List<Module> findByLevel(Integer id) {
		return getModuleDao().findAll(orders, Property.gt("level", id));
	}

	public Module getModuleByName(String moduleName, int parentId) { // 验证父节点下模块名是否存在
		return getModuleDao().getModuleByName(moduleName, parentId);
	}

	@SuppressWarnings("unchecked")
	public List<Module> getMenus(HashSet<Module> set) {
		List list = new ArrayList();
		if (set != null && !set.isEmpty()) {
			Iterator it = set.iterator();
			while (it.hasNext()) {
				Module module = (Module) it.next();
				list.add(module.getId());
			}
		}
		return getModuleDao().findAll(orders, Property.eq("display", 1), Property.in("id", list));
	}

	public String initMenuInsertSQL() {
		return getModuleDao().initMenuInsertSQL();
	}

	public String getCurrentPosition(Integer id) {
		String position = "";
		Module module = getDao().get(id);
		if (module != null) {
			position = module.getName();
			while (module.getParent() != null) {
				module = module.getParent();
				if (module != null) {
					position = module.getName() + " > " + position;
				}
			}
		}
		return position;
	}

}

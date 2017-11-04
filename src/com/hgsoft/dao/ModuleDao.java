package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Stack;
import java.util.TreeMap;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Module;
import com.hgsoft.util.JdbcUtil;


@Repository 
public class ModuleDao extends BaseDao<Module> {

	@Resource
	private JdbcUtil jdbcUtil;
	
	@SuppressWarnings("unchecked")
	public Module getModuleByName(String moduleName, int parentId) {	//验证父节点下模块名是否存在
		String hql = "";
		List<Module> resultList = null;
		if(parentId == 0) {
			hql = "from Module module where module.name=? and module.parent.id is null";
			resultList = executeQuery(hql, moduleName);
		} else {
			hql = "from Module module where module.name=? and module.parent.id=?";
			resultList = executeQuery(hql, moduleName, parentId);
		}
		//System.out.println(hql);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList.get(0);
		}
	}
	
	@SuppressWarnings("unchecked")
	public boolean isHasChild(int id) {
		List<Module> resultList = null;
		String hql = "from Module m where m.parent.id="+id;
		resultList = executeQuery(hql);
		if(resultList.isEmpty()) {
			return false;
		} else {
			return true;
		}
	}
	
	public void deleteModuleById(int id) {
		String sql = "delete from t_park_role_module where module="+id;
		jdbcUtil.delete(sql);
		String hql = "delete from Module module where id="+id;
		Query q = getSession().createQuery(hql);
		q.executeUpdate();
		/*List temp = new ArrayList();
		List<Module> resultList = null;
		temp.add(id);
		String sqlId = "delete from Module m where id="+id;
		String sqlPid = "delete from Module m where parent="+id;
		String sqlParent = "from Module m where parent="+id;
		resultList = executeQuery(sqlParent);
		while(!resultList.isEmpty()){
			resultList = executeQuery(sqlParent);
			Iterator it = resultList.iterator();
			if(it.hasNext()){
				Module m = (Module) it.next();
				temp.add(m.getId());
				id = m.getId();
				temp = parent(temp, id);
			}
		}*/
		
	}
	//删除时递归取子模块
	/*public List parent(List temp, int id) {
		String sqlParent = "from Module m where parent="+id;
		List<Module> resultList = executeQuery(sqlParent);
		while(!resultList.isEmpty()){
			Iterator it = resultList.iterator();
			if(it.hasNext()){
				Module m = (Module) it.next();
				temp.add(m.getId());
				id = m.getId();
				temp = parent(temp, id);
			}
		}
		return temp;
	}*/
	
	//将t_park_module表的数据生成insert SQL语句 输出控制台
	@SuppressWarnings("unchecked")
	public String initMenuInsertSQL(){
		
		//加入删除表、建表语句
		StringBuffer sbf=new StringBuffer("" +
				
				 "if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_admin_role]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)\r\n"
				+"DROP TABLE t_park_admin_role\r\n" 
				+"GO \r\n"
				+"if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_role_module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)\r\n"
				+"DROP TABLE t_park_role_module\r\n" 
				+"GO \r\n"
				+"if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_admin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)\r\n"
				+"DROP TABLE t_park_admin\r\n"
				+"GO\r\n"
				+"if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_role]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)\r\n"
				+"DROP TABLE t_park_role\r\n" 
				+"GO\r\n"
				+"if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)\r\n"
				+"DROP TABLE t_park_module\r\n" 
				+"GO\r\n\r\n"
				
						+ "--创建管理员表\r\n"
						+ "create table t_park_admin\r\n"
						+ "(\r\n"
						+ "  id               int primary key,\r\n"
						+ "  username         varchar(20),\r\n"
						+ "  name             varchar(20),\r\n"
						+ "  password         varchar(32),\r\n"
						+ "  type             varchar(1),\r\n"
						+ "  sex              varchar(2),\r\n"
						+ "  email            varchar(50),\r\n"
						+ "  phone            varchar(20),\r\n"
						+ "  createTime       datetime,\r\n"
						+ "  lastIP           varchar(15),\r\n"
						+ "  lastTime         datetime,\r\n"
						+ "  valid            varchar(1)\r\n"
						+ ")\r\n\r\n"
						
						+ "--创建系统模块表\r\n"
						+ "create table t_park_module\r\n"
						+ "(\r\n"
						+ "  id               int identity(1,1) primary key,\r\n"
						+ "  parent           int,\r\n"
						+ "  name             varchar(50),\r\n"
						+ "  url              varchar(200),\r\n"
						+ "  functions        text,\r\n"
						+ "  priority         int,\r\n"
						+ "  display          int,\r\n"
						+ "  level            int,\r\n"
						+ "  remark           varchar(200)\r\n"
						+ ")\r\n"
						+ "alter table t_park_module add constraint fk_t_park_module foreign key(parent) references t_park_module(id)\r\n\r\n"

						+ "--创建角色表\r\n"
						+ "create table t_park_role\r\n"
						+ "(\r\n"
						+ "   id              int identity(1,1) primary key,\r\n"
						+ "   name            varchar(50),\r\n"
						+ "   remark          varchar(100)\r\n" + ")\r\n\r\n"
		
						+ "--创建角色模块表\r\n"
						+ "create table t_park_role_module\r\n"
						+ "(\r\n"
						+ "   role            int,\r\n"
						+ "   module          int,\r\n"
						+ "   primary key (role, module)\r\n"
						+ ")\r\n"
						+ "alter table t_park_role_module add constraint fk_t_park_role_module_1 foreign key(role) references t_park_role(id)\r\n"
						+ "alter table t_park_role_module add constraint fk_t_park_role_module_2 foreign key(module) references t_park_module(id)\r\n\r\n"

						+ "--创建用户角色表\r\n"
						+ "create table t_park_admin_role\r\n"
						+ "(\r\n"
						+ "   admin           int,\r\n"
						+ "   role            int,\r\n"
						+ "   primary key (admin, role)\r\n"
						+ ")\r\n"
						+ "alter table t_park_admin_role add constraint fk_t_park_admin_role_1 foreign key(admin) references t_park_admin(id)\r\n"
						+ "alter table t_park_admin_role add constraint fk_t_park_admin_role_2 foreign key(role) references t_park_role(id)\r\n\r\n");
		/**
		 * 生成t_park_admin insert语句
		 */
		sbf.append("--插入管理员表 \r\n");
		sbf.append("insert into t_park_admin values(900000001,'admin','超级管理员','BCEF4C756FCB63A2D6E63A716DF7961F',null,'男','admin@163.com','02088332312','2009-03-10 20:33:33','219.23.432.12','2009-03-10 20:33:33','1')");
		sbf.append("\r\n\r\n");
		
		
		/**
		 * 生成t_park_module insert语句
		 */
		sbf.append("--插入系统模块表 \r\n");
		List<Module> Mlist=new ArrayList();
		List<Module> rootMenu=new ArrayList();
		List allParent=new ArrayList();
		List noRepeatParent=new ArrayList();

		String initSQL1="insert into t_park_module values(",initSQL2="";
		int m;
		//将菜单根级别功能模块初始化数据查询加入sbf
		rootMenu=executeQuery("from Module module where module.parent=null");
		for(int j=0;j<rootMenu.size();j++){
			initSQL2="null"+","+"'"+rootMenu.get(j).getName()+"'"+",'"+rootMenu.get(j).getUrl()+"',"+
			"'"+rootMenu.get(j).getFunctions()+"',"+rootMenu.get(j).getPriority()+","+rootMenu.get(j).getDisplay()+
			","+rootMenu.get(j).getLevel()+",'"+rootMenu.get(j).getRemark()+"')";
			
			sbf.append(initSQL1+initSQL2);
			//换行
			sbf.append("\r\n");
		}
		
		allParent=(List)jdbcUtil.selectForList("select * from t_park_module");
		
		//将allParent中重复的parent数字去掉,并去掉null
		Map<Integer,Integer> P_desc=new TreeMap<Integer,Integer>();//用有顺序的treeMap
		int num;
		for(int i=0;i<allParent.size();i++){
			if(!allParent.get(i).toString().split(",")[1].split("=")[1].equals("null")){
				num=Integer.valueOf(allParent.get(i).toString().split(",")[1].split("=")[1].trim());
				P_desc.put(num, num);
			}
			
		}
		for(Entry<Integer, Integer> entry:P_desc.entrySet()){
			noRepeatParent.add(entry.getValue());
		}
        
		//System.out.println("去掉重复的 Parent 降序："+noRepeatParent);
		
		Map<Integer,String> Mlist_desc=new TreeMap<Integer,String>();
		for(int i=0;i<noRepeatParent.size();i++){
			m=Integer.valueOf(noRepeatParent.get(i).toString().trim());
			Mlist=executeQuery("from Module module where module.parent="+m+" order by module.id DESC");
			for(int n=0;n<Mlist.size();n++){
				initSQL2=m+","+"'"+Mlist.get(n).getName()+"'"+",'"+Mlist.get(n).getUrl()+"',"+
				"'"+Mlist.get(n).getFunctions()+"',"+Mlist.get(n).getPriority()+","+Mlist.get(n).getDisplay()+
				","+Mlist.get(n).getLevel()+",'"+Mlist.get(n).getRemark()+"')";

				Mlist_desc.put(Mlist.get(n).getId(), initSQL1+initSQL2);
			}
		}
		//根据id降序append进sbf
		for(Map.Entry<Integer, String> descMlist:Mlist_desc.entrySet()){
			sbf.append(descMlist.getValue());
			sbf.append("\r\n");
			//System.out.println(descMlist.getKey()+" : "+descMlist.getValue());
		}
		
		
		/**
		 * 生成t_park_role insert语句
		 */
		sbf.append("\r\n");
		sbf.append("--插入角色表 \r\n");
		sbf.append("insert into t_park_role values('系统管理员','系统管理员') ");
		sbf.append("\r\n\r\n");
		
		
		/**
		 * 生成t_park_admin_role insert语句
		 */
		sbf.append("--插入用户角色表 \r\n");
		sbf.append("insert into t_park_admin_role values(900000001,1)");
		sbf.append("\r\n\r\n");
		
		/**
		 * 生成t_park_role_module insert语句
		 */
		sbf.append("--插入角色模块表  \r\n");
		List RMlist=new ArrayList();
		RMlist=(List)jdbcUtil.selectForList("select * from t_park_role_module where role=1");
		for(int i=0;i<RMlist.size();i++){
			int role,module=i+1;
			role=Integer.valueOf(RMlist.get(i).toString().split(",")[0].split("=")[1].trim());
			//module=Integer.valueOf(RMlist.get(i).toString().split(",")[1].split("=")[1].split("}")[0].trim());
			sbf.append("insert into t_park_role_module values("+role+","+module+") ");
			sbf.append("\r\n");
			//System.out.println("RMlist:"+role+"  "+module);
		}
		
	   return sbf.toString();
	}
}
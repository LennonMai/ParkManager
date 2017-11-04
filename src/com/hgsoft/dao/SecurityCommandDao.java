package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.util.Pager;



@Repository
public class SecurityCommandDao extends BaseDao<SecurityCommand> {
	
	
	/**
	 * 根据条件查询安全指令
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List querySecurityCommand(Pager pager,String owner,String cardNo,String vehPlate,String type,String validType){
									//   用户名     卡号（卡表面号）      车牌号    
		//String hql = "from UserCardInfo userCardInfo, SecurityUserInfo securityUserInfo where userCardInfo.cardNo = securityUserInfo.cardNo and securityUserInfo.isValid = "+ Short.valueOf("1")+" and ";
		String hql ="from SecurityCommand securityCommand,UserCardInfo userCardInfo where securityCommand.cardNo = userCardInfo.cardNo and ";
		List resultList  = new Vector();//存放返回数据
		List list1 ;//用来存放查询返回结果
		StringBuffer sb = new StringBuffer(0);//用来存放条件
		List list = new Vector();//用来存放hql中带？号的参数
		if(null != owner && !owner.equals("")){
			sb.append(" userCardInfo.owner = ? and ");
			list.add(owner);
		}
		if(null != cardNo && !cardNo.equals("")){
			sb.append(" userCardInfo.cardNo = ? and ");
			list.add(cardNo);
		}
		if(null != vehPlate && !vehPlate.equals("")){
			sb.append(" userCardInfo.vehPlate = ? and ");
			list.add(vehPlate);
		}
		if(null != type && !type.equals("")){
			sb.append(" securityCommand.type = ? and ");
			list.add(Short.parseShort(type));
		}
		if(null != validType && ! validType.equals("")){
			sb.append(" securityCommand.validType = ? and ");
			list.add(Short.parseShort(validType));
		}
		if(list.size()!=0){
			sb = sb.replace(sb.length()-4, sb.length(), "");
		}else{
			hql = hql.substring(0, 113);
		}
		Long count = this.executeCount(hql+sb.toString(), list.toArray());
		pager.setTotalSize(count);
		list1 = this.executeQuery(pager,hql+sb.toString()+" order by securityCommand.opTime desc", list.toArray());
		Iterator it = list1.iterator();
		while(it.hasNext()){
			Object[] obj = (Object[]) it.next();
			SecurityCommand securityCommand = (SecurityCommand) obj[0];
			if(!securityCommand.getStartTime().trim().equals("")){
				if(securityCommand.getStartTime().trim().length()==4){
					String yuan = securityCommand.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					securityCommand.setStartTime(sb1.toString());
				}
				if(securityCommand.getStartTime().trim().length()==12){
					String yuan = securityCommand.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					securityCommand.setStartTime(sb1.toString());
				}
			}
			if(!securityCommand.getEndTime().trim().equals("")){
				if(securityCommand.getEndTime().trim().length()==4){
					String yuan = securityCommand.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					securityCommand.setEndTime(sb1.toString());
				}
				if(securityCommand.getEndTime().trim().length()==12){
					String yuan = securityCommand.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					securityCommand.setEndTime(sb1.toString());
				}
			}
			UserCardInfo userCardInfo = (UserCardInfo) obj[1];
			Object ay = new Object[] { securityCommand, userCardInfo };
			resultList.add(ay);
		}
		return resultList;
	}
	
	//根据卡号和车牌号检验
	@SuppressWarnings("unchecked")
	public boolean getCheckUserCardInfo(String cardNo,String vehPlate){
		boolean flag = false;
		String hql = "from UserCardInfo userCardInfo where userCardInfo.cardNo = ? and userCardInfo.vehPlate = ?";
		List list = this.executeQuery(hql,cardNo,vehPlate);
		if(list.size() != 0){
			flag = true;
		}
		return flag;
	}
	
	//检查不定时操作
	@SuppressWarnings("unchecked")
	public boolean getByCardNoTypeValidType(String cardNo,short type,short vt){
		boolean flag = false;
		String hql = "from SecurityCommand securityCommand where securityCommand.cardNo = ? and securityCommand.type = ? and securityCommand.validType =?";
		List list = this.executeQuery(hql, cardNo,type,vt);
		if(list.size() != 0){
			return true;
		}
		return flag;
	}
	
	@SuppressWarnings("unchecked")
	public boolean getByVehPlateTypeValidType(String cardNo,short type,short vt,String startTime,String endTime){
		boolean flag = false;
		StringBuffer sb = new StringBuffer();
		List list = new ArrayList();
		sb.append("from SecurityCommand securityCommand where securityCommand.cardNo = ? and securityCommand.type = ? and securityCommand.validType =?");
		list.add(cardNo);
		list.add(type);
		list.add(vt);
		if(vt != 3 && vt != 4){
			if(null != startTime && !"".equals(startTime)){
				sb.append(" and securityCommand.startTime = ?");
				list.add(startTime);
			}
			if(null != endTime && !"".equals(endTime)){
				sb.append(" and securityCommand.endTime = ?");
				list.add(endTime);
			}
		}
		//String hql = "from SecurityCommand securityCommand where securityCommand.vehPlate = ? and securityCommand.type = ? and securityCommand.validType =?";
		List temp = this.executeQuery(sb.toString(), list.toArray());
		if(temp.size() != 0){
			return true;
		}
		return flag;
	}
	
	//根据commandId来获得对象
	@SuppressWarnings("unchecked")
	public SecurityCommand getByCommandId(String commandId){
		SecurityCommand command;
		String hql ="from SecurityCommand securityCommand where securityCommand.commandId =?";
		List list = this.executeQuery(hql, Integer.parseInt(commandId));
		if(list.size() != 0){
			command = (SecurityCommand) list.get(0);
			if(!command.getStartTime().trim().equals("")){
				if(command.getStartTime().trim().length()==4){
					String yuan = command.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					command.setStartTime(sb1.toString());
				}
				if(command.getStartTime().trim().length()==12){
					String yuan = command.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					command.setStartTime(sb1.toString());
				}
			}
			if(!command.getEndTime().trim().equals("")){
				if(command.getEndTime().trim().length()==4){
					String yuan = command.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					command.setEndTime(sb1.toString());
				}
				if(command.getEndTime().trim().length()==12){
					String yuan = command.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					command.setEndTime(sb1.toString());
				}
			}
			return command;
		}
		return null;
	}
	
	
	/**
	 * 根据卡表面号来查询指令管理信息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List queryCommand(String cardNo,String type,String validType){	
		String hql = "from SecurityCommand securityCommand where securityCommand.cardNo = ? and ";
		StringBuffer sb = new StringBuffer(0);
		List<Object> list = new ArrayList<Object>();
		list.add(cardNo);
		List resultList;
		if(null != type && !type.equals("")){
			sb.append("securityCommand.type = ? and ");
			list.add(Short.parseShort(type));
		}
		if(null != validType && !validType.equals("")){
			sb.append("securityCommand.validType =? and ");
			list.add(Short.parseShort(validType));
		}
		if(list.size() >= 2){
			sb = sb.replace(sb.length()-4,sb.length(), "");
		}else{
			hql = hql.substring(0, 69);
		}
		resultList = this.executeQuery(hql+sb.toString(),list.toArray());		
		return resultList;
	}
	//chenfuyuan
	public void deleteByCardNo(String cardNo) {
		String hql = "delete from SecurityCommand securityCommand where  securityCommand.cardNo='"+cardNo+"'";
		Query q = getSession().createQuery(hql) ;
        q.executeUpdate() ;		
	}

}

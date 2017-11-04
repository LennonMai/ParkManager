package com.hgsoft.dao;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.util.JdbcUtil;

@Repository
public class CardInfoSendParaDao {
	@Resource
	private JdbcUtil jdbcUtil;
	@Resource
	private SendParaDao sendParaDao;
	@Resource
	private SystemParaDao systemParaDao;
	
	public void SendCardInfoPara() {
		
		String sql1 = "delete from tb_SendPara where tablename='V_WhiteList' or tablename='V_AOwnerNVeh' " +
				"or tablename='v_LimitParkInfo' or tablename='tb_OpCardBlackList' or tablename='tb_IDCardInfo' " +
				"or tablename='V_PassCardWL' or tablename='V_PassCardBlackList' or  tablename='v_securitycommand' or tablename='V_LoseCardList'";
		String sql2 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_WhiteList','V_WhiteList' from tb_LaneUse";
		String sql3 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_AOwnerNVeh','V_AOwnerNVeh' from tb_LaneUse";
		String sql4 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_LimitParkInfo','v_LimitParkInfo' from tb_LaneUse";
		String sql5 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'tb_OpCardBlackList','tb_OpCardBlackList' from tb_LaneUse";
		String sql6 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'tb_IDCardInfo','tb_IDCardInfo' from tb_LaneUse";
		String sql7 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_PassCardWL','V_PassCardWL' from tb_LaneUse where";
		String sql8 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_PassCardBlackList','V_PassCardBlackList' from tb_LaneUse";
		String sql9 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_securitycommand','v_securitycommand' from tb_LaneUse";
		String sql10 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_LoseCardList','V_LoseCardList' from tb_LaneUse";
		//		System.out.println(sql1);
		jdbcUtil.update(sql1);
		jdbcUtil.update(sql2);
		jdbcUtil.update(sql3);
		jdbcUtil.update(sql4);
		jdbcUtil.update(sql5);
		jdbcUtil.update(sql6);
		jdbcUtil.update(sql7);
		jdbcUtil.update(sql8);
		jdbcUtil.update(sql9);
		jdbcUtil.update(sql10);
		//this.InsertSystemPara();
		
	}
	public void SendCardInfoParaHavaPayType() {
		String sql1 = "delete from tb_SendPara where tablename='V_WhiteList' or tablename='V_AOwnerNVeh' " +
				"or tablename='v_LimitParkInfo' or tablename='tb_OpCardBlackList' or tablename='tb_IDCardInfo' " +
				"or tablename='V_PassCardWL' or tablename='V_PassCardBlackList' or  tablename='v_securitycommand' or tablename='V_LoseCardList'";
		String sql2 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_WhiteList','V_WhiteList' from tb_LaneUse";
		//String sql3 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_AOwnerNVeh' from tb_Lane";
		//String sql4 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_LimitParkInfo' from tb_Lane";
		String sql5 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'tb_OpCardBlackList','tb_OpCardBlackList' from tb_LaneUse";
		//String sql6 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'tb_IDCardInfo' from tb_Lane";
		String sql7 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_PassCardWL','V_PassCardWL' from tb_LaneUse";
		String sql8 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_PassCardBlackList','V_PassCardBlackList' from tb_LaneUse";
		String sql9 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_securitycommand','v_securitycommand' from tb_LaneUse";
		String sql10 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_LoseCardList','V_LoseCardList' from tb_LaneUse";
		//		System.out.println(sql1);
		jdbcUtil.update(sql1);
		jdbcUtil.update(sql2);
		//jdbcUtil.update(sql3);
		//jdbcUtil.update(sql4);
		jdbcUtil.update(sql5);
		//jdbcUtil.update(sql6);
		jdbcUtil.update(sql7);
		jdbcUtil.update(sql8);
		jdbcUtil.update(sql9);
		jdbcUtil.update(sql10);
		//this.InsertSystemParaHavaPayType();
	}
	
	/**
	 * �·���ȫָ��Ͷ�ʧ����Ϣ
	 * V_LoseCardList   v_securitycommand
	 */
	public void SendCommandAndLost(){
		String sql1 = "delete from tb_SendPara where tablename='v_securitycommand' or tablename='V_LoseCardList' ";
		String sql2 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_securitycommand','v_securitycommand' from tb_LaneUse";
		String sql3 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_LoseCardList','V_LoseCardList' from tb_LaneUse";
		jdbcUtil.delete(sql1);
		jdbcUtil.save(sql2);
		jdbcUtil.save(sql3);
		
		/*sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='Security' and ItemValue='v_securitycommand'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'����ʱ���','v_securitycommand','Security',"+(short)(systemParaDao.findMaxItemOrderBygroupName("Security")+1)+",null)";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='Security' and ItemValue='V_LoseCardList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'��ǰ����¼��','V_LoseCardList','Security',"+(short)(systemParaDao.findMaxItemOrderBygroupName("Security")+1)+",null)";
		jdbcUtil.update(sql1);*/
	}
	public void InsertSystemPara(){//��Ϣ����b_SystemPara (ϵͳ��������)���Է��·����ɹ�ʱ�����ֹ��·�
		String sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='V_AOwnerNVeh'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'���복λ����Ӧ��ͼ','V_AOwnerNVeh','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='v_LimitParkInfo'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'���ƿ���ֻ�ܴ��ĸ��Ž�����ͼ','v_LimitParkInfo','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
			
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='tb_IDCardInfo'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'��ݿ���Ϣ��','tb_IDCardInfo','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='V_WhiteList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'������','V_WhiteList','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='tb_OpCardBlackList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'��ݿ�������','tb_OpCardBlackList','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='V_PassCardWL'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'ͨ�п��ǼǱ�','V_PassCardWL','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='V_PassCardBlackList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'ͨ�п���������','V_PassCardBlackList','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='Security' and ItemValue='v_securitycommand'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'����ʱ���','v_securitycommand','Security',"+(short)(systemParaDao.findMaxItemOrderBygroupName("Security")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='Security' and ItemValue='V_LoseCardList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'��ǰ����¼��','V_LoseCardList','Security',"+(short)(systemParaDao.findMaxItemOrderBygroupName("Security")+1)+")";
		jdbcUtil.update(sql1);
		
		
	}
	public void InsertSystemParaHavaPayType(){
		String sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='V_WhiteList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'������','V_WhiteList','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		 sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='tb_OpCardBlackList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'��ݿ�������','tb_OpCardBlackList','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='V_PassCardWL'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'ͨ�п��ǼǱ�','V_PassCardWL','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='CardInfo' and ItemValue='V_PassCardBlackList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'ͨ�п���������','V_PassCardBlackList','CardInfo',"+(short)(systemParaDao.findMaxItemOrderBygroupName("CardInfo")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='Security' and ItemValue='v_securitycommand'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'����ʱ���','v_securitycommand','Security',"+(short)(systemParaDao.findMaxItemOrderBygroupName("Security")+1)+")";
		jdbcUtil.update(sql1);
		
		sql1 = "delete from tb_SystemPara where ParaClass=1 and GroupName='Security' and ItemValue='V_LoseCardList'";
		jdbcUtil.update(sql1);
		sql1 = "insert into tb_SystemPara values(1,'��ǰ����¼��','V_LoseCardList','Security',"+(short)(systemParaDao.findMaxItemOrderBygroupName("Security")+1)+")";
		jdbcUtil.update(sql1);
		
	}
	@Resource
	public void setSendParaDao(SendParaDao sendParaDao) {
		this.sendParaDao = sendParaDao;
	}
	public SendParaDao getSendParaDao() {
		return sendParaDao;
	}
	@Resource
	public void setSystemParaDao(SystemParaDao systemParaDao) {
		this.systemParaDao = systemParaDao;
	}
	public SystemParaDao getSystemParaDao() {
		return systemParaDao;
	}

}

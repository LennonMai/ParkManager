
GO
--系统参数配置表数据初始化
-----------------------------------ParkNo需要修改（不知道参数值）------------------------------
Delete from t_park_sysparamconf
Insert into t_park_sysparamconf values('AreaNo','4430',0,'区域编号')
Insert into t_park_sysparamconf values('ParkNo','101',0,'小区编号')
Insert into t_park_sysparamconf values('parkReport','hg',0,'用cardInfoReport的那个校区的jsp文件，如果值为hg，就是cardInfoReprot文件夹下的hg文件夹中的jsp，初始值为hg')
Insert into t_park_sysparamconf values('card_type','0',0,'卡类型参数（0就是记账卡，1就是储值卡,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)')
Insert into t_park_sysparamconf values('endAccount_amongTime','0',0,'申请销户到销户的时间间隔参数值要是数字，否则系统初始化为0天（没设endAccount_amongTime参数系统也初始化为0天)')
Insert into t_park_sysparamconf values('addAccount_LowestBalanceAfterConsume','0',0,'开户中的最低余额（单位：元）（参数值要是正数或者0（例如：10。小数点最多为2位，超过两位时就直接把后面的小数点去点），否则初始化为0）')
Insert into t_park_sysparamconf values('addAccount_TollyLowestBalanceAC','0',0,'开户中的记账最低余额（单位：元）（参数值要是正数或者0（例如：10。小数点最多为2位，超过两位时就直接把后面的小数点去点），否则初始化为0）')
Insert into t_park_sysparamconf values('addAccount_NoEntryBalance','15',0,'开户中的禁止驶入最低余额（单位：元）（参数值要是正数或者0（例如：15。小数点最多为2位，超过两位时就直接把后面的小数点去点），否则系统初始化为15）')
Insert into t_park_sysparamconf values('addAccount_LowBalanceNotice','50',0,'开户中的提示用户去续费的最低余额（单位：元）（参数值要是正数或者0（小数点最多为2位，超过两位时就直接把后面的小数点去点），否则系统初始化为50）')
Insert into t_park_sysparamconf values('addAccount_Cost','0',0,'开户工本费（单位：元）（参数值要是正数或者0（例如：10。小数点最多为2位，超过两位时就直接把后面的小数点去点），否则初始化为0）')
Insert into t_park_sysparamconf values('CardRechargeSystem_path','C:\用户卡充值\CardRechargeSystem.exe',0,'储值卡充值和冲正软件路径，没设置是初始化为C:/充值和冲正/CardRechargeSystem.exe')
Insert into t_park_sysparamconf values('whtherPayType','0',0,'是否有缴费类型参数（0表示有缴费类型，1表示没有缴费类型,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)')
Insert into t_park_sysparamconf values('TIME_updateUserCarInfoStatusTask','2011-04-13_00:00:00',0,'每天定时更改过期校园卡账户状态和缴费期限。（2011-04-13_00:00:00,表示当前时间大于或者等于2011年4月13号时，00：00：00执行）。')
Insert into t_park_sysparamconf values('accountCardNoLength','10',0,'缴费卡账户管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值。例如：值为9则卡号长度只能为9）。')
Insert into t_park_sysparamconf values('parkjsp','hg',0,'用parkCard那个校区的jsp文件，值为hg，就是用parkCard文件下的hg文件夹中的jsp。初始值为hg。')
Insert into t_park_sysparamconf values('userCardInfoCardNoLength','10',0,'校园卡管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值，例如：值为9则卡号长度只能为9）')
Insert into t_park_sysparamconf values('vehPlate','C:\小区中心车辆管理程序\小区中心通讯程序\Data\Jpeg\',0,'为查询车道捉拍图片提供路径')
Insert into t_park_sysparamconf values('CardInit_path','C:/IC卡登记程序/CardInit.exe',0,'IC卡登记程序路径，初始化设置为C:/IC卡登记程序/CardInit.exe')
Insert into t_park_sysparamconf values('SWL_KEY','7#26hgrica1@62#7',0,'华工监听系统配置功能密匙，不可修改。')
Insert into t_park_sysparamconf values('SWL_InputFileName','sysConfig.dll',0,'华工监听系统配置功能所监听的文件名称，不建议修改。')
GO
----------------------------------------------------------------------------------------------------------
Delete from tb_FeeRuleTypeDef;
Insert into tb_FeeRuleTypeDef values(0,'过夜车');
Insert into tb_FeeRuleTypeDef values(1,'不过夜车');
-----------------------------------------------------------------------------------------------------------
GO
Delete from tb_UserCardType;
Insert into tb_UserCardType values(0,'临时卡',null)
Insert into tb_UserCardType values(1,'身份卡',null)
Insert into tb_UserCardType values(2,'缴费卡',null)
Insert into tb_UserCardType values(13,'教工卡',null)
Insert into tb_UserCardType values(14,'月租卡',null)
Delete from tb_UserCardFeeRuleType;
Insert into tb_UserCardFeeRuleType values(13,0)
Insert into tb_UserCardFeeRuleType values(14,1)
GO
-----------------------------------------------------------------------------------------------------------
GO
Delete from tb_CardType;
Insert into tb_CardType values(1,'通行卡',1)
Insert into tb_CardType values(2,'测试通行卡',1)
Insert into tb_CardType values(3,'公务卡',1)
Insert into tb_CardType values(4,'身份卡',1)
Insert into tb_CardType values(5,'储值卡',1)
Insert into tb_CardType values(6,'记账卡',1)
Insert into tb_CardType values(7,'PSAM卡',1)
Insert into tb_CardType values(9,'未知卡',1)
Insert into tb_CardType values(13,'教工卡',1)
Insert into tb_CardType values(14,'月租卡',1)
GO
------------------------------------------------参数管理初始值-----------------------------------------------------------
--------------------------------------------基本信息-------------------------------------------------------
  GO
  Delete from tb_City 
  Insert into tb_City values(4403,'广州','广州')
  GO
  Delete from tb_Area
  Insert into tb_Area values(4430,'广州区','gg','192.168.1.110','gg.cn','parkdb','sa','sa',4430)
  GO
  Delete from tb_Squad
  Insert into tb_Squad values(1,'第一工班','14:50:00','22:50:00','2003-10-01 00:00:00.000',1,null)
  Insert into tb_Squad values(2,'第二工班','22:50:00','06:50:00','2003-10-01 00:00:00.000',1,null)
  Insert into tb_Squad values(3,'第三工班','06:50:00','14:50:00','2003-10-01 00:00:00.000',0,null)
  GO
  Delete from tb_Supplylight
  Insert into tb_Supplylight values('18:00:00','06:30:00')
-----------------------------------------------费率信息----------------------------------------------------
-----------------------------------ParkNo需要修改（不知道参数值）------------------------------
  GO
  Delete from tb_PriceRule
  Insert into tb_PriceRule values(101,1,1,0,9999,59,1,720,1,1,88,'2007-01-01 00:00:00.000',0)
  Insert into tb_PriceRule values(101,1,2,0,9999,59,2,60,2,6,88,'2007-01-01 00:00:00.000',0)
  Insert into tb_PriceRule values(101,2,1,0,720,63,1,720,1,1,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,2,2,0,720,63,2,60,2,6,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,2,3,0,720,63,3,60,3,9,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,3,1,0,720,0,1,720,1,1,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,3,2,0,720,0,2,60,2,6,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,3,3,0,720,0,3,60,3,9,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,4,1,0,720,179,1,720,1,1,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,4,2,0,720,179,1,720,1,1,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,4,3,0,720,179,1,720,1,1,88,'2007-01-01 00:00:00.000',720)
  Insert into tb_PriceRule values(101,1,3,0,720,59,3,60,3,9,88,'2007-01-01 00:00:00.000',0)
  
  GO
  Delete from tb_UserCardRate
  Insert into tb_UserCardRate values(1,2,14,0,1,0,10)
  Insert into tb_UserCardRate values(1,1,14,0,1,0,0) 
  Insert into tb_UserCardRate values(1,3,14,0,1,0,20)
--------------------------------------------运营参数-------------------------------------------------------
  GO
  Delete from tb_VehTypeCode
  Insert into tb_VehTypeCode values (1,'一型车',0,49)
  Insert into tb_VehTypeCode values (2,'二型车',0,50)
  Insert into tb_VehTypeCode values (3,'三型车',0,51)
  Insert into tb_VehTypeCode values (4,'四型车',0,52)
  Insert into tb_VehTypeCode values (5,'五型车',0,53)
  Insert into tb_VehTypeCode values (6,'六型车',0,54)
  Insert into tb_VehTypeCode values (7,'七型车',0,55)
  Insert into tb_VehTypeCode values (8,'八型车',0,56)
  Insert into tb_VehTypeCode values (9,'未知型车',0,0)
  GO
  Delete from tb_VehClassCode
  Insert into tb_VehClassCode values (1,'正常车',0,0)
  Insert into tb_VehClassCode values (2,'免费车',0,188)
  Insert into tb_VehClassCode values (3,'校内车',0,121)
  Insert into tb_VehClassCode values (4,'车队车',0,0)
  Insert into tb_VehClassCode values (5,'未付车',0,220)
  Insert into tb_VehClassCode values (6,'粤通卡',0,0)
  Insert into tb_VehClassCode values (9,'未知车',0,0)
  GO
  Delete from tb_DeviceCode
  Insert into tb_DeviceCode values(1,'外设控制器')
  Insert into tb_DeviceCode values(2,'打印机')
  Insert into tb_DeviceCode values(3,'网络')
  Insert into tb_DeviceCode values(4,'读卡器')
  Insert into tb_DeviceCode values(5,'字符叠加')
  Insert into tb_DeviceCode values(6,'费额处理器')
  Insert into tb_DeviceCode values(7,'车牌识别')
  Insert into tb_DeviceCode values(8,'视频捕捉')
  Insert into tb_DeviceCode values(9,'数据库')
  Insert into tb_DeviceCode values(10,'流式文件')
  Insert into tb_DeviceCode values(11,'其它')
  GO
  Delete from tb_FunctionKey
  Insert into tb_FunctionKey values(1,'确认',0,13)
  Insert into tb_FunctionKey values(2,'取消',0,27)
  Insert into tb_FunctionKey values(3,'抬杠',0,219)
  Insert into tb_FunctionKey values(4,'降杆',0,221)
  Insert into tb_FunctionKey values(5,'下班',0,118)
  Insert into tb_FunctionKey values(6,'管理',0,119)
  Insert into tb_FunctionKey values(7,'前置',0,120)
  Insert into tb_FunctionKey values(8,'丢卡',0,113)
  Insert into tb_FunctionKey values(9,'坏卡',0,114)
  Insert into tb_FunctionKey values(10,'查询',0,222)
  Insert into tb_FunctionKey values(11,'倒车',0,190)
  Insert into tb_FunctionKey values(12,'切换',0,189)
  Insert into tb_FunctionKey values(13,'重打',0,116)
  Insert into tb_FunctionKey values(14,'上移',0,112)
  Insert into tb_FunctionKey values(15,'下移',0,117)
  Insert into tb_FunctionKey values(16,'未付',0,220)
  Insert into tb_FunctionKey values(17,'纸卷',0,191)
  Insert into tb_FunctionKey values(18,'优惠',0,115)
  Insert into tb_FunctionKey values(19,'刷卡',0,192)
  GO
  Delete from tb_CarTypeTrans
  Insert into tb_CarTypeTrans values('20070101','0',1,1,1,1,1,100000200,'2')
  Insert into tb_CarTypeTrans values('20070101','0',1,1,1,1,1,102009900,'3')
  Insert into tb_CarTypeTrans values('20070101','2',1,1,1,1,1,100000200,'2')
  Insert into tb_CarTypeTrans values('20070101','2',1,1,1,1,1,120009900,'3')
  GO
  Delete from tb_LaneType
  Insert into tb_LaneType values(0,'出入口')
  Insert into tb_LaneType values(1,'入口')
  Insert into tb_LaneType values(2,'出口')
  GO
  Delete from tb_SpEventCode
  Insert into tb_SpEventCode values(0,'正常车')
  Insert into tb_SpEventCode values(1,'闯关车')
  Insert into tb_SpEventCode values(2,'挂车')
  Insert into tb_SpEventCode values(3,'倒车')
  Insert into tb_SpEventCode values(4,'拖车')
  Insert into tb_SpEventCode values(5,'车型不符')
  Insert into tb_SpEventCode values(6,'车种不符')
  Insert into tb_SpEventCode values(7,'车牌不符')
  Insert into tb_SpEventCode values(8,'丢卡')
  Insert into tb_SpEventCode values(9,'坏卡')
  Insert into tb_SpEventCode values(10,'修改')
  Insert into tb_SpEventCode values(11,'超时')
  Insert into tb_SpEventCode values(12,'换卡')
  Insert into tb_SpEventCode values(13,'回头车')
  Insert into tb_SpEventCode values(14,'重打')
  Insert into tb_SpEventCode values(15,'车队')
  Insert into tb_SpEventCode values(16,'紧急车')
  Insert into tb_SpEventCode values(17,'免费车')
  Insert into tb_SpEventCode values(18,'校内车')
  Insert into tb_SpEventCode values(19,'重写卡入口信息') 
  Insert into tb_SpEventCode values(20,'未付车')
  Insert into tb_SpEventCode values(23,'抬杠放行')
  Insert into tb_SpEventCode values(24,'优惠车辆')
  Insert into tb_SpEventCode values(25,'重放行')
  Insert into tb_SpEventCode values(26,'拦截后放行')
  Insert into tb_SpEventCode values(27,'特殊处理车辆')
  Insert into tb_SpEventCode values(28,'免费放行')
  Insert into tb_SpEventCode values(29,'报过收取现金')
  Insert into tb_SpEventCode values(120,'软盘下发参数拷贝')
  Insert into tb_SpEventCode values(121,'拷贝流水及工班数据')
  Insert into tb_SpEventCode values(122,'设备维修')
  Insert into tb_SpEventCode values(123,'重连读写器')
  Insert into tb_SpEventCode values(124,'设置打印参数')
  Insert into tb_SpEventCode values(125,'设置字符叠加')
  Insert into tb_SpEventCode values(126,'打开模拟线圈控制')
  Insert into tb_SpEventCode values(127,'取消一次线圈控制')
  Insert into tb_SpEventCode values(128,'完全一次线圈控制')
  Insert into tb_SpEventCode values(129,'打开顶棚灯')
  Insert into tb_SpEventCode values(130,'关闭顶棚灯')
  Insert into tb_SpEventCode values(131,'车号查询')
  Insert into tb_SpEventCode values(132,'打开光报警')
  Insert into tb_SpEventCode values(133,'打开声报警')
  Insert into tb_SpEventCode values(134,'重连读写器')
  Insert into tb_SpEventCode values(135,'发票号码输入')
  Insert into tb_SpEventCode values(136,'换卡盒')
  Insert into tb_SpEventCode values(137,'现场稽查')
  Insert into tb_SpEventCode values(138,'刷班长卡或输入班长密码')
  Insert into tb_SpEventCode values(139,'打开/关闭控制柜门')
  Insert into tb_SpEventCode values(140,'设置打印参数')
  Insert into tb_SpEventCode values(141,'卡挂失')
  GO
  Delete from tb_DeviceErrorCode
  Insert into tb_DeviceErrorCode values(1,'打印机通讯故障',3)
  Insert into tb_DeviceErrorCode values(2,'线圈故障',3)
  Insert into tb_DeviceErrorCode values(3,'栏杆故障',3)
  Insert into tb_DeviceErrorCode values(4,'封道栏杆故障',3)
  Insert into tb_DeviceErrorCode values(5,'网络通讯查询超时故障',3)
  Insert into tb_DeviceErrorCode values(6,'网络通讯上传监控故障',3)
  Insert into tb_DeviceErrorCode values(7,'网络通讯回控超时故障',3)
  Insert into tb_DeviceErrorCode values(8,'顶棚灯故障',3)
  Insert into tb_DeviceErrorCode values(9,'读卡器通讯故障',3)
  Insert into tb_DeviceErrorCode values(10,'读卡器读写卡片失败',3)
  Insert into tb_DeviceErrorCode values(11,'视频捕捉卡故障',3)
  Insert into tb_DeviceErrorCode values(12,'查找价格表失败',3)
  Insert into tb_DeviceErrorCode values(13,'线圈禁止刷卡',3)
  Insert into tb_DeviceErrorCode values(14,'手动抬杆',3)
  Insert into tb_DeviceErrorCode values(15,'手动降杆',3)
  Insert into tb_DeviceErrorCode values(16,'外设控制器通讯故障',3)
  Insert into tb_DeviceErrorCode values(17,'坏卡',3)
  Insert into tb_DeviceErrorCode values(18,'取消线圈控制',3)
  Insert into tb_DeviceErrorCode values(19,'打开线圈控制',3)
  Insert into tb_DeviceErrorCode values(20,'不使用线圈控制',3)
  Insert into tb_DeviceErrorCode values(21,'线圈记数不匹配',3)
  Insert into tb_DeviceErrorCode values(22,'未处理车',3)
  Insert into tb_DeviceErrorCode values(23,'字符叠加通讯故障',3)
  Insert into tb_DeviceErrorCode values(24,'费额处理器通讯故障',3)
  Insert into tb_DeviceErrorCode values(25,'车牌识别通讯故障',3)
  Insert into tb_DeviceErrorCode values(26,'数据库打开或读写失败',3)
  Insert into tb_DeviceErrorCode values(27,'流式文件存储失败',3)
  Insert into tb_DeviceErrorCode values(222,'断链',3)
  GO
  Delete from tb_TicketTypeCode
  Insert into tb_TicketTypeCode values(1,'通行卡')
  Insert into tb_TicketTypeCode values(2,'查入口')
  Insert into tb_TicketTypeCode values(3,'纸卷')
  Insert into tb_TicketTypeCode values(5,'储值卡')
  Insert into tb_TicketTypeCode values(6,'记账卡')
  Insert into tb_TicketTypeCode values(9,'未知卡')
  GO
  Delete from tb_Role
  Insert into tb_Role values(1,'车道班长','车道班长')
  Insert into tb_Role values(2,'车道维护人员','车道维护人员')
  Insert into tb_Role values(3,'车道发卡员','车道发卡员')
  Insert into tb_Role values(4,'车道收费员','车道收费员')
  GO
  Delete from tb_SystemPara
  Insert into tb_SystemPara values (-1,'AdvCode','营运参数','',2,null)
  Insert into tb_SystemPara values (-1,'BaseCode','基本参数','',1,null)
  Insert into tb_SystemPara values (-1,'BlackList','黑名单','',0,null)
  Insert into tb_SystemPara values (-1,'CardInfo','卡信息','',3,null)
  Insert into tb_SystemPara values (-1,'Default','其它','',32767,null)
  Insert into tb_SystemPara values (-1,'Operator','操作员信息','',4,null)
  Insert into tb_SystemPara values (-1,'Price','费率','',6,null)
  Insert into tb_SystemPara values (-1,'Security','安全信息','',5,null)
  -----------------------------------ParkNo需要修改（不知道参数值）------------------------------
  Insert into tb_SystemPara values (0,'AreaName','广州区域','',0,null)
  Insert into tb_SystemPara values (0,'AreaNo','4430','',0,null)
  Insert into tb_SystemPara values (0,'ParkName','广工','',0,null)
  Insert into tb_SystemPara values (0,'ParkNo','101','',0,null)
  Insert into tb_SystemPara values (0,'RateVersion','1','',0,null)
  
  Insert into tb_SystemPara values (1,'OBU有效启用日期','tb_OBUDate','BlackList',0,1)
  Insert into tb_SystemPara values (1,'白名单','v_WhiteList','CardInfo',5,1)
  Insert into tb_SystemPara values (1,'补光灯开关时间表','tb_Supplylight','Default',0,1)
  Insert into tb_SystemPara values (1,'操作员角色','tb_OperatorRole','Operator',1,1)
  Insert into tb_SystemPara values (1,'操作员信息','tb_Operator','Operator',0,1)
  Insert into tb_SystemPara values (1,'车道编码','tb_Lane','BaseCode',4,1)
  Insert into tb_SystemPara values (1,'车型编码表','tb_VehTypeCode','AdvCode',5,1)
  Insert into tb_SystemPara values (1,'车型转换表','tb_carTypeTrans','AdvCode',4,1)
  Insert into tb_SystemPara values (1,'车种编码表','tb_VehClassCode','AdvCode',3,1)
  Insert into tb_SystemPara values (1,'城市编码','tb_City','BaseCode',0,1)
  Insert into tb_SystemPara values (1,'储值卡黑名单','tb_StoreCardBlackList','BlackList',1,1)
  Insert into tb_SystemPara values (1,'储值卡有效启用日期','tb_StoreCardDate','BlackList',2,1)
  Insert into tb_SystemPara values (1,'大门编码','tb_Gateway','BaseCode',3,1)
  Insert into tb_SystemPara values (1,'当前丢卡记录表','V_LoseCardList','Security',0,1)
  Insert into tb_SystemPara values (1,'费率规则表','tb_PriceRule','Price',1,1)
  Insert into tb_SystemPara values (1,'工班','tb_Squad','AdvCode',8,1)
  Insert into tb_SystemPara values (1,'功能键表','tb_FunctionKey','AdvCode',0,1)
  Insert into tb_SystemPara values (1,'黑名单车辆','tb_SpecialVeh','CardInfo',0,1)
  Insert into tb_SystemPara values (1,'记帐卡黑名单','tb_TollyCardBlackList','BlackList',3,1)
  Insert into tb_SystemPara values (1,'记帐卡有效启用日期','tb_TollyCardDate','BlackList',4,1)
  Insert into tb_SystemPara values (1,'卡信息表','tb_CardInfo','CardInfo',4,1)
  Insert into tb_SystemPara values (1,'区域编码','tb_Area','BaseCode',1,1)
  Insert into tb_SystemPara values (1,'设备编码表','tb_devicecode','AdvCode',1,1)
  Insert into tb_SystemPara values (1,'设备错误代码表','tb_deviceerrorcode','AdvCode',2,1)
  Insert into tb_SystemPara values (1,'身份卡黑名单','tb_OpCardBlackList','CardInfo',2,1)
  Insert into tb_SystemPara values (1,'收费类型映射表','tb_pricepasstype','Price',0,1)
  Insert into tb_SystemPara values (1,'锁车时间表','v_securitycommand','Security',1,1)
  Insert into tb_SystemPara values (1,'特殊车辆处理信息表','tb_SpVehHandle','CardInfo',6,1)
  Insert into tb_SystemPara values (1,'特殊事件编码表','tb_speventcode','AdvCode',7,1)
  Insert into tb_SystemPara values (1,'通行卡登记表','V_PassCardWL','CardInfo',3,1)
  Insert into tb_SystemPara values (1,'通行卡黑名单表','V_PassCardBlackList','CardInfo',1,1)
  Insert into tb_SystemPara values (1,'通行券类型编码表','tb_tickettypecode','AdvCode',6,1)
  Insert into tb_SystemPara values (1,'校区编码','tb_Park','BaseCode',2,1)
  Insert into tb_SystemPara values (2,'CardDeposit','0','',0,null)
-----------------------------------------------------------------------------------------------------------
GO
   --设置特殊类型
  delete from tb_SpecialType
  insert into tb_SpecialType(typeCode,Typename) values(1,'提示不拦截')
  insert into tb_SpecialType(typeCode,Typename) values(2,'人工确认')
  insert into tb_SpecialType(typeCode,Typename) values(3,'拦截且提示')


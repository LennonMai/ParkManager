-->修改工班日志表（2011-08-09）
GO
alter table tb_SquadLog alter column OperatorName char(8);
GO
alter table tb_SquadLog alter column ID char(16);


--创建费率配置表（tb_PriceBase）（为了数据库统一，广外没用）
GO
CREATE TABLE tb_PriceBase(
	VerNo int NOT NULL,
	FeeNo int NOT NULL,
	RebateType int NOT NULL,
	InOutSign int NOT NULL,
	TimesSign int NOT NULL,
	VehTypeNo int NOT NULL,
	AllowStayTime int NULL,
	BaseFeeTime int NULL,
	BaseFee int NULL,
	StayAdd int NULL,
	AddFee int NULL,
	AddStart int NULL,
	MaxFee int NULL,
	MaxTime int NULL,
	MaxFeeTime int NULL,
	SumFeeCtr int NULL,
	backup1 char(16) NULL,
	backup2 char(16) NULL,
	StartTime datetime NULL,
	Remark char(50) NULL,
    CONSTRAINT PK_PriceBase PRIMARY KEY CLUSTERED (VerNo ASC,FeeNo ASC,RebateType ASC,InOutSign ASC,TimesSign ASC,VehTypeNo ASC)
)

-->创建费率规则表[浙大]（tb_pricerule_zd）（为了数据库统一，广外没用）
GO
CREATE TABLE tb_PriceRule_zd(
	FeeRuleType int NOT NULL,
	VehTypeNo int NOT NULL,
	FeeOfOneCycle int NULL,
	FreeTimes int NULL,
	MaxFreeTimesUsedEveryTimes int NULL,
	ValidateTrim int NULL,
	InvalidateTrim int NULL,
	remark char(50) NULL,
	MaxTotalFee int NULL,
 CONSTRAINT PK_PriceRule_zd PRIMARY KEY CLUSTERED (FeeRuleType ASC,VehTypeNo ASC)
)
-->创建免费日期表（tb_FreeDays）（浙江大学在用，为了数据库统一，广外没用）
GO
CREATE TABLE tb_FreeDays(
	FeeRuleType int NULL,
	Type int NULL,
	Value char(10) NULL
) 
-->出入口标志表（tb_InOutSignDef）(浙江大学在用，为了数据库统一，广外没用）
GO
CREATE TABLE tb_InOutSignDef(
	InGateNo int NOT NULL,
	OutGateNo int NOT NULL,
	InOutSign int NULL,
	Remark char(16) NULL,
    CONSTRAINT PK_InOutSignDef PRIMARY KEY CLUSTERED (InGateNo ASC,OutGateNo ASC)
 )
-->时间标志表（tb_TimesSignDef）(浙江大学在用，为了数据库统一，广外没用）
GO
CREATE TABLE tb_TimesSignDef(
	FeeRuleType int NOT NULL,
	DayType int NOT NULL,
	StartTime char(8) NOT NULL,
	EndTime char(8) NULL,
	TimesSign int NULL,
	Remark char(50) NULL,
    CONSTRAINT PK_TimesSignDef PRIMARY KEY CLUSTERED (FeeRuleType ASC,DayType ASC,StartTime ASC)
)
GO
--创建帐号信息表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_account]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_account
GO
create table t_park_account
(
	sys_id int identity(1,1),
	status int not null,
	user_id int,
	car_id int,
	cardNo varchar(20) not null,
	cardType int not null,
	parkNo int null,
	cost int not null,
	balance int null,
	lowestBalanceAfterConsume int not null,
	tollyLowestBalanceAC int not null,
	noEntryBalance int,
	lowBalanceNotice int,
	openAccountTime datetime,
	statusUpdateTime datetime,
	remark varchar(100),
	constraint pk_pams_accountNo primary key(sys_id),
)

GO

--创建车辆信息表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_car]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_car
GO
create table t_park_car
(
	sys_id int identity(1,1),
	vehPlate varchar(10) not null,
	carType int,
	carColour varchar(50),
	constraint pk_pams_car_id primary key(sys_id),
)
GO

--创建系统配置表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_config]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_config
GO
create table t_park_config
(
   id               int identity(1,1) primary key,
   siteName         varchar(100),
   propertyName     varchar(50),
   company          varchar(200),
   copyright        varchar(255),
   recordCode       varchar(255),
   email            varchar(100),
   phone            varchar(200),
   mobile           varchar(200)   
)
GO

--初始化系统配置表数据
insert into t_park_config values('小区车辆管理中心系统','小区','小区','Copyright &copy;2007-2009 www.flc.com, All Rights Reserved','京ICP证030173号','liu@hgrica.com','02087113968','13632338888')
GO

--系统参数配置表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_sysparamconf]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_sysparamconf
GO
create table t_park_sysparamconf
(
	sys_id int  identity(1,1),
	pname varchar (50)  NOT NULL ,
	pvalue varchar (200)  NOT NULL ,
	ptype  int NOT NULL ,
	remark varchar (150) ,
	constraint pk_pams_sysparamconf_id primary key (sys_id)  
) 
create unique index index_pams_pname on t_park_sysparamconf(pname)
GO

--系统参数配置表数据初始化
insert into t_park_sysparamconf values('AreaNo','4430',0,'区域编号')
insert into t_park_sysparamconf values('ParkNo','103',0,'小区编号')
insert into t_park_sysparamconf values('parkReport','gw',0,'用cardInfoReport的那个校区的jsp文件，如果值为hg，就是cardInfoReprot文件夹下的hg文件夹中的jsp，初始值为hg')
insert into t_park_sysparamconf values('card_type','0',0,'卡类型参数（0就是记账卡，1就是储值卡,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)')
insert into t_park_sysparamconf values('endAccount_amongTime','0',0,'申请销户到销户的时间间隔参数值要是数字，否则系统初始化为0天（没设endAccount_amongTime参数系统也初始化为0天)')
insert into t_park_sysparamconf values('addAccount_LowestBalanceAfterConsume','0',0,'开户中的最低余额（单位：元）（参数值要是正数或者0（例如：10。小数点最多为2位，超过两位时就直接把后面的小数点去点），否则初始化为0）')
insert into t_park_sysparamconf values('addAccount_TollyLowestBalanceAC','0',0,'开户中的记账最低余额（单位：元）（参数值要是正数或者0（例如：10。小数点最多为2位，超过两位时就直接把后面的小数点去点），否则初始化为0）')
insert into t_park_sysparamconf values('addAccount_NoEntryBalance','15',0,'开户中的禁止驶入最低余额（单位：元）（参数值要是正数或者0（例如：15。小数点最多为2位，超过两位时就直接把后面的小数点去点），否则系统初始化为15）')
insert into t_park_sysparamconf values('addAccount_LowBalanceNotice','50',0,'开户中的提示用户去续费的最低余额（单位：元）（参数值要是正数或者0（小数点最多为2位，超过两位时就直接把后面的小数点去点），否则系统初始化为50）')
insert into t_park_sysparamconf values('addAccount_Cost','0',0,'开户工本费（单位：元）（参数值要是正数或者0（例如：10。小数点最多为2位，超过两位时就直接把后面的小数点去点），否则初始化为0）')
insert into t_park_sysparamconf values('CardRechargeSystem_path','C:\用户卡充值\CardRechargeSystem.exe',0,'储值卡充值和冲正软件路径，没设置是初始化为C:/充值和冲正/CardRechargeSystem.exe')
insert into t_park_sysparamconf values('whtherPayType','0',0,'是否有缴费类型参数（0表示有缴费类型，1表示没有缴费类型,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)')
insert into t_park_sysparamconf values('TIME_updateUserCarInfoStatusTask','2011-04-13_00:00:00',0,'每天定时更改过期校园卡账户状态和缴费期限。（2011-04-13_00:00:00,表示当前时间大于或者等于2011年4月13号时，00：00：00执行）。')
insert into t_park_sysparamconf values('accountCardNoLength','10',0,'缴费卡账户管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值。例如：值为9则卡号长度只能为9）。')
insert into t_park_sysparamconf values('parkjsp','gw',0,'用parkCard那个校区的jsp文件，值为hg，就是用parkCard文件下的hg文件夹中的jsp。初始值为hg。')
insert into t_park_sysparamconf values('userCardInfoCardNoLength','10',0,'校园卡管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值，例如：值为9则卡号长度只能为9）')
insert into t_park_sysparamconf values('vehPlate','D:\Jpeg\',0,'为查询车道捉拍图片提供路径')
insert into t_park_sysparamconf values('CardInit_path','C:/IC卡登记程序/CardInit.exe',0,'IC卡登记程序路径，初始化设置为C:/IC卡登记程序/CardInit.exe')
--insert into t_park_sysparamconf values('SWL_KEY','7#26hgrica1@62#7',0,'华工监听系统配置功能密匙，不可修改。')
--insert into t_park_sysparamconf values('SWL_InputFileName','sysConfig.dll',0,'华工监听系统配置功能所监听的文件名称，不建议修改。')
GO
delete from tb_FreeDays
insert into tb_FreeDays values(4,0,'6')
insert into tb_FreeDays values(4,0,'7')
GO
--创建系统日志表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_systemLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_systemLog
GO
create table t_park_systemLog
(
	sys_id int identity(1,1),
	logTime datetime not null,
	logType int not null,
	operatorID int not null,
	logData	varchar(400) not null,
	coverage varchar(400),
	remark varchar(400),
	constraint pk_pams_systemLog_id primary key(sys_id),
)
GO

--创建更改帐号日志表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_updateAccountLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_updateAccountLog
GO
create table t_park_updateAccountLog
(
	accountNo int,
	seqNo int,
	status int not null,
	cardNo varchar(20) not null,
	cost int not null,
	lowestBalanceAfterConsume int not null,
	tollyLowestBalanceAC int not null,
	noEntryBalance int,
	lowBalanceNotice int,
	openAccountTime datetime,
	statusUpdateTime datetime,
	remark varchar(100),
	user_id int,
	userName varchar(50),
	credentialsType int,
	credentialsNo varchar(50),
	phone varchar(50),
	mobileNumber varchar(50),
	address varchar(120),
	car_id int,
	vehPlate varchar(10),
	carType int,
	carColour varchar(50),
	updateTime datetime,
	operator_id int,
	operatorName varchar(50),
	printNumber int,
	updateRemark varchar(100),
	constraint pk_pams_updateAccountLog_id primary key(accountNo,seqNo),
)
GO

--创建用户信息表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_user]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_user
GO
create table t_park_user
(
	sys_id int,
	userName varchar(50) not null,
	credentialsType int,
	credentialsNo varchar(50),
	phone varchar(50),
	mobileNumber varchar(50),
	address varchar(120),
	constraint pk_pams_user_id primary key(sys_id),
)
GO
--------------------------------------------------------------------------------------
--建立账户信息视图v_account（只有浙江大学在用，为了数据库统一）
--判断视图v_account是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_account]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   删除视图    
  drop view [dbo].[v_account]    
GO
GO

/****** Object:  View [dbo].[v_account]    Script Date: 06/23/2011 09:13:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--账户信息视图v_account

CREATE VIEW [dbo].[v_account]
AS
SELECT         a.sys_id AS accountNo, u.userName, u.credentialsType, u.credentialsNo, 
                          u.address, u.phone, a.lowestBalanceAfterConsume, a.tollyLowestBalanceAC, 
                          a.noEntryBalance, a.lowBalanceNotice, a.status, a.remark
FROM             dbo.t_park_account a INNER JOIN
                          dbo.t_park_user u ON a.user_id = u.sys_id
GO
--------------------------------------------------------------------------------------
--建立车卡账户绑定视图v_accountCard（只有浙江大学在用，为了数据库统一）
--判断车卡账户绑定视图v_accountCard是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_accountCard]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   删除视图    
  drop view [dbo].[v_accountCard]    
GO
GO

/****** Object:  View [dbo].[v_accountCard]    Script Date: 06/23/2011 09:15:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--车卡账户绑定视图v_accountCard

CREATE VIEW [dbo].[v_accountCard]
AS
SELECT         a.sys_id AS accountNo, a.cardNo, a.cardType, c.vehPlate, a.status, 
                          a.remark
FROM             dbo.t_park_account a INNER JOIN
                          dbo.t_park_car c ON a.car_id = c.sys_id
GO

--账户信息下发车道视图（只有富力城在用，为了数据库统一）
--判断视图tb_AccountCard是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountCard]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   删除视图    
  drop view [dbo].[tb_AccountCard]    
GO
create view tb_AccountCard
as
select a.sys_id as accountNo,u.userName,u.credentialsType,u.credentialsNo,u.address,u.phone,a.lowestBalanceAfterConsume,a.tollyLowestBalanceAC,
a.noEntryBalance,a.lowBalanceNotice,a.status,a.remark,a.cardNo,a.CardType,c.VehPlate,a.status as CardStatus,a.balance as Balance
from t_park_account a,t_park_user u,t_park_car c 
where a.user_id=u.sys_id and a.car_id=c.sys_id and a.statusUpdateTime=(select max(statusUpdateTime) from t_park_account a1 where a1.sys_id=a.sys_id)
GO
--------------------------------------------------------------------------------------


--参数管理模块--------------------------------------------------------------------------------------
--exec sp_helpconstraint tb_Squad;--查看表约束
--GO

--小区信息表
GO
alter table tb_Park alter column ParkName char(20) null
GO

-->大门信息表
alter table tb_Gateway alter column GateName char(20) null
GO

-->工班信息表
alter table tb_Squad alter column SquadName char(20) null
GO

--可用车道信息表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneUse]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_LaneUse
GO
CREATE TABLE tb_LaneUse(
	AreaNo smallint NOT NULL,
	ParkNo smallint NOT NULL,
	GateNo smallint NOT NULL,
	LaneNo smallint NOT NULL,
	LaneComputerIP char(15) NULL,
 	CONSTRAINT PK_LaneUse PRIMARY KEY CLUSTERED (AreaNo ASC,ParkNo ASC,GateNo ASC,LaneNo ASC))
go
insert into tb_LaneUse(AreaNo,ParkNo,GateNo,LaneNo,LaneComputerIP) select AreaNo,ParkNo,GateNo,LaneNo,LaneComputerIP from tb_Lane 

GO

--系统参数表
alter table tb_SystemPara alter column ItemValue varchar(100) null
GO
alter table tb_SystemPara  add  SendControl tinyint null
GO
update tb_SystemPara set SendControl=1 where ParaClass=1 

Go
--费显信息显示视图（v_ShowInfo)(为了数据库统一，目前只有富力在用）
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ShowInfo]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   删除视图    
  drop view [dbo].[v_ShowInfo]    
GO
create view [dbo].[v_ShowInfo]
as
select case when InitShow is null then '' else InitShow end as InitShow, 
	IsShowPosition, UseCnt, TotalCnt
from 
(
	select (select top 1 itemvalue  from tb_systempara where paraclass=0 and item='CarSpaceMsg' ) as InitShow,
		'1' as IsShowPosition, CarCount as UseCnt, MaxSpace as TotalCnt
	from tb_CarSpace 
) tmp
GO

--假日定义表（只有富力使用）
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_HoliDayDef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_HoliDayDef
GO
CREATE TABLE tb_HoliDayDef(
	Holiday	varchar(20)	NOT NULL,
	DayType	int NULL,
	Remark	varchar(50)	NULL
 	CONSTRAINT PK_HoliDayDef PRIMARY KEY CLUSTERED (Holiday ASC))
 GO
 
--无需比较识别车牌车辆表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehNoCmpPlate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_VehNoCmpPlate
GO
CREATE TABLE tb_VehNoCmpPlate(
	VehPlate varchar(10) NOT NULL
    CONSTRAINT PK_VehNoCmpPlate PRIMARY KEY CLUSTERED (VehPlate ASC))
GO


--车道费率表tb_PriceRule（广外）
--FeeTypeNo=1000时不明 
    

--系统监控模块------------------------------------------------------------------------------------------------
--tb_SpecialVeh
--华工 VehPlate	CardNo	SpecialType	lanetype	info
--广外VehPlate	CardNo	SpecialType
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpecialVeh]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_SpecialVeh
GO
CREATE TABLE tb_SpecialVeh(
	VehPlate	char(12) NOT NULL,
	CardNo		varchar(16) NOT NULL,
	SpecialType int NOT NULL,
	lanetype	smallint NOT NULL,
	info		char(24) NOT NULL,
 	CONSTRAINT PK_tb_SpecialVeh PRIMARY KEY CLUSTERED (VehPlate ASC,CardNo ASC))
GO

--给下发参数表增加字段
alter table tb_SendPara  add  FileName varchar(30) NULL
GO

--下发参数结果表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SendParaResult]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_SendParaResult
GO
CREATE TABLE tb_SendParaResult(
	SendType       smallint NOT NULL,
	FieldName      varchar(30) NULL,
	FieldValue     varchar(30) NOT NULL,
	LaneNo         smallint NOT NULL,
	LaneComputerIP varchar(15) NOT NULL,
	TableName      varchar(30) NOT NULL,
	FileName	   varchar(30) NULL,
	SendTime	   dateTime  NULL,
	SendResult       smallint null,
 CONSTRAINT PK_SendParaSuccess PRIMARY KEY CLUSTERED 
(FieldValue ASC,LaneNo ASC,LaneComputerIP ASC,TableName ASC))
GO
 -----------------------------------------------------------------------------------
-->车辆免费次数表[浙大]（tb_VehFreeTimes）(目前只有浙江大学在用，为了数据库统一，广外没用）
GO
CREATE TABLE tb_VehFreeTimes(
	VehPlate char(10) NOT NULL,
	Year int NULL,
	LeftFreeTimes int NULL,
    CONSTRAINT PK_VehFreeTimes PRIMARY KEY CLUSTERED (VehPlate ASC)
)
GO
 -----------------------------------------------------------------------------------
--创建tb_VehFreeTimes_Update（目前只有浙江大学在用，为了数据库统一）
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehFreeTimes_Update]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_VehFreeTimes_Update
GO
CREATE TABLE tb_VehFreeTimes_Update(
	VehPlate char(10) NOT NULL,
	Year int NULL,
	LeftFreeTimes int NULL,
 CONSTRAINT PK_VehFreeTimes_Update PRIMARY KEY CLUSTERED(VehPlate ASC)
 )
 
 GO
 -----------------------------------------------------------------------------------
 --添加[tb_VehFreeTimes_Update]表的触发器Tr_VehFreeTimesSplit

/****** Object:  Trigger [dbo].[Tr_VehFreeTimesSplit]    Script Date: 07/26/2011 15:56:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE  trigger [dbo].[Tr_VehFreeTimesSplit]
on [dbo].[tb_VehFreeTimes_Update]
for insert

as

declare @sVehPlate	char(10)
declare @iYear		int
declare @iLeftFreeTimes	int
declare @iFreeTimes     int
declare @iFeeRuleType	int

declare cur_inserted cursor
for
select VehPlate, Year, LeftFreeTimes from inserted
for read only

open cur_inserted

fetch next from cur_inserted into @sVehPlate, @iYear, @iLeftFreeTimes

while @@fetch_status = 0
begin
	--如果表中有该车牌的记录，就剩余免费次数减1
	if exists(select VehPlate from tb_VehFreeTimes where VehPlate = @sVehPlate and Year = @iYear)
	begin
		update tb_VehFreeTimes set LeftFreeTimes = LeftFreeTimes - 1 where VehPlate = @sVehPlate and Year = @iYear
	end
	
	--如果表中无该车牌记录，则往表中插入记录
	else
	begin
		delete from tb_VehFreeTimes where VehPlate = @sVehPlate
		
		--从白名单获得费率类型,然后从浙大的费率规则表中获得该费率类型的免费次数
		select top 1 @iFeeRuleType = FeeRuleType from V_WhiteList where VehPlate = @sVehPlate
		select top 1 @iFreeTimes = FreeTimes from tb_PriceRule_zd where FeeRuleType = @iFeeRuleType
		
		insert into tb_VehFreeTimes Values(@sVehPlate, @iYear, @iFreeTimes -1)
	end
	fetch next from cur_inserted into @sVehPlate, @iYear, @iLeftFreeTimes
end
deallocate cur_inserted 

delete from tb_VehFreeTimes_Update

--插到下发参数
delete from tb_SendPara where TableName = 'tb_VehFreeTimes'
insert into tb_SendPara select 1, 0, 0, LaneNo, LaneComputerIP, 'tb_VehFreeTimes','tb_VehFreeTimes' FROM tb_LaneUse 
GO
-----------------------------------------------------------------------------------

--特殊车辆处理信息表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpVehHandle]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_SpVehHandle
GO
CREATE TABLE tb_SpVehHandle(
	LaneType		smallint 	NOT NULL,
	TableName		varchar(50)	NOT NULL,
	Status			int			NOT NULL,
	HandleType		int			NULL,
	Hint			varchar(100)NULL,
	Remark			varchar(100)NULL,
	CONSTRAINT PK_SpVehHandle PRIMARY KEY CLUSTERED
	(LaneType ASC,TableName ASC,Status ASC)
)
GO

--创建费率配置表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PriceBase]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_PriceBase
GO
CREATE TABLE tb_PriceBase(
	VerNo int NOT NULL,
	FeeNo int NOT NULL,
	RebateType int NOT NULL,
	InOutSign int NOT NULL,
	TimesSign int NOT NULL,
	VehTypeNo int NOT NULL,
	AllowStayTime int NULL,
	BaseFeeTime int NULL,
	BaseFee int NULL,
	StayAdd int NULL,
	AddFee int NULL,
	AddStart int NULL,
	MaxFee int NULL,
	MaxTime int NULL,
	MaxFeeTime int NULL,
	SumFeeCtr int NULL,
	backup1 char(16) NULL,
	backup2 char(16) NULL,
	StartTime datetime NULL,
	Remark char(50) NULL,
 CONSTRAINT PK_PriceBase PRIMARY KEY CLUSTERED 
(
	VerNo ASC,
	FeeNo ASC,
	RebateType ASC,
	InOutSign ASC,
	TimesSign ASC,
	VehTypeNo ASC
))
GO

------------------------------------给缴费卡（储值卡，在卡上写钱的卡）cs充值程序中的卡片转移调用-------------------------------------------------------
GO
/****** 对象:  用户定义的存储过程 dbo.SP_ChangeCard  ************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_ChangeCard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_ChangeCard]
GO

/*
 * 功能：处理换卡操作
 * 参数：
 *		@iSys_id	--输入参数：账户表的主键sys_id
 *		@sNewCardNo	--输入参数：新卡卡号
 *		@iCost		--输入参数：新卡的工本费
 *		@iResult	--输出参数：0：成功，其他：失败
 */
CREATE procedure SP_ChangeCard (@iSys_id int,@sNewCardNo Varchar(20),@iCost int,@iOperatorID int,@iResult int output)
As
Begin
	Declare @sOldCardNo Varchar(20)
	Declare @oldBalance int 

	-- 1.根据sys_id获取旧卡号
	Set @sOldCardNo=''
	Select @sOldCardNo = cardNo,@oldBalance=balance From t_park_account where sys_id=@iSys_id
	Select @oldBalance=@oldBalance/100
	-- 2.把帐户表的卡号修改为新卡号，修改工本费为 0
	Update t_park_account Set cardNo=@sNewCardNo,cost=@iCost where sys_id=@iSys_id

	-- 3.用户卡信息表中的卡号修改为新卡号
	Update tb_UserCardInfo Set cardNo=@sNewCardNo where cardNo=@sOldCardNo
	-- 4.旧卡号写到储值卡黑名单表中，生成原因为2：注销卡
	if(Exists (Select * from tb_StoreCardBlackList where SCCode=@sOldCardNo))
		Update tb_StoreCardBlackList set GenCau=2,GenTime=GetDate() where SCCode=@sOldCardNo
	else
		Insert Into tb_StoreCardBlackList Values(@sOldCardNo,2,GetDate())

	-- 更新IC卡信息表中此卡的状态为1：挂失卡
	update tb_CardInfo Set Status=1 Where CardNo=@sOldCardNo

	-- 把操作写到系统日志表中
	Insert Into t_park_systemLog(logTime,logType,operatorID,logData,coverage,remark)
	Values(GetDate(),1,@iOperatorID,'换卡操作,旧卡号：'+@sOldCardNo+'旧卡号余额为：'+LTrim(str(@oldBalance))+'元.新卡号：'+@sNewCardNo,'t_park_account,tb_UserCardInfo,tb_StoreCardBlackList,tb_CardInfo','执行 SP_ChangeCard')


	Set @iResult=0

End

Go


/****** 对象:  用户定义的存储过程 dbo.SP_ChangeCardCheck  ************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_ChangeCardCheck]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_ChangeCardCheck]
GO

/*
 * 功能：验证新卡的合法性
 * 参数：
 *      @sOldCardNo --输入参数：旧卡卡号
 *		@sNewCardNo	--输入参数：新卡卡号
 *		@iResult	--输出参数：0：该卡合法，其他：非法的原因
 */
CREATE procedure SP_ChangeCardCheck (@sOldCardNo Varchar(20),@sNewCardNo Varchar(20),@iResult int output)
As
Begin
	Declare @iCnt integer
	Declare @iCntOldCardNo integer

	-- 1.检测该卡是否在黑名单中
	Select @iCnt = count(*) from tb_StoreCardBlackList where SCCode=@sNewCardNo
	if @iCnt>0
	Begin
		Set @iResult=11
		return
	End

	-- 2.新卡号是否已存在于帐户表中
	Select @iCnt = count(*) from t_park_account where cardNo=@sNewCardNo
	if @iCnt>0
	Begin
		Set @iResult=12
		return
	End

	-- 3.新卡号和旧卡号是否都存在于用户卡信息表中
	Select @iCnt = count(*) from tb_UserCardInfo where cardNo=@sNewCardNo
	Select @iCntOldCardNo = count(*) from tb_UserCardInfo where cardNo=@sOldCardNo
	if @iCnt>0 and @iCntOldCardNo>0 
	Begin
		Set @iResult=13
		return
	End

	Set @iResult=0
End
Go
-------------------------------------------------------------------------------------------
--缴费卡管理模块
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
--判断表tb_AccountTrade是否存在，存在则删除
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --删除表    
  drop   table   [dbo].[tb_AccountTrade]    
  GO
    
--创建交易流水临时表
create table tb_AccountTrade
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade(ListNo)
--建立optime索引
create index ix_accounttrade_optime on tb_accounttrade (optime desc)

--------------------------------------------------------------------
--判断表tb_AccountTrade1是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade1]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
   --   删除表   
  drop   table   [dbo].[tb_AccountTrade1]    
  GO
  --判断表tb_AccountTrade01是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade01]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade01]    
  GO
--创建12张交易流水表
create table tb_AccountTrade01
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade01_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade01(ListNo)
-------------------------------------------------------------------------------
GO
 --判断表tb_AccountTrade2是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade2]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
     --   删除表 
  drop   table   [dbo].[tb_AccountTrade2]    
  GO
  --判断表tb_AccountTrade02是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade02]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
    --   删除表  
  drop   table   [dbo].[tb_AccountTrade02] 
create table tb_AccountTrade02
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade02_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade02(ListNo)
-------------------------------------------------------------------------
GO
  --判断表tb_AccountTrade3是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade3]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade3]    
  GO
  --判断表tb_AccountTrade03是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade03]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade03]    
  GO
create table tb_AccountTrade03
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade03_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade03(ListNo)
-------------------------------------------------------------------------
GO
  --判断表tb_AccountTrade4是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade4]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade4]    
  GO
  --判断表tb_AccountTrade04是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade04]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade04]    
  GO
create table tb_AccountTrade04
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade04_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade04(ListNo)
-------------------------------------------------------------------------
GO
  --判断表tb_AccountTrade5是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade5]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade5]    
  GO
  --判断表tb_AccountTrade05是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade05]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade05]    
  GO
create table tb_AccountTrade05
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade05_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade05(ListNo)
-------------------------------------------------------------------------
GO
  --判断表tb_AccountTrade6是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade6]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade6]    
  GO
  --判断表tb_AccountTrade06是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade06]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade06]    
  GO
create table tb_AccountTrade06
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade06_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade06(ListNo)
-------------------------------------------------------------------------
GO
  --判断表tb_AccountTrade7是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade7]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade7]    
  GO
  --判断表tb_AccountTrade07是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade07]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade07]    
  GO
create table tb_AccountTrade07
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade07_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade07(ListNo)
-------------------------------------------------------------------------
GO
  --判断表tb_AccountTrade8是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade8]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade8]    
  GO
  --判断表tb_AccountTrade08是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade08]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade08]    
  GO
create table tb_AccountTrade08
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade08_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade08(ListNo)
-------------------------------------------------------------------------
GO
  --判断表tb_AccountTrade9是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade9]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade9]    
  GO
  --判断表tb_AccountTrade09是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade09]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade09]    
  GO
create table tb_AccountTrade09
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade09_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade09(ListNo)
-------------------------------------------------------------------------
GO
  --判断表tb_AccountTrade10是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade10]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade10]    
  GO
  
create table tb_AccountTrade10
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade10_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade10(ListNo)
GO
  --判断表tb_AccountTrade11是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade11]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade11]    
  GO
create table tb_AccountTrade11
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade11_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade11(ListNo)
GO
  --判断表tb_AccountTrade12是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade12]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop   table   [dbo].[tb_AccountTrade12]    
  GO
create table tb_AccountTrade12
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade12_id primary key(accountNo,seqNo),
)
--建立tb_AccountTrade唯一索引
create unique index index_pams_ListNo on tb_AccountTrade12(ListNo)
------------------------------------------------------------------------------------
--创建异常交易流水表
create table tb_UnusualAccountTrade
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_UnusualAccountTrade_id primary key(accountNo,seqNo),
)
------------------------------------------------------------------------------------
--建立tb_AccountTrade表的触发器Tr_AccountTrade
GO
/****** Object:  Trigger [dbo].[Tr_AccountTrade]    Script Date: 05/10/2011 13:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
   create TRIGGER [dbo].[Tr_AccountTrade] 
    ON  [dbo].[tb_AccountTrade] 
    AFTER  INSERT
   
AS 

   declare @Months                  tinyint
     
   declare @TradeType                        int
   
   declare @BackoutedListNo                  varchar(30) 
    

 
select  @Months=DATEPART(month,convert(datetime,OpTime)),@TradeType=tradeType,@BackoutedListNo=backoutedListNo from inserted
if @Months=1
    insert into tb_AccountTrade01
    select * from inserted
    
else if @Months=2
    insert into tb_AccountTrade02
    select * from inserted

else if @Months=3
    insert into tb_AccountTrade03
    select * from inserted
    
else if @Months=4
    insert into tb_AccountTrade04
    select * from inserted

else if @Months=5
    insert into tb_AccountTrade05
    select * from inserted

else if @Months=6
    insert into tb_AccountTrade06
    select * from inserted
    
else if @Months=7
    insert into tb_AccountTrade07
    select * from inserted
    
else if @Months=8
    insert into tb_AccountTrade08
    select * from inserted
    
else if @Months=9
    insert into tb_AccountTrade09
    select * from inserted
    
else if @Months=10
    insert into tb_AccountTrade10
    select * from inserted
    
else if @Months=11
    insert into tb_AccountTrade11
    select * from inserted
    
else if @Months=12
    insert into tb_AccountTrade12
    select * from inserted
   
    
begin  
 
    declare @AccountNo               int  
 
    declare @Fee                     int

    select @AccountNo=accountNo,@Fee=fee from inserted 
 
    update t_park_account set balance=balance+@Fee where sys_id=@AccountNo

end
 delete from tb_AccountTrade
Go
-----------------------------------------------------------------------------
 --判断表v_AccountTrade是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_AccountTrade]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   删除表    
  drop view [dbo].[v_AccountTrade]    
  GO
--创建12个流水表的总视图
go
create view v_AccountTrade
as
select *
from tb_AccountTrade01
union all

select *
from tb_AccountTrade02
union all

select *
from tb_AccountTrade03
union all

select *
from tb_AccountTrade04
union all

select *
from tb_AccountTrade05
union all

select *
from tb_AccountTrade06
union all

select *
from tb_AccountTrade07
union all

select *
from tb_AccountTrade08
union all

select *
from tb_AccountTrade09
union all

select *
from tb_AccountTrade10
union all

select *
from tb_AccountTrade11
union all

select *
from tb_AccountTrade12
-------------------------------------------------------------------------------------------
--校园卡管理模块
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
GO
  --判断表tb_FeeRuleTypeDef是否存在，存在则删除
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_FeeRuleTypeDef]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   删除表    
  drop table [dbo].[tb_FeeRuleTypeDef]    
GO
--在小区卡管理模块中有关数据表的修改和初始值
go
create table tb_FeeRuleTypeDef
(
	FeeRuleType	   int,
	Name		char(20),
	Constraint PK_FeeRuleTypeDef Primary Key(FeeRuleType)
)
Delete from tb_FeeRuleTypeDef;
Insert into tb_FeeRuleTypeDef values(0,'过夜车');
Insert into tb_FeeRuleTypeDef values(1,'不过夜车');
Insert into tb_FeeRuleTypeDef values(4,'MBA学员车');
delete from t_park_sysparamconf where pname='whtherPayType';
insert into t_park_sysparamconf values('whtherPayType','0',0,'是否有缴费类型参数（0表示有缴费类型，1表示没有缴费类型,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)');
------------------------------------------------------
--用户卡类型表
GO
create table tb_UserCardType
(
   UserCardType     smallint primary key,
   TypeName     	char(10) not null,
   Remark     		varchar(255),
)
------------------------------------------------------
--用户卡收费类型表
Go
create table tb_UserCardFeeRuleType
(
   UserCardType     smallint primary key,
   FeeRuleType     	int not null,
)
--初始化值
GO
  insert into tb_UserCardType values(0,'临时卡',null)
  insert into tb_UserCardType values(1,'身份卡',null)
  insert into tb_UserCardType values(2,'缴费卡',null)
   insert into tb_UserCardType values(12,'MBA学员车',null)
  insert into tb_UserCardType values(13,'公车',null)
  insert into tb_UserCardType values(14,'家属卡',null)
  insert into tb_UserCardFeeRuleType values(12,4)
  insert into tb_UserCardFeeRuleType values(13,0)
  insert into tb_UserCardFeeRuleType values(14,1)
  GO
------------------------------------------------------------------------------------------
--在小区卡管理模块中有关数据表的修改和初始值
go
delete from tb_CardType where CardType=12 or CardType=13 or CardType=14;
Insert into tb_CardType  values(12,'MBA学员车',9);
Insert into tb_CardType  values(13,'公车',9);
Insert into tb_CardType  values(14,'家属卡',9);
------------------------------------------------------
--修改tb_CardInfo表
GO
alter table tb_CardInfo add UserCardType smallint not null default 0;
--修改tb_CardOperation表
GO
alter table tb_CardOperation add UserCardType smallint not null default 0;
------------------------------------------------------
----------------------------下发任务表中加一列FileName和运用tb_LaneUse表需要修改的触发器------------------------------------------
--修改tb_usercardInfo表中的触发器Tri_SetSendPara,下发参数需要加多个值
GO
/****** Object:  Trigger [dbo].[Tri_SetSendPara]    Script Date: 06/22/2011 12:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Trigger [dbo].[Tri_SetSendPara] 
on [dbo].[tb_UserCardInfo] 
for insert,update
as
	--delete from tb_sendpara where sendtype=2 and fieldValue in (select vehPlate from inserted);
	if UPDATE ( VehPlate ) or update (VehPlateImage)
	begin
		delete from tb_sendpara where sendtype=2 and fieldValue in (select vehPlate from inserted);

		if exists(select * from tb_usercardinfo where vehplate in (select vehplate from inserted))
			insert into tb_sendpara 
			select distinct 2,'vehPlate',a.vehPlate,b.laneno,b.lanecomputerip,'WhiteListPic','WhiteListPic'
			from inserted a right outer join tb_LaneUse b on 1=1  
			--from inserted a right outer join tb_lane b on 1=1
		--where Not Exists (select * from tb_SendPara where Sendtype=2 and FieldName='VehPlate'
		--					and FieldValue=a.VehPlate and LaneComputerIP=b.LaneComputerIP
		--					and TableName='WhiteListPic')
	end
GO
------------------------------------------------------
--修改tb_userCardInfo表
GO
alter table tb_userCardInfo add VehBrand varchar(30);
alter table tb_userCardInfo alter column ParkingSpace varchar(32);
alter table tb_userCardInfo add StaffNo varchar(32);
alter table tb_userCardInfo add RoomNo varchar(20);
alter table tb_userCardInfo add Address varchar(255);
alter table tb_userCardInfo add LinkMan varchar(20);
alter table tb_userCardInfo add TelePhone varchar(20);
alter table tb_userCardInfo add MobileNumber varchar(20);
alter table tb_userCardInfo add PayEndTime datetime;
alter table tb_userCardInfo add Remark varchar(255);
alter table tb_userCardInfo alter column CardNo varchar(10);
alter table tb_userCardInfo alter column OBU varchar(10);
exec sp_rename 'tb_userCardInfo.UserType' ,'UserCardType', 'column';
------------------------------------------------------
--修改tb_UserCardInfoHistory表
GO
alter table tb_UserCardInfoHistory add VehBrand varchar(30);
alter table tb_UserCardInfoHistory alter column ParkingSpace varchar(32);
alter table tb_UserCardInfoHistory add StaffNo varchar(32);
alter table tb_UserCardInfoHistory add RoomNo varchar(20);
alter table tb_UserCardInfoHistory add Address varchar(255);
alter table tb_UserCardInfoHistory add LinkMan varchar(20);
alter table tb_UserCardInfoHistory add TelePhone varchar(20);
alter table tb_UserCardInfoHistory add MobileNumber varchar(20);
alter table tb_UserCardInfoHistory add PayEndTime datetime;
alter table tb_UserCardInfoHistory add Remark varchar(255);
alter table tb_UserCardInfoHistory alter column CardNo varchar(10);
alter table tb_UserCardInfoHistory alter column OBU varchar(10);
exec sp_rename 'tb_UserCardInfoHistory.UserType' ,'UserCardType', 'column';
------------------------------------------------------
--修改tb_UserCardInfoHistory表触发器Tri_BackupModifiedData
GO
/****** Object:  Trigger [dbo].[Tri_BackupModifiedData]    Script Date: 06/16/2011 10:05:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER  trigger [dbo].[Tri_BackupModifiedData]
on [dbo].[tb_UserCardInfo]
for update, delete
as
insert into tb_UserCardInfoHistory
select RecNO,Owner,IDCard,VehPlate,ParkingSpace,OBU,RegisterTime,Status,Deposit,CardNO,UserCardType,GETDATE() as ModifyTime,FeeRuleType,VehBrand,StaffNo,RoomNo,Address,LinkMan,TelePhone,MobileNumber,PayEndTime,Remark from deleted
-------------------------------------------------------------------------------------------------
--修改tb_UserCardBill表中EndTime，就是缴费结束时间需要加一天，之前都是到月末的最后一天，而且是年月日 00:00:00,这样的话就不包括最后一天
GO
update tb_UserCardBill set EndTime=EndTime+1
GO
-------------------------------------------------------------------------------------------------
Go
--设置tb_UserCardInfo中PayEndTime（缴费期限的值）
update tb_UserCardInfo  set PayEndTime = (select EndTime from (select userRecNo,MAX(EndTime) as EndTime from tb_UserCardBill group by userRecNo) as tb_a where tb_a.UserRecNO = RecNO) where UserCardType=14 and RecNO in (select distinct userRecNo from tb_UserCardBill) 
GO
-------------------------------------------------------------------------------------------------
--修改安全用户信息密码长度
GO
alter table tb_SecurityUserInfo alter column password char(32) not null
-------------------------------------------------------------------------------------------------

--修改白名单视图（userType修改为UserCardType）
GO

/****** Object:  View [dbo].[V_WHITELIST]    Script Date: 06/28/2011 17:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



---白名单视图
ALTER  VIEW [dbo].[V_WHITELIST] AS 
SELECT * FROM 
(
	--费用截止时间不计时分秒，所以+1天
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,
		CASE WHEN B.STARTTIME IS NULL THEN A.REGISTERTIME ELSE B.STARTTIME END AS FIRTIME, 
		CASE WHEN B.ENDTIME IS NULL THEN A.REGISTERTIME ELSE B.ENDTIME+1 END AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, 
		CASE WHEN A.STATUS=0 AND (B.ENDTIME IS NULL OR B.ENDTIME<CONVERT(CHAR(10),GETDATE(),120)) THEN 9 ELSE A.STATUS END AS STATUS,
		CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,0 as FeeRuleType   --把所有的车都固定为过夜车 2011-3-24
	FROM TB_USERCARDINFO  A 
	LEFT JOIN 
	(
		--在跨月缴费的情况下，本SQL可能会有错误
		SELECT USERRECNO, MIN(STARTTIME) AS STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL 
			WHERE convert(char(10),GETDATE(),120) BETWEEN STARTTIME AND ENDTIME OR STARTTIME>convert(char(10),GETDATE(),120)
			GROUP BY USERRECNO
		UNION ALL
		SELECT USERRECNO, MAX(STARTTIME) as STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL
		GROUP BY USERRECNO HAVING MAX(ENDTIME) < convert(char(10),GETDATE(),120)
	) B ON A.RECNO = B.USERRECNO
	WHERE A.UserCardType=14 --月租卡
	UNION ALL
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,GETDATE()-120 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, A.STATUS, CASE WHEN A.VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO A
	WHERE A.UserCardType=13	or A.UserCardType=12--业主卡或者MBA学员车
	union all 
	SELECT CARDNO, VEHPLATE, OWNERName , OBUID, GETDATE()-120 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		13 as Usetype, 0 as Status, CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,0 AS FeeRuleType
	FROM tb_testwl
	
) TMP

GO

-------------------------------------------------------------------------------------------------
--创建教工表
GO
CREATE TABLE tb_Staff(
    CardNo [char](10) primary key,
    StaffName [varchar](32) null,
    StaffAddress [varchar](255) null,
    Relation  [varchar](32) null,
)
GO
-------------------------------------------------------------------------------------------------
 --修改tb_SpEventCode特殊事件编码表的值，以跟车道相符合（车道没有用这个表中的值，这个值用于流水查询，编号大于29以后的不用）
  Go
  delete from tb_SpEventCode where SpEventNo>18 and SpEventNo<30;
  insert into tb_SpEventCode values(19,'重写卡入口信息');
  insert into tb_SpEventCode values(20,'未付车');
  insert into tb_SpEventCode values(23,'抬杆放行');
  insert into tb_SpEventCode values(24,'优惠车辆');
  insert into tb_SpEventCode values(25,'重放行');
  insert into tb_SpEventCode values(26,'拦截后放行');
  insert into tb_SpEventCode values(27,'特殊处理车辆');
  insert into tb_SpEventCode values(28,'免费放行');
  insert into tb_SpEventCode values(29,'报过收取现金');
  -------------------------------------------------------------------------------------------------
----------------------------下发任务表中加一列FileName和运用tb_LaneUse表需要修改的触发器------------------------------------------
--修改tb_CardDynamic表中的触发器Tr_CardDynamicToLoseCard,下发参数需要加多个值
GO
/****** Object:  Trigger [dbo].[Tr_CardDynamicToLoseCard]    Script Date: 06/23/2011 14:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--当丢失的临时卡回收时,该触发器起作用,将最新的丢卡列表下发到车道
--当有新的丢卡时,将新的丢卡列表下发
ALTER trigger [dbo].[Tr_CardDynamicToLoseCard] 
		on [dbo].[tb_CardDynamic]
		for insert,update
as
begin
	--如果有临时卡的丢卡状态被改变
	--对每一个车道添加下发视图TableName
	if exists(select * from inserted where Status=13) or exists(select * from deleted where Status=13)
	begin
		declare @LaneIP char(15),@LaneNo smallint
		declare SendParaCursor cursor
			--for select LaneComputerIP,LaneNo from tb_Lane
              for select LaneComputerIP,LaneNo from tb_LaneUse 
		open SendParaCursor
		fetch next from SendParaCursor into @LaneIP,@LaneNo
		while @@fetch_status=0
		begin
			if not exists (select * from tb_SendPara where LaneNo=@LaneNo and LaneComputerIP=@LaneIP and TableName='V_LoseCardList')
			begin
				insert into tb_SendPara values(1,'0','0',@LaneNo,@LaneIp,'V_LoseCardList','V_LoseCardList')
			end
			
			fetch next from SendParaCursor into @LaneIP,@LaneNo
		end

		close SendParaCursor
		deallocate SendParaCursor
	end
end
GO
-------------------------------------------------------------------------------------------------
--修改tb_CardDynamic卡动态表
GO
--增加用户卡类型
alter table tb_CardDynamic add UserCardType smallint not null default 0
--增加车型
alter table tb_CardDynamic add VehType smallint not null default 0
--增加工班号
alter table tb_CardDynamic add SquadNo smallint not null default 1
--增加入口流水号
alter table tb_CardDynamic add inListNo Char(16) 
--增加出口流水号
alter table tb_CardDynamic add OutListNo Char(16) 
--增加车牌
alter table tb_CardDynamic add VehBrand varchar(30) 
--增加通行卷类型 
alter table tb_cardDynamic add TicketType TinyInt not null default 1
--增加大门名称 
alter table tb_cardDynamic add GateName Char(20)
--创建一个备份表
select * into temp_tb_carddynamic from tb_CardDynamic 
GO
 update tb_CardDynamic set outlistNo= 
 (select tb.ListNo from tb_CardDynamic tb,temp_tb_carddynamic temp where tb.ListNo=temp.listNo and tb.Status =12 and temp.status =12 and tb.ListNo=tb_CardDynamic.ListNo)
GO
update tb_CardDynamic set inlistNo= 
 (select tb.ListNo from tb_CardDynamic tb,temp_tb_carddynamic temp where tb.ListNo=temp.listNo and tb.Status !=12 and temp.status !=12 and tb.ListNo=tb_CardDynamic.ListNo)
GO
--删除listNo列
alter table tb_cardDynamic drop COLUMN  listNo
-------------------------------------------------------------------------------------------------
----------------------------下发任务表中加一列FileName和运用tb_LaneUse表需要修改的触发器和存储过程------------------------------------------
--修改tb_InList_Tmp表中的触发器Tr_YCTInListSplit,下发参数需要加多个值
GO
/****** Object:  Trigger [dbo].[Tr_YCTInListSplit]    Script Date: 06/23/2011 14:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[Tr_YCTInListSplit]
ON [dbo].[tb_InList_Tmp]
FOR INSERT
AS
IF (SELECT Count(*) FROM inserted WHERE TicketType = 10 and CardID <> '' and CardID <> '0') > 0 
BEGIN
	INSERT INTO tb_YCTInList_Tmp
	SELECT CardID, ListNo as InListNo, GateNo as InGateNo, LaneNo as InLaneNo,
		VehType as InVehType, VehClass as InVehClass, VehPlate as InVehPlate,
		PlateImg as InPlateImg, OperatorNo as InOperatorNo, OpTime as InOpTime,
		VehTypeAuto as InVehTypeAuto, VehPlateAuto as InVehPlateAuto
	FROM inserted
	WHERE TicketType = 10 and CardID <> '' and CardID <> '0'
	--下发到所有出口
	DELETE FROM tb_SendPara WHERE TableName = 'tb_YCTInList_Tmp'
	INSERT INTO tb_SendPara
	SELECT 1 as SendType, 0 as FieldName, 0 as FieldValue, LaneNo, LaneComputerIP, 
		'tb_YCTInList_Tmp' as TableName,'tb_YCTInList_Tmp' as FileName
	FROM tb_LaneUse
	--FROM tb_Lane
	--WHERE LaneTypeNo = 2
END
GO
-------------------------------------------------------------------------------------------------
--修改tb_OutList_Tmp表中的触发器Tr_YCTOutListSplit,下发参数需要加多个值
GO
/****** Object:  Trigger [dbo].[Tr_YCTOutListSplit]    Script Date: 06/23/2011 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[Tr_YCTOutListSplit]
ON [dbo].[tb_OutList_Tmp]
FOR INSERT
AS
IF (SELECT Count(*) FROM inserted WHERE TicketType = 10 and CardID <> '' and CardID <> '0') > 0 
BEGIN
	DELETE tb_YCTInList_Tmp 
	FROM inserted
	WHERE inserted.CardID <> '' and inserted.CardID <> '0' and tb_YCTInList_Tmp.CardID = inserted.CardID
	--下发到所有出口
	DELETE FROM tb_SendPara WHERE TableName = 'tb_YCTInList_Tmp'
	INSERT INTO tb_SendPara
	SELECT 1 as SendType, 0 as FieldName, 0 as FieldValue, LaneNo, LaneComputerIP, 
		'tb_YCTInList_Tmp' as TableName,'tb_YCTInList_Tmp' as FileName
	FROM tb_LaneUse
	--FROM tb_Lane
	--WHERE LaneTypeNo = 2
END
GO
-------------------------------------------------------------------------------------------------------
--修改tb_SecurityCommand表中的触发器Tr_SecurityCommanDelete下发参数需要加多个值
GO
/****** Object:  Trigger [dbo].[Tr_SecurityCommandDelete]    Script Date: 06/23/2011 15:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[Tr_SecurityCommandDelete]
on [dbo].[tb_SecurityCommand]
for delete     
AS
	--删除了有效的锁车指令,需要重新下发一份安全指令到车道
	if exists(select * from deleted where type=1 and attribute=0)
	begin
		declare @LaneIP char(15),@LaneNo smallint
		declare SendParaCursor_UpdateSecurityCommand cursor
			--for select LaneComputerIP,LaneNo from tb_Lane
             for select LaneComputerIP,LaneNo from tb_LaneUse 
		open SendParaCursor_UpdateSecurityCommand
		fetch next from SendParaCursor_UpdateSecurityCommand into @LaneIP,@LaneNo
		while @@fetch_status=0
		begin
			if not exists (select * from tb_SendPara where LaneNo=@LaneNo and LaneComputerIP=@LaneIP and TableName='v_securitycommand')
			begin
				insert into tb_SendPara values(1,'0','0',@LaneNo,@LaneIp,'v_securitycommand','v_securitycommand')
			end
			
			fetch next from SendParaCursor_UpdateSecurityCommand into @LaneIP,@LaneNo
		end

		close SendParaCursor_UpdateSecurityCommand
		deallocate SendParaCursor_UpdateSecurityCommand
	end
	
	--更新原来备份表中的指令的有效位为0
	update tb_SecurityCommandBackup set IsValid=0
	where CommandID in (select distinct CommandID from deleted) and IsValid=1

        --对被更新为无效的指令,将其所有的历史指令更新为无效
        update tb_SecurityCommandBackup set Attribute=1
        from tb_SecurityCommandBackup b, deleted d
        where b.CommandID=d.CommandID

	--向备份表中添加新的备份指令
	insert into tb_SecurityCommandBackup
	select CommandID,CardNo,Type,ValidType,UseType,
		(select top 1 sbk.AddTime from tb_SecurityCommandBackup sbk,deleted i where sbk.CommandID=i.CommandID order by sbk.AddTime) as AddTime,
		StartTime,EndTime,getdate() OpTime,Status,1 Attribute,
		(select case when MAX(ModID) is null then 1 else MAX(ModID)+1 end from tb_SecurityCommandBackup sbk,deleted i where sbk.CommandID=i.CommandID) as ModID,
		0 OperatorType,0 OperatorNo,1
	from deleted

	--使用游标逐条将delete中的操作记录向操作记录表中添加操作记录
	declare @CommandID int,@Attribute smallint
	declare DeletedCursor cursor for select distinct CommandID,Attribute from deleted
	open DeletedCursor
	fetch next from DeletedCursor into @CommandID,@Attribute
	while @@fetch_status=0
	begin
		insert into tb_SecurityCommandOperation
		select (select case when Max(OperationID) is null then 1 else Max(OperationID)+1 end from tb_SecurityCommandOperation) as OperationID,
		3 OperationType,
		(select Max(PostModID) from tb_SecurityCommandOperation t1 where t1.CommandID=@CommandID) as 
PreModID,
     	(select Max(PostModID)+1 from tb_SecurityCommandOperation t1 where t1.CommandID=@CommandID) 
as PostModID,
	@CommandID
		
		fetch next from DeletedCursor into @CommandID,@Attribute
	end
	close DeletedCursor
	deallocate DeletedCursor
GO
------------------------------------------------------------------------------------------------------------
--修改tb_SecurityCommand表中的触发器Tr_SecurityCommandInsert下发参数需要加多个值
GO
/****** Object:  Trigger [dbo].[Tr_SecurityCommandInsert]    Script Date: 06/23/2011 15:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger 	[dbo].[Tr_SecurityCommandInsert]
		on [dbo].[tb_SecurityCommand] 
		for insert
AS	
	--添加了新的锁定指令
	if exists(select * from inserted where type=1)
	begin
		declare @LaneIP char(15),@LaneNo smallint
		declare SendParaCursor_InsertSecurityCommand cursor
			--for select LaneComputerIP,LaneNo from tb_Lane
           for select LaneComputerIP,LaneNo from tb_LaneUse 
		open SendParaCursor_InsertSecurityCommand
		fetch next from SendParaCursor_InsertSecurityCommand into @LaneIP,@LaneNo
		while @@fetch_status=0
		begin
			if not exists (select * from tb_SendPara where LaneNo=@LaneNo and LaneComputerIP=@LaneIP and TableName='v_securitycommand')
			begin
				insert into tb_SendPara values(1,'0','0',@LaneNo,@LaneIp,'v_securitycommand','v_securitycommand')
			end
			
			fetch next from SendParaCursor_InsertSecurityCommand into @LaneIP,@LaneNo
		end

		close SendParaCursor_InsertSecurityCommand
		deallocate SendParaCursor_InsertSecurityCommand
	end
	
	--备份一份记录到tb_SecurityCommandBackup中
	insert into tb_SecurityCommandBackup	
	select CommandID,CardNo,Type,ValidType,UseType,OpTime,StartTime,EndTime,OpTime,Status,Attribute,1,OperatorType,OperatorNo,1 	
	from inserted

	--使用游标逐条将inserted中的操作记录向操作记录表中添加操作记录
	declare @CommandID int
	declare InsertedCursor cursor for select distinct CommandID from inserted
	open InsertedCursor
	fetch next from InsertedCursor into @CommandID
	while @@fetch_status=0
	begin
		insert into tb_SecurityCommandOperation
		select (select case when Max(OperationID) is null then 1 else Max(OperationID)+1 end from tb_SecurityCommandOperation) as OperationID,
		1,1,1,@CommandID
		
		fetch next from InsertedCursor into @CommandID
	end
	close InsertedCursor
	deallocate InsertedCursor
GO
------------------------------------------------------------------------------------------------------------
--修改tb_SecurityCommand表中的触发器Tr_SecurityCommandUpdate下发参数需要加多个值
GO
/****** Object:  Trigger [dbo].[Tr_SecurityCommandUpdate]    Script Date: 06/23/2011 15:38:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER trigger 	[dbo].[Tr_SecurityCommandUpdate]
		on [dbo].[tb_SecurityCommand] 
		for update
AS
	--修改了锁定指令
	if exists(select * from inserted where type=1)
	begin
		declare @LaneIP char(15),@LaneNo smallint
		declare SendParaCursor_UpdateSecurityCommand cursor
			--for select LaneComputerIP,LaneNo from tb_Lane
            for select LaneComputerIP,LaneNo from tb_LaneUse 
		open SendParaCursor_UpdateSecurityCommand
		fetch next from SendParaCursor_UpdateSecurityCommand into @LaneIP,@LaneNo
		while @@fetch_status=0
		begin
			if not exists (select * from tb_SendPara where LaneNo=@LaneNo and LaneComputerIP=@LaneIP and TableName='v_securitycommand')
			begin
				insert into tb_SendPara values(1,'0','0',@LaneNo,@LaneIp,'v_securitycommand','v_securitycommand')
			end
			
			fetch next from SendParaCursor_UpdateSecurityCommand into @LaneIP,@LaneNo
		end

		close SendParaCursor_UpdateSecurityCommand
		deallocate SendParaCursor_UpdateSecurityCommand
	end
	
	--更新原来备份表中的指令的有效位为0
	update tb_SecurityCommandBackup set IsValid=0
	where CommandID in (select distinct CommandID from inserted) and IsValid=1

        --对被更新为无效的指令,将其所有的历史指令更新为无效
        update tb_SecurityCommandBackup set Attribute=i.Attribute
        from tb_SecurityCommandBackup b, inserted i
        where i.Attribute<>0 and b.CommandID=i.CommandID

	--向备份表中添加新的备份指令
	insert into tb_SecurityCommandBackup
	select CommandID,CardNo,Type,ValidType,UseType,
		(select top 1 sbk.AddTime from tb_SecurityCommandBackup sbk,inserted i where sbk.CommandID=i.CommandID order by sbk.AddTime) as AddTime,
		StartTime,EndTime,OpTime,Status,Attribute,
		(select case when MAX(ModID) is null then 1 else MAX(ModID)+1 end from tb_SecurityCommandBackup sbk,inserted i where sbk.CommandID=i.CommandID) as ModID,
		OperatorType,OperatorNo,1
	from inserted

	--使用游标逐条将inserted中的操作记录向操作记录表中添加操作记录
	declare @CommandID int,@Attribute smallint
	declare InsertedCursor cursor for select distinct CommandID,Attribute from inserted
	open InsertedCursor
	fetch next from InsertedCursor into @CommandID,@Attribute
	while @@fetch_status=0
	begin
		insert into tb_SecurityCommandOperation
		select (select case when Max(OperationID) is null then 1 else Max(OperationID)+1 end from tb_SecurityCommandOperation) as OperationID,
		case @Attribute when 1 then 3 else 2 end as OperationType,
		(select Max(PostModID) from tb_SecurityCommandOperation t1 where t1.CommandID=@CommandID) as 
PreModID,
     	(select Max(PostModID)+1 from tb_SecurityCommandOperation t1 where t1.CommandID=@CommandID) 
as PostModID,
	@CommandID
		
		fetch next from InsertedCursor into @CommandID,@Attribute
	end
	close InsertedCursor
	deallocate InsertedCursor
GO

-------------------------------------------------------------------------------------------------
----------------------------存储过程中下发任务表需要加一列------------------------------------------
-------------------------------------------------------------------------------------------------
--修改存储过程PROC_SendPara，加一列
GO
/****** Object:  StoredProcedure [dbo].[PROC_SendPara]    Script Date: 06/23/2011 16:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PROC_SendPara](@TableName varchar(255))
AS
	delete tb_SendPara
	from tb_SendPara, (select LaneNo, LaneComputerIP from tb_Lane) tb1
	where tb_SendPara.LaneNo = tb1.LaneNo and
	tb_SendPara.LaneComputerIP = tb1.LaneComputerIP and
	tb_SendPara.TableName = @TableName
	
	insert into tb_SendPara
	select 1 as SendType, '0' as FieldName, '0' as FieldValue,
	tb1.LaneNo, tb1.LaneComputerIP, @TableName,@TableName
	from (select LaneNo, LaneComputerIP from tb_LaneUse ) tb1
GO
-------------------------------------------------------------------------------------------------
--修改(tb_InList_Tmp)中触发器Tr_InlistSplit
GO
/****** Object:  Trigger [dbo].[Tr_InlistSplit]    Script Date: 06/21/2011 10:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--将入口流水表的数据分表存储
ALTER Trigger [dbo].[Tr_InlistSplit]
	on [dbo].[tb_InList_Tmp]
	for insert
As
	declare @Months						tinyint

	--根据工班日期，分别存储流水数据
	select @Months=DATEPART(month,SquadDate) from inserted
	--获取插入流水表名，插入流水
	if @Months = 1
		insert into tb_InList01 	
  		select * from inserted
  else if @Months = 2
		insert into tb_InList02 	
  		select * from inserted
  else if @Months = 3
		insert into tb_InList03 	
  		select * from inserted
  else if @Months = 4
		insert into tb_InList04 	
  		select * from inserted
  else if @Months = 5
		insert into tb_InList05 	
  		select * from inserted
  else if @Months = 6
		insert into tb_InList06 	
  		select * from inserted
  else if @Months = 7
		insert into tb_InList07 	
  		select * from inserted
  else if @Months = 8
		insert into tb_InList08 	
  		select * from inserted
  else if @Months = 9
		insert into tb_InList09 	
  		select * from inserted
  else if @Months = 10
		insert into tb_InList10 	
  		select * from inserted
  else if @Months = 11
  		insert into tb_InList11 	
  		select * from inserted
  else if @Months = 12
		insert into tb_InList12 	
  		select * from inserted

	--修改tb_CardDynamic表记录，cardNo>0的数据才操作
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
				where t1.cardno=t2.cardno and t2.CardNo>0)
	begin
		update tb_CardDynamic set UserCardType=t2.UserCardType,status=11, Optime=t2.Optime, ParkNo=t2.ParkNo,
				 GateNo=t2.GateNo, LaneNo=t2.LaneNo,VehType=t2.Vehtype,VehPlate = t2.VehPlate,OperatorNo = t2.OperatorNo,
				 OperatorName = t2.OperatorName,SquadDate = t2.SquadDate,SquadNo=t2.SquadNo,InListNo=t2.ListNo,OutListNo='',
				 Owner=' ',VehBrand='',TicKetType=t2.TicKetType,GateName=t2.GateName 
		from tb_CardDynamic t1, inserted t2
		where t1.OpTime < t2.OpTime and t1.cardno = t2.cardno
		
	end
	else
	begin
		insert into tb_CardDynamic select CardNo, 11, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,ListNo,' ',' ', TicKetType,GateName
		from inserted t1
		where t1.CardNo>0
	end

	--  统计流水信息给监视用
	declare		@iAreaNo		smallint
  	declare		@iParkNo		smallint
  	declare		@iGateNo		smallint
  	declare		@iLaneNo		smallint
  	declare		@dtSquadDate	DATETIME
  	declare		@iSquadNo		smallint
  	declare		@iOperatorNo	integer
  	declare		@iCashMoney		smallint
  	declare		@dtUploadTime	DATETIME

	declare cur_inserted cursor
	for
	select AreaNo,ParkNo,GateNo,LaneNo,SquadDate,SquadNo,OperatorNo,
		   0 CashMoney,UploadTime
	from inserted
	for read only
	
	open cur_inserted
	/* get the first row from the cursor */
	fetch next from cur_inserted into @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,
									  @dtSquadDate,@iSquadNo,@iOperatorNo,
									  @iCashMoney,@dtUploadTime
	
	/* loop the rows in the cursor*/
	while @@fetch_status = 0
	begin
		
	   	-- 更新 tb_LaneStatus 表	   	
	   	exec Proc_UpdateLaneStatus @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,@dtSquadDate,@iSquadNo,@iOperatorNo,@iCashMoney,@dtUploadTime
	   	
	   	-- 更新 tb_StaVehCount 表
	   	-- exec sp_UpdateStaVehCount @iAreaNo,@iParkNo,@iGateNo,@iVehCount,@dtOpTime,2
	   	
	   	/* get next row */
		fetch next from cur_inserted into @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,
										  @dtSquadDate,@iSquadNo,@iOperatorNo,
									  	  @iCashMoney,@dtUploadTime
	end 
	/* close the cursor */
	deallocate cur_inserted 

  delete from tb_Inlist_Tmp
-------------------------------------------------------------------------------------------------
--修改(tb_OutList_Tmp)中触发器Tr_OutlistSplit

GO
/****** Object:  Trigger [dbo].[Tr_OutlistSplit]    Script Date: 06/21/2011 11:44:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--将出口流水表的数据分表存储
ALTER Trigger [dbo].[Tr_OutlistSplit]
	on [dbo].[tb_OutList_Tmp]
	for insert
As
	declare @Months						tinyint

	--根据工班日期，分别存储流水数据
	select @Months=DATEPART(month,SquadDate) from inserted
	--获取插入流水表名，插入流水
	if @Months = 1
		insert into tb_OutList01 	
  		select * from inserted
  else if @Months = 2
		insert into tb_OutList02 	
  		select * from inserted
  else if @Months = 3
		insert into tb_OutList03 	
  		select * from inserted
  else if @Months = 4
		insert into tb_OutList04 	
  		select * from inserted
  else if @Months = 5
		insert into tb_OutList05 	
  		select * from inserted
  else if @Months = 6
		insert into tb_OutList06 	
  		select * from inserted
  else if @Months = 7
		insert into tb_OutList07 	
  		select * from inserted
  else if @Months = 8
		insert into tb_OutList08 	
  		select * from inserted
  else if @Months = 9
		insert into tb_OutList09 	
  		select * from inserted
  else if @Months = 10
		insert into tb_OutList10 	
  		select * from inserted
  else if @Months = 11
  	insert into tb_OutList11 	
  		select * from inserted
  else if @Months = 12
		insert into tb_OutList12 	
  		select * from inserted
  	
	--修改tb_CardDynamic表记录，cardNo>0的数据才操作
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
				where t1.cardno=t2.cardno and t2.CardNo>0)
	begin
		update tb_CardDynamic set UserCardType=t2.UserCardType,status=12, Optime=t2.Optime, ParkNo=t2.ParkNo,
				 GateNo=t2.GateNo, LaneNo=t2.LaneNo,VehType=t2.Vehtype,VehPlate = t2.VehPlate,OperatorNo = t2.OperatorNo,
				 OperatorName = t2.OperatorName,SquadDate = t2.SquadDate,SquadNo=t2.SquadNo,InListNo='',OutListNo=t2.ListNo,
				 Owner=' ',VehBrand='',TicKetType=t2.TicKetType,GateName=t2.GateName 
		from tb_CardDynamic t1, inserted t2
		where t1.cardno = t2.cardno and t1.OpTime < t2.OpTime
		
	end
	else
	begin
		insert into tb_CardDynamic select CardNo, 12, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
		from inserted t1
		where t1.CardNo>0
	end

	--如果流水记录的特殊事件有"丢卡"(第8位), 修改tb_CardDynamic中临时卡的状态为"丢卡"(13)
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
                    where t2.spevent&0x00000080<>0 and t1.cardno=t2.cardno and t1.optime<t2.optime)
	begin
                update tb_CardDynamic set Status=13
                from tb_CardDynamic t1, inserted t2
                where t2.spevent&0x00000080<>0 and t1.cardno=t2.cardno and t1.optime<t2.optime
	end

	--如果流水记录的特殊事件有"坏卡"(第9位), 修改tb_CardDynamic中临时卡的状态为"坏卡"(15)
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
                    where t2.spevent&0x00000100<>0 and t1.cardno=t2.cardno and t1.optime<t2.optime)
	begin
                update tb_CardDynamic set Status=15
                from tb_CardDynamic t1, inserted t2
                where t2.spevent&0x00000100<>0 and t1.cardno=t2.cardno and t1.optime<t2.optime
	end

	--  统计流水信息给监视用
	declare		@iAreaNo		smallint
  	declare		@iParkNo		smallint
  	declare		@iGateNo		smallint
  	declare		@iLaneNo		smallint
  	declare		@dtSquadDate	DATETIME
  	declare		@iSquadNo		smallint
  	declare		@iOperatorNo	integer
  	declare		@iCashMoney		smallint
  	declare		@dtUploadTime	DATETIME

	declare cur_inserted cursor
	for
	select AreaNo,ParkNo,GateNo,LaneNo,SquadDate,SquadNo,OperatorNo,
		   CashMoney,UploadTime
	from inserted
	for read only
	
	open cur_inserted
	/* get the first row from the cursor */
	fetch next from cur_inserted into @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,
									  @dtSquadDate,@iSquadNo,@iOperatorNo,
									  @iCashMoney,@dtUploadTime
	
	/* loop the rows in the cursor*/
	while @@fetch_status = 0
	begin
		
	   	-- 更新 tb_LaneStatus 表	   	
	   	exec Proc_UpdateLaneStatus @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,@dtSquadDate,@iSquadNo,@iOperatorNo,@iCashMoney,@dtUploadTime
	   	
	   	-- 更新 tb_StaVehCount 表
	   	-- exec sp_UpdateStaVehCount @iAreaNo,@iParkNo,@iGateNo,@iVehCount,@dtOpTime,2
	   	
	   	/* get next row */
		fetch next from cur_inserted into @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,
										  @dtSquadDate,@iSquadNo,@iOperatorNo,
									  	  @iCashMoney,@dtUploadTime
	end 
	/* close the cursor */
	deallocate cur_inserted 

  delete from tb_Outlist_Tmp
---------------------一户多车----------------------------------------------------------------------------
 --判断表tb_CardGroup是否存在，不存在时则创建
GO
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardGroup]') and OBJECTPROPERTY(id,N'IsUserTable') = 1) 
CREATE TABLE [dbo].[tb_CardGroup](
	[RecNo] [int] NOT NULL,
	[CardNo] [varchar](16) NOT NULL,
	[VehPlate] [varchar](10) NOT NULL,
	[GroupNo] [int] NOT NULL,
	[FirstInOut] [int] ,
	[Optime] [datetime] ,
	[LaneGroupNo] [int] NOT NULL,
	constraint pk_pams_CardGroup_id primary key(RecNo,LaneGroupNo),
	)
GO
-------------------------------------------------------------------------------------------------

  --判断表tb_CardGroupInfo是否存在，不存在时则创建
GO
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardGroupInfo]') and OBJECTPROPERTY(id,N'IsUserTable') = 1) 
CREATE TABLE [dbo].[tb_CardGroupInfo](
	[GroupNo] [int] NOT NULL,
	[LaneGroupNo] [char](1) NOT NULL,
	[GroupName] [varchar](20) NOT NULL,
	[ParkSum] [int] ,
	[ParkRemant] [int] ,
	[Optime] [datetime] ,
	constraint pk_pams_CardGroupInfo_id primary key(GroupNo,LaneGroupNo),
	)
-----------------------------------身份卡管理-------------------------------------------------------------
--判断表tb_IDCardInfo是否存在，不存在时则创建
GO
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_IDCardInfo]') and OBJECTPROPERTY(id,N'IsUserTable') = 1) 
CREATE TABLE [dbo].[tb_IDCardInfo](
	[IDCardNo] [varchar](10) primary key,
	[UserName] [varchar](16) NOT NULL,
	[Department] [varchar](40) NOT NULL,
	[Job] [varchar](40) NOT NULL,
	[PlateList] [varchar](255) NOT NULL,
	[Photo] [image] NULL,
	)
GO
-------------------------------------------------------------------------------------------------


GO
-------------------------------------------------------------------------------------------------

GO
-------------------------------------------------------------------------------------------------
--图像查询相关：
--原则：原来的存储过程不改，在查出入口流水时，当发现调用的存储过程参数不一致时，按新参数格式创建对应的存储过程

/*
 *原来使用的
 */
--根据卡号查最近的流水（属于嵌入存储过程）
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo2Table]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByCardNo2Table]
go
create procedure proc_FindInListByCardNo2Table
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	--@LaneFlg int,		--1:外围车道,	其它:所有
	@SpeventFlg int 	--1:军警车,		其它:所有
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int


	set @iMonth = month(getdate()+1)
	set @iCount = 0
	set @iRecord = @RecordCount


	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

--	select * from #t_list
-- order by optime desc

end
GO


--根据车牌查最近的流水（属于嵌入存储过程）
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate2Table]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByVehPlate2Table]
go
create procedure proc_FindInListByVehPlate2Table
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	--@LaneFlg int,		--1:外围车道,	其它:所有
	@SpeventFlg int 	--1:军警车,		其它:所有
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int

	set @iMonth = month(getdate()+1)
	set @iCount = 0
	set @iRecord = @RecordCount

	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

-- select * from #t_list
-- order by optime desc

end
GO



--入口流水查询，卡号（车道根据卡号查询入口）
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByCardNo]
go
create procedure proc_FindInListByCardNo
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@SpeventFlg int 	--1:军警车,		其它:所有
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByCardNo2Table @MonthNum,@RecordCount,@CardNO,@SpeventFlg

	update #t_list set flg=1 from #t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update #t_list set flg=1 from #t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime

	select * from #t_list order by optime desc
end
GO



--入口流水查询，车牌（车道根据车牌查询入口）
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByVehPlate]
go
create procedure proc_FindInListByVehPlate
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@SpeventFlg int 	--1:军警车,		其它:所有
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByVehplate2Table @MonthNum,@RecordCount,@VehPlate,@SpeventFlg

	update #t_list set flg=1 from #t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update #t_list set flg=1 from #t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime

	select * from #t_list order by optime desc
end
GO



--从 卡动态表中查
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByListNo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByListNo]
go
create procedure proc_FindInListByListNo
	@ListNo	Char(16)
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int
	declare @t_list table(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	insert @t_list
	select inlistno as listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype, (case when Status=12 then 1 else 0 end) as flg
	from tb_CardDynamic
	where inlistno=@ListNo
	order by optime desc

	select * from @t_list order by optime desc

end
GO



/*
 *新增的
 */
--根据卡号查最近的流水
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindOutListByCardNo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindOutListByCardNo]
go

CREATE   proc proc_FindOutListByCardNo
	@MonthNum int,
	@RecordCount int,
	@CardNO	int
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int


	set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())
	set @iCount = 0
	set @iRecord = @RecordCount

	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist01 where cardno=@CardNO order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist02 where cardno=@CardNO order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist03 where cardno=@CardNO order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist04 where cardno=@CardNO order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist05 where cardno=@CardNO order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist06 where cardno=@CardNO order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist07 where cardno=@CardNO order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist08 where cardno=@CardNO order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist09 where cardno=@CardNO order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist10 where cardno=@CardNO order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist11 where cardno=@CardNO order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist12 where cardno=@CardNO order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

--	select * from #t_list
-- order by optime desc

end
GO


--根据车牌查最近的流水
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindOutListByVehPlate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindOutListByVehPlate]
go

CREATE       proc proc_FindOutListByVehPlate
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
    @StartTime datetime,
    @EndTime   datetime
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int


	--set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())

    set @iMonth = month(@EndTime + 1)

	set @iCount = 0
	set @iRecord = @RecordCount

	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist01 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist02 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist03 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist04 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist05 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist06 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist07 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist08 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist09 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist10 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist11 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist12 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

--	select * from #t_list
-- order by optime desc

end
Go


-- 在浙大不需要用tb_LaneGroup这个表，为统一版本，增加该该名字的视图
if exists (select table_name from information_schema.views where table_name = 'tb_LaneGroup')
drop view tb_LaneGroup
Go

create view tb_LaneGroup
as
	Select 1 as LaneGroupNo,LaneNo,LaneTypeNo
	From tb_Lane

Go



--根据卡号查最近的流水
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo2Table_Ex]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByCardNo2Table_Ex]
go
CREATE    proc proc_FindInListByCardNo2Table_Ex
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@LaneFlg int,		--1:外围车道,	其它:所有
	@SpeventFlg int 	--1:军警车,		其它:所有
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int


	set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())
	set @iCount = 0
	set @iRecord = @RecordCount


	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

--	select * from #t_list
-- order by optime desc

end
GO



--根据车牌查最近的流水
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate2Table_Ex]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByVehPlate2Table_Ex]
go
CREATE     proc proc_FindInListByVehPlate2Table_Ex
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@LaneFlg int,		--1:外围车道,	其它:所有
	@SpeventFlg int, 	--1:军警车,		其它:所有
    @StartTime  datetime,
    @EndTime    datetime
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int

	--set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())
--月底最后一天会查到下一个月的表
    set @iMonth = month(@EndTime + 1)
	set @iCount = 0
	set @iRecord = @RecordCount

	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

-- select * from #t_list
-- order by optime desc

end
GO

--出入口查询
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInOutListByCardNO]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInOutListByCardNO]
go
create proc proc_FindInOutListByCardNO
	@MonthNum int,
	@RecordCount int,
	@CardNO	int
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByCardNo2Table_Ex @MonthNum,@RecordCount,@CardNO,0,0
	exec proc_FindOutListByCardNo @MonthNum,@RecordCount,@CardNO

	select * from #t_list order by optime desc

end
GO

--出入口查询
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInOutListByVehPlate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInOutListByVehPlate]
go
CREATE   proc proc_FindInOutListByVehPlate
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
    @StartTime datetime,
    @EndTime   datetime
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

    --declare @MonthNum int

    --set @MonthNum = ABS(Month(@EndTime + 1) - Month(@StartTime)) + 1
    --跨年的情况，需要加12取模
    set @MonthNum = (Month(@EndTime + 1) - Month(@StartTime) + 12)%12 + 1

	exec proc_FindInListByVehPlate2Table_Ex @MonthNum,@RecordCount,@VehPlate,0,0,@StartTime,@EndTime
	exec proc_FindOutListByVehPlate @MonthNum,@RecordCount,@VehPlate,@StartTime,@EndTime

	select * from #t_list order by optime desc

end

GO


--入口流水查询，车牌
--出入口查询
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate_Ex]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByVehPlate_Ex]
go
CREATE   proc proc_FindInListByVehPlate_Ex
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@SpeventFlg int, 	--1:军警车,		其它:所有
    @StartTime datetime,
    @EndTime   datetime
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByVehplate2Table_Ex @MonthNum,@RecordCount,@VehPlate,1,@SpeventFlg,@StartTime,@EndTime

	update #t_list set flg=1 from #t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update #t_list set flg=1 from #t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime

	select * from #t_list order by optime desc
end

GO


--入口流水查询，卡号
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo_Ex]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByCardNo_Ex]
go
create proc proc_FindInListByCardNo_Ex
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@SpeventFlg int 	--1:军警车,		其它:所有
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByCardNo2Table_Ex @MonthNum,@RecordCount,@CardNO,1,@SpeventFlg

	update #t_list set flg=1 from #t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update #t_list set flg=1 from #t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime

	select * from #t_list order by optime desc
end

GO

--为了统一版本，浙大不使用该存储过程
--查找同一用户的所有车
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindAllListByCardNo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindAllListByCardNo]
go
create proc proc_FindAllListByCardNo
	@CardNO	int
as
begin

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	select a.ListNo,a.GateNo,b.GateName,a.LaneNo,a.CardNo,a.OpTime,a.squaddate,a.VehPlate,14 as usercardtype,case when a.Status=11 then 0 else 1 end as Flg
	from tb_UserCardDynamic	a left join tb_gateway b on a.GateNo=b.GateNo
	where a.cardno in (select cardno from tb_cardgroup where groupno =(select top 1 groupno from tb_cardgroup where cardno=@CardNo and groupno<>0))
	order by optime desc
end

GO

--为了统一版本，浙大不使用该存储过程
--查找同一用户的所有车
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindAllListByVehPlate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindAllListByVehPlate]
go
create proc proc_FindAllListByVehPlate
	@VehPlate char(10)
as
begin
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	select a.ListNo,a.GateNo,b.GateName,a.LaneNo,a.CardNo,a.OpTime,a.squaddate,a.VehPlate,14 as usercardtype,case when a.Status=11 then 0 else 1 end as Flg
	from tb_UserCardDynamic	a left join tb_gateway b on a.GateNo=b.GateNo
	where a.cardno in (select cardno from tb_cardgroup where groupno in (select groupno from tb_cardgroup where vehplate like @VehPlate and groupno<>0))
	order by optime desc
end
GO
------------------------------------------------------------------------------------------------------------
--------------------------------------广外初始华系统参数sql--------------------------------------------------
--系统参数设置信息
--下发参数->基本信息BaseCode 1
delete tb_SystemPara where ParaClass=1
GO

delete tb_SystemPara where ParaClass=1 and GroupName='BaseCode'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'城市编码','tb_City','BaseCode',0,1)

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'区域编码','tb_Area','BaseCode',1,1)

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'校区编码','tb_Park','BaseCode',2,1)

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'大门编码','tb_Gateway','BaseCode',3,1)

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'车道编码','tb_Lane','BaseCode',4,1)
GO

--下发参数->营运参数AdvCode 2
delete tb_SystemPara where ParaClass=1 and GroupName='AdvCode'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'功能键表','tb_FunctionKey','AdvCode',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'设备编码表 ','tb_devicecode','AdvCode',1,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'设备错误代码表','tb_deviceerrorcode','AdvCode',2,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'车种编码表','tb_VehClassCode','AdvCode',3,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'车型转换表','tb_carTypeTrans','AdvCode',4,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'车型编码表','tb_VehTypeCode','AdvCode',5,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'通行券类型编码表 ','tb_tickettypecode','AdvCode',6,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'特殊事件编码表 ','tb_speventcode','AdvCode',7,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'工班','tb_Squad','AdvCode',8,1)
GO

--下发惨->卡信息CardInfo 3
delete tb_SystemPara where ParaClass=1 and GroupName='CardInfo'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'广外黑名单车辆','tb_SpecialVeh','CardInfo',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'通行卡黑名单表','V_PassCardBlackList','CardInfo',1,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'身份卡黑名单','tb_OpCardBlackList','CardInfo',2,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'通行卡登记表','V_PassCardWL','CardInfo',3,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'卡信息表','tb_CardInfo','CardInfo',4,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'白名单','v_WhiteList','CardInfo',5,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'特殊车辆处理信息表','tb_SpVehHandle','CardInfo',6,1)
GO

--下发参数->费率Price 4
delete tb_SystemPara where ParaClass=1 and GroupName='Price'
GO

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'收费类型映射表 ','tb_pricepasstype','Price',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'费率规则表','tb_PriceRule','Price',1,1)
GO
delete from tb_SystemPara where ItemValue='tb_FreeDays'
Go
insert into tb_SystemPara values (1,'免费日期','tb_FreeDays','Price',2,1)
--下发参数->操作员信息Operator 5
delete tb_SystemPara where ParaClass=1 and GroupName='Operator'
GO

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'操作员信息','tb_Operator','Operator',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'操作员角色','tb_OperatorRole','Operator',1,1)

GO

--下发参数->其它Default 6
delete tb_SystemPara where ParaClass=1 and GroupName='Default'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'补光灯开关时间表 ','tb_Supplylight','Default',0,1)
GO

--下发参数->黑名单BlackList 7
delete tb_SystemPara where ParaClass=1 and GroupName='BlackList'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'OBU有效启用日期 ','tb_OBUDate','BlackList',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'储值卡黑名单 ','tb_StoreCardBlackList','BlackList',1,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'储值卡有效启用日期  ','tb_StoreCardDate','BlackList',2,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'记帐卡黑名单 ','tb_TollyCardBlackList','BlackList',3,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'记帐卡有效启用日期 ','tb_TollyCardDate','BlackList',4,1)
GO

--下发参数->安全信息Security 8
delete tb_SystemPara where ParaClass=1 and GroupName='Security'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'当前丢卡记录表  ','V_LoseCardList','Security',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'锁车时间表 ','v_securitycommand','Security',1,1)
GO
------------------------------------------------------------------------------------------------------------
--为了数据库统一，目前只有富力在用
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_AOwnerNVeh]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   删除视图    
  drop view [dbo].[V_AOwnerNVeh]
GO
create view [dbo].[V_AOwnerNVeh]
AS
select distinct
       t1.CardNo,
       t1.VehPlate,
       t2.GroupNo,
	   t2.GroupName,
	   t2.ParkSum as VehPlaceCnt
from tb_CardGroup t1, tb_CardGroupInfo t2
where t1.GroupNo = t2.GroupNo
---------------------------------------------------------------------------------------------
GO
--为了数据库统一，目前只有富力在用，其它校区运用一定要保持parkingspace只的长度大于1和‘-’（这个-一定要用）不能在第一位，否则会出错
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_LimitParkInfo]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   删除视图    
  drop view [dbo].[v_LimitParkInfo]
GO
CREATE   view [dbo].[v_LimitParkInfo]
as
select 1 as gateno , 1 as laneno, cardno, 'A4' as remark from 
(select Substring(parkingspace, 1, patindex('%-%', parkingspace)-1) as parkingspace, cardno
from (select parkingspace, cardno from tb_usercardinfo where parkingspace is not null and parkingspace <> '0') t1
) t2 where parkingspace in('B1', 'B5', 'B11', 'B8', 'A4')

union all

select 5 as gateno , 5 as laneno, cardno, 'A5' as remark from 
(select Substring(parkingspace, 1, patindex('%-%', parkingspace)-1) as parkingspace, cardno
from (select parkingspace, cardno from tb_usercardinfo where parkingspace is not null and parkingspace <> '0') t1
) t2 where parkingspace in('A5', 'C9', 'C1', 'D1')

union all


select 34 as gateno , 34 as laneno, cardno, 'D4' as remark from 
(select Substring(parkingspace, 1, patindex('%-%', parkingspace)-1) as parkingspace, cardno
from (select parkingspace, cardno from tb_usercardinfo where parkingspace is not null and parkingspace <> '0') t1
) t2 where parkingspace in('A5', 'C9', 'C1', 'D1')

union all

select 59 as gateno , 59 as laneno, cardno, 'E9' as remark from 
(select Substring(parkingspace, 1, patindex('%-%', parkingspace)-1) as parkingspace, cardno
from (select parkingspace, cardno from tb_usercardinfo where parkingspace is not null and parkingspace <> '0') t1
) t2 where parkingspace in('E1', 'F1', 'G1')

GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarSpaceDynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_CarSpaceDynamic
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InPark]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_InPark
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutPark]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_OutPark
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarSpaceDynamicBackUp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_CarSpaceDynamicBackUp
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InParkBackUp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_InParkBackUp
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutParkBackUp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_OutParkBackUp
GO
create table tb_CarSpaceDynamic
(
  RecNo                int identity(1,1) primary key,
  ParkNo               varchar(10) NOT NUll,
  TotalSpace           int  NOT NUll,
  MonthlyRentSpace     int  NOT NUll,
  TemporarySpace       int  NOT NUll,
  CurrentEmptySpace    int  NOT NUll,
  OutParkTotal         int  NOT NUll,
  InParkTotal          int  NOT NUll,
  MonthlyRentInPark    int  NOT NUll,
  MonthlyRentOutPark   int  NOT NUll,
  TemporaryInPark      int  NOT NUll,
  TemporaryOutPark     int  NOT NUll,
  ModifyTime           datetime NOT NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
GO
Insert into tb_CarSpaceDynamic(ParkNo,TotalSpace,MonthlyRentSpace,TemporarySpace,CurrentEmptySpace,OutParkTotal,InParkTotal,MonthlyRentInPark,MonthlyRentOutPark,
TemporaryInPark,TemporaryOutPark,ModifyTime,BackUp1,BackUp2) values('101',80,40,40,0,0,0,0,80,0,0,'2011-10-10 15:42:00',null,null)
GO
create table tb_InPark
(
  RecNo                int identity(1,1) primary key,
  ParkNo               varchar(10) NOT NUll,
  VehPlate             varchar(10) NOT NUll,
  InOptime             datetime NOT NUll,
  CurrentEmptySpace    int  NOT NUll,
  ModifyTime           datetime NOT NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
GO
create table tb_OutPark
(
  RecNo                int identity(1,1) primary key,
  ParkNo               varchar(10) NOT NUll,
  VehPlate             varchar(10) NOT NUll,
  InOptime             datetime NOT NUll,
  Optime               datetime NOT NUll,
  ChargeType           varchar(10) NOT NUll,
  ChargeTime           varchar(10) NOT NUll,
  TotalMoney           int  NOT NUll,  
  CurrentEmptySpace    int  NOT NUll,
  ModifyTime           datetime NOT NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)

GO
create table tb_CarSpaceDynamicBackUp
(
  RecNo                int NULL,
  ParkNo               varchar(10)  NUll,
  TotalSpace           int   NUll,
  MonthlyRentSpace     int   NUll,
  TemporarySpace       int   NUll,
  CurrentEmptySpace    int   NUll,
  OutParkTotal         int   NUll,
  InParkTotal          int   NUll,
  MonthlyRentInPark    int   NUll,
  MonthlyRentOutPark   int   NUll,
  TemporaryInPark      int   NUll,
  TemporaryOutPark     int   NUll,
  ModifyTime           datetime  NUll,
  SendTime             datetime  NUll,
  RequestRecNO         varchar(20) NUll,
  Keywords             varchar(20) NUll,
  SendMessage          varchar(250) NUll,
  ReturnMessage        varchar(250) NUll,
  IsSucceed            int   NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
GO
create table tb_InParkBackUp
(
  RecNo                int NULl,
  ParkNo               varchar(10)  NUll,
  VehPlate             varchar(10)  NUll,
  InOptime             datetime  NUll,
  CurrentEmptySpace    int   NUll,
  ModifyTime           datetime  NUll,
  SendTime             datetime  NUll,
  RequestRecNO         varchar(20) NUll,
  Keywords             varchar(20) NUll,
  SendMessage          varchar(250) NUll,
  ReturnMessage        varchar(250) NUll,
  IsSucceed            int   NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
create table tb_OutParkBackUp
(
  RecNo                int NULL,
  ParkNo               varchar(10) NUll,
  VehPlate             varchar(10)  NUll,
  InOptime             datetime  NUll,
  Optime               datetime  NUll,
  ChargeType           varchar(10)  NUll,
  ChargeTime           varchar(10)  NUll,
  TotalMoney           int   NUll,  
  CurrentEmptySpace    int   NUll,
  ModifyTime           datetime  NUll,
  SendTime             datetime  NUll,
  RequestRecNO         varchar(20) NUll,
  Keywords             varchar(20) NUll,
  SendMessage          varchar(250) NUll,
  ReturnMessage        varchar(250) NUll,
  IsSucceed            int   NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_InlistCarSpaceDynamicAndInPark]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_InlistCarSpaceDynamicAndInPark]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Trigger [dbo].[Tr_InlistCarSpaceDynamicAndInPark]--修改车位动态信息和插入信息到进入停车场信息表（tb_InPark）中（上传给政府用）
	on [dbo].[tb_InList_Tmp]
	for insert
As
	declare @AreaNo				smallint     
	declare @ParkNo				smallint     
	declare @GateNo				smallint     
	declare @LaneNo				smallint 
	declare @sVehPlate          varchar(10)
	declare @VehType			smallint     
	declare @VehClass			smallint     
	declare @TicketType			smallint      
	declare @UserCardType       smallint     
	declare @VehCount			smallint     
	declare @SquadDate			datetime
	declare @SquadNo			smallint     
	declare @OperatorNo			int     
	declare @OperatorName		char(8)         
	declare @OpTime				datetime 
	declare @iCurrentEmptySpace int   
	declare @sParkNo            varchar(10)
	
		
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@sVehPlate=VehPlate,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
	@UserCardType=UserCardType,@VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,@OpTime=OpTime 
	from inserted
	if exists(select * from tb_CarSpaceDynamic)--车位动态表中存在信息
	   begin
	       select @sParkNo=ParkNo,@iCurrentEmptySpace=CurrentEmptySpace from tb_CarSpaceDynamic--查询当前空车位数
	       if(@iCurrentEmptySpace>0)--当前空车位数大于0时
	          begin
	             update tb_CarSpaceDynamic set CurrentEmptySpace=CurrentEmptySpace-1--修改当前空车位数
	          end
	       else--当前空车位数不大于0时
	          begin
	             update tb_CarSpaceDynamic set CurrentEmptySpace=0--修改当前空车位数
	          end
	       if(@UserCardType=0)--临保车（刷临时卡时从车道下写上来UserCardType的值为0）
	           begin
	              update tb_CarSpaceDynamic set TemporaryInPark=TemporaryInPark+1--修改临保进场数量                   
	           end
	       else--月保车
	           begin
	               update tb_CarSpaceDynamic set MonthlyRentInPark=MonthlyRentInPark+1--修改月保进场数量  
	           end
	       update tb_CarSpaceDynamic set InParkTotal=TemporaryInPark+MonthlyRentInPark--修改进场总数量，保持进场总数量=月保进场数量+临保进场数量

	       select @sParkNo=ParkNo,@iCurrentEmptySpace=CurrentEmptySpace from tb_CarSpaceDynamic--查询当前空车位数和停车场编号
	       insert into tb_InPark(ParkNo,VehPlate,InOptime,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2) values(@sParkNo,@sVehPlate,@OpTime,@iCurrentEmptySpace,getDate(),null,null)	          
	   end
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Trigger [dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]--修改车位动态信息和插入信息到出入停车场信息表（tb_OutPark）中（上传给政府用）
	on [dbo].[tb_OutList_Tmp]
	for insert
As
	declare @AreaNo				smallint     
	declare @ParkNo				smallint     
	declare @GateNo				smallint     
	declare @LaneNo				smallint
	declare @sVehPlate          varchar(10)     
	declare @VehType			smallint     
	declare @VehClass			smallint     
	declare @TicketType			smallint      
	declare @UserCardType       smallint     
	declare @CheckType			smallint
	declare @VehCount			smallint     
	declare @SquadDate			datetime
	declare @SquadNo			smallint     
	declare @OperatorNo			int     
	declare @OperatorName		char(8)         
	declare @CashMoney			int 											
	declare @FreeMoney			int											
	declare @UnpayMoney			int								
	declare @ETCMoney			int
	declare @OpTime				datetime 
	declare @InOpTime			datetime 
	declare @iCurrentEmptySpace int   
	declare @sParkNo            varchar(10) 
	declare @iTotalMoney        int
	declare @iTotalMinute       int--两个时间相差的总分钟
	declare @iDay               int--两个时间相差的天数
	declare @iHour              int--两个时间相差的小时
	declare @iMinute            int--两个时间相差的分钟
	declare @sDay               varchar(10)--转换车字符串，格式格式为两位，不够两位前面补0
	declare @sHour              varchar(10)--转换车字符串，格式格式为两位，不够两位前面补0
	declare @sMinute            varchar(10)--转换车字符串，格式格式为两位，不够两位前面补0
	declare @sChargeTime        varchar(10)--格式为00：00：00 中文意思 天：小时：分钟
	
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
		   @UserCardType=UserCardType,@CheckType=CheckType,@InOpTime=InOpTime,@sVehPlate=VehPlate,
		   @VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,
		   @CashMoney=CashMoney,@FreeMoney=FreeMoney,@UnpayMoney=UnpayMoney,@ETCMoney=ETCMoney,@OpTime=OpTime 
	from inserted
	
	if exists(select * from tb_CarSpaceDynamic)--车位动态表中存在信息
	   begin	       
	       update tb_CarSpaceDynamic set CurrentEmptySpace=CurrentEmptySpace+1--修改当前空车位数
	       select @sParkNo=ParkNo,@iCurrentEmptySpace=CurrentEmptySpace from tb_CarSpaceDynamic--查询当前空车位数和停车场编号	
	       set @iTotalMoney=@CashMoney+@FreeMoney+@UnpayMoney+@ETCMoney--获取票价总价 
	       --求出停车场时间与进停车场之间的差，格式为 00:00:00(就是天：小时：分钟）
	       set @iTotalMinute=sum(datediff(minute,@InOpTime, @OpTime)) --求时间差的总分钟
	       set @iDay = @iTotalMinute/1440--天数=总分钟/(60*24)
	       set @iHour = (@iTotalMinute-@iDay*1440)/60--小时=（总分钟-天数*60*24）/60
	       set @iMinute = @iTotalMinute-@iDay*1440-@iHour*60--分钟=总分钟-数*60*24-小时*60
	        if(@iDay<10) 
	            begin
	             set @sDay='0'+LTrim(str(@iDay))
	            end
	        else
	            begin
	             set @sDay=LTrim(str(@iDay))
	            end        
	        if(@iHour<10) 
	            begin
	             set @sHour='0'+LTrim(str(@iHour))
	            end
	        else
	            begin
	               set @sHour=LTrim(str(@iHour))
	            end
	        if(@iMinute<10)
	           begin
	              set @sMinute='0'+LTrim(str(@iMinute))
	           end 
	        else
	           begin
	            set @sMinute=LTrim(str(@iMinute))
	           end
	        set  @sChargeTime=@sDay+'-'+@sHour+'-'+@sMinute
	            
	       if(@UserCardType=0)--临保车（刷临时卡时从车道下写上来UserCardType的值为0）
	           begin
	              update tb_CarSpaceDynamic set TemporaryOutPark=TemporaryOutPark+1--修改临保出场数量
	              Insert into tb_OutPark(ParkNo,VehPlate,InOptime,Optime,ChargeType,ChargeTime,TotalMoney,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2)
	              values(@sParkNo,@sVehPlate,@InOpTime,@OpTime,'临保',@sChargeTime,@iTotalMoney,@iCurrentEmptySpace,getDate(),null,null)                   
	           end
	       else--月保车
	           begin
	               update tb_CarSpaceDynamic set MonthlyRentOutPark=MonthlyRentOutPark+1--修改月保出场数量 
	               if(@UserCardType=13)
	                  begin
	                     Insert into tb_OutPark(ParkNo,VehPlate,InOptime,Optime,ChargeType,ChargeTime,TotalMoney,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2)
	                     values(@sParkNo,@sVehPlate,@InOpTime,@OpTime,'Vip',@sChargeTime,@iTotalMoney,@iCurrentEmptySpace,getDate(),null,null) 
	                  end
	               else
	                  begin 
	                     Insert into tb_OutPark(ParkNo,VehPlate,InOptime,Optime,ChargeType,ChargeTime,TotalMoney,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2)
	                     values(@sParkNo,@sVehPlate,@InOpTime,@OpTime,'月保',@sChargeTime,@iTotalMoney,@iCurrentEmptySpace,getDate(),null,null)
	                  end
	           end
	       update tb_CarSpaceDynamic set OutParkTotal=TemporaryOutPark+MonthlyRentOutPark--修改出场总数量，保持出场总数量=月保出场数量+临保出场数量
	   end


GO









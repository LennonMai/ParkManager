-->修改工班日志表（2011-08-09）
GO
alter table tb_SquadLog alter column OperatorName char(8);
GO
alter table tb_SquadLog alter column ID char(16);
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
-->浙江大学费率规则（为了数据库统一）
alter table tb_pricerule_zd add  MaxTotalFee int null default(-1) with values;
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
GO
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


--系统参数配置表数据初始化------------------------------------------------------------------------------------------------------------------
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
insert into t_park_sysparamconf values('ParkNo','101',0,'小区编号')
insert into t_park_sysparamconf values('parkReport','hg',0,'用cardInfoReport的那个校区的jsp文件，如果值为hg，就是cardInfoReprot文件夹下的hg文件夹中的jsp，初始值为hg')
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
insert into t_park_sysparamconf values('parkjsp','hg',0,'用parkCard那个校区的jsp文件，值为hg，就是用parkCard文件下的hg文件夹中的jsp。初始值为hg。')
insert into t_park_sysparamconf values('userCardInfoCardNoLength','10',0,'校园卡管理模块中限制卡号的长度（值为<=0、>=10、值不为数字时长度不能超过10，值为正整数时卡号长度只能等于其值，例如：值为9则卡号长度只能为9）')
insert into t_park_sysparamconf values('vehPlate','D:\Jpeg\',0,'为查询车道捉拍图片提供路径')
insert into t_park_sysparamconf values('CardInit_path','C:/IC卡登记程序/CardInit.exe',0,'IC卡登记程序路径，初始化设置为C:/IC卡登记程序/CardInit.exe')
insert into t_park_sysparamconf values('SWL_KEY','7#26hgrica1@62#7',0,'华工监听系统配置功能密匙，不可修改。')
insert into t_park_sysparamconf values('SWL_InputFileName','sysConfig.dll',0,'华工监听系统配置功能所监听的文件名称，不建议修改。')
GO


--缴费卡管理模块--------------------------------------------------------------------------------------
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
GO
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
  insert into tb_UserCardType values(13,'教工卡',null)
  insert into tb_UserCardType values(14,'家属卡',null)
  insert into tb_UserCardFeeRuleType values(13,0)
  insert into tb_UserCardFeeRuleType values(14,1)
  GO
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
alter table tb_userCardInfo alter column StaffNo varchar(32);
alter table tb_userCardInfo add LinkMan varchar(20);
alter table tb_userCardInfo alter column CardNo varchar(10);
alter table tb_userCardInfo alter column OBU varchar(10);
alter table tb_userCardInfo add Remark varchar(255);
exec sp_rename 'tb_userCardInfo.Phone' ,'TelePhone', 'column';
exec sp_rename 'tb_userCardInfo.UserType' ,'UserCardType', 'column';
Alter table tb_userCardInfo  drop column   RealUserType; 
------------------------------------------------------
--修改tb_UserCardInfoHistory表
Go
alter table tb_UserCardInfoHistory add VehBrand varchar(30);
alter table tb_UserCardInfoHistory alter column ParkingSpace varchar(32);
alter table tb_UserCardInfoHistory alter column StaffNo varchar(32);
alter table tb_UserCardInfoHistory add LinkMan varchar(20);
alter table tb_UserCardInfoHistory alter column CardNo varchar(10);
alter table tb_UserCardInfoHistory alter column OBU varchar(10);
alter table tb_UserCardInfoHistory add Remark varchar(255);
exec sp_rename 'tb_UserCardInfoHistory.Phone' ,'TelePhone', 'column';
exec sp_rename 'tb_UserCardInfoHistory.UserType' ,'UserCardType', 'column';
Alter table tb_UserCardInfoHistory  drop column   RealUserType; 
------------------------------------------------------
--修改tb_UserCardInfoHistory表触发器Tri_BackupModifiedData
GO
/****** Object:  Trigger [dbo].[Tri_BackupModifiedData]    Script Date: 06/13/2011 09:01:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER  trigger [dbo].[Tri_BackupModifiedData]
on [dbo].[tb_UserCardInfo]
for update, delete
as
insert into tb_UserCardInfoHistory
select RecNO,Owner,IDCard,VehPlate,ParkingSpace,OBU,RegisterTime,Status,Deposit,CardNO,UserCardType,GETDATE() as ModifyTime,FeeRuleType,RoomNo,TelePhone,PayEndTime,MobileNumber,Address,StaffNo,VehBrand,LinkMan,Remark from deleted
-------------------------------------------------------------------------------------------------
--修改tb_UserCardBill表中EndTime，就是缴费结束时间需要加一天，之前都是到月末的最后一天，而且是年月日 00:00:00,这样的话就不包括最后一天
GO
update tb_UserCardBill set EndTime=EndTime+1
GO
-------------------------------------------------------------------------------------------------
--设置tb_UserCardInfo中PayEndTime（缴费期限的值）
Go
update tb_UserCardInfo  set PayEndTime = (select EndTime from (select userRecNo,MAX(EndTime) as EndTime from tb_UserCardBill group by userRecNo) as tb_a where tb_a.UserRecNO = RecNO) where UserCardType=14 and RecNO in (select distinct userRecNo from tb_UserCardBill) 
GO
-------------------------------------------------------------------------------------------------
--修改安全用户信息密码长度
GO
alter table tb_SecurityUserInfo alter column password char(32) not null
-------------------------------------------------------------------------------------------------
--修改白名单视图（userType修改为UserCardType）
GO

/****** Object:  View [dbo].[V_WHITELIST]    Script Date: 06/15/2011 10:42:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
---白名单视图
ALTER VIEW [dbo].[V_WHITELIST] AS 
SELECT * FROM 
(
	--费用截止时间不计时分秒，所以+1天
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,
		CASE WHEN B.STARTTIME IS NULL THEN A.REGISTERTIME ELSE B.STARTTIME END AS FIRTIME, 
		CASE WHEN B.ENDTIME IS NULL THEN A.REGISTERTIME ELSE B.ENDTIME+1 END AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, 
		CASE WHEN A.STATUS=0 AND (B.ENDTIME IS NULL OR B.ENDTIME<CONVERT(CHAR(10),GETDATE(),120)) THEN 9 ELSE A.STATUS END AS STATUS,
		CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
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
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,GETDATE()-30 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, A.STATUS, CASE WHEN A.VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO A
	WHERE A.UserCardType=13	--业主卡
	union all 
	SELECT CARDNO, VEHPLATE, OWNERName , OBUID, GETDATE()-30 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
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
GO
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
------------------------------------------------------------------------------------------------------------
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
--创建删除tb_InList（01-12）流水表信息的存储过程PROC_DeleteInList
Go
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_DeleteInList]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[PROC_DeleteInList]

GO
/****** Object:  StoredProcedure [dbo].[PROC_DeleteInList]    Script Date: 05/17/2011 17:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



create   PROCEDURE [dbo].[PROC_DeleteInList]
AS
declare @Months             tinyint --当前系统的月份
declare @Time               dateTime --当前系统时间
declare @TimeYM             varchar(10)--当前系统的时间的年-月
declare @FirstTimeS         varchar(10)--当前系统的时间月份的第一天时间（字符串型）
declare @FirstTimeDate      varchar(10)--当前系统的时间月份的第一天时间（dateTime型）
declare @MaxSquadDate       dateTime--最大工班日期
declare @SquadDateCorrow    dateTime--最大工班日期加1年减1个月后的日期
declare @SquadDateCorrowYM   varchar(10)--最大工班日期加1年减1个月后的日期的年-月

select @Time = CONVERT(dateTime,getDate(),121)
select @Months = SUBSTRING (CONVERT(varchar,@Time,101),1,2)
select @TimeYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@Time))+'-'+CONVERT(varchar(4),month(@Time))),120)
select @FirstTimeS = CONVERT(varchar(10),(CONVERT(varchar(4),year(@Time))+'-'+CONVERT(varchar(4),month(@Time))+'-1'),120)
select @FirstTimeDate = CONVERT(dateTime,@FirstTimeS,120)

if @Months = 1
  begin
    if exists(select * from tb_InList01) 
       begin
         if exists(select * from tb_InList01 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList02
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList02
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList02中的数据',@Time,'tb_InList02')
               end
           end
        end
  end    
if @Months = 2
  begin
    if exists(select * from tb_InList02) 
       begin
         if exists(select * from tb_InList02 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList03
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList03
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList03中的数据',@Time,'tb_InList03')
               end
            end
         end
     end  
if @Months = 3
  begin
    if exists(select * from tb_InList03) 
       begin
         if exists(select * from tb_InList03 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList04
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList04
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList04中的数据',@Time,'tb_InList04')
               end
            end
         end
     end 
if @Months = 4
  begin
    if exists(select * from tb_InList04) 
       begin
         if exists(select * from tb_InList04 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList05
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList05
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList05中的数据',@Time,'tb_InList05')
               end
            end
         end
     end  
if @Months = 5
  begin
    if exists(select * from tb_InList05) 
       begin
         if exists(select * from tb_InList05 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList06
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList06
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList06中的数据',@Time,'tb_InList06')
               end
            end
         end
     end  
if @Months = 6
  begin
    if exists(select * from tb_InList06) 
       begin
         if exists(select * from tb_InList06 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList07
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList07
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList07中的数据',@Time,'tb_InList07')
               end
            end
         end
     end  
if @Months = 7
  begin
    if exists(select * from tb_InList07) 
       begin
         if exists(select * from tb_InList07 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList08
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList08
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList08中的数据',@Time,'tb_InList08')
               end
            end
         end
     end 
if @Months = 8
  begin
    if exists(select * from tb_InList08) 
       begin
         if exists(select * from tb_InList08 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList09
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList09
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList09中的数据',@Time,'tb_InList09')
               end
            end
         end
     end
if @Months = 9
  begin
    if exists(select * from tb_InList09) 
       begin
         if exists(select * from tb_InList09 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList10
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList10
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList10中的数据',@Time,'tb_InList10')
               end
            end
         end
     end   
if @Months = 10
  begin
    if exists(select * from tb_InList10) 
       begin
         if exists(select * from tb_InList10 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList11
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList11
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList11中的数据',@Time,'tb_InList11')
               end
            end
         end
     end 
if @Months = 11
  begin
    if exists(select * from tb_InList11) 
       begin
         if exists(select * from tb_InList11 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList12
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList12
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList12中的数据',@Time,'tb_InList12')
               end
            end
         end
     end 
if @Months = 12
  begin
    if exists(select * from tb_InList12) 
       begin
         if exists(select * from tb_InList12 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_InList01
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_InList01
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList01中的数据',@Time,'tb_InList01')
               end
            end
         end
     end    
     Go
-------------------------------------------------------------------------------------------------  
--创建删除tb_OutList（01-12）流水表信息的存储过程PROC_DeleteOutList
Go
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_DeleteOutList]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[PROC_DeleteOutList]

GO
/****** Object:  StoredProcedure [dbo].[PROC_DeleteInList]    Script Date: 05/17/2011 17:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



create   PROCEDURE [dbo].[PROC_DeleteOutList]
AS
declare @Months             tinyint --当前系统的月份
declare @Time               dateTime --当前系统时间
declare @TimeYM             varchar(10)--当前系统的时间的年-月
declare @FirstTimeS         varchar(10)--当前系统的时间月份的第一天时间（字符串型）
declare @FirstTimeDate      varchar(10)--当前系统的时间月份的第一天时间（dateTime型）
declare @MaxSquadDate       dateTime--最大工班日期
declare @SquadDateCorrow    dateTime--最大工班日期加1年减1个月后的日期
declare @SquadDateCorrowYM   varchar(10)--最大工班日期加1年减1个月后的日期的年-月

select @Time = CONVERT(dateTime,getDate(),121)
select @Months = SUBSTRING (CONVERT(varchar,@Time,101),1,2)
select @TimeYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@Time))+'-'+CONVERT(varchar(4),month(@Time))),120)
select @FirstTimeS = CONVERT(varchar(10),(CONVERT(varchar(4),year(@Time))+'-'+CONVERT(varchar(4),month(@Time))+'-1'),120)
select @FirstTimeDate = CONVERT(dateTime,@FirstTimeS,120)

if @Months = 1
  begin
    if exists(select * from tb_OutList01) 
       begin
         if exists(select * from tb_OutList01 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList02
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList02
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList02中的数据',@Time,'tb_OutList02')
               end
           end
        end
  end    
if @Months = 2
  begin
    if exists(select * from tb_OutList02) 
       begin
         if exists(select * from tb_OutList02 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList03
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList03
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList03中的数据',@Time,'tb_OutList03')
               end
            end
         end
     end  
if @Months = 3
  begin
    if exists(select * from tb_OutList03) 
       begin
         if exists(select * from tb_OutList03 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList04
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList04
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList04中的数据',@Time,'tb_OutList04')
               end
            end
         end
     end 
if @Months = 4
  begin
    if exists(select * from tb_OutList04) 
       begin
         if exists(select * from tb_OutList04 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList05
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList05
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList05中的数据',@Time,'tb_OutList05')
               end
            end
         end
     end  
if @Months = 5
  begin
    if exists(select * from tb_OutList05) 
       begin
         if exists(select * from tb_OutList05 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList06
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList06
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList06中的数据',@Time,'tb_OutList06')
               end
            end
         end
     end  
if @Months = 6
  begin
    if exists(select * from tb_OutList06) 
       begin
         if exists(select * from tb_OutList06 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList07
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList07
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList07中的数据',@Time,'tb_OutList07')
               end
            end
         end
     end  
if @Months = 7
  begin
    if exists(select * from tb_OutList07) 
       begin
         if exists(select * from tb_OutList07 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList08
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList08
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList08中的数据',@Time,'tb_OutList08')
               end
            end
         end
     end 
if @Months = 8
  begin
    if exists(select * from tb_OutList08) 
       begin
         if exists(select * from tb_OutList08 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList09
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList09
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList09中的数据',@Time,'tb_OutList09')
               end
            end
         end
     end
if @Months = 9
  begin
    if exists(select * from tb_OutList09) 
       begin
         if exists(select * from tb_OutList09 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList10
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList10
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList10中的数据',@Time,'tb_OutList10')
               end
            end
         end
     end   
if @Months = 10
  begin
    if exists(select * from tb_OutList10) 
       begin
         if exists(select * from tb_OutList10 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList11
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList11
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList11中的数据',@Time,'tb_OutList11')
               end
            end
         end
     end 
if @Months = 11
  begin
    if exists(select * from tb_OutList11) 
       begin
         if exists(select * from tb_OutList11 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList12
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList12
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList12中的数据',@Time,'tb_OutList12')
               end
            end
         end
     end 
if @Months = 12
  begin
    if exists(select * from tb_OutList12) 
       begin
         if exists(select * from tb_OutList12 where SquadDate >= @FirstTimeDate and SquadDate <=@Time)
           begin
             select @MaxSquadDate = MAX(SquadDate) from tb_OutList01
             select @SquadDateCorrow = DATEADD(MONTh,-1,@MaxSquadDate)--减一个月
             select @SquadDateCorrow = DATEADD(YEAR,1,@SquadDateCorrow)--加一年
             select @SquadDateCorrowYM = CONVERT(varchar(10),(CONVERT(varchar(4),year(@SquadDateCorrow))+'-'+CONVERT(varchar(4),month(@SquadDateCorrow))),120)
             if @SquadDateCorrowYM=@TimeYM
               begin 
                 delete from tb_OutList01
                 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList01中的数据',@Time,'tb_OutList01')
               end
            end
         end
     end     
GO	 
-------------------------------------------------------------------------------------------------
--建立调用存储过程PROC_DeleteInList和PROC_DeleteOutList进行删除流水的作业DeleteOutListAndInList
Go
IF EXISTS(SELECT * FROM msdb.dbo.sysjobs WHERE name=N'DeleteOutListAndInList')
EXEC msdb.dbo.sp_delete_job @job_name=N'DeleteOutListAndInList'

GO

/****** Object:  Job [DeleteOutListAndInList]    Script Date: 05/18/2011 09:10:21 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 05/18/2011 09:10:21 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DeleteOutListAndInList', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'无描述。', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [delete]    Script Date: 05/18/2011 09:10:21 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'delete', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC PROC_DeleteOutList
EXEC PROC_DeleteInList', 
		@database_name=N'parkdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'deteleTime', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=15, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20110518, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'22585441-db79-403e-9639-1e270702bdfc'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO
-------------------------------------------------------------------------------------------------
/****** 对象:  用户定义的存储过程 Proc_DeleteCardDynamicByTicketType  ************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_DeleteCardDynamicByTicketType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_DeleteCardDynamicByTicketType]
GO
--删除外来车
CREATE proc [dbo].[Proc_DeleteCardDynamicByTicketType]
as
delete from tb_CardDynamic where TicketType=5 or TicketType=6
GO
---------------------------------------------------------------------------------------------------
--建立调用存储过程Proc_DeleteCardDynamicByTicketType外来车的作业deleteCardDynamic,每三个月删除一次
Go
IF EXISTS(SELECT * FROM msdb.dbo.sysjobs WHERE name=N'deleteCardDynamic')
EXEC msdb.dbo.sp_delete_job @job_name=N'deleteCardDynamic'

GO
/****** Object:  Job [deleteCardDynamic]    Script Date: 07/26/2011 15:14:23 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 07/26/2011 15:14:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'deleteCardDynamic', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'无描述。', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [delete]    Script Date: 07/26/2011 15:14:23 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'delete', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC Proc_DeleteCardDynamicByTicketType', 
		@database_name=N'parkdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'3个月执行一次', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=3, 
		@active_start_date=20110726, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'95dd31e6-750e-4f28-85d3-257db9824e0f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

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



--入口流水查询，流水号（车道根据流水号查询入口）
/*--从 流水表中查
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


	set @iMonth = month(getdate()+1)
	set @iCount = 0
	set @iRecord = 1

	while(@iCount<12 and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01 where listno=@ListNo order by optime desc
		else if(@iMonth=2)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02 where listno=@ListNo order by optime desc
		else if(@iMonth=3)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03 where listno=@ListNo order by optime desc
		else if(@iMonth=4)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04 where listno=@ListNo order by optime desc
		else if(@iMonth=5)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05 where listno=@ListNo order by optime desc
		else if(@iMonth=6)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06 where listno=@ListNo order by optime desc
		else if(@iMonth=7)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07 where listno=@ListNo order by optime desc
		else if(@iMonth=8)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08 where listno=@ListNo order by optime desc
		else if(@iMonth=9)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09 where listno=@ListNo order by optime desc
		else if(@iMonth=10)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10 where listno=@ListNo order by optime desc
		else if(@iMonth=11)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11 where listno=@ListNo order by optime desc
		else if(@iMonth=12)
			insert @t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12 where listno=@ListNo order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

	update @t_list set flg=1 from @t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update @t_list set flg=1 from @t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime
	select * from @t_list order by optime desc

end
GO
*/
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
--------------------------------------华工初始华系统参数sql--------------------------------------------------
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
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'华工黑名单车辆','tb_SpecialVeh','CardInfo',0,1)
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

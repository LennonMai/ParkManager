use [parkdb]
----------------------------------------------------------------删除触发器------------------------------------------------------
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_AccountTrade]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_AccountTrade]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_CardDynamicToLoseCard]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_CardDynamicToLoseCard]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_YCTInListSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_YCTInListSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_InlistStat]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_InlistStat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_InlistSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_InlistSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_OutlistSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_OutlistSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_YCTOutListSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_YCTOutListSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_OutlistStat]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_OutlistStat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_PlateToObuId]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_PlateToObuId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_UserVehPlate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_UserVehPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_SecurityCommandDelete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_SecurityCommandDelete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_SecurityCommandInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_SecurityCommandInsert]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_SecurityCommandUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_SecurityCommandUpdate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_SpVehMonitor]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_SpVehMonitor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tri_ToYZList_Tmp]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tri_ToYZList_Tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tri_BackupModifiedData]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tri_BackupModifiedData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tri_SetSendPara]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tri_SetSendPara]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tri_SetUsercardbill]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tri_SetUsercardbill]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_VehFreeTimesSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_VehFreeTimesSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_CarCountIff]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_CarCountIff]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_CarCountAdd]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_CarCountAdd]
GO
--后来接口项目需要添加的触发器（2011-10-14），就是上传数据给政府用
----------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_InlistCarSpaceDynamicAndInPark]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_InlistCarSpaceDynamicAndInPark]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]
GO
---------------------------------------------------------------
--车道设备监控
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_systemStatusInserted]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_systemStatusInserted]
Go

-----------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_SendAccountCard]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_SendAccountCard]
Go

-----------------------------------------------建立触发器----------------------------------------------------------------------------------
GO

/****** Object:  Trigger [dbo].[Tr_AccountTrade]    Script Date: 10/13/2011 15:34:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
   CREATE TRIGGER [dbo].[Tr_AccountTrade] 
    ON  [dbo].[tb_AccountTrade] 
   instead of insert
   
AS 

   declare @Months                           tinyint
   declare @SeqNo                            int
   declare @TradeType                        int
   declare @AccountNo                        int 
   declare @BackoutedListNo                  varchar(30) 
   declare @ListNo                           varchar(30)
   declare @ParkNo                           int
   declare @VehPlate                         varchar(10)
   declare @CardNo                           varchar(30)
   declare @Balance                          int

select  @Months=DATEPART(month,convert(datetime,OpTime)),@TradeType=tradeType,@ListNo=listNo,@BackoutedListNo=backoutedListNo,@AccountNo=accountNo ,@SeqNo=seqNo,@CardNo=cardNo,@Balance=balance from inserted
if @Months is null
select @Months=DATEPART(month,convert(datetime,tradeTime)) from inserted
if @Months=1
  Begin
   if not exists(select * from tb_AccountTrade01 where listNo=@ListNo)--流水号不存在时（防止站入库程序重新上传）
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade01 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo --保证tb_AccountTrade中保持不是冲正/充值的流水最多只能一条，而且seqNo是最大的那条（充值/冲正的流水保存tb_AccountTrade表也保存在12表中的其中一个）
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo--更新t_park_account中的余额
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
   end
    
    
else if @Months=2
  Begin
   if not exists(select * from tb_AccountTrade02 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade02 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end

else if @Months=3
  Begin
   if not exists(select * from tb_AccountTrade03 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade03 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end
    
else if @Months=4
   Begin
   if not exists(select * from tb_AccountTrade04 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade04 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end

else if @Months=5
  Begin
   if not exists(select * from tb_AccountTrade05 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade05 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end

else if @Months=6
  Begin
   if not exists(select * from tb_AccountTrade06 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade06 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end
    
else if @Months=7
  Begin
   if not exists(select * from tb_AccountTrade07 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade07 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end
    
else if @Months=8
  Begin
   if not exists(select * from tb_AccountTrade08 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade08 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end
    
else if @Months=9
  Begin
   if not exists(select * from tb_AccountTrade09 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade09 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end
    
else if @Months=10
  Begin
   if not exists(select * from tb_AccountTrade10 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade10 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end
    
else if @Months=11
  Begin
   if not exists(select * from tb_AccountTrade11 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade11 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end
    
else if @Months=12
  Begin
   if not exists(select * from tb_AccountTrade12 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade12 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--卡号不存在或者已销户
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--插入异常流水表
     end
  end

GO

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  trigger [dbo].[Tr_CardDynamicToLoseCard] 
		on [dbo].[tb_CardDynamic]
		for insert
as
begin
    --tb_LoseCardHis属性
    declare @iParkNo            smallint
    declare @iGateNo            smallint
    declare @iLaneNo            smallint
	declare @sVehPlate          varchar(10)
	declare @sCardNo            varchar(10)
	declare @iStatus            smallint
	declare @dOpTime            datetime
	declare @iOperatorNo	    int
	declare @sOperatorname      varchar(8)
	declare @dSquadDate         date
	declare @sInListNo          varchar(16)
	declare @sOwner             varchar(32)
	
	--tb_CardDynamic插入的属性值
	declare @iIParkNo            smallint
    declare @iIGateNo            smallint
    declare @iILaneNo            smallint
	declare @sIVehPlate          varchar(10)
	declare @sICardNo            varchar(10)
	declare @iIStatus            smallint
	declare @dIOpTime            datetime
	declare @iIOperatorNo	     int
	declare @sIOperatorname      varchar(8)
	declare @dISquadDate         date
	declare @sIInListNo          varchar(16)
	declare @sIOutListNo         varchar(16)
	declare @sIOwner             varchar(32)
	select @sICardNo=CardNo,@dIOpTime=OpTime,@iIParkNo=ParkNo,@iIGateNo=GateNo,@iILaneNo=LaneNo,@sIVehPlate=VehPlate,@iIOperatorNo=OperatorNo,@sIOperatorname=Operatorname,@dISquadDate=SquadDate,@sIInListNo=inListNo,@sIOutListNo=OutListNo,@sIOwner=Owner,@iIStatus=Status from inserted
	if(@iIStatus=13)--上来的流水中卡状态就是13：丢卡（车道按"丢卡"按钮）
		begin
			delete from tb_LoseCardHis where CardNo=@sICardNo and OpTime=@dIOpTime
			insert into tb_LoseCardHis(CardNo,OpTime,ParkNo,GateNo,LaneNo,VehPlate,OperatorNo,OperatorName,SquadDate,ListNo,Owner,OutListNo,OutParkNo,OutGateNo,OutLaneNo,OutOpTime,OutSquadDate,OutRemark,OutOperatorNo,OutOperatorName,CardStatus)
			values('0',@dIOpTime,0,0,0,'0',0,'0',getDate(),@sIInListNo,'0',@sIOutListNo,@iIParkNo,@iIGateNo,@iILaneNo,@dIOpTime,@dISquadDate,'车道操作员设置为丢卡',@iIOperatorNo,@sIOperatorname,13) 	
			delete from tb_SendPara where tablename='V_LoseCardList'
			insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_LoseCardList','V_LoseCardList' from tb_LaneUse
		end
	else
		begin
			if exists(select * from tb_CardDynamic where VehPlate=@sIVehPlate and CardNo!=@sICardNo and status=11 and UserCardType=0 and VehPlate!='0')--存在临时卡入口发出，车牌号相等，卡号不相等
				begin 
					select @sCardNo=CardNo,@dOpTime=OpTime,@iParkNo=ParkNo,@iGateNo=GateNo,@iLaneNo=LaneNo,@sVehPlate=VehPlate,@iOperatorNo=OperatorNo,@sOperatorname=Operatorname,@dSquadDate=SquadDate,@sInListNo=inListNo,@sOwner=Owner,@iStatus=Status from tb_CardDynamic where VehPlate=@sIVehPlate and CardNo!=@sICardNo and status=11 and UserCardType=0 and VehPlate!='0'
					update tb_CardDynamic set status=13 where  VehPlate=@sIVehPlate and CardNo!=@sICardNo and status=11 and UserCardType=0 and VehPlate!='0'--UserCardType等于0表示为使用临时卡，status状态为“11：入口发出”，车牌号相等而卡号不相等是设置状态为“13：丢卡”		
					if(@iIStatus=11)--11:入口发出，如果插入的数据为入口流水信息,如果出场时车牌识别不准确时会发生入口时才查找到车牌
					begin
						delete from tb_LoseCardHis where CardNo=@SCardNo and OpTime=@dIOpTime
						insert into tb_LoseCardHis(CardNo,OpTime,ParkNo,GateNo,LaneNo,VehPlate,OperatorNo,OperatorName,SquadDate,ListNo,Owner,OutListNo,OutParkNo,OutGateNo,OutLaneNo,OutOpTime,OutSquadDate,OutRemark,OutOperatorNo,OutOperatorName,CardStatus)
						values(@sCardNo,@dOpTime,@iParkNo,@iGateNo,@iLaneNo,@sVehPlate,@iOperatorNo,@sOperatorname,@dSquadDate,@sInListNo,@sOwner,'0',0,0,0,null,null,'该车已出但卡没回收',0,'0',13) 
					end
					if(@iIStatus=12)--12:出口回收，如果插入的数据为出口流水信息
					begin
						delete from tb_LoseCardHis where CardNo=@SCardNo and OpTime=@dIOpTime
						insert into tb_LoseCardHis(CardNo,OpTime,ParkNo,GateNo,LaneNo,VehPlate,OperatorNo,OperatorName,SquadDate,ListNo,Owner,OutListNo,OutParkNo,OutGateNo,OutLaneNo,OutOpTime,OutSquadDate,OutRemark,OutOperatorNo,OutOperatorName,CardStatus)
						values(@sCardNo,@dOpTime,@iParkNo,@iGateNo,@iLaneNo,@sVehPlate,@iOperatorNo,@sOperatorname,@dSquadDate,@sInListNo,@sOwner,@sIOutListNo,@iIParkNo,@iIGateNo,@iILaneNo,@dIOpTime,@dISquadDate,'该车已出但卡没回收',@iIOperatorNo,@sIOperatorname,13) 
					end
					delete from tb_SendPara where tablename='V_LoseCardList'
					insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_LoseCardList','V_LoseCardList' from tb_LaneUse
				 end
		end
	
	
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER [dbo].[Tr_YCTInListSplit]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create Trigger Tr_InlistStat
	on tb_InList_Tmp
	for insert
As
	declare @AreaNo				smallint     
	declare @ParkNo				smallint     
	declare @GateNo				smallint     
	declare @LaneNo				smallint     
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
	
	
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
		@UserCardType=UserCardType,
		@VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,
		@OperatorNo=OperatorNo,@OperatorName=OperatorName,@OpTime=OpTime 
	from inserted
	
	--生成报表统计数据
	update tb_InListSum                         
		set VehCountSum=VehCountSum+@VehCount,StatTime=@OpTime  
		where AreaNo=@AreaNo and ParkNo=@ParkNo and GateNo=@GateNo and LaneNo=@LaneNo and VehType=@VehType and VehClass=@VehClass and 
			TicketType=@TicketType and UserCardType=@UserCardType and SquadDate=@SquadDate and SquadNo=@SquadNo and 
			OperatorNo=@OperatorNo and OperatorName=@OperatorName
    
    if @@ROWCOUNT = 0
    Begin   
		insert into tb_InListSum(AreaNo,ParkNo,GateNo,LaneNo,VehType,VehClass,TicketType,UserCardType,VehCountSum,
				SquadDate,SquadNo,OperatorNo,OperatorName,StatTime)
			values(@AreaNo,@ParkNo,@GateNo,@LaneNo,@VehType,@VehClass,@TicketType,@UserCardType,@VehCount,
				@SquadDate,@SquadNo,@OperatorNo,@OperatorName,@OpTime)
    End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--将入口流水表的数据分表存储
CREATE Trigger [dbo].[Tr_InlistSplit]
	on [dbo].[tb_InList_Tmp]
	for insert
As
	declare @Months						tinyint
	declare @sCardNo						varchar(10)

	--根据工班日期，分别存储流水数据
	select @Months=DATEPART(month,SquadDate),@sCardNo=CardNo from inserted
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
		--判断卡动态表中的操作时间小于上传流水的操作时间		
		if exists (select t1.cardno from tb_CardDynamic t1, inserted t2 where  t1.cardno=t2.cardno and t1.optime<t2.optime)
		begin
			delete from tb_CardDynamic where cardno=@sCardNo
			insert into tb_CardDynamic select CardNo, 11, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
			OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,ListNo,' ',' ', TicKetType,GateName
			from inserted t1
			where t1.CardNo>0
		end
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
GO

-------------------------------------------------------------------------------------------------
--修改(tb_OutList_Tmp)中触发器Tr_OutlistSplit


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--将出口流水表的数据分表存储
CREATE Trigger [dbo].[Tr_OutlistSplit]
	on [dbo].[tb_OutList_Tmp]
	for insert
As
	declare @Months						tinyint
	declare @sCardNo						varchar(10)
	declare @iSpevent					int

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
  	
  	select @iSpevent=spevent,@sCardNo=cardNo from inserted
  	
	--修改tb_CardDynamic表记录，cardNo>0的数据才操作（使用卡过车的情况）
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
				where t1.cardno=t2.cardno and t2.CardNo>0)
	begin
		--判断卡动态表中的操作时间小于上传流水的操作时间		
		if exists (select t1.cardno from tb_CardDynamic t1, inserted t2 where  t1.cardno=t2.cardno and t1.optime<t2.optime)
		begin
			delete from tb_CardDynamic where cardno=@sCardNo
			--如果流水记录的特殊事件有"丢卡"(第8位), 修改tb_CardDynamic中临时卡的状态为"丢卡"(13)
			if(@iSpevent&0x00000080<>0)
			begin
				insert into tb_CardDynamic select CardNo, 13, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end
			--如果流水记录的特殊事件有"坏卡"(第9位), 修改tb_CardDynamic中临时卡的状态为"坏卡"(15)
			else if(@iSpevent&0x00000100<>0)
			begin
				insert into tb_CardDynamic select CardNo, 15, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end
			--正常出口回收, 修改tb_CardDynamic中临时卡的状态为"出口回收"(12)
			else
			begin
				insert into tb_CardDynamic select CardNo, 12, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end		
		end
	end
	else
	--使用新卡片或者行人、自行车之类的无卡片情况
	begin
		delete from tb_CardDynamic where cardno=@sCardNo
		--如果流水记录的特殊事件有"丢卡"(第8位), 修改tb_CardDynamic中临时卡的状态为"丢卡"(13)
		if(@iSpevent&0x00000080<>0)
			begin
				insert into tb_CardDynamic select CardNo, 13, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end
		--如果流水记录的特殊事件有"坏卡"(第9位), 修改tb_CardDynamic中临时卡的状态为"坏卡"(15)
		else if(@iSpevent&0x00000100<>0)
			begin
				insert into tb_CardDynamic select CardNo, 15, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end
		--正常出口回收, 修改tb_CardDynamic中临时卡的状态为"出口回收"(12)
		else
			begin
				insert into tb_CardDynamic select CardNo, 12, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end		
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
GO
---------------------一户多车----------------------------------------------------------------------------
 --判断表tb_CardGroup是否存在，不存在时则创建

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER [dbo].[Tr_YCTOutListSplit]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create Trigger Tr_OutlistStat
	on tb_OutList_Tmp
	for insert
As
	declare @AreaNo				smallint     
	declare @ParkNo				smallint     
	declare @GateNo				smallint     
	declare @LaneNo				smallint     
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
	
	
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
		@UserCardType=UserCardType,@CheckType=CheckType,
		@VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,
		@CashMoney=CashMoney,@FreeMoney=FreeMoney,@UnpayMoney=UnpayMoney,@ETCMoney=ETCMoney,@OpTime=OpTime 
	from inserted
	
	--生成报表统计数据
	update tb_OutListSum                         
		set VehCountSum=VehCountSum+@VehCount,CashMoneySum=CashMoneySum+@CashMoney,FreeMoneySum=FreeMoneySum+@FreeMoney,
			UnpayMoneySum=UnpayMoneySum+@UnpayMoney,ETCMoneySum=ETCMoneySum+@ETCMoney,StatTime=@OpTime  
		where AreaNo=@AreaNo and ParkNo=@ParkNo and GateNo=@GateNo and LaneNo=@LaneNo and VehType=@VehType and VehClass=@VehClass and 
			TicketType=@TicketType and UserCardType=@UserCardType and CheckType=@CheckType and SquadDate=@SquadDate and SquadNo=@SquadNo and 
			OperatorNo=@OperatorNo and OperatorName=@OperatorName
    
    if @@ROWCOUNT = 0
    Begin   
		insert into tb_OutListSum(AreaNo,ParkNo,GateNo,LaneNo,VehType,VehClass,TicketType,UserCardType,CheckType,VehCountSum,
				SquadDate,SquadNo,OperatorNo,OperatorName,CashMoneySum,FreeMoneySum,UnpayMoneySum,ETCMoneySum,StatTime)
			values(@AreaNo,@ParkNo,@GateNo,@LaneNo,@VehType,@VehClass,@TicketType,@UserCardType,@CheckType,@VehCount,
				@SquadDate,@SquadNo,@OperatorNo,@OperatorName,@CashMoney,@FreeMoney,@UnpayMoney,@ETCMoney,@OpTime)
    End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--将tb_CardUserInfo对应的车牌的OBUid更新
Create Trigger Tr_PlateToObuId
	on tb_PlateToObuId
	for insert
As
	update tb_UserCardInfo 
	set OBU=t2.ObuId
	from tb_UserCardInfo t1, inserted t2
	where t1.VehPlate=t2.VehPlate
  
  	delete from tb_PlateToObuId
  

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


--更新车道上传的白名单车牌图片
create Trigger tr_UserVehPlate 
on tb_PlateToPic
INSTEAD OF INSERT
AS
BEGIN
	if exists (select * from tb_usercardinfo where vehplate in (select vehplate from inserted))
		update tb_UserCardInfo 
		set VehPlateImage=t2.Picture
		from tb_UserCardInfo t1, inserted t2
		where t1.VehPlate=t2.VehPlate
		
	if exists (select * from tb_testwl where vehplate in (select vehplate from inserted))
		update tb_testwl 
		set VehPlateImage=t2.Picture
		from tb_testwl t1, inserted t2
		where t1.VehPlate=t2.VehPlate
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE trigger [dbo].[Tr_SecurityCommandDelete]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE trigger 	[dbo].[Tr_SecurityCommandInsert]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE trigger 	[dbo].[Tr_SecurityCommandUpdate]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER tr_SpVehMonitor
ON tb_SpVehMonitor
FOR UPDATE
AS
	INSERT INTO tb_SpVehMonitorLog 
		SELECT AreaNo, ParkNo, GateNo, LaneNo, VehPlate, CardNo, Operation, OpTime, GETDATE()  
		FROM tb_SpVehMonitor
		WHERE IsRead = 1
	DELETE FROM tb_SpVehMonitor
	WHERE IsRead = 1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create Trigger Tri_ToYZList_Tmp 
on tb_ToYZList_Tmp
for insert
as

	--Begin TRANSACTION

	insert into tb_YZList_Tmp
	select CardNo, VehPlate, OwnerName, ObuId, Getdate()-1,  Getdate()+60, 14, 0
	from inserted t1

	--commit

	delete from tb_ToYZList_Tmp


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE  trigger [dbo].[Tri_BackupModifiedData]
on [dbo].[tb_UserCardInfo]
for update, delete
as
insert into tb_UserCardInfoHistory
select RecNO,Owner,IDCard,VehPlate,ParkingSpace,OBU,RegisterTime,Status,Deposit,CardNO,UserCardType,GETDATE() as ModifyTime,FeeRuleType,RoomNo,TelePhone,PayEndTime,MobileNumber,Address,StaffNo,VehBrand,LinkMan,Remark from deleted
-------------------------------------------------------------------------------------------------
--修改tb_UserCardBill表中EndTime，就是缴费结束时间需要加一天，之前都是到月末的最后一天，而且是年月日 00:00:00,这样的话就不包括最后一天

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE Trigger [dbo].[Tri_SetSendPara] 
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create   Trigger Tri_SetUsercardbill
on dbo.tb_UserCardInfo 
for delete
as
	begin
		delete from tb_usercardbill
		where userRecno in (select recno from deleted)
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
CREATE trigger [dbo].[Tr_CarCountAdd]
on [dbo].[tb_InList_Tmp]
for insert
as
declare @iParkNo            smallint
declare @sGateNo            varchar(10)
declare @iCardNo			int 
declare @iUserCardType      int
select @iParkNo=ParkNo,@sGateNo=GateNo,@iCardNo=CardNo,@iUserCardType=UserCardType from inserted
if(@iCardNo!=0 and @iUserCardType=0)--临时车才算车位
begin
	if exists(select * from tb_CarSpace where ParkNo=@iParkNo and GateNo=@sGateNo)
		begin
			 update tb_CarSpace set CarCount = CarCount +1,ModifyTime = getdate() where ParkNo=@iParkNo and GateNo=@sGateNo and MaxSpace>CarCount
		end
	else
		begin
			 update tb_CarSpace set CarCount = CarCount +1,ModifyTime = getdate() where ParkNo=@iParkNo and GateNo='all' and MaxSpace>CarCount
		end
  delete from tb_SendPara where tablename='v_ShowInfo'
  insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_ShowInfo','v_ShowInfo' from tb_LaneUse
end


GO
exec sp_settriggerorder @triggername ='Tr_CarCountAdd',
                        @order = 'first',
                        @stmttype = 'insert',
                        @namespace = null
GO
GO
create trigger [dbo].[Tr_CarCountIff]
on [dbo].[tb_OutList_Tmp]
for insert
as
declare @iParkNo            smallint
declare @sGateNo            varchar(10)
declare @iCardNo			int 
declare @iUserCardType      int
select @iParkNo=ParkNo,@sGateNo=GateNo,@iCardNo=CardNo,@iUserCardType=UserCardType from inserted
if(@iCardNo!=0 and @iUserCardType=0)--临时车才算车位
begin
	if exists(select * from tb_CarSpace where ParkNo=@iParkNo and GateNo=@sGateNo)
		begin
			 update tb_CarSpace set CarCount = CarCount -1,ModifyTime = getdate() where ParkNo=@iParkNo and GateNo=@sGateNo and CarCount>0
		end
	else
		begin
			 update tb_CarSpace set CarCount = CarCount -1,ModifyTime = getdate() where ParkNo=@iParkNo and GateNo='all' and CarCount>0
		end
  delete from tb_SendPara where tablename='v_ShowInfo'
  insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_ShowInfo','v_ShowInfo' from tb_LaneUse
end

GO
exec sp_settriggerorder @triggername ='Tr_CarCountIff',
                        @order = 'first',
                        @stmttype = 'insert',
                        @namespace = null
GO

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Trigger [dbo].[Tr_InlistCarSpaceDynamicAndInPark]--修改车位动态信息和插入信息到进入停车场信息表（tb_InPark）中（上传给政府用）
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
	declare @iCardNo			int 
			
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@sVehPlate=VehPlate,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
	@UserCardType=UserCardType,@VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,@OpTime=OpTime,@iCardNo=CardNo
	from inserted
	if(@iCardNo!=0)
	begin
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
			   insert into tb_InPark(ParkNo,VehPlate,InOptime,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2)
			   values(@sParkNo,@sVehPlate,@OpTime,@iCurrentEmptySpace,getDate(),null,null)	          
		   end
	   end

GO

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Trigger [dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]--修改车位动态信息和插入信息到出入停车场信息表（tb_OutPark）中（上传给政府用）
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
	declare @iCardNo			int 
	
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
		   @UserCardType=UserCardType,@CheckType=CheckType,@InOpTime=InOpTime,@sVehPlate=VehPlate,
		   @VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,
		   @CashMoney=CashMoney,@FreeMoney=FreeMoney,@UnpayMoney=UnpayMoney,@ETCMoney=ETCMoney,@OpTime=OpTime,@iCardNo=CardNo 
	from inserted
	if(@iCardNo!=0)
	begin
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
				if(@iDay>99)
					begin
					   set @sDay='99'
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
				set  @sChargeTime=@sDay+':'+@sHour+':'+@sMinute
		            
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
	   end

GO
Go
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [dbo].[Tr_SendAccountCard]
on [dbo].[t_park_account]
for update
as
delete from tb_SendPara where tablename='tb_AccountCard'
insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'tb_AccountCard','tb_AccountCard' from tb_LaneUse
GO

--车道设备监控触发器
GO

/****** Object:  Trigger [dbo].[Tr_systemStatusInserted]    Script Date: 01/05/2012 15:03:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE Trigger [dbo].[Tr_systemStatusInserted] 
	on [dbo].[tb_SystemEventLog] for insert
	as 
	Begin
	 declare @iStatus smallint
	 declare @dOccurTime dateTime
	 select @iStatus = DeviceErrorNo,@dOccurTime = OccurTime from inserted;
	if not exists (select * from tb_SystemStatus where stationId in (select stationId from inserted) and RoadNum in (select RoadNum from inserted) and DeviceNo in (select DeviceNo from inserted))
		insert into tb_SystemStatus(stationId,RoadNum,DeviceNo,SystemTypeNo,Status,OccurTime) select stationId,RoadNum,DeviceNo,0,DeviceErrorNo,OccurTime from inserted;
	else
		update tb_SystemStatus set status = @iStatus,OccurTime = @dOccurTime where stationId in (select stationId from inserted) and RoadNum in (select RoadNum from inserted) and DeviceNo in (select DeviceNo from inserted)
	End
	
GO
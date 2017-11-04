create Trigger [dbo].[Tr_InlistSplit]
	on [dbo].[tb_InList_Tmp]
	for insert
As
	if exists (select t1.IDCardNo from tb_IDCardInfo t1, inserted t2
				where t1.IDCardNo=t2.cardno and t2.CardNo>0)
	begin
		
		insert into tb_vipInList 	
  		select * from inserted
		delete from tb_Inlist_Tmp
	end
	else 
	begin			
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
  end
-------------------------------------------------------------------------------------------------
--修改(tb_OutList_Tmp)中触发器Tr_OutlistSplit



GO



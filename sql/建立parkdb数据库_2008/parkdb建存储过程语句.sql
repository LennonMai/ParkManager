use [parkdb]
--------------------------------------------------------ɾ���洢����----------------------------------------------------------
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_SendPara]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PROC_SendPara]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_UpdateCardStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PROC_UpdateCardStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_AutoPassRate_ByPlate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_AutoPassRate_ByPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_AutoPassSpeed]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_AutoPassSpeed]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_CommandCheckByCardNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_CommandCheckByCardNo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_CommandCheckByVehPlate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_CommandCheckByVehPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_DeleteCardDynamicByTicketType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_DeleteCardDynamicByTicketType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_DeleteSecurityCardNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_DeleteSecurityCardNo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_InsertBasisOfVehPass]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_InsertBasisOfVehPass]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_RegPlateRate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_RegPlateRate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_RegPlateRate_ByTime]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_RegPlateRate_ByTime]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_UpdateLaneStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_UpdateLaneStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_UpdateOneTimeLockCommand]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_UpdateOneTimeLockCommand]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_UpdateOneTimeUnlockCommand]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_UpdateOneTimeUnlockCommand]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_UpdateSecurityCardNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_UpdateSecurityCardNo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_UpdateSecurityCommand]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_UpdateSecurityCommand]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_UpdateSecurityCommand2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_UpdateSecurityCommand2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_WhiteVeh_AutoPassRate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_WhiteVeh_AutoPassRate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_YTK_AutoPassRate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_YTK_AutoPassRate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_YTK_UnAutoPassAnalyze]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_YTK_UnAutoPassAnalyze]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_ChangeCard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_ChangeCard]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_ChangeCardCheck]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_ChangeCardCheck]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[in2xls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[in2xls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[out2xls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[out2xls]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindAllListByCardNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindAllListByCardNo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindAllListByVehPlate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindAllListByVehPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByCardNo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo2Table]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByCardNo2Table]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo2Table_Ex]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByCardNo2Table_Ex]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo_Ex]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByCardNo_Ex]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByListNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByListNo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByVehPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate2Table]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByVehPlate2Table]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate2Table_Ex]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByVehPlate2Table_Ex]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate_Ex]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInListByVehPlate_Ex]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInOutListByCardNO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInOutListByCardNO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInOutListByVehPlate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindInOutListByVehPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindOutListByCardNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindOutListByCardNo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindOutListByVehPlate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_FindOutListByVehPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_PinInlistTables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_PinInlistTables]
GO
---------------------------------------------------------------�����洢����-------------------------------------------------------------------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

create procedure proc_FindInListByCardNo2Table
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	--@LaneFlg int,		--1:��Χ����,	����:����
	@SpeventFlg int 	--1:������,		����:����
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

create procedure proc_FindInListByVehPlate2Table
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	--@LaneFlg int,		--1:��Χ����,	����:����
	@SpeventFlg int 	--1:������,		����:����
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


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




-------------------------------------------------------------------------------------------------------------------------------
--�½���ҵ���ô洢����PROC_SendStoreCardBlackListAndTollyCardBlackList��ÿ��20��ʱ�·���ֵ���������ͼ��ʿ���������OBU��Ч�������ںʹ�ֵ����Ч�������ںͼ��ʿ���Ч��������

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[PROC_SendPara](@TableName varchar(255))
AS
	delete tb_SendPara
	from tb_SendPara, (select LaneNo, LaneComputerIP from tb_Lane) tb1
	where tb_SendPara.LaneNo = tb1.LaneNo and
	tb_SendPara.LaneComputerIP = tb1.LaneComputerIP and
	tb_SendPara.TableName = @TableName
	
	insert into tb_SendPara
	select 1 as SendType, '0' as FieldName, '0' as FieldValue,
	tb1.LaneNo, tb1.LaneComputerIP, @TableName,@TableName
	from (select LaneNo, LaneComputerIP from tb_LaneUse  ) tb1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO




CREATE   PROCEDURE PROC_UpdateCardStatus
AS
	UPDATE TB_USERCARDINFO SET STATUS=9 
	WHERE STATUS=0 AND USERCARDTYPE=14
	AND RECNO NOT IN (SELECT USERRECNO FROM TB_USERCARDBILL GROUP BY USERRECNO HAVING MAX(ENDTIME)>=CONVERT(CHAR(10), GETDATE(), 120))




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE procedure Proc_AutoPassRate_ByPlate (@sPlate varchar(10),@dtStart datetime,@dtEnd datetime)
As
begin    	
	Declare @iStartMonth	int
	Declare @iMonthOffset	int
	Declare @iMonth		int
	Declare @iTmpMonth	int

	Declare @TmpTB table(
		VehPlate 	Varchar(20),	-- ����
		ListCnt 	Integer,	-- ��ˮ��¼��
		AutoPassCnt 	Integer,	-- �Զ�������
		HasRegPlateCnt 	Integer		-- �г���ʶ����
		)

	Set @iStartMonth = DATEPART(mm, @dtStart)
	Set @iMonthOffset = 12*(DATEPART(yyyy, @dtEnd) - DATEPART(yyyy, @dtStart) ) + (DATEPART(mm, @dtEnd)-@iStartMonth)
	
	if(@iMonthOffset>11) set @iMonthOffset = 11

	Set @iMonth = @iStartMonth
	if(@sPlate<>'') Set @sPlate = '%'+@sPlate+'%'
	
	-- ͳ�����ݵ���ʱ����
 	While (@iMonth<=@iStartMonth+@iMonthOffset)
	Begin
				
		Set @iTmpMonth = @iMonth%12
		if(@iTmpMonth=0) set @iTmpMonth=12
		
		if(@iTmpMonth=1)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist01
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist01
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist01
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist01
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate

		end
		else if (@iTmpMonth=2)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist02
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist02
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist02
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist02
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=3)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist03
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist03
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist03
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist03
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=4)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist04
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist04
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist04
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist04
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=5)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist05
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist05
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist05
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist05
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=6)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist06
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist06
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist06
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist06
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=7)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist07
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist07
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist07
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist07
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=8)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist08
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist08
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist08
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist08
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=9)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist09
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist09
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist09
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist09
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=10)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist10
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist10
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist10
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist10
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=11)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist11
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist11
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist11
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist11
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end
		else if (@iTmpMonth=12)
		begin	
			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist12
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate	
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_outlist12
				Where optime between @dtStart and @dtEnd and vehplate =any (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate					

			if(@sPlate<>'')
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist12
				Where optime between @dtStart and @dtEnd and vehplate like @sPlate
				Group By VehPlate
			else 
				Insert Into @TmpTB
				Select VehPlate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
				From tb_Inlist12
				Where optime between @dtStart and @dtEnd and vehplate in (select vehplate from v_whitelist where obuid<>'0')
				Group By VehPlate
		end

		Set @iMonth = @iMonth + 1
	End 	

	-- ������ʱ���������ɱ���	
	Select VehPlate as ����,sum(ListCnt) as �����ܴ���,sum(AutoPassCnt)as �Զ�������,convert(Varchar(10),convert(decimal (5,2),sum(AutoPassCnt)*1.0/sum(ListCnt) * 100))+'%' as �Զ�������,sum(HasRegPlateCnt) as ����ʶ����, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/sum(ListCnt) * 100))+'%' as ʶ����
	from @TmpTB
	Group by VehPlate
	Order by sum(AutoPassCnt)*1.0/sum(ListCnt),VehPlate
	
	
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


CREATE procedure Proc_AutoPassSpeed (@iLaneNo int,@dtStart datetime,@dtEnd datetime)
As
begin    	
	Declare @iStartMonth	int
	Declare @iMonthOffset	int
	Declare @iMonth		int
	Declare @iTmpMonth	int

	Declare @TmpTB table(
		LaneNo 		int,		-- ����
		SpeedLevel 	int,		-- �ٶȵȼ�
		ListCnt 	Integer,	-- ��ˮ��¼��
		AddupCnt	int		-- �ۼ���ˮ��		
		)
	
	Declare @RptTB table(
		LaneNo 		int,		-- ����
		SpeedLevel 	int,		-- �ٶȵȼ�
		ListCnt 	Integer,	-- ��ˮ��¼��
		AddupCnt	int		-- �ۼ���ˮ��		
		)

	Set @iStartMonth = DATEPART(mm, @dtStart)
	Set @iMonthOffset = 12*(DATEPART(yyyy, @dtEnd) - DATEPART(yyyy, @dtStart) ) + (DATEPART(mm, @dtEnd)-@iStartMonth)
	
	if(@iMonthOffset>11) set @iMonthOffset = 11

	Set @iMonth = @iStartMonth
	
	-- ͳ�����ݵ���ʱ����
 	While (@iMonth<=@iStartMonth+@iMonthOffset)
	Begin
				
		Set @iTmpMonth = @iMonth%12
		if(@iTmpMonth=0) set @iTmpMonth=12
		
		if(@iTmpMonth=1)
		begin				
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist01
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist01
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
			
		end
		else if (@iTmpMonth=2)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist02
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist02
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=3)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist03
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist03
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=4)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist04
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist04
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=5)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist05
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist05
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=6)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist06
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist06
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=7)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist07
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist07
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=8)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist08
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist08
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=9)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist09
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist09
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=10)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist10
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist10
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=11)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist11
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist11
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end
		else if (@iTmpMonth=12)
		begin	
			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_outlist12
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	

			Insert Into @TmpTB
			Select LaneNo,backup4/100,count(*) as ListCnt,0
			From tb_inlist12
			Where optime between @dtStart and @dtEnd and obuid<>'0' and backup4>0
			Group By LaneNo,backup4/100	
		end

		Set @iMonth = @iMonth + 1
	End 	

	-- ����ʱ��@RtpTB������
	Insert Into @RptTB
	select LaneNo,SpeedLevel,sum(ListCnt),sum(AddupCnt)
	from @TmpTB
	Group by LaneNo,SpeedLevel

	update @RptTB 
	set AddupCnt = (select sum(ListCnt) from @RptTB tb2 where tb2.LaneNo=tb1.LaneNo and tb2.SpeedLevel<=tb1.SpeedLevel)
	from @RptTB tb1
	
	-- ������ʱ���������ɱ���	
	
	if(@iLaneNo<>0)
	begin
		Declare @iTotalCnt int
		
		Select @iTotalCnt=Max(AddupCnt)
		From @RptTB
		Where LaneNo=@iLaneNo
		
		Select LaneNo as ����,SpeedLevel+1 as �ٶȵȼ�,@iTotalCnt as �Զ���������,ListCnt as ���ٶȹ�����,convert(Varchar(10),convert(decimal (5,2),ListCnt*1.0/@iTotalCnt * 100))+'%' as �ٷݱ�,convert(Varchar(10),convert(decimal (5,2),AddupCnt*1.0/@iTotalCnt * 100))+'%' as �ۼưٷݱ�
		From @RptTB
		Where LaneNo=@iLaneNo and SpeedLevel<20
		order by LaneNo,SpeedLevel		
	end 
	else		
		Select SpeedLevel+1 as �ٶȵȼ�,		       
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=11 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��11_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=11 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��11_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=12 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��12_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=12 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��12_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=13 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��13_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=13 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��13_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=16 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��16_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=16 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��16_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=17 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��17_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=17 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��17_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=18 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��18_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=18 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��18_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=31 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��31_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=31 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��31_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=32 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��32_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=32 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��32_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=41 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��41_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=41 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��41_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=42 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��42_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=42 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��42_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=51 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��51_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=51 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��51_�ۼưٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=52 then ListCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��52_�ٷݱ�,
		       convert(Varchar(10),convert(decimal (5,2),sum((case when tb1.LaneNo=52 then AddupCnt else 0 end)*1.0/TatolCnt) * 100))+'%' as ��52_�ۼưٷݱ�
		From @RptTB tb1,(select LaneNo,Max(AddupCnt) as TatolCnt from @RptTB Group By LaneNo) as tb2
		where tb1.LaneNo=tb2.LaneNo 
		Group By SpeedLevel
		Having SpeedLevel<20
			
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


create procedure Proc_CommandCheckByCardNo (@CardNo char(20),
				@QuestTime char(14),@Result int output,@OCardNo char(20) output)
as 
	
	declare @TheLastUnlock datetime
	declare @SCardNo char(20)

	--��ȡ@CardNo��Ӧ�İ�ȫ����
	set @SCardNo=	(select su.CardNo 
			from tb_SecurityUserInfo su 
			where su.IsValid=1 and su.CardNo in 
			(select CardNo from tb_UserCardInfo where VehPlate=(select VehPlate from tb_UserCardInfo where CardNo=@CardNo))
			)
	set @CardNo=@SCardNo
	set @OCardNo=@SCardNo
	--��ȡ��Ч�����µĽ���ʱ��
        --����ǲ���ʱָ��,����û�н���ʱ��,����ֻ�Ƚ���ʼʱ��
	set @TheLastUnlock = 	( select top 1 OpTime 
				from v_AllValidUnlockCommand 
				where CardNo=@CardNo and ((ValidType=2 and @QuestTime between StartTime and EndTime)
                                      or (ValidType=4 and @QuestTime>=StartTime))
				order by Optime desc
				)
	
	if @TheLastUnlock is not null
	begin
		--�ǲ��Ǳ�������Ч������ָ���
		--�ǲ��Ǳ�ÿ����Ч������ָ���
		--�ǲ��Ǳ���������ָ���
		if not exists ( select top 1 * from tb_SecurityCommand
				where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=2 and OpTime>=@TheLastUnlock
				and @QuestTime between StartTime and EndTime order by Optime
				)
			and  not exists ( select top 1 * from tb_SecurityCommand
					where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=1 and OpTime>=@TheLastUnlock
					and SUBSTRING(@QuestTime,9,4) between StartTime and EndTime order by OpTime)
			and  not exists ( select * from tb_SecurityCommand
					where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=3 and OpTime>=@TheLastUnLock)
			and not exists ( select * from tb_SecurityCommand
					where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=4 and OpTime>=@TheLastUnLock)
		begin				
			set @Result=1
		end
		else
		begin
			set @Result=0
		end
	end
	else
	begin
		set @Result=0
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


create procedure Proc_CommandCheckByVehPlate (@VehPlate char(10),
				@QuestTime char(14),@Result int output,@CardNo char(10) output)
as 
	
	declare @cardnum char(10),@TheLastUnlock datetime

	--��ȡ��Ч�����µĽ���ʱ��
        --����ǲ���ʱָ��,����û�н���ʱ��,����ֻ�Ƚ���ʼʱ��
	select top 1 @cardnum=cardno,@TheLastUnlock=optime 
	from v_AllValidUnlockCommand
	where vehplate = @VehPlate and ((ValidType=2 and @QuestTime between StartTime and EndTime)
              or (ValidType=4 and @QuestTime>=StartTime))
	order by OpTime desc
	
	if @TheLastUnlock is not null
	begin
		--�ǲ��Ǳ�������Ч������ָ���
		--�ǲ��Ǳ�ÿ����Ч������ָ���
		--�ǲ��Ǳ���������ָ���
		if not exists ( select top 1 * from tb_SecurityCommand
				where CardNo=@cardnum and Attribute=0 and Type=1 and ValidType=2 and OpTime>=@TheLastUnlock
				and @QuestTime between StartTime and EndTime order by Optime
				)
			and not exists ( select top 1 * from tb_SecurityCommand
					where CardNo=@cardnum and Attribute=0 and Type=1 and ValidType=1 and OpTime>=@TheLastUnlock
					and SUBSTRING(@QuestTime,9,4) between StartTime and EndTime order by OpTime )
			and  not exists ( select * from tb_SecurityCommand
						where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=3 and OpTime>=@TheLastUnLock)
			and not exists ( select * from tb_SecurityCommand
						where CardNo=@cardnum and Attribute=0 and Type=1 and ValidType=4 and Optime>=@theLastUnLock)	
		begin				
			set @Result=1
			set @CardNo = @cardnum
		end
		else
		begin
			set @Result=0
		end
	end
	else
	begin
		--û�п��ţ����²���
		select @cardnum=u.CardNo
		from tb_UserCardInfo u,tb_SecurityUserInfo s
		where u.VehPlate=@VehPlate and s.CardNo=u.CardNo
		set @Result=0
		set @CardNo=@cardnum
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

--ɾ��������
CREATE proc [dbo].[Proc_DeleteCardDynamicByTicketType]
as
delete from tb_CardDynamic where TicketType=5 or TicketType=6

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure Proc_DeleteSecurityCardNo
(@OldCardNo varchar(10), @SUserInfoUpdated int output, @SCommandUpdated int output)
as
    set @SUserInfoUpdated=0
    set @SCommandUpdated=0

    --����ǰ�ȫ�û�
    if exists (select * from tb_SecurityUserInfo where CardNo=@OldCardNo and IsValid=1)
    begin
        update tb_SecurityUserInfo set IsValid=0 where CardNo=@OldCardNo and IsValid=1
        set @SUserInfoUpdated=@@rowcount

        --���������Ч�İ�ȫָ��
        if exists (select * from tb_SecurityCommand where CardNo=@OldCardNo and Attribute=0)
        begin
            delete from tb_SecurityCommand where CardNo=@OldCardNo and Attribute=0
            set @SCommandUpdated=@@rowcount
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


create procedure Proc_InsertBasisOfVehPass
(@VehPassID char(32), @CardNo char(10), @QuestDT char(14), @OpTime DATETIME, @RowCount int output)
as
	declare @TheLastLock DATETIME,@LockTime DATETIME
	--���µ���ʱ����ʱ��
	set @LockTime = (select top 1 OpTime 
			from tb_SecurityCommandBackup 
			where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=2 and OpTime<=@OpTime 
			and @QuestDT between StartTime and EndTime
			order by OpTime desc
			)
	set @TheLastLock=@LockTime
	--���µ�ÿ������ʱ��
	set @LockTime = (select top 1 OpTime
			from tb_SecurityCommandBackup
			where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=1 and OpTime<=@OpTime 
			and SUBSTRING(@QuestDT,9,4) between StartTime and EndTime
			order by OpTime desc
			)
	if @LockTime is not null
	begin
		if @TheLastLock is null or (@TheLastLock is not null and @LockTime>@TheLastLock)
		begin
			set @TheLastLock=@Locktime
		end
	end
	--���µ���������ʱ��
	set @LockTime = (select Top 1 OpTime
			from tb_SecurityCommandBackup
			where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=3 and OpTime<=@OpTime
			order by OpTime desc
			)
	if @LockTime is not null
	begin
		if @TheLastLock is null or (@TheLastLock is not null and @LockTime>@TheLastLock)
		begin
			set @TheLastLock=@Locktime
		end
	end
	--���µĲ���ʱ����ʱ��
	set @LockTime=(select Top 1 OpTime 
			from tb_SecurityCommandBackup
			where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=4 and OpTime<=@OpTime
			order by OpTime desc
			)
	if @LockTime is not null
	begin
		if @TheLastLock is null or (@TheLastLock is not null and @LockTime>@TheLastLock)
		begin
			set @TheLastLock=@Locktime
		end
	end


	--��ӹ������ݵ������������ݼ�¼���У���Ϊ�����ǵĽ�����δ�����ǵĽ�����δ�����ǵ���ʱ������ÿ����������������
	--����ʱ����,����ʱ����
	insert into tb_BasisOfSecurityVehPass
	select distinct * from
	(
	--�����ǵĽ���
	select @VehPassID VehPassID,t1.CommandID,t1.ModID,0 IsValid
	from tb_SecurityCommandBackup t1,
        (select CommandID, max(ModID) ModID
        from tb_SecurityCommandBackup 
	where CardNo=@CardNo and Attribute=0 and Type=2 and ValidType=2 and OpTime<@TheLastLock 
		and @QuestDT between StartTime and EndTime
        group by CommandID
        ) t2
        where t1.CommandID=t2.CommandID and t1.ModID=t2.ModID

	union all
	--δ�����ǵĽ��� 
	select @VehPassID VehPassID,t1.CommandID,t1.ModID,1 IsValid
	from tb_SecurityCommandBackup t1,
        (select CommandID, max(ModID) ModID
        from tb_SecurityCommandBackup 
	where CardNo=@CardNo and Attribute=0 and Type=2 and ValidType=2 and OpTime between @TheLastLock and @OpTime
		and @QuestDT between StartTime and EndTime
        group by CommandID
        ) t2
        where t1.CommandID=t2.CommandID and t1.ModID=t2.ModID

	union all
	--��Ч����ʱ��
	select @VehPassID VehPassID,t1.CommandID,t1.ModID,1 IsValid
	from tb_SecurityCommandBackup t1,
        (select CommandID, max(ModID) ModID
        from tb_SecurityCommandBackup 
	where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=2 and OpTime<@OpTime
		and @QuestDT between StartTime and EndTime
        group by CommandID
        ) t2
        where t1.CommandID=t2.CommandID and t1.ModID=t2.ModID

	union all
	--��Ч��ÿ����
	select @VehPassID VehPassID,t1.CommandID,t1.ModID,1 IsValid
	from tb_SecurityCommandBackup t1,
        (select CommandID, max(ModID) ModID
        from tb_SecurityCommandBackup 
	where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=1 and OpTime<@OpTime
		and SUBSTRING(@QuestDT,9,4) between StartTime and EndTime
        group by CommandID
        ) t2
        where t1.CommandID=t2.CommandID and t1.ModID=t2.ModID

	union all
	--��Ч��������
	select @VehPassID VehPassID,t1.CommandID,t1.ModID,1 IsValid
	from tb_SecurityCommandBackup t1,
        (select CommandID, max(ModID) ModID
        from tb_SecurityCommandBackup 
	where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=3 and OpTime<@OpTime
        group by CommandID
        ) t2
        where t1.CommandID=t2.CommandID and t1.ModID=t2.ModID

	union all
	--�����ǵĲ���ʱ����
	select @VehPassID VehPassID,t1.CommandID,t1.ModID,0 IsValid
	from tb_SecurityCommandBackup t1,
        (select CommandID, max(ModID) ModID
        from tb_SecurityCommandBackup 
	where CardNo=@CardNo and Attribute=0 and Type=2 and ValidType=4 and OpTime<@TheLastLock
        group by CommandID
        ) t2
        where t1.CommandID=t2.CommandID and t1.ModID=t2.ModID

	union all
	--δ�����ǵĲ���ʱ����
	select @VehPassID VehPassID,t1.CommandID,t1.ModID,1 IsValid
	from tb_SecurityCommandBackup t1,
        (select CommandID, max(ModID) ModID
        from tb_SecurityCommandBackup 
	where CardNo=@CardNo and Attribute=0 and Type=2 and ValidType=4 and OpTime between @TheLastLock and @OpTime
        group by CommandID
        ) t2
        where t1.CommandID=t2.CommandID and t1.ModID=t2.ModID

	union all
	--����ʱ����
	select @VehPassID VehPassID,t1.CommandID,t1.ModID,1 IsValid
	from tb_SecurityCommandBackup t1,
        (select CommandID, max(ModID) ModID
        from tb_SecurityCommandBackup 
	where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=4 and OpTime<@OpTime
        group by CommandID
        ) t2
        where t1.CommandID=t2.CommandID and t1.ModID=t2.ModID

	) as tb_Temp
	
	set @RowCount=@@ROWCOUNT


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE procedure Proc_RegPlateRate (@dtStart datetime,@dtEnd datetime)
As
begin    	
	Declare @iStartMonth	int
	Declare @iMonthOffset	int
	Declare @iMonth		int
	Declare @iTmpMonth	int

	Declare @TmpTB table(
		LaneNo 		Integer,	-- ������
		ListCnt 	Integer,	-- ��ˮ��¼��
		HasRegPlateCnt 	Integer		-- �г���ʶ��ļ�¼��		
		)

	Set @iStartMonth = DATEPART(mm, @dtStart)
	Set @iMonthOffset = 12*(DATEPART(yyyy, @dtEnd) - DATEPART(yyyy, @dtStart) ) + (DATEPART(mm, @dtEnd)-@iStartMonth)
	
	if(@iMonthOffset>11) set @iMonthOffset = 11

	Set @iMonth = @iStartMonth
	
	-- ͳ�����ݵ���ʱ����
 	While (@iMonth<=@iStartMonth+@iMonthOffset)
	Begin
				
		Set @iTmpMonth = @iMonth%12
		if(@iTmpMonth=0) set @iTmpMonth=12
		
		if(@iTmpMonth=1)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist01
			Where optime between @dtStart and @dtEnd 
			Group By laneno
			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist01
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=2)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist02
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist02
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=3)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist03
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist03
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=4)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist04
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist04
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=5)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist05
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist05
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=6)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist06
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist06
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=7)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist07
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt			From tb_inlist07
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=8)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist08
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist08
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=9)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist09
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist09
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=10)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist10
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist10
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=11)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist11
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist11
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end
		else if (@iTmpMonth=12)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist12
			Where optime between @dtStart and @dtEnd 
			Group By laneno			

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist12
			Where optime between @dtStart and @dtEnd 
			Group by laneno
		end

		Set @iMonth = @iMonth + 1
	End 	

	-- ������ʱ���������ɱ���
	Select LaneNo as ������,sum(ListCnt) as ��ˮ����,sum(HasRegPlateCnt) as ����ʶ����, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/sum(ListCnt) * 100))+'%' as ʶ����
	from @TmpTB
	Group by LaneNo
	Order by LaneNo
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


CREATE procedure Proc_RegPlateRate_ByTime (@iLaneNo int,@dtStart datetime,@dtEnd datetime)
As
begin    	
	Declare @iStartMonth	int
	Declare @iMonthOffset	int
	Declare @iMonth		int
	Declare @iTmpMonth	int

	Declare @TmpTB table(
		LaneNo 		Integer,	-- ������
		HourNo 		Integer,	-- Сʱ
		ListCnt 	Integer,	-- ��ˮ��¼��
		HasRegPlateCnt 	Integer		-- �г���ʶ��ļ�¼��		
		)

	Set @iStartMonth = DATEPART(mm, @dtStart)
	Set @iMonthOffset = 12*(DATEPART(yyyy, @dtEnd) - DATEPART(yyyy, @dtStart) ) + (DATEPART(mm, @dtEnd)-@iStartMonth)
	
	if(@iMonthOffset>11) set @iMonthOffset = 11

	Set @iMonth = @iStartMonth
	
	-- ͳ�����ݵ���ʱ����
 	While (@iMonth<=@iStartMonth+@iMonthOffset)
	Begin
				
		Set @iTmpMonth = @iMonth%12
		if(@iTmpMonth=0) set @iTmpMonth=12
		
		if(@iTmpMonth=1)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist01
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist01
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			
		end
		else if (@iTmpMonth=2)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist02
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist02
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=3)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist03
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist03
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=4)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist04
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist04
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=5)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist05
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist05
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=6)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist06
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist06
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=7)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist07
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist07
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=8)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist08
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist08
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=9)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist09
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist09
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=10)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist10
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist10
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=11)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist11
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist11
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end
		else if (@iTmpMonth=12)
		begin	
			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist12
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
			

			Insert Into @TmpTB
			Select laneno,DATEPART(Hour,optime),count(*) as ListCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_inlist12
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo)
			Group By laneno,DATEPART(Hour,optime)
		end

		Set @iMonth = @iMonth + 1
	End 	

	-- ������ʱ���������ɱ���
	Select LaneNo as ������,HourNo as ʱ��,sum(ListCnt) as ��ˮ����,sum(HasRegPlateCnt) as ����ʶ����, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/sum(ListCnt) * 100))+'%' as ʶ����
	from @TmpTB
	Group by LaneNo,HourNo
	Order by LaneNo,HourNo
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

CREATE procedure Proc_UpdateLaneStatus 
   (@iAreaNo		smallint,
   	@iParkNo		smallint,
   	@iGateNo		smallint,
    @iLaneNo		smallint,    
    @dtSquadDate	datetime,
    @iSquadNo		smallint,
    @iOperatorNo	integer,
    @iCashMoney		integer,
    @dtUploadTime	datetime)
As
begin    
	Declare @iRowCount	int
	
	-- ���� tb_LaneStatus ��   	
	Select @iRowCount=count(1)
	From tb_LaneStatus 		
	Where AreaNo=@iAreaNo and ParkNo=@iParkNo and GateNo=@iGateNo and LaneNo=@iLaneNo	
		
	IF @iRowCount = 0		
   		Insert into tb_LaneStatus (AreaNo,ParkNo,GateNo,LaneNo,SquadDate,SquadNo,OperatorNo,
   								   RecordCounts,CashSum,LastOpTime,LaneStatusNo,NetStatus)
   		values (@iAreaNo,@iParkNo,@iGateNo,@iLaneNo,@dtSquadDate,@iSquadNo,@iOperatorNo,
   				1,@iCashMoney,@dtUploadTime,1,1)
   	else
   		Update tb_LaneStatus
   		Set SquadDate=@dtSquadDate,SquadNo=@iSquadNo,OperatorNo=@iOperatorNo,LaneStatusNo=1,
   			LastOpTime=@dtUploadTime,
   			RecordCounts = (case when SquadDate=@dtSquadDate and SquadNo=@iSquadNo and OperatorNo=@iOperatorNo then RecordCounts + 1 else 1 end),
   			CashSum = (case when SquadDate=@dtSquadDate and SquadNo=@iSquadNo and OperatorNo=@iOperatorNo then CashSum + @iCashMoney else @iCashMoney end),
   			NetStatus=1
   		Where AreaNo=@iAreaNo and ParkNo=@iParkNo and GateNo=@iGateNo and LaneNo=@iLaneNo
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


create Procedure Proc_UpdateOneTimeLockCommand
(@CardNo CHAR(10), @QuestDT CHAR(14), @OpTime DATETIME, @OnTimeUpdated int output, @TimeNotsureUpdate int output)
as
	--���µ�����Ч������ָ��Ĳ���ʱ�䡢���ԡ�����ʱ�䡢����Ա���͡�����Ա��
	update tb_SecurityCommand set OpTime=@OpTime,Attribute=2,HandleTime=@OpTime,OperatorType=3,
					OperatorNo=NULL
	where CardNo=@CardNo and @QuestDT between StartTime and EndTime and OpTime<@OpTime
		and Type=1 and ValidType=2 and Attribute=0

	set @OnTimeUpdated=@@ROWCOUNT

	--������Ч�Ĳ���ʱ��
	update tb_SecurityCommand set OpTime=@OpTime,Attribute=2,HandleTime=@OpTime,OperatorType=3,
					OperatorNo=NULL
	where CardNo=@CardNo and Attribute=0 and Type=1 and ValidType=4 
              and @QuestDT >= StartTime and OpTime<@OpTime

	set @TimeNotsureUpdate=@@ROWCOUNT
		

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create Procedure Proc_UpdateOneTimeUnlockCommand
(@CardNo CHAR(10),@QuestDT CHAR(14),@OpTime DATETIME,  @OnTimeUpdated int output, @TimeNotsureUpdate int output)
as
	--���µ�����Ч�Ľ���ָ��Ĳ���ʱ�䡢���ԡ�����ʱ�䡢����Ա���͡�����Ա��
	update tb_SecurityCommand set OpTime=@OpTime,Attribute=2,HandleTime=@OpTime,OperatorType=3,
					OperatorNo=NULL
	where CardNo=@CardNo and @QuestDT between StartTime and EndTime and OpTime<@OpTime
		and Type=2 and ValidType=2 and Attribute=0

	set @OnTimeUpdated=@@ROWCOUNT

	--������Ч�Ĳ���ʱ����
	update tb_SecurityCommand set OpTime=@OpTime,Attribute=2,HandleTime=@OpTime,OperatorType=3,
					OperatorNo=NULL
	where CardNo=@CardNo and Attribute=0 and Type=2 and ValidType=4 
              and @QuestDT>=StartTime and OpTime<@OpTime

	set @TimeNotsureUpdate=@@ROWCOUNT
		

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure Proc_UpdateSecurityCardNo 
(@OldCardNo varchar(10), @NewCardNo varchar(10), 
    @SUserInfoUpdated int output, @SCommandUpdated int output)
as
    set @SUserInfoUpdated=0
    set @SCommandUpdated=0

    --����ǰ�ȫ�û�
    if exists (select * from tb_SecurityUserInfo where CardNo=@OldCardNo and IsValid=1)
    begin
        update tb_SecurityUserInfo set CardNo=@NewCardNo where CardNo=@OldCardNo and IsValid=1 
        set @SUserInfoUpdated=@@rowcount

        --���������Ч�İ�ȫָ��
        if exists (select * from tb_SecurityCommand where CardNo=@OldCardNo and Attribute=0)
        begin
           update tb_SecurityCommand set CardNo=@NewCardNo where CardNo=@OldCardNo and Attribute=0
           set @SCommandUpdated=@@rowcount
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


create Procedure Proc_UpdateSecurityCommand(@CardNo CHAR(10),@QuestDT CHAR(14),@OpTime DATETIME)
as
	--���µ�����Ч������ָ��Ĳ���ʱ�䡢���ԡ�����ʱ�䡢����Ա���͡�����Ա��
	update tb_SecurityCommand set OpTime=@OpTime,Attribute=2,HandleTime=@OpTime,OperatorType=3,
					OperatorNo=NULL
	where CardNo=@CardNo and @QuestDT between StartTime and EndTime and OpTime<@OpTime
		and Type=1 and ValidType=2 and Attribute=0
	--������Ч�Ĳ���ʱ��
	update tb_SecurityCommand set OpTime=@OpTime,Attribute=2,HandleTime=@OpTime,OperatorType=3,
					OperatorNo=NULL
	where CardNo=@CardNo and @QuestDT between StartTime and EndTime and OpTime<@OpTime
		and Type=1 and ValidType=4 and Attribute=0
	--���µ�����Ч�Ľ���ָ��Ĳ���ʱ�䡢���ԡ�����ʱ�䡢����Ա���͡�����Ա��
	update tb_SecurityCommand set OpTime=@OpTime,Attribute=2,HandleTime=@OpTime,OperatorType=3,
					OperatorNo=NULL
	where CardNo=@CardNo and @QuestDT between StartTime and EndTime and OpTime<@OpTime
		and Type=2 and ValidType=2 and Attribute=0
	--������Ч�Ĳ���ʱ����
	update tb_SecurityCommand set OpTime=@OpTime,Attribute=2,HandleTime=@OpTime,OperatorType=3,
					OperatorNo=NULL
	where CardNo=@CardNo and @QuestDT between StartTime and EndTime and OpTime<@OpTime
		and Type=2 and ValidType=4 and Attribute=0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create Procedure Proc_UpdateSecurityCommand2
as
	declare @CurDT DATETIME,@szDT char(12),@szDTFull char(32)
	set @CurDT=getdate()
	set @szDTFull=convert(char(32),getdate(),120)
	set @szDT=substring(@szDTFull,1,4)+substring(@szDTFull,6,2)+substring(@szDTFull,9,2)+substring(@szDTFull,12,2)+substring(@szDTFull,15,2)

	--���³�ʱδ����ĵ�����Ч����ָ��
	update tb_SecurityCommand set OpTime=@CurDT,Attribute=3,OperatorType=4,OperatorNo=NULL
	where @szDT>EndTime and Type=2 and ValidType=2 and Attribute=0
	--���³�ʱδ����ĵ�����Ч����ָ��
	update tb_SecurityCommand set OpTime=@CurDT,Attribute=3,OperatorType=4,OperatorNo=NULL
	where @szDT>EndTime and Type=1 and ValidType=2 and Attribute=0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE procedure Proc_WhiteVeh_AutoPassRate (@iLaneNo int,@dtStart datetime,@dtEnd datetime)
As
begin    	
	Declare @iStartMonth	int
	Declare @iMonthOffset	int
	Declare @iMonth		int
	Declare @iTmpMonth	int

	Declare @TmpTB table(
		LaneNo 		Integer,	-- ������
		OpDate 		Varchar(20),	-- ����
		ListCnt 	Integer,	-- װ��OBUУ�ڳ���ˮ��¼��
		AutoPassCnt 	Integer,	-- װ��OBUУ�ڳ��Զ�������		
		HasRegPlateCnt 	Integer		-- �����г���ʶ��ļ�¼��		
		)

	Set @iStartMonth = DATEPART(mm, @dtStart)
	Set @iMonthOffset = 12*(DATEPART(yyyy, @dtEnd) - DATEPART(yyyy, @dtStart) ) + (DATEPART(mm, @dtEnd)-@iStartMonth)
	
	if(@iMonthOffset>11) set @iMonthOffset = 11

	Set @iMonth = @iStartMonth
	
	-- ͳ�����ݵ���ʱ����
 	While (@iMonth<=@iStartMonth+@iMonthOffset)
	Begin
				
		Set @iTmpMonth = @iMonth%12
		if(@iTmpMonth=0) set @iTmpMonth=12
		
		if(@iTmpMonth=1)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist01
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist01
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
			
		end
		else if (@iTmpMonth=2)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist02
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist02
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=3)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist03
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist03
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=4)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist04
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist04
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=5)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist05
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist05
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=6)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist06
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist06
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=7)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist07
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist07
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=8)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist08
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist08
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=9)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist09
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist09
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=10)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist10
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist10
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=11)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist11
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist11
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=12)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist12
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist12
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and cardno in (select cardno from v_whitelist where obuid<>'0' ) 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end

		Set @iMonth = @iMonth + 1
	End 	

	-- ������ʱ���������ɱ���
	if(@iLaneNo=0)
		Select LaneNo as ������,sum(ListCnt) as װ��OBUУ�ڳ���ˮ����,sum(AutoPassCnt)as �Զ�������,convert(Varchar(10),convert(decimal (5,2),sum(AutoPassCnt)*1.0/sum(ListCnt) * 100))+'%' as �Զ�������,sum(HasRegPlateCnt) as ����ʶ����, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/sum(ListCnt) * 100))+'%' as ʶ����
		from @TmpTB
		Group by LaneNo
		Order by LaneNo
	else 
		Select LaneNo as ������,OpDate as ����,sum(ListCnt) as װ��OBUУ�ڳ���ˮ����,sum(AutoPassCnt)as �Զ�������,convert(Varchar(10),convert(decimal (5,2),sum(AutoPassCnt)*1.0/sum(ListCnt) * 100))+'%' as �Զ�������,sum(HasRegPlateCnt) as ����ʶ����, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/sum(ListCnt) * 100))+'%' as ʶ����
		from @TmpTB
		Where LaneNo=@iLaneNo
		Group by LaneNo,OpDate
		Order by LaneNo,OpDate
	
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


CREATE procedure Proc_YTK_AutoPassRate (@iLaneNo int,@dtStart datetime,@dtEnd datetime)
As
begin    	
	Declare @iStartMonth	int
	Declare @iMonthOffset	int
	Declare @iMonth		int
	Declare @iTmpMonth	int

	Declare @TmpTB table(
		LaneNo 		Integer,	-- ������
		OpDate 		Varchar(20),	-- ����
		ListCnt 	Integer,	-- ������ͨ����ˮ��¼��
		AutoPassCnt 	Integer,	-- ������ͨ���Զ�������		
		HasRegPlateCnt 	Integer		-- �����г���ʶ��ļ�¼��		
		)

	Set @iStartMonth = DATEPART(mm, @dtStart)
	Set @iMonthOffset = 12*(DATEPART(yyyy, @dtEnd) - DATEPART(yyyy, @dtStart) ) + (DATEPART(mm, @dtEnd)-@iStartMonth)
	
	if(@iMonthOffset>11) set @iMonthOffset = 11

	Set @iMonth = @iStartMonth
	
	-- ͳ�����ݵ���ʱ����
 	While (@iMonth<=@iStartMonth+@iMonthOffset)
	Begin
				
		Set @iTmpMonth = @iMonth%12
		if(@iTmpMonth=0) set @iTmpMonth=12
		
		if(@iTmpMonth=1)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist01
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist01
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
			
		end
		else if (@iTmpMonth=2)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist02
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist02
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=3)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist03
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist03
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=4)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist04
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist04
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=5)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist05
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist05
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=6)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist06
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist06
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=7)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist07
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist07
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=8)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist08
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist08
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=9)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist09
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist09
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=10)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist10
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist10
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=11)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist11
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist11
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end
		else if (@iTmpMonth=12)
		begin	
			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_outlist12
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)			

			Insert Into @TmpTB
			Select laneno,dbo.f_DTtoStr(optime,0) as OpDate,count(*) as ListCnt,sum(case when obuid='0' then 0 else 1 end) as AutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt
			From tb_Inlist12
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and backup2<>1 and cardno not in (select cardno from tb_usercardinfo) and vehclass=6 
			Group By laneno,dbo.f_DTtoStr(optime,0)
		end

		Set @iMonth = @iMonth + 1
	End 	

	-- ������ʱ���������ɱ���
	if(@iLaneNo=0)
		Select LaneNo as ������,sum(ListCnt) as ������ͨ������,sum(AutoPassCnt)as �Զ�������,convert(Varchar(10),convert(decimal (5,2),sum(AutoPassCnt)*1.0/sum(ListCnt) * 100))+'%' as �Զ�������,sum(HasRegPlateCnt) as ����ʶ����, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/sum(ListCnt) * 100))+'%' as ʶ����,convert(Varchar(10),convert(decimal (5,2),sum(AutoPassCnt)*1.0/sum(HasRegPlateCnt) * 100))+'%' as �ų�δʶ���Զ�������
		from @TmpTB
		Group by LaneNo
		Order by LaneNo
	else 
		Select LaneNo as ������,OpDate as ����,sum(ListCnt) as ������ͨ������,sum(AutoPassCnt)as �Զ�������,convert(Varchar(10),convert(decimal (5,2),sum(AutoPassCnt)*1.0/sum(ListCnt) * 100))+'%' as �Զ�������,sum(HasRegPlateCnt) as ����ʶ����, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/sum(ListCnt) * 100))+'%' as ʶ����
		from @TmpTB
		Where LaneNo=@iLaneNo
		Group by LaneNo,OpDate
		Order by LaneNo,OpDate
	
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


CREATE procedure Proc_YTK_UnAutoPassAnalyze (@iLaneNo int,@dtStart datetime,@dtEnd datetime)
As
begin    	
	Declare @iStartMonth	int
	Declare @iMonthOffset	int
	Declare @iMonth			int
	Declare @iTmpMonth		int
	
	Declare @iListCnt		int
	Declare @iUnAutoPassCnt	int	

	Declare @TmpTB table(
		LaneNo 			Integer,	-- ������		
		ListCnt 		Integer,	-- ������ͨ����ˮ��¼��
		UnAutoPassCnt 	Integer,	-- ������ͨ���Զ�������		
		HasRegPlateCnt 	Integer,	-- �����г���ʶ��ļ�¼��
		Backup2			Integer, 	-- ��������
		Backup2Cnt		Integer		-- �����������������
		)
	
	Declare @TmpTB2 table(
		LaneNo 			Integer,	-- ������		
		ListCnt 		Integer,	-- ������ͨ����ˮ��¼��
		UnAutoPassCnt 	Integer,	-- ������ͨ���Զ�������		
		HasRegPlateCnt 	Integer,	-- �����г���ʶ��ļ�¼��
		Backup2			Integer, 	-- ��������
		Backup2Cnt		Integer		-- �����������������
		)


	Set @iStartMonth = DATEPART(mm, @dtStart)
	Set @iMonthOffset = 12*(DATEPART(yyyy, @dtEnd) - DATEPART(yyyy, @dtStart) ) + (DATEPART(mm, @dtEnd)-@iStartMonth)
	
	if(@iMonthOffset>11) set @iMonthOffset = 11

	Set @iMonth = @iStartMonth
	
	-- ͳ�����ݵ���ʱ����
 	While (@iMonth<=@iStartMonth+@iMonthOffset)
	Begin
				
		Set @iTmpMonth = @iMonth%12
		if(@iTmpMonth=0) set @iTmpMonth=12
		
		if(@iTmpMonth=1)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist01
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist01
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2							
		end
		else if (@iTmpMonth=2)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist02
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist02
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=3)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist03
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist03
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=4)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist04
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist04
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=5)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist05
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist05
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=6)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist06
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist06
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=7)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist07
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist07
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=8)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist08
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist08
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=9)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist09
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist09
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=10)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist10
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist10
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=11)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist11
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist11
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end
		else if (@iTmpMonth=12)
		begin	
			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_outlist12
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		

			Insert Into @TmpTB
			Select laneno,count(*) as ListCnt,sum(case when obuid='0' then 1 else 0 end) as UnAutoPassCnt,sum(case when VehPLATEAUTO<>'0' THEN 1 ELSE 0 END) as HasRegPlateCnt,Backup2,Count(Backup2) as Backup2Cnt
			From tb_Inlist12
			Where optime between @dtStart and @dtEnd and (0=@iLaneNo or LaneNo=@iLaneNo) and vehclass=6 and cardno not in (select cardno from tb_usercardinfo)
			Group By laneno,Backup2		
		end

		Set @iMonth = @iMonth + 1
	End 
	
	delete from @TmpTB where laneno in (41,42,51,52)
	
	insert into @TmpTB2
	select LaneNo,sum(ListCnt),sum(UnAutoPassCnt),sum(HasRegPlateCnt),Backup2,sum(Backup2Cnt)
	from @TmpTB 
	group by LaneNo,Backup2
	
	-- ������ʱ���������ɱ���
	if(@iLaneNo<>0)
	begin
		-- ������ˮ�����벻���Զ���������
		Update @TmpTB2
		Set ListCnt=(Select sum(ListCnt) From @TmpTB2 tb2 where tb2.LaneNo=tb.LaneNo),
			UnAutoPassCnt = (Select sum(UnAutoPassCnt) From @TmpTB2 tb2 where tb2.LaneNo=tb.LaneNo)
		From @TmpTB2 tb	
	
		
		Select ListCnt as ������ͨ������,UnAutoPassCnt as ���Զ�������, convert(Varchar(10),convert(decimal (5,2),UnAutoPassCnt*1.0/ListCnt * 100))+'%' as ���Զ�������,
			   Backup2Cnt as ��ԭ�������,HasRegPlateCnt as �����г���ʶ�������, convert(Varchar(10),convert(decimal (5,2),Backup2Cnt*1.0/ListCnt * 100))+'%' as ��ԭ����ռ�ı���,
			   (case when backup2>0 and (backup2/power(2,0)%2=1 or backup2=power(2,2) or backup2=power(2,3) or backup2/power(2,4)%2=1 or backup2/power(2,6)%2=1 or backup2/power(2,7)%2=1 or backup2/power(2,11)%2=1 or backup2/power(2,12)%2=1 or backup2/power(2,13)%2=1 or backup2/power(2,15)%2=1 or backup2/power(2,16)%2=1 or backup2/power(2,17)%2=1 or backup2/power(2,18)%2=1 or backup2/power(2,19)%2=1 or backup2/power(2,22)%2=1 or backup2/power(2,23)%2=1) then 0 else 1 end) as �л����Զ��� ,
			   dbo.f_GetWhysName(backup2) as ���Զ�����ԭ��,0 as ������
		from @TmpTB2
					
		union all
		select ListCnt as ������ͨ������,UnAutoPassCnt as ���Զ�������, convert(Varchar(10),convert(decimal (5,2),UnAutoPassCnt*1.0/ListCnt * 100))+'%' as ���Զ�������,
			   sum(Backup2Cnt) as ��ԭ�������,sum(HasRegPlateCnt) as �����г���ʶ�������, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/ListCnt * 100))+'%' as ��ԭ����ռ�ı���,
			   1 as �л����Զ���,
			   '�����ϣ��п��ܿ����Զ�����' as ���Զ�����ԭ��,1 as ������
		from @TmpTB2
		where backup2>0 and (case when backup2>0 and (backup2/power(2,0)%2=1 or backup2=power(2,2) or backup2=power(2,3) or backup2/power(2,4)%2=1 or backup2/power(2,6)%2=1 or backup2/power(2,7)%2=1 or backup2/power(2,11)%2=1 or backup2/power(2,12)%2=1 or backup2/power(2,13)%2=1 or backup2/power(2,15)%2=1 or backup2/power(2,16)%2=1 or backup2/power(2,17)%2=1 or backup2/power(2,18)%2=1 or backup2/power(2,19)%2=1 or backup2/power(2,20)%2=1 or backup2/power(2,22)%2=1 or backup2/power(2,23)%2=1) then 0 else 1 end)=1
		group by ListCnt,UnAutoPassCnt
					
		order by ������,Backup2Cnt desc	
	end
	else 	
	begin
		Set @iListCnt=0
		Set @iUnAutoPassCnt=0
		
		Select @iListCnt=sum(ListCnt),@iUnAutoPassCnt=sum(UnAutoPassCnt) 
		From @TmpTB2
		
		
		Select @iListCnt as ������ͨ������,@iUnAutoPassCnt as ���Զ�������, convert(Varchar(10),convert(decimal (5,2),@iUnAutoPassCnt*1.0/@iListCnt * 100))+'%' as ���Զ�������,
			   sum(Backup2Cnt) as ��ԭ�������,sum(HasRegPlateCnt) as �����г���ʶ�������, convert(Varchar(10),convert(decimal (5,2),sum(Backup2Cnt)*1.0/@iListCnt * 100))+'%' as ��ԭ����ռ�ı���,
			   (case when backup2>0 and (backup2/power(2,0)%2=1 or backup2=power(2,2) or backup2=power(2,3) or backup2/power(2,4)%2=1 or backup2/power(2,6)%2=1 or backup2/power(2,7)%2=1 or backup2/power(2,11)%2=1 or backup2/power(2,12)%2=1 or backup2/power(2,13)%2=1 or backup2/power(2,15)%2=1 or backup2/power(2,16)%2=1 or backup2/power(2,17)%2=1 or backup2/power(2,18)%2=1 or backup2/power(2,19)%2=1 or backup2/power(2,20)%2=1 or backup2/power(2,22)%2=1 or backup2/power(2,23)%2=1) then 0 else 1 end) as �л����Զ��� ,
			   dbo.f_GetWhysName(backup2) as ���Զ�����ԭ��,0 as ������
		from @TmpTB2	
		group by backup2		
		
		union all
		select @iListCnt as ������ͨ������,@iUnAutoPassCnt as ���Զ�������, convert(Varchar(10),convert(decimal (5,2),@iUnAutoPassCnt*1.0/@iListCnt * 100))+'%' as ���Զ�������,
			   sum(Backup2Cnt) as ��ԭ�������,sum(HasRegPlateCnt) as �����г���ʶ�������, convert(Varchar(10),convert(decimal (5,2),sum(HasRegPlateCnt)*1.0/@iListCnt * 100))+'%' as ��ԭ����ռ�ı���,
			   1 as �л����Զ���,
			   ' �����ϣ��п��ܿ����Զ�����' as ���Զ�����ԭ��,1 as ������
		from @TmpTB2
		where backup2>0 and (case when backup2>0 and (backup2/power(2,0)%2=1 or backup2=power(2,2) or backup2=power(2,3) or backup2/power(2,4)%2=1 or backup2/power(2,6)%2=1 or backup2/power(2,7)%2=1 or backup2/power(2,11)%2=1 or backup2/power(2,12)%2=1 or backup2/power(2,13)%2=1 or backup2/power(2,15)%2=1 or backup2/power(2,16)%2=1 or backup2/power(2,17)%2=1 or backup2/power(2,18)%2=1 or backup2/power(2,19)%2=1 or backup2/power(2,20)%2=1 or backup2/power(2,22)%2=1 or backup2/power(2,23)%2=1) then 0 else 1 end)=1
		
		order by ������,sum(Backup2Cnt) desc			
		
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


/*
 * ���ܣ�����������
 * ������
 *		@iSys_id	--����������˻��������sys_id
 *		@sNewCardNo	--����������¿�����
 *		@iCost		--����������¿��Ĺ�����
 *		@iResult	--���������0���ɹ���������ʧ��
 */
CREATE procedure SP_ChangeCard (@iSys_id int,@sNewCardNo Varchar(20),@iCost int,@iOperatorID int,@iResult int output)
As
Begin
	Declare @sOldCardNo Varchar(20)
	Declare @oldBalance int 

	-- 1.����sys_id��ȡ�ɿ���
	Set @sOldCardNo=''
	Select @sOldCardNo = cardNo,@oldBalance=balance From t_park_account where sys_id=@iSys_id
	Select @oldBalance=@oldBalance/100
	-- 2.���ʻ���Ŀ����޸�Ϊ�¿��ţ��޸Ĺ�����Ϊ 0
	Update t_park_account Set cardNo=@sNewCardNo,cost=@iCost where sys_id=@iSys_id

	-- 3.�û�����Ϣ���еĿ����޸�Ϊ�¿���
	Update tb_UserCardInfo Set cardNo=@sNewCardNo where cardNo=@sOldCardNo
	-- 4.�ɿ���д����ֵ�����������У�����ԭ��Ϊ2��ע����
	if(Exists (Select * from tb_StoreCardBlackList where SCCode=@sOldCardNo))
		Update tb_StoreCardBlackList set GenCau=2,GenTime=GetDate() where SCCode=@sOldCardNo
	else
		Insert Into tb_StoreCardBlackList Values(@sOldCardNo,2,GetDate())

	-- ����IC����Ϣ���д˿���״̬Ϊ1����ʧ��
	update tb_CardInfo Set Status=1 Where CardNo=@sOldCardNo

	-- �Ѳ���д��ϵͳ��־����
	Insert Into t_park_systemLog(logTime,logType,operatorID,logData,coverage,remark)
	Values(GetDate(),1,@iOperatorID,'��������,�ɿ��ţ�'+@sOldCardNo+'�ɿ������Ϊ��'+LTrim(str(@oldBalance))+'Ԫ.�¿��ţ�'+@sNewCardNo,'t_park_account,tb_UserCardInfo,tb_StoreCardBlackList,tb_CardInfo','ִ�� SP_ChangeCard')


	Set @iResult=0

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


/*
 * ���ܣ���֤�¿��ĺϷ���
 * ������
 *      @sOldCardNo --����������ɿ�����
 *		@sNewCardNo	--����������¿�����
 *		@iResult	--���������0���ÿ��Ϸ����������Ƿ���ԭ��
 */
CREATE procedure SP_ChangeCardCheck (@sOldCardNo Varchar(20),@sNewCardNo Varchar(20),@iResult int output)
As
Begin
	Declare @iCnt integer
	Declare @iCntOldCardNo integer

	-- 1.���ÿ��Ƿ��ں�������
	Select @iCnt = count(*) from tb_StoreCardBlackList where SCCode=@sNewCardNo
	if @iCnt>0
	Begin
		Set @iResult=11
		return
	End

	-- 2.�¿����Ƿ��Ѵ������ʻ�����
	Select @iCnt = count(*) from t_park_account where cardNo=@sNewCardNo
	if @iCnt>0
	Begin
		Set @iResult=12
		return
	End

	-- 3.�¿��ź;ɿ����Ƿ񶼴������û�����Ϣ����
	Select @iCnt = count(*) from tb_UserCardInfo where cardNo=@sNewCardNo
	Select @iCntOldCardNo = count(*) from tb_UserCardInfo where cardNo=@sOldCardNo
	if @iCnt>0 and @iCntOldCardNo>0 
	Begin
		Set @iResult=13
		return
	End

	Set @iResult=0
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

CREATE   proc   in2xls    
  @��������   varchar(255),     
  @����   varchar(255),   
  @�û���   varchar(100),   
  @����   varchar(100),   
  @·�����ļ���   varchar(255)   
  as   
  declare   @temp2   varchar(8000)   

  set   @temp2='bcp   '+@����+'   in   '+'"'+@·�����ļ���+'"'+'   -c   -S'+@��������+'   -U'+@�û���+'   -P'+@����   
    
  EXEC   master..xp_cmdshell   @temp2  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE   proc   out2xls   
  @��������   varchar(255),   
  @����   varchar(255),   
  @����   varchar(255),   
  @�û���   varchar(100),   
  @����   varchar(100),   
  @·�����ļ���   varchar(255)   
  as   
  declare   @temp1   nvarchar(4000),@temp2   varchar(8000)    
  set   @temp1='select   @value1='''',@value2=''''   select   @value1=@value1+'',''''''+a.name+''''+char(39)+''   [''+a.name+'']'',@value2=@value2+'',cast(''+''[''+a.name+'']''+   ''   as   varchar(200))''   from   '+@����+'..syscolumns   a,'+@����+'..sysobjects   d   where   a.id=d.id   and   d.name='''+@����+''''+'   order   by   a.colorder'   
    
    
  exec   sp_executesql   @temp1,N'@value1   nvarchar(4000)   output   ,   @value2   varchar(8000)   output',@temp1   output,@temp2   output   
    
  select   @temp1=right(@temp1,len(@temp1)-1),@temp2=right(@temp2,len(@temp2)-1)   
    
  exec('select   *   into   '+@����+'.dbo.�м��   from   (select   '+   @temp1+'   union   all   SELECT   '+@temp2+'   FROM   '+@����+'..'+@����+' with (HOLDLOCK))   tem3')   
    
    
  set   @temp2='bcp   '+@����+'.dbo.�м��   out   '+'"'+@·�����ļ���+'"'+'   -c   -S'+@��������+'   -U'+@�û���+'   -P'+@����   
    
  EXEC   master..xp_cmdshell   @temp2   
  exec('drop   table   '+@����+'.dbo.�м��') 



---------------------------------------------------

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

create procedure proc_FindInListByCardNo
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@SpeventFlg int 	--1:������,		����:����
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE    proc proc_FindInListByCardNo2Table_Ex
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@LaneFlg int,		--1:��Χ����,	����:����
	@SpeventFlg int 	--1:������,		����:����
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

create proc proc_FindInListByCardNo_Ex
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@SpeventFlg int 	--1:������,		����:����
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

create procedure proc_FindInListByVehPlate
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@SpeventFlg int 	--1:������,		����:����
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE     proc proc_FindInListByVehPlate2Table_Ex
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@LaneFlg int,		--1:��Χ����,	����:����
	@SpeventFlg int, 	--1:������,		����:����
    @StartTime  datetime,
    @EndTime    datetime
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int

	--set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())
--�µ����һ���鵽��һ���µı�
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE   proc proc_FindInListByVehPlate_Ex
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@SpeventFlg int, 	--1:������,		����:����
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

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
    --������������Ҫ��12ȡģ
    set @MonthNum = (Month(@EndTime + 1) - Month(@StartTime) + 12)%12 + 1

	exec proc_FindInListByVehPlate2Table_Ex @MonthNum,@RecordCount,@VehPlate,0,0,@StartTime,@EndTime
	exec proc_FindOutListByVehPlate @MonthNum,@RecordCount,@VehPlate,@StartTime,@EndTime

	select * from #t_list order by optime desc

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


--��ָ���������ˮ��פ�����ڴ���
--����: 
--    months : ָ��������ǰ�·����ڹ����ٸ��µ������ˮ����Ҫפ�����ڴ�
--             ����������·���С�ڵ���0,�����������õ�פ�����פ����־,����������·�������12,����12���´���,
--             �����İ�������ʵ���·���פ�������ˮ��
create procedure proc_PinInlistTables(@months int)
as

if @months > 12
begin
    set @months=12
end

--�������µ�פ���ڴ������ˮ��ǰ,�Ƚ�֮ǰ��פ���ڴ������ˮ���פ����־���
--ѭ������
declare @i int
--���ݿ�ID�ͱ����ID,��pintable��unpintable��ʹ��
declare @dbid int, @objid int
--��ǰ�·�
declare @curMonth int
--�����·����ɵı���
declare @tableName char(16)
--��̬����SQL���,����pintable֮��,��פ�����ڵı��ȡ���ڴ�
declare @sql  nvarchar(1024)

set @i=1
set @dbid=db_id('parkdb')

while @i<=12
begin
    if @i<10
    begin
        set @tableName='tb_inlist0'+cast(@i as char(2))
    end
    else
    begin
        set @tableName='tb_inlist'+cast(@i as char(3))
    end

    set @objid=object_id('parkdb..'+@tableName)
    if objectproperty(@objid, 'TableIsPinned')=1
    begin
        dbcc unpintable(@dbid, @objid)
    end
   
    set @i=@i+1
end

--����·���С�ڵ���0,����
if @months<=0
begin
    return
end
--פ���µ������ˮ��
--������Ҫפ���������ˮ��
set @curMonth=month(getdate())


set @sql='declare inlistCursor cursor for select * from (select * from tb_inlist01 where 1=0'

while @months>0
begin
    if @curMonth<10
    begin
        set @tableName='tb_inlist0'+cast(@curMonth as char(2))
    end
    else
    begin
        set @tableName='tb_inlist'+cast(@curMonth as char(3))
    end

    set @objid=object_id('parkdb..'+@tableName)
    dbcc pintable(@dbid, @objid)

    set @sql=@sql+' union all select * from '+@tableName

    set @months=@months-1
    set @curMonth=@curMonth-1
    --�����ǰ�·�Ϊ0,��������Ϊ12
    if @curMonth=0
    begin
        set @curMonth=12
    end

end

set @sql=@sql+') as t open inlistCursor close inlistCursor deallocate inlistCursor'

--print @sql

exec(@sql)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 

GO


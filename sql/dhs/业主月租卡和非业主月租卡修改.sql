--1、tb_userCardInfo增加了feeCardType字段
alter table tb_userCardINfo add feeCardType int ;

--2、重建白名单视图，增加feeCardType字段
CREATE VIEW [dbo].[V_WHITELIST] AS 
SELECT * FROM 
(
	--费用截止时间不计时分秒，所以+1天
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,
		CASE WHEN B.STARTTIME IS NULL THEN A.REGISTERTIME ELSE B.STARTTIME END AS FIRTIME, 
		CASE WHEN B.ENDTIME IS NULL THEN A.REGISTERTIME ELSE B.ENDTIME+1 END AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, 
		CASE WHEN A.STATUS=0 AND (B.ENDTIME IS NULL OR B.ENDTIME<CONVERT(CHAR(10),GETDATE(),120)) THEN 9 ELSE A.STATUS END AS STATUS,
		CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType,A.feeCardType
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
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,CASE WHEN A.REGISTERTIME IS NULL THEN GETDATE() - 120 ELSE A.REGISTERTIME END AS FIRTIME,
	 GETDATE()+1000 AS INVALIDATETIME,A.UserCardType AS CARDTYPE, A.STATUS, CASE WHEN A.VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType,A.feeCardType
	FROM TB_USERCARDINFO A
	WHERE A.UserCardType=13	--业主卡
	union all 
	SELECT CARDNO, VEHPLATE, OWNERName , OBUID, GETDATE()-120 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		13 as Usetype, 0 as Status, CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,0 AS FeeRuleType,0 as feeCardType
	FROM tb_testwl
	
) TMP



GO


--3、修改了v_passcardblackList

CREATE VIEW [dbo].[V_PASSCARDBLACKLIST] AS 
SELECT CARDNO, CARDID, OPTIME, STATUS FROM TB_CARDINFO
WHERE CARDTYPE=1 AND STATUS <> 0
union
(
    SELECT     CardNO, CardID, OpTime, 70
    FROM         dbo.tb_CardInfo
    WHERE     (CardType = 1) AND (Status = 0) 
              and cardno in(select cardno from v_whitelist where CARDTYPE=14 and FeeRuleType =1 and (status<>0 or FIRTIME>getdate() or invalidatetime<=getdate() ) )
		and cardno not in (select cardno from v_whitelist where status=0 and FIRTIME<=getdate() and invalidatetime>getdate() )
)
GO

--3、增加了按天定时下发作业 passCardBlackListIssued
USE [msdb]
GO

/****** Object:  Job [passCardBlackListIssued]    Script Date: 10/16/2012 08:58:02 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 10/16/2012 08:58:02 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'passCardBlackListIssued', 
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
/****** Object:  Step [passCardBlackListIssued]    Script Date: 10/16/2012 08:58:03 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passCardBlackListIssued', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,''V_PassCardBlackList'',''V_PassCardBlackList'' from tb_LaneUse', 
		@database_name=N'parkdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'passCardBlackListIssued', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20121015, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'8ed3ff07-409d-4499-8322-c8848f646bb6'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO
--代码已和通用版兼容



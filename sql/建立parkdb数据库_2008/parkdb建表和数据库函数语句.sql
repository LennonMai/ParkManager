
use [parkdb]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fk_t_park_admin_role_1]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[t_park_admin_role] DROP CONSTRAINT fk_t_park_admin_role_1
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fk_t_park_module]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[t_park_module] DROP CONSTRAINT fk_t_park_module
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fk_t_park_role_module_2]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[t_park_role_module] DROP CONSTRAINT fk_t_park_role_module_2
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fk_t_park_admin_role_2]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[t_park_admin_role] DROP CONSTRAINT fk_t_park_admin_role_2
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fk_t_park_role_module_1]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[t_park_role_module] DROP CONSTRAINT fk_t_park_role_module_1
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_account]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_account]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_admin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_admin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_admin_role]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_admin_role]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_car]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_car]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_config]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_config]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_module]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_role]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_role]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_role_module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_role_module]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_sysparamconf]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_sysparamconf]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_systemLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_systemLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_updateAccountLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_updateAccountLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_user]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[t_park_user]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_0714InList_temp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_0714InList_temp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountAgentExportLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountAgentExportLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountAgentImportLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountAgentImportLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade01]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade01]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade02]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade02]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade03]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade03]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade04]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade05]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade05]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade06]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade06]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade07]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade07]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade08]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade08]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade09]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade09]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade10]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade10]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade11]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade11]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade12]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_AccountTrade12]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Area]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Area]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BasisOfSecurityVehPass]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BasisOfSecurityVehPass]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BillOperation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BillOperation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BillStorage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BillStorage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BillTransfer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BillTransfer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BillTransferDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BillTransferDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BillType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BillType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BlankCardStorage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BlankCardStorage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BlankCardTransfer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BlankCardTransfer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_BlankCardTransferDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_BlankCardTransferDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarBrandCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CarBrandCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarClassCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CarClassCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarSpace]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CarSpace]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarTypeTrans]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CarTypeTrans]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardDynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardDynamic]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardDynamicTemp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardDynamicTemp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardGroupInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardGroupInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardHandOutIn]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardHandOutIn]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardInfo_bak]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardInfo_bak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardOperation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardOperation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CardType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_City]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_City]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_DeviceActionCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_DeviceActionCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_DeviceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_DeviceCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_DeviceErrorCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_DeviceErrorCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_DeviceLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_DeviceLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_FeeRuleTypeDef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_FeeRuleTypeDef]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_FreeDays]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_FreeDays]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_FunctionKey]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_FunctionKey]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_GateSummation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_GateSummation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Gateway]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Gateway]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_HandInMoney]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_HandInMoney]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_HandleType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_HandleType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_HoliDayDef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_HoliDayDef]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_ICCardStorage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_ICCardStorage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_ICCardTransfer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_ICCardTransfer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_IDCardInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_IDCardInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_IdentifyResult]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_IdentifyResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_ImageVerify]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_ImageVerify]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList01]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList01]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList02]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList02]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList03]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList03]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList04]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList05]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList05]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList06]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList06]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList07]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList07]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList08]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList08]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList09]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList09]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList10]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList10]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList11]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList11]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList12]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList12]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InListForAuto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InListForAuto]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InListOutListPair]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InListOutListPair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InListSum]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InListSum]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InList_Tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InList_Tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InOutSignDef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_InOutSignDef]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_KeyCardStorage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_KeyCardStorage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_KeyCardTransfer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_KeyCardTransfer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Lane]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Lane]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneRemoteCommand]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_LaneRemoteCommand]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_LaneStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneSummation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_LaneSummation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_LaneType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneUse]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_LaneUse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneWatch]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_LaneWatch]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LoseCardHis]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_LoseCardHis]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Module]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Module]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OBUDate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OBUDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OpCardBlackList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OpCardBlackList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Operator]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Operator]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OperatorPrivilege]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OperatorPrivilege]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OperatorRole]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OperatorRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList01]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList01]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList02]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList02]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList03]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList03]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList04]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList05]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList05]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList06]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList06]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList07]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList07]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList08]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList08]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList09]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList09]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList10]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList10]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList11]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList11]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList12]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList12]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutListForAuto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutListForAuto]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutListSum]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutListSum]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutList_Tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OutList_Tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OwnerIncomeSum]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_OwnerIncomeSum]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Park]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Park]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PassCardBlackList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_PassCardBlackList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PlateToObuId]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_PlateToObuId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PlateToPic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_PlateToPic]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Position]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Position]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PriceBase]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_PriceBase]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PriceRule]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_PriceRule]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PriceRule2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_PriceRule2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PriceRule_zd]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_PriceRule_zd]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Role]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Role]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_RoleModule]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_RoleModule]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SecurityCommand]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SecurityCommand]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SecurityCommandBackup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SecurityCommandBackup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SecurityCommandOperation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SecurityCommandOperation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SecurityQueryHis]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SecurityQueryHis]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SecurityUserInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SecurityUserInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SecurityVehPass]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SecurityVehPass]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SendPara]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SendPara]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SendParaResult]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SendParaResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpEventCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SpEventCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpVehHandle]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SpVehHandle]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpVehMonitor]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SpVehMonitor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpVehMonitorLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SpVehMonitorLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpecialType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SpecialType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpecialVeh]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SpecialVeh]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpeventDeal]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SpeventDeal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Squad]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Squad]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SquadLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SquadLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Staff]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Staff]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_StationSummation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_StationSummation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_StoreCardBlackList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_StoreCardBlackList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_StoreCardDate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_StoreCardDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SumInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SumInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Supplylight]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Supplylight]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SystemPara]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SystemPara]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_TestWL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_TestWL]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_TicketTypeCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_TicketTypeCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_TimesSignDef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_TimesSignDef]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_ToYZList_Tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_ToYZList_Tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_TollyCardBlackList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_TollyCardBlackList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_TollyCardDate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_TollyCardDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_Uniqueness]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_Uniqueness]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UnusualAccountTrade]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UnusualAccountTrade]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardBill]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardBill]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardBlackList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardBlackList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardFeeRuleType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardFeeRuleType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardInfoH]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardInfoH]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardInfoHistory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardInfoHistory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardRate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardRate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardRateEdit]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardRateEdit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardRenew]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardRenew]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardRenewBak]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardRenewBak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_UserCardType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_UserCardType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehClassCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_VehClassCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehFreeTimes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_VehFreeTimes]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehFreeTimes_Update]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_VehFreeTimes_Update]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehNoCmpPlate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_VehNoCmpPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehTypeCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_VehTypeCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_WatchSet]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_WatchSet]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_WhiteList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_WhiteList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_WhiteList_Recv]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_WhiteList_Recv]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_WhiteList_Tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_WhiteList_Tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_WorkLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_WorkLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_YCTConsumption]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_YCTConsumption]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_YCTInList_Tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_YCTInList_Tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_YCTOutList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_YCTOutList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_YZList_Tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_YZList_Tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_outlist_recv_l]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_outlist_recv_l]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_pricepasstype]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_pricepasstype]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercardinfo_bak20090119]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_usercardinfo_bak20090119]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[temp_tb_carddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[temp_tb_carddynamic]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmp_cardinfobak]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tmp_cardinfobak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmp_cardno]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tmp_cardno]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmp_usercardbillbak]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tmp_usercardbillbak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmp_usercardinfobak]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tmp_usercardinfobak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tt_outlist_1]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tt_outlist_1]
--后来接口需要添加的表（就是给数据给政府需要添加的表）
------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------
--车道设备监控需要添加的表
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SystemEventCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SystemEventCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SystemStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SystemStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SystemEventLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_SystemEventLog]
GO
-----------------------------------------------------------------------------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarSpaceShowMessage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_CarSpaceShowMessage]
GO
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE TABLE [dbo].[t_park_account] (
	[sys_id] [int] IDENTITY (1, 1) NOT NULL ,
	[status] [int] NOT NULL ,
	[user_id] [int] NULL ,
	[car_id] [int] NULL ,
	[cardNo] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardType] [int] NOT NULL ,
	[cost] [int] NOT NULL ,
	[lowestBalanceAfterConsume] [int] NOT NULL ,
	[tollyLowestBalanceAC] [int] NOT NULL ,
	[noEntryBalance] [int] NULL ,
	[lowBalanceNotice] [int] NULL ,
	[openAccountTime] [datetime] NULL ,
	[statusUpdateTime] [datetime] NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[parkNo] [int] NULL ,
	[balance] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_admin] (
	[id] [int] NOT NULL ,
	[username] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[name] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[password] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[type] [varchar] (1) COLLATE Chinese_PRC_CI_AS NULL ,
	[sex] [varchar] (2) COLLATE Chinese_PRC_CI_AS NULL ,
	[email] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[phone] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[createTime] [datetime] NULL ,
	[lastIP] [varchar] (15) COLLATE Chinese_PRC_CI_AS NULL ,
	[lastTime] [datetime] NULL ,
	[valid] [varchar] (1) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_admin_role] (
	[admin] [int] NOT NULL ,
	[role] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_car] (
	[sys_id] [int] IDENTITY (1, 1) NOT NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[carType] [int] NULL ,
	[carColour] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_config] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[siteName] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[propertyName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[company] [varchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[copyright] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[recordCode] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[email] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[phone] [varchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[mobile] [varchar] (200) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO
Insert into t_park_config(siteName,propertyName,company,copyright,recordCode,email,phone,mobile) values('小区车辆管理中心系统','小区','小区','Copyright &copy; 2007-2009 www.flc.com, All Rights Reserved','京ICP证030173号','liu@hgrica.com','02087113968','13632338888')
GO
----------------------------------------------------------------------------------------------------------
GO

CREATE TABLE [dbo].[t_park_module] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[parent] [int] NULL ,
	[name] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[url] [varchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[functions] [text] COLLATE Chinese_PRC_CI_AS NULL ,
	[priority] [int] NULL ,
	[display] [int] NULL ,
	[level] [int] NULL ,
	[remark] [varchar] (200) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_role] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_role_module] (
	[role] [int] NOT NULL ,
	[module] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_sysparamconf] (
	[sys_id] [int] IDENTITY (1, 1) NOT NULL ,
	[pname] [varchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[pvalue] [varchar] (200) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ptype] [int] NOT NULL ,
	[remark] [varchar] (150) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_systemLog] (
	[sys_id] [int] IDENTITY (1, 1) NOT NULL ,
	[logTime] [datetime] NOT NULL ,
	[logType] [int] NOT NULL ,
	[operatorID] [int] NOT NULL ,
	[logData] [varchar] (400) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[coverage] [varchar] (400) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (400) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_updateAccountLog] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[status] [int] NOT NULL ,
	[cardNo] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cost] [int] NOT NULL ,
	[lowestBalanceAfterConsume] [int] NOT NULL ,
	[tollyLowestBalanceAC] [int] NOT NULL ,
	[noEntryBalance] [int] NULL ,
	[lowBalanceNotice] [int] NULL ,
	[openAccountTime] [datetime] NULL ,
	[statusUpdateTime] [datetime] NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[user_id] [int] NULL ,
	[userName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[credentialsType] [int] NULL ,
	[credentialsNo] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[phone] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[mobileNumber] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[address] [varchar] (120) COLLATE Chinese_PRC_CI_AS NULL ,
	[car_id] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[carType] [int] NULL ,
	[carColour] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[updateTime] [datetime] NULL ,
	[operator_id] [int] NULL ,
	[operatorName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[printNumber] [int] NULL ,
	[updateRemark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[t_park_user] (
	[sys_id] [int] NOT NULL ,
	[userName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[credentialsType] [int] NULL ,
	[credentialsNo] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[phone] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[mobileNumber] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[address] [varchar] (120) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_0714InList_temp] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountAgentExportLog] (
	[SquadDate] [datetime] NOT NULL ,
	[PackNo] [char] (4) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[FileName] [varchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[RecCount] [int] NULL ,
	[TotalMoney] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountAgentImportLog] (
	[PackNo] [char] (4) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[FileName] [varchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[RecCount] [int] NULL ,
	[Reserved] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade01] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade02] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade03] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade04] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade05] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade06] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade07] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade08] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade09] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade10] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade11] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_AccountTrade12] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Area] (
	[AreaNo] [smallint] NOT NULL ,
	[AreaName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[AreaServerName] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AreaServerIP] [char] (15) COLLATE Chinese_PRC_CI_AS NULL ,
	[AreaDomain] [char] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[AreaDBName] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AreaDBUserName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[AreaDBPassword] [char] (6) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BasisOfSecurityVehPass] (
	[VehPassID] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CommandID] [int] NOT NULL ,
	[CommandModID] [int] NOT NULL ,
	[IsValid] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BillOperation] (
	[HankNO] [int] NOT NULL ,
	[CardOperateType] [smallint] NOT NULL ,
	[StartBillNO] [int] NOT NULL ,
	[EndBillNO] [int] NOT NULL ,
	[Amount] [int] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Remark] [varchar] (40) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BillStorage] (
	[HankNO] [int] NOT NULL ,
	[Position] [smallint] NOT NULL ,
	[BillType] [smallint] NOT NULL ,
	[BillHead] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[StartBillNO] [int] NOT NULL ,
	[EndBillNO] [int] NOT NULL ,
	[Amount] [int] NOT NULL ,
	[UsedBillNO] [int] NULL ,
	[UsedAmount] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BillTransfer] (
	[RecNO] [int] NOT NULL ,
	[TransferType] [smallint] NOT NULL ,
	[Amount] [int] NOT NULL ,
	[OutPosition] [smallint] NOT NULL ,
	[InPosition] [smallint] NOT NULL ,
	[Ratifier] [int] NULL ,
	[Transactor] [int] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[SquadDate] [datetime] NULL ,
	[SquadNO] [int] NULL ,
	[Verifier] [int] NULL ,
	[VerifyTime] [datetime] NULL ,
	[Remark] [varchar] (40) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BillTransferDetail] (
	[RecNO] [int] NOT NULL ,
	[HankNO] [int] NOT NULL ,
	[StartBillNO] [int] NOT NULL ,
	[EndBillNO] [int] NOT NULL ,
	[Amount] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BillType] (
	[BillType] [smallint] NOT NULL ,
	[TypeName] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[TypeClass] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BlankCardStorage] (
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Position] [int] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BlankCardTransfer] (
	[RecNO] [int] NOT NULL ,
	[TransferType] [smallint] NOT NULL ,
	[Amount] [int] NOT NULL ,
	[OutPosition] [smallint] NOT NULL ,
	[InPosition] [smallint] NOT NULL ,
	[Transactor] [int] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Verifier] [int] NULL ,
	[VerifyTime] [datetime] NULL ,
	[Remark] [varchar] (40) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_BlankCardTransferDetail] (
	[RecNO] [int] NOT NULL ,
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CarBrandCode] (
	[BrandNo] [int] NOT NULL ,
	[BrandName] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CarClassCode] (
	[ClassNo] [int] NOT NULL ,
	[ClassName] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

GO
CREATE TABLE [dbo].[tb_CarSpace](
	[ParkNo] [smallint] NOT NULL,
	[MaxSpace] [smallint] NULL,
	[CarCount] [smallint] NULL,
	[CriticalNum] [smallint] NULL,
	[ModifyTime] [datetime] NULL,
	[GateNo] [varchar](10) NOT NULL,--all 代码全大门，大门编号则为其中大门，表中有all也有大门编号时就代表：这个校区中大门编号那个为一个车位统计，其他大门合为一个车位统计
 CONSTRAINT [PK_CarSpace] PRIMARY KEY CLUSTERED 
(
	[ParkNo] ASC,
	[GateNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tb_CarTypeTrans] (
	[StartDate] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Class] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Length] [int] NOT NULL ,
	[Height] [int] NOT NULL ,
	[Width] [int] NOT NULL ,
	[WheelNumber] [int] NOT NULL ,
	[AxleNumber] [smallint] NOT NULL ,
	[Weight] [int] NOT NULL ,
	[VehType] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardDynamic] (
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OperatorNo] [int] NOT NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[Owner] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserCardType] [smallint] NOT NULL ,
	[VehType] [smallint] NOT NULL ,
	[SquadNo] [smallint] NOT NULL ,
	[inListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[VehBrand] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[TicketType] [tinyint] NOT NULL ,
	[GateName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardDynamicTemp] (
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardGroup] (
	[RecNo] [int] NOT NULL ,
	[CardNo] [varchar] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[GroupNo] [int] NOT NULL ,
	[FirstInOut] [int] NULL ,
	[Optime] [datetime] NULL ,
	[LaneGroupNo] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardGroupInfo] (
	[GroupNo] [int] NOT NULL ,
	[LaneGroupNo] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[GroupName] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkSum] [int] NULL ,
	[ParkRemant] [int] NULL ,
	[Optime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardHandOutIn] (
	[RecordNo] [int] NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[SquadNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[Type] [smallint] NOT NULL ,
	[Amount] [int] NOT NULL ,
	[OperatorName] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OperatorNo] [int] NOT NULL ,
	[RecorderName] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[RecorderNo] [int] NOT NULL ,
	[RecordTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardInfo] (
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardID] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardType] [smallint] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[UserCardType] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardInfo_bak] (
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardID] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardType] [smallint] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardOperation] (
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardType] [int] NOT NULL ,
	[CardOperate] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[Remark] [varchar] (40) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserCardType] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_CardType] (
	[CardType] [smallint] NOT NULL ,
	[TypeName] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardClass] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_City] (
	[CityNo] [smallint] NOT NULL ,
	[CityName] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[Remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_DeviceActionCode] (
	[DeviceActionNo] [tinyint] NOT NULL ,
	[DeviceActionName] [char] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[DeviceNo] [tinyint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_DeviceCode] (
	[DeviceNo] [tinyint] NOT NULL ,
	[DeviceName] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_DeviceErrorCode] (
	[DeviceErrorNo] [tinyint] NOT NULL ,
	[DeviceErrorName] [char] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[DeviceNo] [tinyint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_DeviceLog] (
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[LoginTime] [datetime] NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IDNO] [int] NOT NULL ,
	[LaneType] [smallint] NULL ,
	[DeviceType] [smallint] NULL ,
	[ExceptionType] [smallint] NOT NULL ,
	[Describe] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[RaiseTime] [datetime] NOT NULL ,
	[BackUp1] [int] NULL ,
	[BakcUp2] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_FeeRuleTypeDef] (
	[FeeRuleType] [int] NOT NULL ,
	[Name] [char] (20) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_FreeDays] (
	[FeeRuleType] [int] NULL ,
	[Type] [int] NULL ,
	[Value] [char] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_FunctionKey] (
	[FunctionNo] [smallint] NOT NULL ,
	[FunctionName] [char] (6) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[BackUp1] [int] NULL ,
	[KeyCode] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_GateSummation] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[SumType] [smallint] NOT NULL ,
	[RecordCnt] [smallint] NULL ,
	[MoneySummation] [decimal](10, 2) NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[GenTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Gateway] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[GateName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[GateAllName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[Remark] [char] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_HandInMoney] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[SquadNo] [smallint] NOT NULL ,
	[Money] [decimal](10, 2) NULL ,
	[HandInMoney] [decimal](10, 2) NULL ,
	[MoneyTypeNo] [smallint] NULL ,
	[LaneOperatorNo] [int] NULL ,
	[LaneOperatorName] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OperatorNo] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OperatorName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[OpTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_HandleType] (
	[TypeCode] [int] NOT NULL ,
	[TypeName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_HoliDayDef] (
	[Holiday] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[DayType] [int] NULL ,
	[Remark] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_ICCardStorage] (
	[Amount] [int] NOT NULL ,
	[Position] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_ICCardTransfer] (
	[RecNO] [int] NOT NULL ,
	[TransferType] [smallint] NOT NULL ,
	[Amount] [int] NOT NULL ,
	[OutPosition] [smallint] NOT NULL ,
	[InPosition] [smallint] NOT NULL ,
	[Transactor] [int] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[SquadDate] [datetime] NULL ,
	[SquadNO] [int] NULL ,
	[Verifier] [int] NULL ,
	[VerifyTime] [datetime] NULL ,
	[Remark] [varchar] (40) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_IDCardInfo] (
	[IDCardNo] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[UserName] [varchar] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Department] [varchar] (40) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Job] [varchar] (40) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[PlateList] [varchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Photo] [image] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_IdentifyResult] (
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CarSize] [smallint] NOT NULL ,
	[CarClass] [int] NOT NULL ,
	[CarBrand] [int] NOT NULL ,
	[InOutMark] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_ImageVerify] (
	[ListNO] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Host] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ImagePath] [varchar] (256) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[Verifier] [int] NOT NULL ,
	[VerifyTime] [datetime] NOT NULL ,
	[IsSave] [smallint] NOT NULL ,
	[Remark] [varchar] (40) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList01] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList02] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList03] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList04] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList05] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList06] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList07] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList08] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList09] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList10] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList11] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList12] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InListForAuto] (
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NOT NULL ,
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[SquadDate] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InListOutListPair] (
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InDateTime] [datetime] NOT NULL ,
	[OutListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OutDateTime] [datetime] NOT NULL ,
	[OutListRemark] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InListSum] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[VehType] [smallint] NOT NULL ,
	[VehClass] [smallint] NOT NULL ,
	[TicketType] [smallint] NOT NULL ,
	[UserCardType] [smallint] NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[SquadNo] [smallint] NOT NULL ,
	[OperatorNo] [int] NOT NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehCountSum] [int] NOT NULL ,
	[StatTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InList_Tmp] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [int] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[OBUid] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[SpEvent] [int] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[ListName] [smallint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_InOutSignDef] (
	[InGateNo] [int] NOT NULL ,
	[OutGateNo] [int] NOT NULL ,
	[InOutSign] [int] NULL ,
	[Remark] [char] (16) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_KeyCardStorage] (
	[RecNO] [int] NOT NULL ,
	[KeyCardID] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[KeyCardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[PSAMCardID] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[PSAMCardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardType] [smallint] NOT NULL ,
	[Position] [int] NOT NULL ,
	[Keeper] [int] NULL ,
	[Status] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_KeyCardTransfer] (
	[RecNO] [int] NOT NULL ,
	[TransferType] [smallint] NOT NULL ,
	[CardID] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardType] [smallint] NOT NULL ,
	[ICCardType] [smallint] NOT NULL ,
	[OutPosition] [int] NOT NULL ,
	[InPosition] [int] NOT NULL ,
	[Transactor] [int] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Verifier] [int] NULL ,
	[VerifyTime] [datetime] NULL ,
	[Remark] [varchar] (40) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Lane] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[LaneTypeNo] [smallint] NOT NULL ,
	[LaneComputerName] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneComputerIP] [char] (15) COLLATE Chinese_PRC_CI_AS NOT NULL, 
	[isUse] [int] null--1:表示合计启用，0表示不启用，产生合计数条件，防止车道不用也合计数错误上传到联合电子
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_LaneRemoteCommand] (
	[RecNO] [int] NOT NULL ,
	[SpeventRecNO] [int] NOT NULL ,
	[LaneNO] [smallint] NOT NULL ,
	[DeviceNO] [int] NOT NULL ,
	[CommandCode] [int] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Remark] [varchar] (128) COLLATE Chinese_PRC_CI_AS NULL ,
	[Status] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_LaneStatus] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[LaneStatusNo] [tinyint] NOT NULL ,
	[NetStatus] [tinyint] NOT NULL ,
	[FogLightStatus] [smallint] NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[SquadNo] [tinyint] NOT NULL ,
	[OperatorNo] [int] NOT NULL ,
	[RecordCounts] [int] NOT NULL ,
	[CashSum] [int] NOT NULL ,
	[LastOpTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_LaneSummation] (
	[AreaNo] [smallint] NOT NULL ,
	[parkno] [smallint] NOT NULL ,
	[gateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[SquadDate] [smalldatetime] NOT NULL ,
	[SquadNo] [tinyint] NOT NULL ,
	[LaneTypeNo] [smallint] NOT NULL ,
	[RecordCnt] [int] NOT NULL ,
	[MoneySummation] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_LaneType] (
	[LaneTypeNo] [smallint] NOT NULL ,
	[LaneTypeName] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_LaneUse] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[LaneComputerIP] [char] (15) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_LaneWatch] (
	[AreaNo] [smallint] NOT NULL ,
	[RoadNo] [smallint] NOT NULL ,
	[StationNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[RecordNo] [smallint] NOT NULL ,
	[LaneType] [smallint] NOT NULL ,
	[WorkStatus] [smallint] NOT NULL ,
	[SquadDate] [datetime] NULL ,
	[SquadNo] [smallint] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[NetStatus] [smallint] NOT NULL ,
	[ReaderStatus] [smallint] NULL ,
	[PrinterStatus] [smallint] NULL ,
	[ManulUpDownStatus] [smallint] NULL ,
	[TopLampStatus] [smallint] NULL ,
	[Loop1Status] [smallint] NULL ,
	[Loop2Status] [smallint] NULL ,
	[Loop3Status] [smallint] NULL ,
	[AutoUpDownStatus] [smallint] NULL ,
	[FogLightStatus] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[TicketType] [smallint] NULL ,
	[InvoiceID] [int] NULL ,
	[InStationName] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[ImageInfo] [image] NULL ,
	[ActionInfo] [varchar] (150) COLLATE Chinese_PRC_CI_AS NULL ,
	[getMoney] [smallint] NULL ,
	[GenTime] [datetime] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_LoseCardHis] (
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OperatorNo] [int] NOT NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[Owner] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutParkNo] [smallint] NULL ,
	[OutGateNo] [smallint] NULL ,
	[OutLaneNo] [smallint] NULL ,
	[OutOpTime] [datetime] NULL ,
	[OutSquadDate] [datetime] NULL ,
	[OutRemark] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutOperatorNo] [int] NULL ,
	[OutOperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardStatus] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Module] (
	[ModuleNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ModuleName] [varchar] (24) COLLATE Chinese_PRC_CI_AS NULL ,
	[Remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OBUDate] (
	[FirTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OpCardBlackList] (
	[CardNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpTime] [datetime] NULL ,
	[InValidTypeNo] [tinyint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Operator] (
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[OperatorNo] [int] NOT NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[OpCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[OpCardNO] [int] NULL ,
	[Password] [char] (6) COLLATE Chinese_PRC_CI_AS NULL ,
	[Status] [char] (1) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OperatorPrivilege] (
	[OperatorNo] [int] NOT NULL ,
	[ModuleNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Privilege] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OperatorRole] (
	[OperatorNo] [int] NOT NULL ,
	[RoleNo] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (1) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (1) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList01] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList02] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList03] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList04] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList05] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList06] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList07] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList08] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList09] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList10] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList11] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList12] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutListForAuto] (
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CityNo] [smallint] NOT NULL ,
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[SquadDate] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutListSum] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[VehType] [smallint] NOT NULL ,
	[VehClass] [smallint] NOT NULL ,
	[TicketType] [smallint] NOT NULL ,
	[UserCardType] [smallint] NOT NULL ,
	[CheckType] [smallint] NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[SquadNo] [smallint] NOT NULL ,
	[OperatorNo] [int] NOT NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehCountSum] [int] NOT NULL ,
	[CashMoneySum] [int] NOT NULL ,
	[FreeMoneySum] [int] NOT NULL ,
	[UnpayMoneySum] [int] NOT NULL ,
	[ETCMoneySum] [int] NOT NULL ,
	[StatTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OutList_Tmp] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_OwnerIncomeSum] (
	[ListNo] [int] NOT NULL ,
	[StartTime] [datetime] NOT NULL ,
	[EndTime] [datetime] NOT NULL ,
	[AreaNo] [smallint] NOT NULL ,
	[OwnCode] [char] (4) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OwnName] [char] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Income] [decimal](18, 3) NOT NULL ,
	[ServiceFee] [decimal](18, 3) NOT NULL ,
	[ICType] [tinyint] NOT NULL ,
	[GenDate] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Park] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[ParkName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParkFullName] [char] (40) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParkServerName] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParkServerIP] [char] (15) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParkDomain] [char] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParkDBName] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParkDBUserName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParkDBPassword] [char] (6) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParkLevel] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[UplevelParkNo] [smallint] NULL ,
	[ParkSpaceCnt] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_PassCardBlackList] (
	[CardNO] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpTime] [datetime] NULL ,
	[InValidTypeNo] [tinyint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_PlateToObuId] (
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ObuId] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_PlateToPic] (
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Picture] [image] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Position] (
	[No] [int] NOT NULL ,
	[Name] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[Class] [smallint] NOT NULL ,
	[IID] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_PriceBase] (
	[VerNo] [int] NOT NULL ,
	[FeeNo] [int] NOT NULL ,
	[RebateType] [int] NOT NULL ,
	[InOutSign] [int] NOT NULL ,
	[TimesSign] [int] NOT NULL ,
	[VehTypeNo] [int] NOT NULL ,
	[AllowStayTime] [int] NULL ,
	[BaseFeeTime] [int] NULL ,
	[BaseFee] [int] NULL ,
	[StayAdd] [int] NULL ,
	[AddFee] [int] NULL ,
	[AddStart] [int] NULL ,
	[MaxFee] [int] NULL ,
	[MaxTime] [int] NULL ,
	[MaxFeeTime] [int] NULL ,
	[SumFeeCtr] [int] NULL ,
	[backup1] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[backup2] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[StartTime] [datetime] NULL ,
	[Remark] [char] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_PriceRule] (
	[ParkNo] [smallint] NOT NULL ,
	[FeeTypeNo] [smallint] NOT NULL ,
	[VehTypeNo] [smallint] NOT NULL ,
	[StartRange] [int] NOT NULL ,
	[EndRange] [int] NULL ,
	[AllowStay] [int] NULL ,
	[BaseFee] [int] NULL ,
	[StayAdd] [int] NULL ,
	[AddFee] [int] NULL ,
	[MaxFee] [int] NULL ,
	[VerNo] [int] NULL ,
	[StartTime] [datetime] NULL ,
	[BackUp1] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_PriceRule2] (
	[ParkNo] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[FeeTypeNo] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[VehTypeNo] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[StartRange] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[EndRange] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[AllowStay] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[BaseFee] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[StayAdd] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddFee] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[MaxFee] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[VerNo] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[StartTime] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[BackUp1] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_PriceRule_zd] (
	[FeeRuleType] [int] NOT NULL ,
	[VehTypeNo] [int] NOT NULL ,
	[FeeOfOneCycle] [int] NULL ,
	[FreeTimes] [int] NULL ,
	[MaxFreeTimesUsedEveryTimes] [int] NULL ,
	[ValidateTrim] [int] NULL ,
	[InvalidateTrim] [int] NULL ,
	[remark] [char] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[MaxTotalFee] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Role] (
	[RoleNo] [smallint] NOT NULL ,
	[RoleName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[Remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_RoleModule] (
	[RoleNo] [smallint] NOT NULL ,
	[ModuleNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Privilege] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SecurityCommand] (
	[CommandID] [int] IDENTITY (1, 1) NOT NULL ,
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Type] [smallint] NOT NULL ,
	[ValidType] [smallint] NOT NULL ,
	[UseType] [smallint] NOT NULL ,
	[StartTime] [char] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[EndTime] [char] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[Attribute] [smallint] NOT NULL ,
	[HandleTime] [datetime] NULL ,
	[OperatorType] [smallint] NOT NULL ,
	[OperatorNo] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SecurityCommandBackup] (
	[CommandID] [int] NOT NULL ,
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Type] [smallint] NOT NULL ,
	[ValidType] [smallint] NOT NULL ,
	[UseType] [smallint] NOT NULL ,
	[AddTime] [datetime] NOT NULL ,
	[StartTime] [char] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[EndTime] [char] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[Attribute] [smallint] NOT NULL ,
	[ModID] [int] NOT NULL ,
	[OperatorType] [smallint] NOT NULL ,
	[OperatorNo] [int] NULL ,
	[IsValid] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SecurityCommandOperation] (
	[OperationID] [int] NOT NULL ,
	[OperationType] [smallint] NOT NULL ,
	[PreModID] [int] NOT NULL ,
	[PostModID] [int] NOT NULL ,
	[CommandID] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SecurityQueryHis] (
	[QueryRcID] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Number] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[NumberType] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Result] [smallint] NOT NULL ,
	[ResultRemark] [smallint] NOT NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[LaneNo] [smallint] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[OperatorType] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SecurityUserInfo] (
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IDCardImage] [image] NULL ,
	[CallNum] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[password] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IsValid] [smallint] NOT NULL ,
	[RegID] [int] IDENTITY (1, 1) NOT NULL ,
	[RegTime] [datetime] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SecurityVehPass] (
	[VehPassID] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[PassTime] [datetime] NOT NULL ,
	[IsAllowPass] [smallint] NOT NULL ,
	[AllowPassRemark] [smallint] NOT NULL ,
	[VehPass] [smallint] NOT NULL ,
	[PassRemark] [smallint] NOT NULL ,
	[OperatorNo] [int] NOT NULL ,
	[OperatorName] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SendPara] (
	[SendType] [smallint] NOT NULL ,
	[FieldName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[FieldValue] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[LaneComputerIP] [varchar] (15) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[TableName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[FileName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SendParaResult] (
	[SendType] [smallint] NOT NULL ,
	[FieldName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[FieldValue] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[LaneComputerIP] [varchar] (15) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[TableName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[FileName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[SendTime] [datetime] NULL ,
	[SendResult] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SpEventCode] (
	[SpEventNo] [smallint] NOT NULL ,
	[SpEventName] [char] (30) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SpVehHandle] (
	[LaneType] [smallint] NOT NULL ,
	[TableName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Status] [int] NOT NULL ,
	[HandleType] [int] NULL ,
	[Hint] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[Remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SpVehMonitor] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNo] [varchar] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Operation] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[OpTime] [datetime] NOT NULL ,
	[IsRead] [bit] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SpVehMonitorLog] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNo] [varchar] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Operation] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[OpTime] [datetime] NOT NULL ,
	[ConfirmTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SpecialType] (
	[TypeCode] [int] NOT NULL ,
	[TypeName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SpecialVeh] (
	[VehPlate] [char] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNo] [varchar] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[SpecialType] [int] NOT NULL ,
	[lanetype] [smallint] NOT NULL ,
	[info] [char] (24) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SpeventDeal] (
	[SpeventRecNO] [int] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Remark] [varchar] (128) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Squad] (
	[SquadNo] [tinyint] NOT NULL ,
	[SquadName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[StartTime] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[EndTime] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[StartDate] [datetime] NULL ,
	[TimeDiff] [smallint] NULL ,
	[Remark] [char] (30) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SquadLog] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[OperatorNo] [int] NOT NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[SquadNo] [smallint] NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[LoginTime] [datetime] NOT NULL ,
	[LogOutTime] [datetime] NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNO] [int] NULL ,
	[LaneType] [smallint] NULL ,
	[InvStartID] [int] NULL ,
	[InvEndID] [int] NULL ,
	[InvPrintCnt] [int] NULL ,
	[ICCardCnt] [int] NULL ,
	[ForeLoopCnt] [int] NULL ,
	[BackLoopCnt] [int] NULL ,
	[PoleDownCnt] [int] NULL ,
	[PoleUpCnt] [int] NULL ,
	[LoopCancelCnt] [int] NULL ,
	[ModifyCnt] [int] NULL ,
	[BadInVoiceCnt] [int] NULL ,
	[WhileVehCnt] [int] NULL ,
	[TotalVehCnt] [int] NULL ,
	[TotalVehMoney] [int] NULL ,
	[VTMoney1] [int] NULL ,
	[VTMoney2] [int] NULL ,
	[VTMoney3] [int] NULL ,
	[VTMoney4] [int] NULL ,
	[VTMoney5] [int] NULL ,
	[VTMoney6] [int] NULL ,
	[CDMoney1] [int] NULL ,
	[CDMoney2] [int] NULL ,
	[CDMoney3] [int] NULL ,
	[VTCnt1] [int] NULL ,
	[VTCnt2] [int] NULL ,
	[VTCnt3] [int] NULL ,
	[VTCnt4] [int] NULL ,
	[VTCnt5] [int] NULL ,
	[VTCnt6] [int] NULL ,
	[CDCnt1] [int] NULL ,
	[CDCnt2] [int] NULL ,
	[CDCnt3] [int] NULL ,
	[Integrality] [smallint] NULL ,
	[Backup1] [int] NULL ,
	[Backup2] [int] NULL ,
	[Backup3] [int] NULL ,
	[ListName] [smallint] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Staff] (
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[StaffName] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[StaffAddress] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Relation] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_StationSummation] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[SumType] [smallint] NOT NULL ,
	[RecordCnt] [smallint] NULL ,
	[MoneySummation] [decimal](10, 2) NULL ,
	[SquadDate] [datetime] NULL ,
	[GenTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_StoreCardBlackList] (
	[SCCode] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[GenCau] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[GenTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_StoreCardDate] (
	[FirTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SumInfo] (
	[AreaNo] [smallint] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[SquadNo] [smallint] NOT NULL ,
	[GenTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Supplylight] (
	[StartTime] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[EndTime] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_SystemPara] (
	[ParaClass] [smallint] NOT NULL ,
	[Item] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ItemValue] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[GroupName] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[ItemOrder] [smallint] NOT NULL ,
	[SendControl] [tinyint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_TestWL] (
	[CardNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OwnerName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[ObuId] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[FirTime] [datetime] NULL ,
	[InvalidateTime] [datetime] NULL ,
	[GenTime] [datetime] NULL ,
	[VehPlateImage] [image] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_TicketTypeCode] (
	[TicketTypeNo] [tinyint] NOT NULL ,
	[TicketTypeName] [char] (30) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_TimesSignDef] (
	[FeeRuleType] [int] NOT NULL ,
	[DayType] [int] NOT NULL ,
	[StartTime] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[EndTime] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[TimesSign] [int] NULL ,
	[Remark] [char] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_ToYZList_Tmp] (
	[OwnerName] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ObuId] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_TollyCardBlackList] (
	[ACCode] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[GenCau] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[GenTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_TollyCardDate] (
	[FirTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_Uniqueness] (
	[UniqueKeyName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[KeyValue] [bigint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UnusualAccountTrade] (
	[accountNo] [int] NOT NULL ,
	[seqNo] [int] NOT NULL ,
	[tradeType] [int] NOT NULL ,
	[listNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[cardNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardType] [int] NULL ,
	[tradeTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[fee] [int] NOT NULL ,
	[balance] [int] NOT NULL ,
	[cardBalance] [int] NULL ,
	[backoutedListNo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[backoutedMark] [int] NULL ,
	[parkNo] [int] NULL ,
	[vehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[inGateNo] [int] NULL ,
	[inGateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[inLaneNo] [int] NULL ,
	[inOpTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gateNo] [int] NULL ,
	[gateName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[laneNo] [int] NULL ,
	[opTime] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[operatorID] [int] NULL ,
	[operatorPassword] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[verify] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardBill] (
	[UserRecNO] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Money] [int] NOT NULL ,
	[StartTime] [datetime] NOT NULL ,
	[EndTime] [datetime] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[Version] [smallint] NOT NULL ,
	[RateRecNO] [smallint] NOT NULL ,
	[Amount] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardBlackList] (
	[UCCode] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[GenCau] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[GenTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardFeeRuleType] (
	[UserCardType] [smallint] NOT NULL ,
	[FeeRuleType] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardInfo] (
	[RecNO] [int] NOT NULL ,
	[Owner] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IDCard] [char] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlateImage] [image] NULL ,
	[ParkingSpace] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[OBU] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[RegisterTime] [datetime] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[Deposit] [int] NOT NULL ,
	[CardNO] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserCardType] [smallint] NOT NULL ,
	[FeeRuleType] [smallint] NOT NULL ,
	[RoomNo] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[TelePhone] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayEndTime] [datetime] NULL ,
	[MobileNumber] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[Address] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[StaffNo] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[VehBrand] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[LinkMan] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[Remark] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardInfoH] (
	[RecNO] [int] NOT NULL ,
	[Owner] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IDCard] [char] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlateImage] [image] NULL ,
	[ParkingSpace] [int] NULL ,
	[OBU] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[RegisterTime] [datetime] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[Deposit] [int] NOT NULL ,
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[UserType] [smallint] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardInfoHistory] (
	[RecNO] [int] NOT NULL ,
	[Owner] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IDCard] [char] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkingSpace] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[OBU] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[RegisterTime] [datetime] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[Deposit] [int] NOT NULL ,
	[CardNO] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserCardType] [smallint] NOT NULL ,
	[ModifyTime] [datetime] NOT NULL ,
	[FeeRuleType] [smallint] NULL ,
	[RoomNo] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[TelePhone] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayEndTime] [datetime] NULL ,
	[MobileNumber] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[Address] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[StaffNo] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[VehBrand] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[LinkMan] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[Remark] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardRate] (
	[Version] [smallint] NOT NULL ,
	[RecNO] [smallint] NOT NULL ,
	[UserCardType] [smallint] NOT NULL ,
	[Year] [smallint] NOT NULL ,
	[Month] [smallint] NOT NULL ,
	[Day] [smallint] NOT NULL ,
	[Money] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardRateEdit] (
	[Version] [smallint] NOT NULL ,
	[StartTime] [datetime] NOT NULL ,
	[EndTime] [datetime] NOT NULL ,
	[Operator] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Verifier] [int] NULL ,
	[VerifyTime] [datetime] NULL ,
	[Status] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardRenew] (
	[VehPlate] [nvarchar] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNo] [nvarchar] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Operation] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardRenewBak] (
	[VehPlate] [nvarchar] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNo] [nvarchar] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Operation] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_UserCardType] (
	[UserCardType] [smallint] NOT NULL ,
	[TypeName] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Remark] [varchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_VehClassCode] (
	[VehClassNo] [tinyint] NOT NULL ,
	[VehClassName] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[BackUp1] [int] NULL ,
	[KeyCode] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_VehFreeTimes] (
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Year] [int] NULL ,
	[LeftFreeTimes] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_VehFreeTimes_Update] (
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Year] [int] NULL ,
	[LeftFreeTimes] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_VehNoCmpPlate] (
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_VehTypeCode] (
	[VehTypeNo] [tinyint] NOT NULL ,
	[VehTypeName] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[BackUp1] [int] NULL ,
	[KeyCode] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_WatchSet] (
	[AreaNo] [smallint] NOT NULL ,
	[RoadNo] [smallint] NOT NULL ,
	[StationNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[IsWatch] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_WhiteList] (
	[CardNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (12) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OwnerName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[ObuId] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[FirTime] [datetime] NULL ,
	[InvalidateTime] [datetime] NULL ,
	[CardType] [smallint] NULL ,
	[Status] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_WhiteList_Recv] (
	[CardNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OwnerName] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[ObuId] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[FirstTime] [datetime] NULL ,
	[InvalidateTime] [datetime] NULL ,
	[CardType] [smallint] NULL ,
	[Status] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_WhiteList_Tmp] (
	[CardNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OwnerName] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[ObuId] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[FirstTime] [datetime] NULL ,
	[InvalidateTime] [datetime] NULL ,
	[CardType] [smallint] NULL ,
	[Status] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_WorkLog] (
	[ListNo] [int] NOT NULL ,
	[OperatorNo] [int] NOT NULL ,
	[ModuleNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpType] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OpTime] [datetime] NULL ,
	[Remark] [varchar] (60) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_YCTConsumption] (
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[YCTData] [char] (132) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_YCTInList_Tmp] (
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InGateNo] [smallint] NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_YCTOutList] (
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[YCTData] [char] (132) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_YZList_Tmp] (
	[CardNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OwnerName] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[ObuId] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[FirstTime] [datetime] NULL ,
	[InvalidateTime] [datetime] NULL ,
	[CardType] [smallint] NULL ,
	[Status] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_outlist_recv_l] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InParkName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (1) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[ParkName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (1) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_pricepasstype] (
	[ParkNo] [smallint] NOT NULL ,
	[InGateNo] [smallint] NOT NULL ,
	[OutGateNo] [smallint] NOT NULL ,
	[FeeType] [smallint] NOT NULL ,
	[VerNo] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_usercardinfo_bak20090119] (
	[RecNO] [int] NOT NULL ,
	[Owner] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IDCard] [char] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlateImage] [image] NULL ,
	[ParkingSpace] [int] NULL ,
	[OBU] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[RegisterTime] [datetime] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[Deposit] [int] NOT NULL ,
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[UserType] [smallint] NOT NULL ,
	[FeeRuleType] [smallint] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[temp_tb_carddynamic] (
	[CardNo] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[ParkNo] [smallint] NOT NULL ,
	[GateNo] [smallint] NOT NULL ,
	[LaneNo] [smallint] NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OperatorNo] [int] NOT NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[SquadDate] [datetime] NOT NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[Owner] [char] (32) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserCardType] [smallint] NOT NULL ,
	[VehType] [smallint] NOT NULL ,
	[SquadNo] [smallint] NOT NULL ,
	[inListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[VehBrand] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[TicketType] [tinyint] NOT NULL ,
	[GateName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tmp] (
	[cardno] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[cardid] [varchar] (200) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tmp_cardinfobak] (
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardID] [char] (8) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardType] [smallint] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[OpTime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tmp_cardno] (
	[cardno] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tmp_usercardbillbak] (
	[UserRecNO] [int] NOT NULL ,
	[OpTime] [datetime] NOT NULL ,
	[Money] [int] NOT NULL ,
	[StartTime] [datetime] NOT NULL ,
	[EndTime] [datetime] NOT NULL ,
	[Operator] [int] NOT NULL ,
	[Version] [smallint] NOT NULL ,
	[RateRecNO] [smallint] NOT NULL ,
	[Amount] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tmp_usercardinfobak] (
	[RecNO] [int] NOT NULL ,
	[Owner] [char] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IDCard] [char] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[VehPlateImage] [image] NULL ,
	[ParkingSpace] [int] NULL ,
	[OBU] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[RegisterTime] [datetime] NOT NULL ,
	[Status] [smallint] NOT NULL ,
	[Deposit] [int] NOT NULL ,
	[CardNO] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[UserType] [smallint] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tt_outlist_1] (
	[RecordNo] [smallint] NULL ,
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[InListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[InGateNo] [smallint] NULL ,
	[InGateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[InLaneNo] [smallint] NULL ,
	[InVehType] [smallint] NULL ,
	[InVehClass] [smallint] NULL ,
	[InVehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[InPlateImg] [varbinary] (512) NULL ,
	[InOperatorNo] [int] NULL ,
	[InOpTime] [datetime] NULL ,
	[InVehTypeAuto] [smallint] NULL ,
	[InVehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[CityNo] [smallint] NULL ,
	[AreaNo] [smallint] NULL ,
	[ParkNo] [smallint] NULL ,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[VehType] [smallint] NULL ,
	[VehClass] [smallint] NULL ,
	[VehCount] [smallint] NULL ,
	[VehPlate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PlateImg] [varbinary] (512) NULL ,
	[SquadNo] [smallint] NULL ,
	[SquadDate] [datetime] NULL ,
	[OperatorNo] [int] NULL ,
	[OperatorName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[ID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[IDNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[CardBoxNo] [int] NULL ,
	[CardTrunkNo] [int] NULL ,
	[TicketType] [smallint] NULL ,
	[UserCardType] [smallint] NULL ,
	[CardID] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardNo] [int] NULL ,
	[ObuID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardID] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[PayCardNo] [int] NULL ,
	[PayCardType] [smallint] NULL ,
	[PayCardBalance] [int] NULL ,
	[SpEvent] [int] NULL ,
	[InvoiceID] [int] NULL ,
	[CashMoney] [smallint] NULL ,
	[FreeMoney] [smallint] NULL ,
	[UnpayMoney] [smallint] NULL ,
	[ETCMoney] [smallint] NULL ,
	[VehTypeAuto] [smallint] NULL ,
	[VehPlateAuto] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PriceVerNo] [smallint] NULL ,
	[ListName] [smallint] NULL ,
	[CheckType] [smallint] NULL ,
	[InParkListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[AddCashMoney] [int] NULL ,
	[AddEtcMoney] [int] NULL ,
	[ETCTradeNo] [bigint] NULL ,
	[ETCTac] [bigint] NULL ,
	[ETCTermTradNo] [bigint] NULL ,
	[ETCTermCode] [bigint] NULL ,
	[BackUp1] [int] NULL ,
	[BackUp2] [int] NULL ,
	[BackUp3] [int] NULL ,
	[BackUp4] [int] NULL ,
	[VerifyCode] [int] NULL ,
	[UploadTime] [datetime] NULL 
) ON [PRIMARY]
GO

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
TemporaryInPark,TemporaryOutPark,ModifyTime,BackUp1,BackUp2) values('ParkNo',80,40,40,0,0,0,0,0,0,0,'2011-10-10 15:42:00',null,null)
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
-----------------------------------------------------------------------------------------------------------
--车道设备监控添加的表

CREATE TABLE [dbo].[tb_SystemEventCode](
	[SystemEventNo] [smallint] NOT NULL,
	[SystemEventName] [varchar](30) NOT NULL,
 CONSTRAINT [PK_SystemEventCode] PRIMARY KEY CLUSTERED 
(
	[SystemEventNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tb_SystemStatus](
	[StationID] [varchar](4) NOT NULL,
	[RoadNum] [smallint] NOT NULL,
	[DeviceNo] [smallint] NOT NULL,
	[SystemTypeNo] [smallint] NOT NULL,
	[Status] [smallint] NOT NULL,
	[OccurTime] [datetime] NOT NULL,
	[Info] [varchar](100) NULL,
 CONSTRAINT [PK_SystemStatus] PRIMARY KEY CLUSTERED 
(
	[StationID] ASC,
	[RoadNum] ASC,
	[OccurTime] ASC,
	[DeviceNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tb_SystemEventLog](
	[StationID] [varchar](4) NOT NULL,
	[RoadNum] [smallint] NOT NULL,
	[OccurTime] [datetime] NOT NULL,
	[DeviceNo] [smallint] NOT NULL,
	[DeviceErrorNo] [smallint] NOT NULL,
	[Code] [int] NOT NULL,
	[Severity] [smallint] NOT NULL,
	[Event] [varchar](100) NULL,
	[ImageInfo] [image] NULL,
 CONSTRAINT [PK_SystemEventLog] PRIMARY KEY CLUSTERED 
(
	[StationID] ASC,
	[RoadNum] ASC,
	[OccurTime] ASC,
	[DeviceNo] ASC,
	[DeviceErrorNo] ASC,
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[tb_CarSpaceShowMessage](--车辆进出场数量
	[ParkNo] [smallint] NOT NULL,
	[GateNo] [smallint] NOT NULL,
	[LaneNo] [smallint] NOT NULL,
	[InitShow] [varchar](150) NULL,--显示内容
	[IsShowPosition] [varchar](2) not NULL,--是否显示，0代表显示，1代表不显示
 CONSTRAINT [PK_CarSpaceShowMessage] PRIMARY KEY CLUSTERED 
(
	[ParkNo] ASC,
	[GateNo] ASC,
	[LaneNo] ASC
)
)
GO
------------------------------------------------------------------------------------------------------------
--建主外键
ALTER TABLE [dbo].[t_park_account] ADD 
	CONSTRAINT [pk_pams_accountNo] PRIMARY KEY  CLUSTERED 
	(
		[sys_id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_admin] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_admin_role] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[admin],
		[role]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_car] ADD 
	CONSTRAINT [pk_pams_car_id] PRIMARY KEY  CLUSTERED 
	(
		[sys_id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_config] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_module] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_role] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_role_module] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[role],
		[module]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_sysparamconf] ADD 
	CONSTRAINT [pk_pams_sysparamconf_id] PRIMARY KEY  CLUSTERED 
	(
		[sys_id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_systemLog] ADD 
	CONSTRAINT [pk_pams_systemLog_id] PRIMARY KEY  CLUSTERED 
	(
		[sys_id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_updateAccountLog] ADD 
	CONSTRAINT [pk_pams_updateAccountLog_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_user] ADD 
	CONSTRAINT [pk_pams_user_id] PRIMARY KEY  CLUSTERED 
	(
		[sys_id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_0714InList_temp] ADD 
	CONSTRAINT [PK_InList] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountAgentExportLog] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[SquadDate],
		[PackNo],
		[OpTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountAgentImportLog] ADD 
	CONSTRAINT [DF__tb_Accoun__Reser__269AB60B] DEFAULT ('') FOR [Reserved],
	 PRIMARY KEY  CLUSTERED 
	(
		[PackNo],
		[OpTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade] ADD 
	CONSTRAINT [pk_pams_accountTrade_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade01] ADD 
	CONSTRAINT [pk_pams_accountTrade01_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade02] ADD 
	CONSTRAINT [pk_pams_accountTrade02_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade03] ADD 
	CONSTRAINT [pk_pams_accountTrade03_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade04] ADD 
	CONSTRAINT [pk_pams_accountTrade04_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade05] ADD 
	CONSTRAINT [pk_pams_accountTrade05_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade06] ADD 
	CONSTRAINT [pk_pams_accountTrade06_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade07] ADD 
	CONSTRAINT [pk_pams_accountTrade07_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade08] ADD 
	CONSTRAINT [pk_pams_accountTrade08_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade09] ADD 
	CONSTRAINT [pk_pams_accountTrade09_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade10] ADD 
	CONSTRAINT [pk_pams_accountTrade10_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade11] ADD 
	CONSTRAINT [pk_pams_accountTrade11_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_AccountTrade12] ADD 
	CONSTRAINT [pk_pams_accountTrade12_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Area] ADD 
	CONSTRAINT [PK_Area] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BasisOfSecurityVehPass] ADD 
	CONSTRAINT [pk_BasisOfSecurityVehPass] PRIMARY KEY  NONCLUSTERED 
	(
		[VehPassID],
		[CommandID],
		[CommandModID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BillOperation] ADD 
	CONSTRAINT [PK_BillOperation] PRIMARY KEY  NONCLUSTERED 
	(
		[HankNO],
		[CardOperateType],
		[OpTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BillStorage] ADD 
	CONSTRAINT [PK_BillStorage] PRIMARY KEY  NONCLUSTERED 
	(
		[HankNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BillTransfer] ADD 
	CONSTRAINT [PK_BillTransfer] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BillTransferDetail] ADD 
	CONSTRAINT [PK_BillTransferDetail] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO],
		[HankNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BillType] ADD 
	CONSTRAINT [PK_BillType] PRIMARY KEY  NONCLUSTERED 
	(
		[BillType]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BlankCardStorage] ADD 
	CONSTRAINT [PK_BlankCardStorage] PRIMARY KEY  NONCLUSTERED 
	(
		[CardNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BlankCardTransfer] ADD 
	CONSTRAINT [PK_BlankCardTransfer] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_BlankCardTransferDetail] ADD 
	CONSTRAINT [PK_BlankCardTransferDetail] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO],
		[CardNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CarBrandCode] ADD 
	CONSTRAINT [PK_CarBrandCode] PRIMARY KEY  CLUSTERED 
	(
		[BrandNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CarClassCode] ADD 
	CONSTRAINT [PK_CarClassCode] PRIMARY KEY  CLUSTERED 
	(
		[ClassNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CarTypeTrans] ADD 
	CONSTRAINT [PK_CarTypeTrans] PRIMARY KEY  CLUSTERED 
	(
		[StartDate],
		[Class],
		[Length],
		[Height],
		[Width],
		[WheelNumber],
		[AxleNumber],
		[Weight]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardDynamic] ADD 
	CONSTRAINT [DF__tb_CardDy__UserC__58BC2184] DEFAULT (0) FOR [UserCardType],
	CONSTRAINT [DF__tb_CardDy__VehTy__59B045BD] DEFAULT (0) FOR [VehType],
	CONSTRAINT [DF__tb_CardDy__Squad__5AA469F6] DEFAULT (1) FOR [SquadNo],
	CONSTRAINT [DF__tb_cardDy__Ticke__5B988E2F] DEFAULT (1) FOR [TicketType],
	CONSTRAINT [PK_CardDynamic] PRIMARY KEY  CLUSTERED 
	(
		[CardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardDynamicTemp] ADD 
	CONSTRAINT [PK_CardDynamicTemp] PRIMARY KEY  CLUSTERED 
	(
		[CardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardGroup] ADD 
	CONSTRAINT [pk_pams_CardGroup_id] PRIMARY KEY  CLUSTERED 
	(
		[RecNo],
		[LaneGroupNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardGroupInfo] ADD 
	CONSTRAINT [pk_pams_CardGroupInfo_id] PRIMARY KEY  CLUSTERED 
	(
		[GroupNo],
		[LaneGroupNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardHandOutIn] ADD 
	CONSTRAINT [PK_CardHandOutIn] PRIMARY KEY  CLUSTERED 
	(
		[RecordNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardInfo] ADD 
	CONSTRAINT [DF__tb_CardIn__UserC__54EB90A0] DEFAULT (0) FOR [UserCardType],
	CONSTRAINT [PK_CardInfo] PRIMARY KEY  CLUSTERED 
	(
		[CardNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardInfo_bak] ADD 
	CONSTRAINT [PK_CardInfo_bak] PRIMARY KEY  CLUSTERED 
	(
		[CardNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardOperation] ADD 
	CONSTRAINT [DF__tb_CardOp__UserC__55DFB4D9] DEFAULT (0) FOR [UserCardType],
	CONSTRAINT [PK_CardOperation] PRIMARY KEY  NONCLUSTERED 
	(
		[CardNO],
		[OpTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_CardType] ADD 
	CONSTRAINT [PK_CardType] PRIMARY KEY  NONCLUSTERED 
	(
		[CardType]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_City] ADD 
	CONSTRAINT [PK_City] PRIMARY KEY  CLUSTERED 
	(
		[CityNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_DeviceActionCode] ADD 
	CONSTRAINT [PK_ACTIONCODE] PRIMARY KEY  CLUSTERED 
	(
		[DeviceActionNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_DeviceCode] ADD 
	CONSTRAINT [PK_DeviceCode] PRIMARY KEY  CLUSTERED 
	(
		[DeviceNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_DeviceErrorCode] ADD 
	CONSTRAINT [DF__tb_Device__Devic__3864608B] DEFAULT (0) FOR [DeviceNo],
	CONSTRAINT [PK_ERRORCODE] PRIMARY KEY  CLUSTERED 
	(
		[DeviceErrorNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_DeviceLog] ADD 
	CONSTRAINT [PK_DeviceLog] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[LaneNo],
		[ExceptionType],
		[RaiseTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_FeeRuleTypeDef] ADD 
	CONSTRAINT [PK_FeeRuleTypeDef] PRIMARY KEY  CLUSTERED 
	(
		[FeeRuleType]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_FunctionKey] ADD 
	CONSTRAINT [DF__tb_Functi__KeyCo__6EC0713C] DEFAULT (0) FOR [KeyCode],
	CONSTRAINT [PK_FunctionKey] PRIMARY KEY  CLUSTERED 
	(
		[FunctionNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Gateway] ADD 
	CONSTRAINT [PK_Gateway] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_HandInMoney] ADD 
	CONSTRAINT [PK_HandInMoney] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[LaneNo],
		[SquadDate],
		[SquadNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_HandleType] ADD 
	CONSTRAINT [PK_tb_HandleType] PRIMARY KEY  CLUSTERED 
	(
		[TypeCode],
		[TypeName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_HoliDayDef] ADD 
	CONSTRAINT [PK_HoliDayDef] PRIMARY KEY  CLUSTERED 
	(
		[Holiday]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_ICCardStorage] ADD 
	CONSTRAINT [PK_ICCardStorage] PRIMARY KEY  NONCLUSTERED 
	(
		[Position]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_ICCardTransfer] ADD 
	CONSTRAINT [PK_ICCardTransfer] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_IDCardInfo] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[IDCardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_IdentifyResult] ADD 
	CONSTRAINT [PK_IdentifyResult] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_ImageVerify] ADD 
	CONSTRAINT [PK_ImageVerify] PRIMARY KEY  NONCLUSTERED 
	(
		[ListNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList01] ADD 
	CONSTRAINT [PK_InList01] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList02] ADD 
	CONSTRAINT [PK_InList02] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList03] ADD 
	CONSTRAINT [PK_InList03] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList04] ADD 
	CONSTRAINT [PK_InList04] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList05] ADD 
	CONSTRAINT [PK_InList05] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList06] ADD 
	CONSTRAINT [PK_InList06] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList07] ADD 
	CONSTRAINT [PK_InList07] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList08] ADD 
	CONSTRAINT [PK_InList08] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList09] ADD 
	CONSTRAINT [PK_InList09] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList10] ADD 
	CONSTRAINT [PK_InList10] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList11] ADD 
	CONSTRAINT [PK_InList11] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList12] ADD 
	CONSTRAINT [PK_InList12] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InListForAuto] ADD 
	CONSTRAINT [PK_InListForAuto] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InListOutListPair] ADD 
	CONSTRAINT [PK_InListOutListPair] PRIMARY KEY  CLUSTERED 
	(
		[VehPlate],
		[InListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InListSum] ADD 
	CONSTRAINT [PK_InListSum] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[LaneNo],
		[VehType],
		[VehClass],
		[TicketType],
		[UserCardType],
		[SquadDate],
		[SquadNo],
		[OperatorNo],
		[OperatorName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InList_Tmp] ADD 
	CONSTRAINT [PK_InList_Tmp] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_InOutSignDef] ADD 
	CONSTRAINT [PK_InOutSignDef] PRIMARY KEY  CLUSTERED 
	(
		[InGateNo],
		[OutGateNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_KeyCardStorage] ADD 
	CONSTRAINT [PK_KeyCardStorage] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_KeyCardTransfer] ADD 
	CONSTRAINT [PK_KeyCardTransfer] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Lane] ADD 
	CONSTRAINT [PK_Lane] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[LaneNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_LaneRemoteCommand] ADD 
	CONSTRAINT [PK_LaneRemoteCommand] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_LaneStatus] ADD 
	CONSTRAINT [PK_LaneStatus] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[LaneNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_LaneSummation] ADD 
	CONSTRAINT [PK_LaneSummation] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[parkno],
		[gateNo],
		[LaneNo],
		[SquadDate],
		[SquadNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_LaneType] ADD 
	CONSTRAINT [PK_LaneType] PRIMARY KEY  CLUSTERED 
	(
		[LaneTypeNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_LaneUse] ADD 
	CONSTRAINT [PK_LaneUse] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[LaneNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_LaneWatch] ADD 
	CONSTRAINT [PK_LaneWatch] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[RoadNo],
		[StationNo],
		[LaneNo],
		[RecordNo],
		[GenTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_LoseCardHis] ADD 
	CONSTRAINT [DF__tb_LoseCa__OutLi__36D11DD4] DEFAULT ('0') FOR [OutListNo],
	CONSTRAINT [DF__tb_LoseCa__OutPa__37C5420D] DEFAULT (0) FOR [OutParkNo],
	CONSTRAINT [DF__tb_LoseCa__OutGa__38B96646] DEFAULT (0) FOR [OutGateNo],
	CONSTRAINT [DF__tb_LoseCa__OutLa__39AD8A7F] DEFAULT (0) FOR [OutLaneNo],
	CONSTRAINT [DF__tb_LoseCa__OutRe__3AA1AEB8] DEFAULT (' ') FOR [OutRemark],
	CONSTRAINT [DF__tb_LoseCa__OutOp__3B95D2F1] DEFAULT (0) FOR [OutOperatorNo],
	CONSTRAINT [DF__tb_LoseCa__OutOp__3C89F72A] DEFAULT (' ') FOR [OutOperatorName],
	CONSTRAINT [DF__tb_LoseCa__CardS__3D7E1B63] DEFAULT (0) FOR [CardStatus],
	CONSTRAINT [PK_LoseCardHis] PRIMARY KEY  CLUSTERED 
	(
		[CardNo],
		[OpTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Module] ADD 
	CONSTRAINT [PK_Module] PRIMARY KEY  CLUSTERED 
	(
		[ModuleNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OBUDate] ADD 
	CONSTRAINT [PK_OBUDate] PRIMARY KEY  CLUSTERED 
	(
		[FirTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OpCardBlackList] ADD 
	CONSTRAINT [PK_OpCardBlackList] PRIMARY KEY  CLUSTERED 
	(
		[CardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Operator] ADD 
	CONSTRAINT [PK_Operator] PRIMARY KEY  CLUSTERED 
	(
		[OperatorNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OperatorPrivilege] ADD 
	CONSTRAINT [PK_OperatorPrivilege] PRIMARY KEY  CLUSTERED 
	(
		[OperatorNo],
		[ModuleNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OperatorRole] ADD 
	CONSTRAINT [PK_OperatorRole] PRIMARY KEY  CLUSTERED 
	(
		[OperatorNo],
		[RoleNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList] ADD 
	CONSTRAINT [PK_OutList] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList01] ADD 
	CONSTRAINT [PK_OutList01] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList02] ADD 
	CONSTRAINT [PK_OutList02] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList03] ADD 
	CONSTRAINT [PK_OutList03] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList04] ADD 
	CONSTRAINT [PK_OutList04] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList05] ADD 
	CONSTRAINT [PK_OutList05] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList06] ADD 
	CONSTRAINT [PK_OutList06] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList07] ADD 
	CONSTRAINT [PK_OutList07] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList08] ADD 
	CONSTRAINT [PK_OutList08] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList09] ADD 
	CONSTRAINT [PK_OutList09] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList10] ADD 
	CONSTRAINT [PK_OutList10] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList11] ADD 
	CONSTRAINT [PK_OutList11] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList12] ADD 
	CONSTRAINT [PK_OutList12] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutListForAuto] ADD 
	CONSTRAINT [PK_OutListForAuto] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutListSum] ADD 
	CONSTRAINT [PK_OutListSum] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[LaneNo],
		[VehType],
		[VehClass],
		[TicketType],
		[UserCardType],
		[CheckType],
		[SquadDate],
		[SquadNo],
		[OperatorNo],
		[OperatorName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OutList_Tmp] ADD 
	CONSTRAINT [PK_OutList_Tmp] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_OwnerIncomeSum] ADD 
	CONSTRAINT [PK_OWNERINCOMESUM] PRIMARY KEY  NONCLUSTERED 
	(
		[StartTime],
		[EndTime],
		[OwnCode],
		[ICType]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Park] ADD 
	CONSTRAINT [PK_Park] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[ParkLevel]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_PassCardBlackList] ADD 
	CONSTRAINT [PK_PassCardBlackList] PRIMARY KEY  CLUSTERED 
	(
		[CardNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_PlateToObuId] ADD 
	CONSTRAINT [PK_tb_PlateToObuId] PRIMARY KEY  CLUSTERED 
	(
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Position] ADD 
	CONSTRAINT [PK_Position] PRIMARY KEY  CLUSTERED 
	(
		[No],
		[Class]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_PriceBase] ADD 
	CONSTRAINT [PK_PriceBase] PRIMARY KEY  CLUSTERED 
	(
		[VerNo],
		[FeeNo],
		[RebateType],
		[InOutSign],
		[TimesSign],
		[VehTypeNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_PriceRule] ADD 
	CONSTRAINT [PK_PriceRule] PRIMARY KEY  NONCLUSTERED 
	(
		[ParkNo],
		[FeeTypeNo],
		[VehTypeNo],
		[StartRange]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_PriceRule_zd] ADD 
	CONSTRAINT [DF__tb_pricer__MaxTo__1D9B5BB6] DEFAULT ((-1)) FOR [MaxTotalFee],
	CONSTRAINT [PK_PriceRule_zd] PRIMARY KEY  CLUSTERED 
	(
		[FeeRuleType],
		[VehTypeNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Role] ADD 
	CONSTRAINT [PK_role] PRIMARY KEY  CLUSTERED 
	(
		[RoleNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_RoleModule] ADD 
	CONSTRAINT [PK_RoleModule] PRIMARY KEY  CLUSTERED 
	(
		[RoleNo],
		[ModuleNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SecurityCommand] ADD 
	CONSTRAINT [PK_SecurityCommand] PRIMARY KEY  NONCLUSTERED 
	(
		[CommandID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SecurityCommandBackup] ADD 
	CONSTRAINT [PK_SecurityCommandBackup] PRIMARY KEY  NONCLUSTERED 
	(
		[CommandID],
		[ModID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SecurityCommandOperation] ADD 
	CONSTRAINT [PK_SecurityCommandOperation] PRIMARY KEY  NONCLUSTERED 
	(
		[OperationID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SecurityQueryHis] ADD 
	CONSTRAINT [PK_SecurityQueryHis] PRIMARY KEY  NONCLUSTERED 
	(
		[QueryRcID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SecurityUserInfo] ADD 
	CONSTRAINT [DF__tb_Securi__RegTi__09C96D33] DEFAULT (getdate()) FOR [RegTime],
	CONSTRAINT [PK_SecurityUserInfo] PRIMARY KEY  CLUSTERED 
	(
		[RegID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SecurityVehPass] ADD 
	CONSTRAINT [pk_SecurityVehPass] PRIMARY KEY  NONCLUSTERED 
	(
		[VehPassID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SendPara] ADD 
	CONSTRAINT [PK_SendPara] PRIMARY KEY  CLUSTERED 
	(
		[FieldValue],
		[LaneNo],
		[LaneComputerIP],
		[TableName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SendParaResult] ADD 
	CONSTRAINT [PK_SendParaSuccess] PRIMARY KEY  CLUSTERED 
	(
		[FieldValue],
		[LaneNo],
		[LaneComputerIP],
		[TableName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SpEventCode] ADD 
	CONSTRAINT [PK_SpEventCode] PRIMARY KEY  CLUSTERED 
	(
		[SpEventNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SpVehHandle] ADD 
	CONSTRAINT [PK_SpVehHandle] PRIMARY KEY  CLUSTERED 
	(
		[LaneType],
		[TableName],
		[Status]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SpVehMonitor] ADD 
	CONSTRAINT [DF_tb_SpVehWatch_CardNo] DEFAULT ('0') FOR [CardNo],
	CONSTRAINT [DF_tb_SpVehWatch_IsRead] DEFAULT (0) FOR [IsRead]
GO

ALTER TABLE [dbo].[tb_SpVehMonitorLog] ADD 
	CONSTRAINT [DF_tb_SpVehWatchLog_CardNo] DEFAULT ('0') FOR [CardNo]
GO

ALTER TABLE [dbo].[tb_SpecialType] ADD 
	CONSTRAINT [PK_tb_SpecialType] PRIMARY KEY  CLUSTERED 
	(
		[TypeCode],
		[TypeName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SpecialVeh] ADD 
	CONSTRAINT [DF_tb_SpecialVeh_CardNo] DEFAULT ('0') FOR [CardNo],
	CONSTRAINT [DF__tb_specia__lanet__48BAC3E5] DEFAULT (0) FOR [lanetype],
	CONSTRAINT [DF__tb_special__info__49AEE81E] DEFAULT (0) FOR [info],
	CONSTRAINT [PK_tb_SpecialVeh] PRIMARY KEY  CLUSTERED 
	(
		[VehPlate],
		[CardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SpeventDeal] ADD 
	CONSTRAINT [PK_SpeventDeal] PRIMARY KEY  NONCLUSTERED 
	(
		[SpeventRecNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Squad] ADD 
	CONSTRAINT [PK_Squad] PRIMARY KEY  CLUSTERED 
	(
		[SquadNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SquadLog] ADD 
	CONSTRAINT [PK_SquadLog] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[LaneNo],
		[OperatorNo],
		[SquadNo],
		[SquadDate],
		[LoginTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Staff] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[CardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_StationSummation] ADD 
	CONSTRAINT [PK_StationSummation] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[SumType]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_StoreCardBlackList] ADD 
	CONSTRAINT [PK_SCardBlackList] PRIMARY KEY  CLUSTERED 
	(
		[SCCode]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_StoreCardDate] ADD 
	CONSTRAINT [PK_StoreCardDate] PRIMARY KEY  CLUSTERED 
	(
		[FirTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SumInfo] ADD 
	CONSTRAINT [PK_SumInfo] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[ParkNo],
		[GateNo],
		[SquadDate],
		[SquadNo],
		[GenTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Supplylight] ADD 
	CONSTRAINT [PK_Supplylight] PRIMARY KEY  CLUSTERED 
	(
		[StartTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_SystemPara] ADD 
	CONSTRAINT [DF__tb_System__Group__2C88998B] DEFAULT ('Default') FOR [GroupName],
	CONSTRAINT [DF__tb_System__ItemO__2D7CBDC4] DEFAULT (32767) FOR [ItemOrder],
	CONSTRAINT [PK_SystemPara] PRIMARY KEY  CLUSTERED 
	(
		[ParaClass],
		[Item]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_TestWL] ADD 
	CONSTRAINT [PK_TestWL] PRIMARY KEY  CLUSTERED 
	(
		[CardNo],
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_TicketTypeCode] ADD 
	CONSTRAINT [PK_TicketTypeCode] PRIMARY KEY  CLUSTERED 
	(
		[TicketTypeNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_TimesSignDef] ADD 
	CONSTRAINT [PK_TimesSignDef] PRIMARY KEY  CLUSTERED 
	(
		[FeeRuleType],
		[DayType],
		[StartTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_ToYZList_Tmp] ADD 
	CONSTRAINT [PK_ToYZList_Tmp] PRIMARY KEY  CLUSTERED 
	(
		[CardNo],
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_TollyCardBlackList] ADD 
	CONSTRAINT [PK_TollyCardBlackList] PRIMARY KEY  CLUSTERED 
	(
		[ACCode]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_TollyCardDate] ADD 
	CONSTRAINT [PK_TollyCardDate] PRIMARY KEY  CLUSTERED 
	(
		[FirTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_Uniqueness] ADD 
	CONSTRAINT [DF__tb_Unique__KeyVa__1C1D2798] DEFAULT (1) FOR [KeyValue],
	CONSTRAINT [PK_Uniqueness] PRIMARY KEY  CLUSTERED 
	(
		[UniqueKeyName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UnusualAccountTrade] ADD 
	CONSTRAINT [pk_pams_UnusualAccountTrade_id] PRIMARY KEY  CLUSTERED 
	(
		[accountNo],
		[seqNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UserCardBill] ADD 
	CONSTRAINT [PK_UserCardBill] PRIMARY KEY  NONCLUSTERED 
	(
		[UserRecNO],
		[OpTime]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UserCardBlackList] ADD 
	CONSTRAINT [PK_UserCardBlackList] PRIMARY KEY  CLUSTERED 
	(
		[UCCode]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UserCardFeeRuleType] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[UserCardType]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UserCardInfo] ADD 
	CONSTRAINT [DF__tb_userca__FeeRu__2942188C] DEFAULT (0) FOR [FeeRuleType],
	CONSTRAINT [PK_UserCardInfo] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO],
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UserCardInfoH] ADD 
	CONSTRAINT [PK_UserCardInfoH] PRIMARY KEY  NONCLUSTERED 
	(
		[RecNO],
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UserCardInfoHistory] ADD 
	CONSTRAINT [DF__tb_userca__FeeRu__2D12A970] DEFAULT (null) FOR [FeeRuleType]
GO

ALTER TABLE [dbo].[tb_UserCardRate] ADD 
	CONSTRAINT [PK_UserCardRate] PRIMARY KEY  NONCLUSTERED 
	(
		[Version],
		[RecNO]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UserCardRateEdit] ADD 
	CONSTRAINT [PK_UserCardRateEdit] PRIMARY KEY  NONCLUSTERED 
	(
		[Version]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_UserCardType] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[UserCardType]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_VehClassCode] ADD 
	CONSTRAINT [DF__tb_VehCla__KeyCo__2BFE89A6] DEFAULT (0) FOR [KeyCode],
	CONSTRAINT [PK_VehClassCode] PRIMARY KEY  CLUSTERED 
	(
		[VehClassNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_VehFreeTimes] ADD 
	CONSTRAINT [PK_VehFreeTimes] PRIMARY KEY  CLUSTERED 
	(
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_VehFreeTimes_Update] ADD 
	CONSTRAINT [PK_VehFreeTimes_Update] PRIMARY KEY  CLUSTERED 
	(
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_VehNoCmpPlate] ADD 
	CONSTRAINT [PK_VehNoCmpPlate] PRIMARY KEY  CLUSTERED 
	(
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_VehTypeCode] ADD 
	CONSTRAINT [DF__tb_VehTyp__KeyCo__29221CFB] DEFAULT (0) FOR [KeyCode],
	CONSTRAINT [PK_VehTypeCode] PRIMARY KEY  CLUSTERED 
	(
		[VehTypeNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_WatchSet] ADD 
	CONSTRAINT [PK_WatchSet] PRIMARY KEY  CLUSTERED 
	(
		[AreaNo],
		[RoadNo],
		[StationNo],
		[LaneNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_WhiteList] ADD 
	CONSTRAINT [PK_WhiteList] PRIMARY KEY  CLUSTERED 
	(
		[CardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_WhiteList_Recv] ADD 
	CONSTRAINT [PK_WhiteList_01] PRIMARY KEY  CLUSTERED 
	(
		[CardNo],
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_WhiteList_Tmp] ADD 
	CONSTRAINT [PK_WhiteList_Tmp] PRIMARY KEY  CLUSTERED 
	(
		[CardNo],
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_WorkLog] ADD 
	CONSTRAINT [PK_WorkLog] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_YCTConsumption] ADD 
	CONSTRAINT [PK_tb_YCTConsumption] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_YZList_Tmp] ADD 
	CONSTRAINT [PK_YZList_Tmp] PRIMARY KEY  CLUSTERED 
	(
		[CardNo],
		[VehPlate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_outlist_recv_l] ADD 
	CONSTRAINT [PK_OutList_Recv_L] PRIMARY KEY  CLUSTERED 
	(
		[ListNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_pricepasstype] ADD 
	CONSTRAINT [PK_pricepasstype] PRIMARY KEY  CLUSTERED 
	(
		[ParkNo],
		[InGateNo],
		[OutGateNo],
		[FeeType],
		[VerNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[t_park_admin_role] ADD 
	CONSTRAINT [fk_t_park_admin_role_1] FOREIGN KEY 
	(
		[admin]
	) REFERENCES [dbo].[t_park_admin] (
		[id]
	),
	CONSTRAINT [fk_t_park_admin_role_2] FOREIGN KEY 
	(
		[role]
	) REFERENCES [dbo].[t_park_role] (
		[id]
	)
GO

ALTER TABLE [dbo].[t_park_module] ADD 
	CONSTRAINT [fk_t_park_module] FOREIGN KEY 
	(
		[parent]
	) REFERENCES [dbo].[t_park_module] (
		[id]
	)
GO

ALTER TABLE [dbo].[t_park_role_module] ADD 
	CONSTRAINT [fk_t_park_role_module_1] FOREIGN KEY 
	(
		[role]
	) REFERENCES [dbo].[t_park_role] (
		[id]
	),
	CONSTRAINT [fk_t_park_role_module_2] FOREIGN KEY 
	(
		[module]
	) REFERENCES [dbo].[t_park_module] (
		[id]
	)
GO
-----------------------------------------------------------------------------------------------------------
--建立索引
 CREATE  UNIQUE  INDEX [index_pams_pname] ON [dbo].[t_park_sysparamconf]([pname]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade]([listNo]) ON [PRIMARY]
GO

 CREATE  INDEX [ix_accounttrade_optime] ON [dbo].[tb_AccountTrade]([opTime] DESC ) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade01]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade02]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade03]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade04]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade05]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade06]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade07]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade08]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade09]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade10]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade11]([listNo]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [index_pams_ListNo] ON [dbo].[tb_AccountTrade12]([listNo]) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList01]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList01]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList02]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList02]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList03]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList03]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList04]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList04]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList05]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList05]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList06]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList06]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList07]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList07]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList08]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList08]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList09]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList09]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList10]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList10]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList11]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList11]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_in] ON [dbo].[tb_InList12]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_in] ON [dbo].[tb_InList12]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList01]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList01]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList02]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList02]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList03]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList03]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList04]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList04]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList05]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList05]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList06]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList06]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList07]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList07]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList08]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList08]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList09]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList09]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList10]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList10]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList11]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList11]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_card_out] ON [dbo].[tb_OutList12]([CardNo], [OpTime] DESC ) ON [PRIMARY]
GO

 CREATE  INDEX [idx_veh_out] ON [dbo].[tb_OutList12]([VehPlate], [OpTime] DESC ) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------------------------
--建立数据库函数

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Int2Hex]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[Int2Hex]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_DTtoStr]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[f_DTtoStr]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_GateSummation]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[f_GateSummation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_GetWhysName]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[f_GetWhysName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_PlateMatch]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[f_PlateMatch]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_getSpName]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[f_getSpName]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Dec2Bin]') and xtype in (N'FN', N'IF', N'TF'))
-- 删除函数
drop function [dbo].[Dec2Bin]
GO
----------------------------------------------------------------------------------------------------------------------
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create function Int2Hex (@value int)
returns varchar(8)
as
begin
	declare @tmp int
	declare @str varchar(8)
	set @str = ''
	while @value <> 0
	begin
		set @tmp = @value %16
		set @value = @value / 16
		if @tmp = 10	set @str = 'A' + @str
		if @tmp = 11	set @str = 'B' + @str
		if @tmp = 12	set @str = 'C' + @str
		if @tmp = 13	set @str = 'D' + @str
		if @tmp = 14	set @str = 'E' + @str
		if @tmp = 15	set @str = 'F' + @str
		if @tmp <10 	set @str = cast(@tmp as char(1)) + @str
	end
	
	return @str
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

CREATE  function f_DTtoStr(@Value Datetime,@Style int)
Returns VARCHAR(20)
As
Begin
--函数说明：返回一个DateTime类型的转变为varchar类型的字符串
--					@Style :0 返回格式yyyy-mm-dd
--									1 返回格式yyyy-mm
--									2 返回格式yyyy-mm-dd hh:mm:ss
-- 									3 返回星期几
--									4 返回格式yyyymmddT000000	
--									5 返回格式yyyymmdd				
--									6 返回格式yyyy				
  Declare @Year int,
          @Month int,
          @Day int,
          @Hour int,
          @Minute int,
          @Second int,
          @Week		int,
          @strReturn varchar(20)
  
  if @Value is null 
  	return '19000101T000000'
  set @Year=Datepart(yyyy,@Value)
  set @Month=Datepart(mm,@Value)
  set @Day=Datepart(dd,@Value)
  set @Hour=Datepart(hh,@Value)
  set @Minute=Datepart(mi,@Value)
  set @Second=Datepart(ss,@Value)
  set @Week=Datepart(dw,@Value)
  
  if  @Style = 0
  	set @strReturn = convert(varchar(4),@year) 
  					 +'-'+(case when @Month<10 then '0' else '' end)+ convert(varchar(2),@Month)
      	 			 +'-'+(case when @Day<10 then '0' else '' end)+convert(varchar(2),@Day)
  else if @Style = 1
  	set @strReturn = convert(varchar(4),@year) 
  					 +'-'+(case when @Month<10 then '0' else '' end)+ convert(varchar(2),@Month)
  else if @Style = 2
  	set @strReturn = convert(varchar(4),@year) 
  					 +'-'+(case when @Month<10 then '0' else '' end)+ convert(varchar(2),@Month)
  					 +'-'+(case when @Day<10 then '0' else '' end)+convert(varchar(2),@Day)
       				 +' '+(case when @Hour<10 then '0' else '' end)+convert(varchar(2),@Hour)
					 +':'+(case when @Minute<10 then '0' else '' end)+convert(varchar(2),@Minute)
					 +':'+(case when @Second<10 then '0' else '' end)+convert(varchar(2),@Second)
	else if @Style = 3
			set @strReturn = (case @week when 2 then  '星期一'
     									 when 3 then  '星期二'
     									 when 4 then  '星期三'
     									 when 5 then  '星期四'
     									 when 6 then  '星期五'
     									 when 7 then  '星期六'
     									 when 1 then  '星期日'
     									 else 'yyyy-mm-dd'
							  end)
			
	else if @Style = 4
		set @strReturn = convert(varchar(4),@year) 
						 + (case when @Month<10 then '0' else '' end)+ convert(varchar(2),@Month)
						 +(case when @Day<10 then '0' else '' end)+convert(varchar(2),@Day)
						 +'T'
						 +(case when @Hour<10 then '0' else '' end)+convert(varchar(2),@Hour)
						 +(case when @Minute<10 then '0' else '' end)+convert(varchar(2),@Minute)
						 +(case when @Second<10 then '0' else '' end)+convert(varchar(2),@Second)
	else if @Style = 5
		set @strReturn = convert(varchar(4),@year) 
						 + (case when @Month<10 then '0' else '' end)+ convert(varchar(2),@Month)
						 +(case when @Day<10 then '0' else '' end)+convert(varchar(2),@Day)						 
	else if @Style = 6
		set @strReturn = convert(varchar(4),@year)+'年'
	else
		set @strReturn = 'yyyy-mm-dd'
		
  return @strReturn  
End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


Create function f_GateSummation(@dtSquadDate datetime,@dtNow datetime)
Returns @tb_GateSum table (
	AreaNo 		char(4),
	ParkNo 		char(4),
	GateNo 		char(4),
	SumType 	char(1),
	RecordCnt 	char(7),
	MoneySummation 	char(12),
	SquadDate 	char(8),
	GenTime 	char(15)
	)
As
Begin				
	Declare	@Month int
	
	set @Month=Datepart(mm,@dtSquadDate)

	IF (@Month = 1)  
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList01
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6) and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	IF (@Month = 2)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList02
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	IF (@Month = 3)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList03
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
			
	IF (@Month = 4)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList04
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	IF (@Month = 5)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList05
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	IF (@Month = 6)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList06
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	IF (@Month = 7)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList07
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	IF (@Month = 8)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList08
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	
	IF (@Month = 9)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList09
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	IF (@Month = 10)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList10
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	IF (@Month = 11)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList11
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	
	IF (@Month = 12)   
		Insert Into @tb_GateSum
		Select 	cast(AreaNo as char(4)),
			cast(ParkNo as char(4)),
			cast(GateNo as char(4)),
    			'8' as SumType,
    			cast(count(*) as char(7)) as RecordCnt,
    			cast(sum(ETCMoney) as char(12)) as MoneySummation,
    			dbo.f_DTtoStr(SquadDate,5) as SquadDate,
    			dbo.f_DTtoStr(@dtNow,4) as GenTime
		From tb_OutList12
		Where SquadDate=@dtSquadDate and ETCMoney<>0 and vehclass=6 and tickettype in (5,6)
		Group By AreaNo,ParkNo,GateNo,SquadDate
	
	RETURN 

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


Create   function f_GetWhysName(@Value Integer)
Returns VARCHAR(200)
As
Begin
DECLARE @ReturnStr			VARCHAR(200)	
	
	Set @ReturnStr=''
	
	IF (@Value > 0 )
		begin
			IF (@Value/power(2,0)%2=1)  
				Set @ReturnStr = @ReturnStr + ' 无标签转刷卡 '
			IF (@Value/power(2,1)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 卡未插好 '
			IF (@Value/power(2,2)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 锁其它标签而丢弃 '
			IF (@Value/power(2,3)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 锁空标签而丢弃 '
			IF (@Value/power(2,4)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 车牌识别不符而转刷卡 '
			IF (@Value/power(2,5)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 读超时(收到80错误码) '
			IF (@Value/power(2,6)%2=1) 
				Set @ReturnStr = @ReturnStr + ' ICNOTCOMPLETE(在提示报警信息前，收到41_01) '
			IF (@Value/power(2,7)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 车牌不符 '					
			IF (@Value/power(2,8)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 认为在旁道交易而丢弃 '	
			IF (@Value/power(2,9)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 防跟车干扰天线过滤 '	
			IF (@Value/power(2,10)%2=1) 
				Set @ReturnStr = @ReturnStr + ' OBU排队丢弃 '	
			IF (@Value/power(2,11)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 已交易过丢弃 '	
			IF (@Value/power(2,12)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 禁止外出 '	
			IF (@Value/power(2,13)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 非法拆卸 '	
			IF (@Value/power(2,14)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 锁卡 '
			IF (@Value/power(2,15)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 等待车牌识别而丢弃 '		
			IF (@Value/power(2,16)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 特殊车辆转刷卡 '								
			IF (@Value/power(2,17)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 有未回收的临时卡，拦截 '	
			IF (@Value/power(2,18)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 黑名单 '	
			IF (@Value/power(2,19)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 车型转换/卡类型错误 '				
			IF (@Value/power(2,20)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 未报无标签就转人工刷卡 '		
			IF (@Value/power(2,21)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 等待45帧 '		
			IF (@Value/power(2,22)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 无费率/无入口 '
			IF (@Value/power(2,23)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 余额不足 '				
			IF (@Value/power(2,24)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 电压低 '				
			IF (@Value/power(2,25)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 车辆验证没通过 '				
			IF (@Value/power(2,26)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 写Obu失败 '																			
		end
	ELSE IF @Value<0 
		Set @ReturnStr = @ReturnStr + ' 其它原因 '		
	ELSE
		Set @ReturnStr = ' 自动过车 ' 	
	
	RETURN @ReturnStr;

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


CREATE  function f_PlateMatch(@SrcVehPlate varchar(20),@DesVehPlate varchar(20),@StartPos int,@MatchNum int)
Returns int
As
Begin
--函数说明：判断车牌是否符合匹配条件，车牌位数不一致返回-1，匹配正确位数不合格返回0，匹配正确位数合格返回匹配正确位数
--					@SrcVehPlate :匹配车牌
--					@DesVehPlate :目标车牌
--					@StartPos :匹配起始位
-- 					@MatchNum :匹配正确位数

	Declare @MatchLength int,
			@SrcVehPlateLength int,
    		@DesVehPlateLength int,
    		@MatchPos int,
			@SameCount int
  
	--如果匹配车牌位数不一致，返回-1
	set @SrcVehPlateLength = LEN(@SrcVehPlate)
	set @DesVehPlateLength = LEN(@DesVehPlate)
	if @SrcVehPlateLength <> @DesVehPlateLength return -1
	
	--如果匹配车牌位数不够，返回-1
	set @MatchLength = @DesVehPlateLength-@StartPos+1
	if @MatchLength < @MatchNum	return -1
	
	set @MatchPos = @StartPos
	set @SameCount = 0
	While @MatchPos <= @DesVehPlateLength
	Begin
		--匹配计算器加一，字符为_（下划线），该字符不用匹配
		if SUBSTRING(@SrcVehPlate,@MatchPos,1) = SUBSTRING(@DesVehPlate,@MatchPos,1) or SUBSTRING(@DesVehPlate,@MatchPos,1)='_'
			set @SameCount = @SameCount + 1
		--下一个字符
		set @MatchPos  = @MatchPos + 1	 
	End

	--匹配正确位数不够，返回-1
	if @SameCount < @MatchNum	return 0
	return @SameCount

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


create   function f_getSpName(@Value Integer)
Returns VARCHAR(100)
As
Begin
DECLARE @ReturnStr			VARCHAR(100)	
	
	Set @ReturnStr=''
	
	IF (@Value > 0 )
		begin
			IF (@Value/power(2,0)%2=1)  
				Set @ReturnStr = @ReturnStr + ' 闯关车 '
			IF (@Value/power(2,1)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 挂车 '
			IF (@Value/power(2,2)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 倒车 '
			IF (@Value/power(2,3)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 拖车 '
			IF (@Value/power(2,4)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 车型不符 '
			IF (@Value/power(2,5)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 车种不符 '
			IF (@Value/power(2,6)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 车牌不符 '
			IF (@Value/power(2,7)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 丢卡 '					
			IF (@Value/power(2,8)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 坏卡 '	
			IF (@Value/power(2,9)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 修改 '	
			IF (@Value/power(2,10)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 超时 '	
			IF (@Value/power(2,11)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 换卡 '	
			IF (@Value/power(2,12)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 回头车 '	
			IF (@Value/power(2,13)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 重打 '	
			IF (@Value/power(2,14)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 车队 '
			IF (@Value/power(2,15)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 紧急车 '		
			IF (@Value/power(2,16)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 免费车 '								
			IF (@Value/power(2,17)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 校内车 '	
			IF (@Value/power(2,18)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 逆行 '	
			IF (@Value/power(2,19)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 未付车 '				
			IF (@Value/power(2,20)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 未知 '		
			IF (@Value/power(2,21)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 未知 '		
			IF (@Value/power(2,22)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 抬杆放行 '
			IF (@Value/power(2,23)%2=1) 
				Set @ReturnStr = @ReturnStr + ' 优惠车辆 '				
		end
	ELSE
		Set @ReturnStr = ' 正常车 ' 	
	
	RETURN @ReturnStr;

End

Go
-- 功能: 将十进制数(INT)转换为二进制字符串(VARCHAR)  
-- 输入参数: @Dec 待转换的十进制数,正数,  @StrLen 返回的二进制字符串的长度  
-- 返回值: 二进制形式表示的字符串  
-- 注意: 如果@Dec转换后的实际长度小于@StrLen,则左边补足"0",如果@Dec转换后的实际长度  
--       大于@StrLen,则以实际长度返回  
-- 作者: cheyfuyuan   
-- 日期: 2005-09-29  
-- 例子: SELECT 'B' + dbo.Dec2Bin(15, 4) AS '15的二进制表示'  
CREATE FUNCTION Dec2Bin(@Dec INT, @StrLen TINYINT)  
RETURNS VARCHAR(31) -- INT型,4字节,正数转为二进制字符串最多31位  
AS  
BEGIN  
    DECLARE @BinStr AS VARCHAR(31)      -- 二进制表示的字符串  
    DECLARE @Div2 AS INT                -- 商  
    DECLARE @Mod2 AS INT                -- 模/余数  
    IF @Dec < 0  
        RETURN 'NULL'              -- 不支持负数的转换  
    SET @Div2 = @Dec / 2    
    SET @Mod2 = @Dec % 2    
    SET @BinStr = ''  
    WHILE @Div2 <> 0  
    BEGIN  
        SET @BinStr = CAST(@Mod2 AS CHAR(1)) + @BinStr  
        SET @Dec = @Dec / 2  
        SET @Div2 = @Dec / 2  
        SET @Mod2 = @Dec % 2  
    END  
      
    SET @BinStr = CAST(@Mod2 AS CHAR(1)) + @BinStr -- 至此,已完成十进制到二进制的转换  
    IF @StrLen > LEN(@BinStr)    -- 如果用户指定的长度大于实际长度，则需要左边补0  
        BEGIN  
            IF @StrLen > 31    -- 返回的长度，最长为32  
                SET @StrLen = 31  
      
            DECLARE @ZeroStr VARCHAR(31)    -- 需要补充的"0000..."  
            DECLARE @OffsetLen TINYINT       -- 需要补充几个"0"  
            SET @ZeroStr = ''  
            SET @OffsetLen = @StrLen - LEN(@BinStr)  
      
            WHILE  @OffsetLen > 0  
            BEGIN  
                SET @ZeroStr = @ZeroStr + '0'   
                SET @OffsetLen = @OffsetLen - 1  
            END  
      
            SET @BinStr = @ZeroStr + @BinStr  
        END  
    RETURN @BinStr  
END  
GO
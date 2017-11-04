--2012-11-29
--华师刷卡优惠模块
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES ( 3, N'刷卡优惠', N'/freeAction_index.do', N'/freeAction_isSysCard.do', 100, 1, 2, N'')
--2012-12-10
--华师通行费分车道分时段报表模块
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (27, N'通行费分车道分时段报表',N'/tollsReport_tollsLane.do',N'/tollsReport_tollsLane.do',90,1,3,N'')
--华师通行费分车道分时段报表（2）模块
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (27, N'通行费分车道分时段报表(2)',N'/otherTollsReport_tollsLane.do',N'/otherTollsReport_tollsLane.do',100,1,3,N'')



INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (485, N'生成HTML报表and查询',N'/tollsReport_tollsLaneReport.do',N'/tollsReport_tollsLaneReport.do',10,0,4,N'')
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (485, N'生成PDF报表',N'/tollsReport_tollsLaneReportPDF.do',N'/tollsReport_tollsLaneReportPDF.do',20,0,4,N'')
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (486, N'生成HTML报表and查询',N'/otherTollsReport_tollsLaneReport.do',N'/otherTollsReport_tollsLaneReport.do',10,0,4,N'')
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (486, N'生成PDF报表',N'/otherTollsReport_tollsLaneReportPDF.do',N'/otherTollsReport_tollsLaneReportPDF.do',20,0,4,N'')

--插入角色模块表 
insert into t_park_role_module values(1,484)
insert into t_park_role_module values(1,485)
insert into t_park_role_module values(1,486) 
insert into t_park_role_module values(1,487)
insert into t_park_role_module values(1,488) 
insert into t_park_role_module values(1,489) 
insert into t_park_role_module values(1,490)  

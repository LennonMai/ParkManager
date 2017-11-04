CREATE TABLE [dbo].[tb_vipInList](
	[RecordNo] [smallint] NULL,
	[ListNo] [char](16) NOT NULL,
	[CityNo] [int] NULL,
	[AreaNo] [smallint] NULL,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL,
	[GateName] [char](8) NULL,
	[LaneNo] [smallint] NULL,
	[VehType] [smallint] NULL,
	[VehClass] [smallint] NULL,
	[VehCount] [smallint] NULL,
	[VehPlate] [varchar](10) NULL,
	[PlateImg] [varbinary](512) NULL,
	[SquadNo] [smallint] NULL,
	[SquadDate] [datetime] NULL,
	[OperatorNo] [int] NULL,
	[OperatorName] [char](8) NULL,
	[ID] [char](16) NULL,
	[IDNo] [int] NULL,
	[OpTime] [datetime] NULL,
	[CardBoxNo] [int] NULL,
	[CardTrunkNo] [int] NULL,
	[TicketType] [smallint] NULL,
	[UserCardType] [smallint] NULL,
	[CardID] [char](16) NULL,
	[CardNo] [int] NULL,
	[OBUid] [char](16) NULL,
	[SpEvent] [int] NULL,
	[VehTypeAuto] [smallint] NULL,
	[VehPlateAuto] [char](10) NULL,
	[ListName] [smallint] NULL,
	[BackUp1] [int] NULL,
	[BackUp2] [int] NULL,
	[BackUp3] [int] NULL,
	[BackUp4] [int] NULL,
	[VerifyCode] [int] NULL,
	[UploadTime] [datetime] NULL,
 CONSTRAINT [PK_vipInList] PRIMARY KEY CLUSTERED 
(
	[ListNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



CREATE TABLE [dbo].[tb_vipOutList](
	[RecordNo] [smallint] NULL,
	[ListNo] [char](16) NOT NULL,
	[InListNo] [char](16) NULL,
	[InGateNo] [smallint] NULL,
	[InGateName] [char](8) NULL,
	[InLaneNo] [smallint] NULL,
	[InVehType] [smallint] NULL,
	[InVehClass] [smallint] NULL,
	[InVehPlate] [char](10) NULL,
	[InPlateImg] [varbinary](512) NULL,
	[InOperatorNo] [int] NULL,
	[InOpTime] [datetime] NULL,
	[InVehTypeAuto] [smallint] NULL,
	[InVehPlateAuto] [char](10) NULL,
	[CityNo] [smallint] NULL,
	[AreaNo] [smallint] NULL,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL,
	[GateName] [char](8) NULL,
	[LaneNo] [smallint] NULL,
	[VehType] [smallint] NULL,
	[VehClass] [smallint] NULL,
	[VehCount] [smallint] NULL,
	[VehPlate] [char](10) NULL,
	[PlateImg] [varbinary](512) NULL,
	[SquadNo] [smallint] NULL,
	[SquadDate] [datetime] NULL,
	[OperatorNo] [int] NULL,
	[OperatorName] [char](8) NULL,
	[ID] [char](16) NULL,
	[IDNo] [int] NULL,
	[OpTime] [datetime] NULL,
	[CardBoxNo] [int] NULL,
	[CardTrunkNo] [int] NULL,
	[TicketType] [smallint] NULL,
	[UserCardType] [smallint] NULL,
	[CardID] [char](16) NULL,
	[CardNo] [int] NULL,
	[ObuID] [char](16) NULL,
	[PayCardID] [char](16) NULL,
	[PayCardNo] [int] NULL,
	[PayCardType] [smallint] NULL,
	[PayCardBalance] [int] NULL,
	[SpEvent] [int] NULL,
	[InvoiceID] [int] NULL,
	[CashMoney] [smallint] NULL,
	[FreeMoney] [smallint] NULL,
	[UnpayMoney] [smallint] NULL,
	[ETCMoney] [smallint] NULL,
	[VehTypeAuto] [smallint] NULL,
	[VehPlateAuto] [char](10) NULL,
	[PriceVerNo] [smallint] NULL,
	[ListName] [smallint] NULL,
	[CheckType] [smallint] NULL,
	[InParkListNo] [char](16) NULL,
	[AddCashMoney] [int] NULL,
	[AddEtcMoney] [int] NULL,
	[ETCTradeNo] [bigint] NULL,
	[ETCTac] [bigint] NULL,
	[ETCTermTradNo] [bigint] NULL,
	[ETCTermCode] [bigint] NULL,
	[BackUp1] [int] NULL,
	[BackUp2] [int] NULL,
	[BackUp3] [int] NULL,
	[BackUp4] [int] NULL,
	[VerifyCode] [int] NULL,
	[UploadTime] [datetime] NULL,
 CONSTRAINT [PK_vipOutList] PRIMARY KEY CLUSTERED 
(
	[ListNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

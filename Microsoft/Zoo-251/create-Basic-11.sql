-- Table with columns of different numeric types
create table Basic_01_Numeric_Types
(
    [bit]         bit,
    [tinyint]     tinyint,
    [smallint]    smallint,
    [int]         int,
    [bigint]      bigint,
    [decimal(1)]  decimal(1),  -- 5 bytes
    [decimal(9)]  decimal(9),
    [decimal(10)] decimal(10), -- 9 bytes
    [decimal(19)] decimal(19),
    [decimal(20)] decimal(20), -- 13 bytes
    [decimal(28)] decimal(28),
    [decimal(29)] decimal(29), -- 17 bytes
    [decimal(38)] decimal(38), -- 17 bytes
    [smallmoney]  smallmoney,
    [money]       money,
    [real]        real,
    [float(25)]   float(25)    -- 8 bytes
)


-- Table with columns of different text types
create table Basic_02_Text_Types
(
    [char]          char,
    [char(8)]       char(8),
    [varchar(8)]    varchar(8),
    [varchar(max)]  varchar(max),
    [text]          text,
    [nchar]         nchar,
    [nchar(8)]      nchar(8),
    [nvarchar(8)]   nvarchar(8),
    [nvarchar(max)] nvarchar(max),
    [ntext]         ntext
)

-- Table with columns of different calendar types
create table Basic_03_Calendar_Types
(
    [date]           date,
    [time]           time,
    [smalldatetime]  smalldatetime,
    [datetime]       datetime,
    [datetime2]      datetime2,
    [datetimeoffset] datetimeoffset,
    [timestamp]      timestamp
)

-- Table with columns of other/unsorted types
create table Basic_04_Other_Types
(
    [uniqueidentifier] uniqueidentifier,
    [xml]              xml
)

go


-- Table with columns of different numeric types
create table Zoo.Basic_01_Numeric_Types
(
    [bit]         bit      default 0,
    [tinyint]     tinyint  default 42,
    [smallint]    smallint default 1984,
    [int]         int      default 123456789,
    [bigint]      bigint   default 1234567890,
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
create table Zoo.Basic_02_Text_Types
(
    [char]          char         default 'A',
    [char(8)]       char(8)      default 'XyZ',
    [varchar(8)]    varchar(8)   default 'A word',
    [varchar(max)]  varchar(max),
    [text]          text,
    [nchar]         nchar        default N'Я',
    [nchar(15)]     nchar(15)    default N'Größenmaßstäbe',
    [nvarchar(15)]  nvarchar(15) default N'Fußgängerübergänge',
    [nvarchar(max)] nvarchar(max),
    [ntext]         ntext
)
-- Table with columns of different calendar types
create table Zoo.Basic_03_Calendar_Types
(
    [date]           date          default getdate(),
    [time]           time          default getdate(),
    [smalldatetime]  smalldatetime default sysdatetime(),
    [datetime]       datetime      default sysdatetime(),
    [datetime2]      datetime2     default sysdatetime(),
    [datetimeoffset] datetimeoffset,
    [timestamp]      timestamp
)
-- Table with columns of other/unsorted types
create table Zoo.Basic_04_Other_Types
(
    [uniqueidentifier] uniqueidentifier,
    [xml]              xml
)
go

-- View with all columns
create view Zoo.Basic_09_All_Types
as
select *
from Zoo.Basic_01_Numeric_Types,
     Zoo.Basic_02_Text_Types,
     Zoo.Basic_03_Calendar_Types,
     Zoo.Basic_04_Other_Types
go



-- Table with basic primary key and a basic indices
create table Zoo.Basic_11_Key
(
    C0 char,
    F1 int not null,
    F2 int not null,
    F3 int not null,
    F4 int not null,
    F5 int,
    F6 int,
    F7 int,
    F8 varchar(15),
    X1 varchar(15),
    constraint Basic_11_Key_pk primary key (F1, F2),
    constraint Basic_11_Key_ak unique (F3, F4)
)
create index Basic_11_Key_i1 on Zoo.Basic_11_Key (F5, F6, F7) include (F8)
go

-- Table with non-primary cluster key and primary non-clustered key
create table Zoo.Basic_12_C
(
    C0 char,
    F1 int not null,
    F2 int not null,
    F3 int not null,
    F4 int not null,
    F5 int,
    F6 int,
    F7 int,
    X1 varchar(15)
)
create clustered index Basic_12_C_cluster on Zoo.Basic_12_C (F1, F2)
alter table Zoo.Basic_12_C
    add constraint Basic_12_C_pk primary key (F3, F4)
create index Basic_12_C_i1 on Zoo.Basic_12_C (F5, F6, F7)
go

-- Table with a serial column and foreign keys to tables 11 and 12
create table Zoo.Basic_13_ForeignKeys
(
    Id int identity constraint Basic_13_ForeignKeys_pk primary key,
    A int,
    B int,
    C int,
    D int,
    E int,
    F int,
    Note varchar(80),
    constraint Basic_13_fk_11_a foreign key (A,B) references Zoo.Basic_11_Key,
    constraint Basic_13_fk_11_b foreign key (C,D) references Zoo.Basic_11_Key (F3,F4),
    constraint Basic_13_fk_12 foreign key (E,F) references Zoo.Basic_12_C
)
go
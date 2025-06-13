create fulltext catalog Ftx_Default as default
go

create table Zoo.Ftx_Tab_1 (
  Id int not null
      constraint Ftx_Tab_1_pk primary key,
  Note nvarchar(255)
)

create table Zoo.Ftx_Tab_2 (
  Id int not null
      constraint Ftx_Tab_2_pk primary key,
  Note nvarchar(1000)
)

create fulltext index on Zoo.Ftx_Tab_1 (Note) key index Ftx_Tab_1_pk;
create fulltext index on Zoo.Ftx_Tab_2 (Note) key index Ftx_Tab_2_pk;
go


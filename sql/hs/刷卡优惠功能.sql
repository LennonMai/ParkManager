create table tb_rebate(
RebateNo int primary key,
RebateType int,
ValueType int,
RebateTime int, 
RebateAmount int,
RebateName varchar(50)
)
insert into tb_rebate values(11,0,1,240,0,'³Ô·¹');
insert into tb_rebate values(12,0,1,480,0,'»áÒé');
insert into tb_rebate values(13,0,3	,0,	0,'×¡ËŞ');
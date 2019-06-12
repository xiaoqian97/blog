create database music;


use music;

CREATE TABLE user (
	account varchar(50) not null,
	password varchar(50) not null,
	state varchar(50) not null,
	nickname varchar(50) not null,
	gender varchar(50) not null,
	birthday varchar(50) not null,
	PRIMARY KEY (account)
)  DEFAULT CHARSET=utf8;

create table song(
	id int(11) PRIMARY KEY AUTO_INCREMENT,
	name varchar(50) not null,
	filesize varchar(50) not null,
	singer varchar(50) not null,
	path varchar(50) not null,
	account varchar(50) not null,
	foreign key(account) references user(account)
)

insert into user values ('admin', '123456', '1', '管理员', '男', '20000101');
insert into user values ('张三', 'a123', '0', '张三', '男', '19980419');
insert into user values ('user01', '000', '0', '游客', '女', '19990323');
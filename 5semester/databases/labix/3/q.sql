create database lab3;
use lab3;

create table tasks (
  id int primary key auto_increment,
  taskname varchar(45) not null,
  taskmonth varchar(45),
  taskday varchar(45),
  u_id int
);



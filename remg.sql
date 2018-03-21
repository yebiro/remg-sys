-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 2017-12-26 06:59:53
-- 服务器版本： 5.7.19
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `remg`
--

DELIMITER $$
--
-- 存储过程
--
DROP PROCEDURE IF EXISTS `add_activities`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_activities` (IN `aid` VARCHAR(4), IN `aname` VARCHAR(15), IN `begin_time` DATETIME, IN `end_time` DATETIME)  begin
   set names utf8;
   insert into activities (aid,aname,begin_time,end_time)
   values  (aid,aname,begin_time,end_time);
end$$

DROP PROCEDURE IF EXISTS `add_customers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_customers` (IN `cid` VARCHAR(4), IN `cname` VARCHAR(15), IN `sex` VARCHAR(15), IN `telephone_no` VARCHAR(15), IN `birthdate` DATETIME)  begin
   set names utf8;
   insert into customers (cid,cname,sex,level,integral,register_time,last_visit_time,visits_made,telephone_no,birthdate)
   values  (cid,cname,sex,"regular",100,current_timestamp,current_timestamp,1,telephone_no,birthdate);
end$$

DROP PROCEDURE IF EXISTS `add_meals`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_meals` (IN `mid` VARCHAR(4), IN `mname` VARCHAR(15), IN `mprice` DECIMAL(6,2), IN `meal_integral` INT(5), IN `qoh` INT(5), IN `qoh_threshold` INT(5))  begin
   set names utf8;
   insert into meals (mid,mname,mprice,meal_integral,qoh,qoh_threshold)
   values  (mid,mname,mprice,meal_integral,qoh,qoh_threshold);
end$$

DROP PROCEDURE IF EXISTS `add_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_orders` (IN `oid1` VARCHAR(4), IN `telephone_no1` VARCHAR(15), IN `eid1` VARCHAR(4), IN `sid1` VARCHAR(4), IN `mid1` VARCHAR(4), IN `aid1` VARCHAR(4), IN `qty` INT(5), IN `a_discount` DECIMAL(6,2))  begin
   declare cid1 varchar(4);
   declare price decimal(6,2);
   declare clevel varchar(15);
   declare discount decimal(6,2);
   declare finalprice decimal(6,2);
   declare btime datetime;
   declare etime datetime;
   set cid1="";
   
   select cid into cid1 from customers where telephone_no=telephone_no1 limit 1;
   if cid1="" then
    set @error_phone='手机号不存在！';
    signal sqlstate '45000' set message_text='手机号不存在！';
    
   else if cid1 !="" then
   select mprice into price from meals where mid=mid1 limit 1;
   select level into clevel from customers where cid=cid1 limit 1;
   select c_discount into discount from clevels where level=clevel limit 1;
   set finalprice=price*qty*discount*a_discount;
   insert into orders (oid,cid,eid,sid,mid,aid,staid,qty,otime,a_discount,final_price)
   values  (oid1,cid1,eid1,sid1,mid1,aid1,"sta0",qty,current_timestamp,a_discount,finalprice);
   
   end if;
   end if;
end$$

DROP PROCEDURE IF EXISTS `confirm_manager`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `confirm_manager` (IN `mgid1` VARCHAR(6), IN `password1` VARCHAR(20))  begin
  declare confirmation varchar(20);
  set confirmation="";
  set  @error_login="";
  select mgname into confirmation from managers where mgid=mgid1 and password=password1;
  if confirmation="" then
  set @error_login="账号或密码不对！";
  end if;
end$$

DROP PROCEDURE IF EXISTS `del_activities`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_activities` (IN `id` VARCHAR(4))  begin
    delete from orders where aid=id;
    delete from activities where aid=id;
end$$

DROP PROCEDURE IF EXISTS `del_customers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_customers` (IN `id` VARCHAR(4))  begin
    delete from orders where cid=id;
    delete from customers where cid=id;
end$$

DROP PROCEDURE IF EXISTS `del_meals`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_meals` (IN `id` VARCHAR(4))  begin
    delete from orders where mid=id;
    delete from meals where mid=id;
end$$

DROP PROCEDURE IF EXISTS `del_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_orders` (IN `id` VARCHAR(4))  begin
    delete from orders where oid=id;
end$$

DROP PROCEDURE IF EXISTS `finish_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `finish_orders` (IN `id` VARCHAR(4))  begin
   update orders set staid="sta1" where oid =id;  
end$$

DROP PROCEDURE IF EXISTS `que_activities`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `que_activities` (IN `info` VARCHAR(15))  begin
   select distinct * from activities where aid like '%info%' or aname like '%info%' limit 1;
end$$

DROP PROCEDURE IF EXISTS `que_customers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `que_customers` (IN `info` VARCHAR(15))  begin
   select distinct * from customers where cid like binary '%info%' or cname like binary '%info%' or sex like binary '%info%' 
   or level like binary '%info%' or integral like binary '%info%' or telephone_no like binary '%info%' or birthdate like binary '%info%';
end$$

DROP PROCEDURE IF EXISTS `que_meals`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `que_meals` (IN `info` VARCHAR(15))  begin
   select distinct * from meals where mid like '%info%' or mname like '%info%' limit 1;
end$$

DROP PROCEDURE IF EXISTS `que_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `que_orders` (IN `info` VARCHAR(15))  begin
     select distinct o.oid,c.cid,c.level,e.eid,m.mname,o.qty,otime,a_discount,final_price,s.staname 
    from orders o, customers c,employees e,meals m,states s where (o.cid=c.cid and o.eid =e.eid and o.mid= m.mid 
    and o.staid=s.staid) and (o.oid like '%info%' or c.cid like '%info%' or c.level like '%info%'or e.eid like '%info%'  
   or m.mname like '%info%' or o.qty like '%info%' or o.otime like '%info%' or o.a_discount like '%info%' or o.final_price like '%info%');
end$$

DROP PROCEDURE IF EXISTS `que_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `que_test` (IN `id` VARCHAR(15))  begin
   select distinct * from meals where mid =id;
end$$

DROP PROCEDURE IF EXISTS `report_highest_consumption_customer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_highest_consumption_customer` ()  begin
  declare ccid varchar(4);
  declare max decimal(6,2);
  declare day_begin_time datetime;
  declare day_end_time datetime;

  set day_begin_time= str_to_date(date_format(now(),'%Y-%m-%d'),'%Y-%m-%d %H:%i:%s');   
  set day_end_time = date_add(date_add(str_to_date(date_format(now(),'%Y-%m-%d'),'%Y-%m-%d %H:%i:%s'),interval 1 day),interval -1 second);

  select  o.cid, sum(o.final_price) as p into ccid,max from orders o where o.otime>= day_begin_time and o.otime <=day_end_time and o.staid="sta1" group by o.cid order by p desc limit 1;
  select cid,cname from customers where cid =ccid;
end$$

DROP PROCEDURE IF EXISTS `report_luckiest_customer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_luckiest_customer` ()  begin
  declare ccid varchar(4);
  declare min decimal(6,2);
  declare day_begin_time datetime;
  declare day_end_time datetime;
  -- 取当天的开始时间 
  set day_begin_time= str_to_date(date_format(now(),'%Y-%m-%d'),'%Y-%m-%d %H:%i:%s');  
  -- 取当天的结束时间  
  set day_end_time = date_add(date_add(str_to_date(date_format(now(),'%Y-%m-%d'),'%Y-%m-%d %H:%i:%s'),interval 1 day),interval -1 second);

  select cid,min(a_discount)as p into ccid,min from orders where otime>= day_begin_time and otime <=day_end_time and staid="sta1" group by cid order by p limit 1;
  select cid,cname from customers where cid =ccid;
end$$

DROP PROCEDURE IF EXISTS `report_most_sale_meal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_most_sale_meal` ()  begin
  declare mmid varchar(4);
  declare most decimal(6,2);
  declare day_begin_time datetime;
  declare day_end_time datetime;

  set day_begin_time= str_to_date(date_format(now(),'%Y-%m-%d'),'%Y-%m-%d %H:%i:%s');   
  set day_end_time = date_add(date_add(str_to_date(date_format(now(),'%Y-%m-%d'),'%Y-%m-%d %H:%i:%s'),interval 1 day),interval -1 second);

  select  o.mid,sum(o.qty) as p into mmid,most from orders o where o.otime>= day_begin_time and o.otime <=day_end_time and o.staid="sta1" group by o.mid order by p desc limit 1;
  select mid,mname from meals where mid =mmid;
end$$

DROP PROCEDURE IF EXISTS `report_total_consumption`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_total_consumption` ()  begin
  declare day_begin_time datetime;
  declare day_end_time datetime;
  set day_begin_time= str_to_date(date_format(now(),'%Y-%m-%d'),'%Y-%m-%d %H:%i:%s');  
  set day_end_time = date_add(date_add(str_to_date(date_format(now(),'%Y-%m-%d'),'%Y-%m-%d %H:%i:%s'),interval 1 day),interval -1 second);
  
  select sum(final_price) from orders where otime >=day_begin_time 
  and otime <=day_end_time and staid="sta1";
end$$

DROP PROCEDURE IF EXISTS `show_activities`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_activities` ()  begin 
   select aid, aname, begin_time, end_time from activities  where aid!= "a000" order by begin_time desc;
end$$

DROP PROCEDURE IF EXISTS `show_error_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_error_login` ()  begin
  select @error_login;
end$$

DROP PROCEDURE IF EXISTS `show_error_phone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_error_phone` ()  begin
  select @error_phone;
end$$

DROP PROCEDURE IF EXISTS `show_low_stock`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_low_stock` ()  begin
     select @low_stock;
 end$$

DROP PROCEDURE IF EXISTS `show_meals`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_meals` ()  begin 
   select mid, mname, mprice, meal_integral, qoh,qoh_threshold from meals;
end$$

DROP PROCEDURE IF EXISTS `show_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_orders` ()  begin 
   select o.oid,c.cid,c.level,e.eid,m.mname,o.qty,otime,a_discount,final_price,s.staname from orders o, customers c,employees e,meals m,states s
   where o.cid=c.cid and o.eid =e.eid and o.mid= m.mid and o.staid=s.staid order by otime desc;
end$$

DROP PROCEDURE IF EXISTS `show_out_stock`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_out_stock` ()  begin
     select @out_stock;
 end$$

DROP PROCEDURE IF EXISTS `upd_activities`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_activities` (IN `aid1` VARCHAR(4), IN `aname1` VARCHAR(15), IN `begin_time1` DATETIME, IN `end_time1` DATETIME)  begin
   update activities set aname=aname1,begin_time=begin_time1,end_time=end_time1
       where aid=aid1;
end$$

DROP PROCEDURE IF EXISTS `upd_customers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_customers` (IN `cid1` VARCHAR(4), IN `cname1` VARCHAR(15), IN `sex1` VARCHAR(15), IN `telephone_no1` VARCHAR(15), IN `birthdate1` DATETIME)  begin
   update customers set cname=cname1,sex=sex1, telephone_no=telephone_no1,
   birthdate=birthdate1 where cid=cid1;
end$$

DROP PROCEDURE IF EXISTS `upd_meals`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_meals` (IN `mid1` VARCHAR(4), IN `mname1` VARCHAR(15), IN `mprice1` DECIMAL(6,2), IN `meal_integral1` INT(5), IN `qoh1` INT(5), IN `qoh_threshold1` INT(5))  begin
   update meals set mname=mname1,mprice=mprice1,meal_integral=meal_integral1,
   qoh=qoh1,qoh_threshold=qoh_threshold1 where mid=mid1;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `activities`
--

DROP TABLE IF EXISTS `activities`;
CREATE TABLE IF NOT EXISTS `activities` (
  `aid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `aname` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `begin_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `activities`
--

INSERT INTO `activities` (`aid`, `aname`, `begin_time`, `end_time`) VALUES
('a000', '无活动', '2017-01-01 00:00:00', '2017-01-01 00:00:00'),
('a001', '周年庆随机立减', '2017-12-26 00:00:00', '2017-12-27 00:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `clevels`
--

DROP TABLE IF EXISTS `clevels`;
CREATE TABLE IF NOT EXISTS `clevels` (
  `level` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `least_integral` int(5) DEFAULT NULL,
  `c_discount` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `clevels`
--

INSERT INTO `clevels` (`level`, `least_integral`, `c_discount`) VALUES
('bronze', 150, '0.95'),
('gold', 350, '0.80'),
('regular', 100, '1.00'),
('silver', 220, '0.90');

-- --------------------------------------------------------

--
-- 表的结构 `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `cid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `cname` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sex` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `level` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integral` int(15) DEFAULT NULL,
  `register_time` datetime DEFAULT NULL,
  `last_visit_time` datetime DEFAULT NULL,
  `visits_made` int(5) DEFAULT NULL,
  `telephone_no` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `telephone_no` (`telephone_no`),
  KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `customers`
--

INSERT INTO `customers` (`cid`, `cname`, `sex`, `level`, `integral`, `register_time`, `last_visit_time`, `visits_made`, `telephone_no`, `birthdate`) VALUES
('c000', 'Amy', 'female', 'bronze', 193, '2016-07-05 09:20:41', '2017-12-24 22:06:34', 2, '13500000001', '1999-05-04 00:00:00'),
('c001', 'Tom', 'male', 'silver', 303, '2016-12-14 08:27:27', '2017-12-24 22:52:05', 15, '13500000002', '2002-10-12 00:00:00'),
('c002', 'KI', 'male', 'regular', 100, '2017-12-25 11:31:54', '2017-12-25 11:31:54', 1, '13500000007', '1996-02-01 00:00:00'),
('c003', 'Kay', 'female', 'silver', 301, '2010-10-12 14:28:18', '2017-12-25 10:22:10', 26, '13500000003', '1997-08-12 00:00:00'),
('c004', 'Tim', 'male', 'gold', 519, '2007-10-12 14:28:18', '2017-12-25 10:28:23', 41, '13500000004', '1994-05-04 00:00:00'),
('c005', 'Jan', 'female', 'silver', 310, '2001-06-23 14:27:18', '2017-12-25 10:19:50', 27, '13500000005', '1983-11-10 00:00:00');

--
-- 触发器 `customers`
--
DROP TRIGGER IF EXISTS `after_update_customers`;
DELIMITER $$
CREATE TRIGGER `after_update_customers` AFTER UPDATE ON `customers` FOR EACH ROW begin
   if new.last_visit_time>old.last_visit_time then
      insert into logs (who,time,table_name,operation,key_value)
      values (user(),current_timestamp,'customers','update',new.cid);
   end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `eid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `ename` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `employees`
--

INSERT INTO `employees` (`eid`, `ename`) VALUES
('e000', '小零'),
('e001', '小一'),
('e002', '小二'),
('e003', '小三');

-- --------------------------------------------------------

--
-- 表的结构 `logs`
--

DROP TABLE IF EXISTS `logs`;
CREATE TABLE IF NOT EXISTS `logs` (
  `logid` int(5) NOT NULL AUTO_INCREMENT,
  `who` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `table_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `operation` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `key_value` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `logs`
--

INSERT INTO `logs` (`logid`, `who`, `time`, `table_name`, `operation`, `key_value`) VALUES
(1, 'root@localhost', '2017-12-24 22:35:23', 'orders', 'insert', 'o001'),
(2, 'root@localhost', '2017-12-24 22:35:23', 'meals', 'update', 'm001'),
(3, 'root@localhost', '2017-12-24 22:39:02', 'customers', 'update', 'c000'),
(4, 'root@localhost', '2017-12-24 22:47:24', 'customers', 'update', 'c001'),
(5, 'root@localhost', '2017-12-24 22:52:05', 'orders', 'insert', 'o004'),
(6, 'root@localhost', '2017-12-24 22:52:05', 'meals', 'update', 'm002'),
(7, 'root@localhost', '2017-12-24 23:05:54', 'orders', 'insert', 'o005'),
(8, 'root@localhost', '2017-12-24 23:05:54', 'meals', 'update', 'm002'),
(9, 'root@localhost', '2017-12-24 23:08:52', 'customers', 'update', 'c001'),
(10, 'root@localhost', '2017-12-24 23:08:58', 'customers', 'update', 'c004'),
(11, 'root@localhost', '2017-12-24 23:10:09', 'orders', 'insert', 'o006'),
(12, 'root@localhost', '2017-12-24 23:10:09', 'meals', 'update', 'm001'),
(13, 'root@localhost', '2017-12-24 23:10:29', 'orders', 'delete', 'o006'),
(14, 'root@localhost', '2017-12-24 23:10:29', 'meals', 'update', 'm001'),
(15, 'root@localhost', '2017-12-25 10:19:15', 'orders', 'insert', 'o001'),
(16, 'root@localhost', '2017-12-25 10:19:15', 'meals', 'update', 'm001'),
(17, 'root@localhost', '2017-12-25 10:19:20', 'customers', 'update', 'c004'),
(18, 'root@localhost', '2017-12-25 10:19:50', 'orders', 'insert', 'o002'),
(19, 'root@localhost', '2017-12-25 10:19:50', 'meals', 'update', 'm002'),
(20, 'root@localhost', '2017-12-25 10:20:01', 'customers', 'update', 'c005'),
(21, 'root@localhost', '2017-12-25 10:20:43', 'orders', 'insert', 'o003'),
(22, 'root@localhost', '2017-12-25 10:20:43', 'meals', 'update', 'm001'),
(23, 'root@localhost', '2017-12-25 10:21:35', 'customers', 'update', 'c003'),
(24, 'root@localhost', '2017-12-25 10:22:10', 'orders', 'insert', 'o004'),
(25, 'root@localhost', '2017-12-25 10:22:10', 'meals', 'update', 'm000'),
(26, 'root@localhost', '2017-12-25 10:22:16', 'customers', 'update', 'c003'),
(27, 'root@localhost', '2017-12-25 10:24:28', 'orders', 'insert', 'o005'),
(28, 'root@localhost', '2017-12-25 10:24:28', 'meals', 'update', 'm000'),
(29, 'root@localhost', '2017-12-25 10:24:41', 'orders', 'delete', 'o005'),
(30, 'root@localhost', '2017-12-25 10:24:41', 'meals', 'update', 'm000'),
(31, 'root@localhost', '2017-12-25 10:25:10', 'meals', 'update', 'm001'),
(32, 'root@localhost', '2017-12-25 10:25:20', 'meals', 'update', 'm002'),
(33, 'root@localhost', '2017-12-25 10:28:23', 'orders', 'insert', 'o006'),
(34, 'root@localhost', '2017-12-25 10:28:23', 'meals', 'update', 'm001'),
(35, 'root@localhost', '2017-12-25 10:32:59', 'orders', 'insert', 'o007'),
(36, 'root@localhost', '2017-12-25 10:32:59', 'meals', 'update', 'm001'),
(37, 'root@localhost', '2017-12-25 10:49:05', 'orders', 'delete', 'o007'),
(38, 'root@localhost', '2017-12-25 10:49:05', 'meals', 'update', 'm001'),
(39, 'root@localhost', '2017-12-25 11:33:43', 'meals', 'update', 'm000'),
(40, 'root@localhost', '2017-12-25 11:34:26', 'customers', 'update', 'c004'),
(41, 'root@localhost', '2017-12-25 11:35:59', 'orders', 'insert', 'o000'),
(42, 'root@localhost', '2017-12-25 11:35:59', 'meals', 'update', 'm001'),
(43, 'root@localhost', '2017-12-25 11:37:51', 'orders', 'insert', 'o009'),
(44, 'root@localhost', '2017-12-25 11:37:51', 'meals', 'update', 'm002');

-- --------------------------------------------------------

--
-- 表的结构 `managers`
--

DROP TABLE IF EXISTS `managers`;
CREATE TABLE IF NOT EXISTS `managers` (
  `mgid` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `mgname` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`mgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `managers`
--

INSERT INTO `managers` (`mgid`, `mgname`, `password`) VALUES
('150916', '叶', '123456');

-- --------------------------------------------------------

--
-- 表的结构 `meals`
--

DROP TABLE IF EXISTS `meals`;
CREATE TABLE IF NOT EXISTS `meals` (
  `mid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `mname` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `mprice` decimal(6,2) DEFAULT NULL,
  `meal_integral` int(5) NOT NULL,
  `qoh` int(5) NOT NULL,
  `qoh_threshold` int(5) NOT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `meals`
--

INSERT INTO `meals` (`mid`, `mname`, `mprice`, `meal_integral`, `qoh`, `qoh_threshold`) VALUES
('m000', '刀削面', '15.00', 7, 24, 20),
('m001', '阳春面', '16.50', 8, 8, 10),
('m002', '炸酱面', '20.00', 10, 25, 13),
('m003', '捞面', '13.00', 6, 22, 8);

--
-- 触发器 `meals`
--
DROP TRIGGER IF EXISTS `after_update_meals`;
DELIMITER $$
CREATE TRIGGER `after_update_meals` AFTER UPDATE ON `meals` FOR EACH ROW begin
    insert into logs(who,time,table_name,operation,key_value)
    values(user(),current_timestamp,'meals','update',new.mid);
end
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `before_update_meals`;
DELIMITER $$
CREATE TRIGGER `before_update_meals` BEFORE UPDATE ON `meals` FOR EACH ROW begin
    if new.qoh < new.qoh_threshold then
     set @low_stock = concat('套餐  ',new.mname,' 即将销售完!');
    end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `oid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `cid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `eid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `sid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `mid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `aid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `staid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `qty` int(5) DEFAULT NULL,
  `otime` datetime DEFAULT NULL,
  `a_discount` decimal(6,2) DEFAULT NULL,
  `final_price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `cid` (`cid`),
  KEY `eid` (`eid`),
  KEY `sid` (`sid`),
  KEY `mid` (`mid`),
  KEY `aid` (`aid`),
  KEY `staid` (`staid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `orders`
--

INSERT INTO `orders` (`oid`, `cid`, `eid`, `sid`, `mid`, `aid`, `staid`, `qty`, `otime`, `a_discount`, `final_price`) VALUES
('o000', 'c000', 'e003', 's000', 'm001', 'a000', 'sta0', 6, '2017-12-25 11:35:59', '1.00', '99.00'),
('o001', 'c004', 'e001', 's001', 'm001', 'a001', 'sta1', 4, '2017-12-25 10:19:15', '0.32', '16.90'),
('o002', 'c005', 'e002', 's002', 'm002', 'a001', 'sta1', 6, '2017-12-25 10:19:50', '0.81', '87.48'),
('o003', 'c003', 'e003', 's000', 'm001', 'a001', 'sta1', 2, '2017-12-25 10:20:43', '0.97', '28.81'),
('o004', 'c003', 'e001', 's003', 'm000', 'a001', 'sta1', 7, '2017-12-25 10:22:10', '0.56', '52.92'),
('o006', 'c004', 'e003', 's001', 'm001', 'a000', 'sta1', 5, '2017-12-25 10:28:23', '1.00', '66.00'),
('o009', 'c004', 'e003', 's000', 'm002', 'a001', 'sta0', 2, '2017-12-25 11:37:51', '0.63', '20.16');

--
-- 触发器 `orders`
--
DROP TRIGGER IF EXISTS `after_delete_orders`;
DELIMITER $$
CREATE TRIGGER `after_delete_orders` AFTER DELETE ON `orders` FOR EACH ROW begin
  declare intg int(5);
  declare intg1 int(5);
  declare intg2 int(5);
  declare intg3 int(5);
  declare c_intg int(5);
  
  if(old.staid="sta0") then
  #logs about orders
  insert into logs (who,time,table_name,operation,key_value)
    values (user(),current_timestamp,'orders','delete',old.oid);
    
  #update meals
  update meals set qoh = qoh + old.qty where mid = old.mid;
  
  #update customers
  select meal_integral into intg
  from meals where mid=old.mid ;
  
  select integral into c_intg
  from customers where cid=old.cid;
  
  set c_intg = c_intg -intg*old.qty;
  
  select least_integral into intg1
  from clevels where level="gold" ;
  select least_integral into intg2
  from clevels where level="silver" ;
  select least_integral into intg3
  from clevels where level="bronze" ;
  
  if(c_intg>=intg1) then
    update customers set level ="gold",integral =c_intg
      where cid=old.cid;
  else if(c_intg>=intg2) then
    update customers set level ="silver",integral =c_intg
      where cid=old.cid;
  else if(c_intg>=intg3) then
    update customers set level ="bronze",integral =c_intg
      where cid=old.cid;
  else if(c_intg<intg3) then
    update customers set level ="regular",integral =c_intg
      where cid=old.cid;
  end if;
  end if;
  end if;
  end if;
  end if;
end
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `after_insert_orders`;
DELIMITER $$
CREATE TRIGGER `after_insert_orders` AFTER INSERT ON `orders` FOR EACH ROW begin
  declare intg int(5);
  declare intg1 int(5);
  declare intg2 int(5);
  declare intg3 int(5);
  declare c_intg int(5);
  
  #logs about orders
  insert into logs (who,time,table_name,operation,key_value)
    values (user(),current_timestamp,'orders','insert',new.oid);
    
  #update meals
  update meals set qoh = qoh - new.qty where mid = new.mid;
  
  #update customers
  select meal_integral into intg
  from meals where mid=new.mid ;

  select integral into c_intg
  from customers where cid=new.cid;
  
  set c_intg = c_intg +intg*new.qty;
  
  select least_integral into intg1
  from clevels where level="gold" ;
  select least_integral into intg2
  from clevels where level="silver" ;
  select least_integral into intg3
  from clevels where level="bronze" ;
  
  if(c_intg>=intg1) then
    update customers set level ="gold",integral =c_intg
      where cid=new.cid;
  else if(c_intg>=intg2) then
    update customers set level ="silver",integral =c_intg
      where cid=new.cid;
  else if(c_intg>=intg3) then
    update customers set level ="bronze",integral =c_intg
      where cid=new.cid;
  else if(c_intg<intg3) then
    update customers set level ="regular",integral =c_intg
      where cid=new.cid;
  end if;
  end if;
  end if;
  end if;
end
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `after_update_orders`;
DELIMITER $$
CREATE TRIGGER `after_update_orders` AFTER UPDATE ON `orders` FOR EACH ROW begin
   if(new.staid="sta1") then
   update customers set visits_made = visits_made+1 , last_visit_time =new.otime where cid=new.cid;
   end if;
end
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `before_insert_orders`;
DELIMITER $$
CREATE TRIGGER `before_insert_orders` BEFORE INSERT ON `orders` FOR EACH ROW begin
    declare num int(5);
    select qoh into num from meals where mid = new.mid;
    if new.qty > num then
    set @out_stock='该套餐销售火爆，数量不足！';
	signal sqlstate '45000'
      set message_text = '该套餐销售火爆，数量不足！';
	end if;   
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `seats`
--

DROP TABLE IF EXISTS `seats`;
CREATE TABLE IF NOT EXISTS `seats` (
  `sid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `sname` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `seats`
--

INSERT INTO `seats` (`sid`, `sname`) VALUES
('s000', '0号座位'),
('s001', '1号座位'),
('s002', '2号座位'),
('s003', '3号座位');

-- --------------------------------------------------------

--
-- 表的结构 `states`
--

DROP TABLE IF EXISTS `states`;
CREATE TABLE IF NOT EXISTS `states` (
  `staid` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `staname` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`staid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `states`
--

INSERT INTO `states` (`staid`, `staname`) VALUES
('sta0', '配餐中'),
('sta1', '配餐完成');

--
-- 限制导出的表
--

--
-- 限制表 `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`level`) REFERENCES `clevels` (`level`);

--
-- 限制表 `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customers` (`cid`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`eid`) REFERENCES `employees` (`eid`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`sid`) REFERENCES `seats` (`sid`),
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`mid`) REFERENCES `meals` (`mid`),
  ADD CONSTRAINT `orders_ibfk_5` FOREIGN KEY (`aid`) REFERENCES `activities` (`aid`),
  ADD CONSTRAINT `orders_ibfk_6` FOREIGN KEY (`staid`) REFERENCES `states` (`staid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

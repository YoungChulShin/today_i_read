# 예제 테이블 생성

DROP DATABASE IF EXISTS employees;
CREATE DATABASE IF NOT EXISTS employees;
USE employees;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS dept_emp,
                     dept_manager,
                     titles,
                     salaries,
                     employees,
                     departments;

-- set storage_engine = InnoDB;
-- select CONCAT('storage engine: ', @@storage_engine) as INFO;

CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no     CHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE  KEY (dept_name)
);

CREATE TABLE dept_manager (
   dept_no      CHAR(4)         NOT NULL,
   emp_no       INT             NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   KEY         (emp_no),
   KEY         (dept_no),
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)    ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    KEY         (emp_no),
    KEY         (dept_no),
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    KEY         (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
);

CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    KEY         (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
);


create table tb_boolean(bool_value boolean);

select *
from tb_boolean
where bool_value = FALSE

insert into tb_boolean value (44);
insert into tb_boolean value (FALSE);

select null is null
explain select 1=1, null<=>null, null<=>1;

select IFNULL(null, 3);
select isnull(3);

select now(), sleep(2), sysdate();

select now();


## 날짜와 시간의 포멧
select date_format(now(), '%Y-%m-%d %H');
select str_to_date('2021-02-19 15:34:33', '%Y-%m-%d %H:%i:%s');

## 날짜와 시간의 연산
select now(), date_add(now(), interval 1 day);
select now(), date_add(now(), interval -5 minute);

## 타임 스탬프 연산
select unix_timestamp(), unix_timestamp(date_add(now(), interval -1 minute)), from_unixtime(unix_timestamp());

## 문자열 처리
select rpad('rtest', 10, '_'), lpad('ltest', 10, '-');
select replace(ltrim('     hi    '),' ', '_'), replace(rtrim('     hi    '),' ', '_'), replace(trim('     hi    '),' ', '_')

## 문자열 결합
select concat('hi, ', 'my name is', ' youngchul') as name, concat('born ', 1984), concat(cast(38 as char), ' years old')
select concat_ws(',', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

## Group by 문자열 결합
show variables where Variable_name = 'group_concat_max_len';

## 값 비교와 대체
SET @gender = 'M';
select @gender,
       case @gender when 'M' then 'Man'
                    when 'W' then 'Woman'
                    else 'Unknown'
       end as longGender;

select now(),
       case when now() < '2021-01-01 00:00:00' then 'old'
            else 'new'
       end;

## 타입의 전환(CAST, CONVERT)
select cast('1234' as signed integer) as converted_integer, cast('2000-01-01' as date) as converted_date,
       1 - 2, cast(1 - 2 as unsigned );

## 암호화 및 해시 함수(MD5, SHA)
select MD5('abc'), sha('abc'), sha1('abc'), sha2('abc', 224);

## 처리 대기(sleep)
select sleep(10);

## Benchmark
select benchmark(100000, md5('abcdef'));

## IP 주소 변환
create table tab_acesslog(access_dttm datetime, ip_addr integer unsigned);
insert into tab_acesslog values (now(), inet6_aton('127.0.0.130'));

## 암호화
SELECT PASSWORD('mypass');

## 주석
-- 한줄 주석
/*
 여러줄 주석
 주석~~~
 */
# 이것도 한줄 주석

# SELECT
## where 절 인덱스 사용
CREATE TABLE tb_test (age VARCHAR(10), INDEX idx_age(age));
INSERT INTO tb_test VALUES ('1'),('2'),('3'),('4'),('5'),('6'),('7');
explain SELECT * FROM tb_test WHERE age = 2;
explain SELECT * FROM tb_test WHERE age = '2';
DROP TABLE tb_test;

## null 비교
SELECT NULL = NULL,
       CASE WHEN NULL = NULL THEN 1 ELSE 0 END,
       IF(NULL IS NULL, 1, 0);



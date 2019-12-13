@ www.mysql.com
	> 가입
	> downloads
	> web community 설치
	
@ path 추가 
	> C:\Program Files\MySQL\MySQL Server 8.0\bin // 주로 bin에 실행파일
	> 환경변수 path에 새로만들기로 추가
	// 추가를 안하면 mysql command 말고 cmd에서 mysql 명령어 사용이 안됨
	
@ cmd
	> create database memberdb;
	> use membedb;
	> create table member_tx(id int, name varchar(10), pwd varchar(10));

@ workbench
: mysql client tool
	> Mysql Connections 기존 것 삭제
	> + 버튼 누른후 캡처(workbench_start)대로

@ 
> 샘플코드 다운
> db_t2/toku2-1
> 추가
	CREATE TABLE CahngeCols
	(year  INTEGER NOT NULL PRIMARY KEY,
	 col_1 INTEGER NOT NULL,
	 col_2 INTEGER NOT NULL);

	INSERT INTO CahngeCols VALUES(2011,	10,	7);
	INSERT INTO CahngeCols VALUES(2012,	20,	6);
	INSERT INTO CahngeCols VALUES(2013,	30,	5);
	INSERT INTO CahngeCols VALUES(2014,	40,	4);
	INSERT INTO CahngeCols VALUES(2015,	50,	3);
	
@
> db_t2/toku2-1
> 추가
	CREATE TABLE Perm2
	(cust_id  CHAR(3) PRIMARY KEY,
	 item_1   VARCHAR(32)  NOT NULL,
	 item_2   VARCHAR(32) NOT NULL);

	INSERT INTO Perm2 VALUES('001', '시계', '정수기');
	INSERT INTO Perm2 VALUES('002', '휴대전화', '휴대전화');
	INSERT INTO Perm2 VALUES('003', '정수기', '시계');
	INSERT INTO Perm2 VALUES('004', '휴대전화', '휴대전화');
	INSERT INTO Perm2 VALUES('005', '잉크', '안경');
	insert into perm2 values('006', 'item1', 'item2');
	insert into perm2(cust_id, item_1, item_2) values('007', 'item1', 'item2');

@ workbench
	server-data import
	
@ 실습

[1] 사원정보(employee) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오. 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오.
>> 이름 결합 : concat

select employee_id, concat(first_name, ' ', last_name) as Name, salary, job_id, hire_date, manager_id
from employees;


[2] HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 사원정보(employee) 테이블에서 급여가 $7,000~10,000 범위 이외인 사람의 성과 이름(Name 별칭) 및 급여를 급여가 작은 순서로 출력하시오.

select concat(first_name, ' ', last_name) as Name, salary
from employees
where salary not between 7000 and 10000
order by salary;


[3] 사원의 이름(last_name) 중에 'e' 및 'o' 글자가 포함된 사원을 출력하시오. 이때 컬럼명은 'e and o Name'라고 출력하시오.
>> like '%..%'

select last_name as 'e and o Name'
from employees
where last_name like '%e%' or '%o%';

select last_name as 'e and o Name'
from employees
where last_name like '%e%' and last_name like '%o%';


[4] HR 부서에서는 급여와 수당(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오.

select concat(first_name, ' ', last_name) as Name, salary, job_id, commission_pct
from employees
where commission_pct is not null
order by salary and commission_pct desc;

>> 보너스 계산하기

select concat(first_name, ' ', last_name) as Name, salary, job_id, commission_pct
		, (salary * commission_pct) as bonus
from employees
where commission_pct is not null
order by salary and commission_pct desc;


[5] 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오. 단, 업무에 사원(clerk)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오.

select job_id, avg(salary) as 'Avg Salary'
from employees
where job_id not like '%clerk%'
group by job_id
having avg(salary) > 10000
order by avg(salary) desc;
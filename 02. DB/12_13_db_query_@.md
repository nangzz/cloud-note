[6] 각 이름이 ‘s’로 끝나는 사원들의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs로 표시하시오.
	□예 Sigal Tobias is a PU_CLERK
>대문자 upper()

```mysql
select concat(first_name, ' ', last_name, ' is a ', upper(job_id) ) as 'Employee JOBs'
from employees
where first_name like '%s';
```





[7] 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오. 수당여부는 수당이 있으면 “Salary + Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 또한 출력 시 연봉이 높은 순으로 정렬한다.

>if, ifnull(a, 0) : a가 null이면 0

```mysql
m
select concat(first_name, ' ', last_name) as 'Name', salary, 
       case when commission_pct is not null then (salary*12) + (salary*12*commission_pct)
			when commission_pct is null then 'salary only'
	   end as 'total'
from employees
order by salary desc;



select concat(first_name, ' ', last_name) as 'Name'
	   , salary
	   , (salary * 12) + (salary * 12 * ifnull(commission_pct, 0)) as 'total'
       , if(commission_pct is not null, 'salary + commission', 'salary only') as 'salary type'
from employees
order by salary desc;
```





[8] 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오. 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오.

> dayname (oracle에선 to_char) : dayname('yyyy-mm-dd')이면 해당 날짜를 영어 요일로 변환
> dayofweek : dayofweek('yyyy-mm-dd')이면 해당 날짜를 정수로 변환 (1~7 : 일~토)
> date_format : '%W' - 영어요일 / '%w' - 정수
/ date_add

```mysql
select concat(first_name, ' ', last_name) as 'Name', hire_date, dayname(hire_date) as 'week'
from employees
order by dayofweek(hire_date);


select concat(first_name, ' ', last_name) as 'Name', hire_date, date_format(hire_date, '%W') as 'week'
from employees
order by date_format(hire_date, '%w');
```





[8-1]입사 요일별 인원수를 출력하시오.
>group by 1; // select로 가져온 첫번째 컬럼에 대해 그룹핑하겠다. --> 속도 더 빠르다!

```mysql
select date_format(hire_date, '%W') as 'week'
	   , count(date_format(hire_date, '%W')) as 'count'
from employees
group by 1
order by 2 desc;


```





[9] 모든 사원은 직속 상사 및 직속 직원을 갖는다. 단, 최상위 또는 최하위 직원은 직속상사 및 직원이 없다. 소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오.

```mysql
select count(distinct manager_id) as '상사 수'
from employees;
```





[10] 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다. 계산된 출력값은 6자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름차순 정렬하시오. 단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 칭(alias) 처리하시오.
>sum, avg, max, min()
>format(값, 소수점 표현자리수) : format(salary, 1) - salary 값의 소수점 첫째짜리까지 나타낸다.

```mysql
select  count(a.department_id) as 'count'
		, a.department_id
		, b.department_name
		, concat('$ ', format(sum(salary), 0))  as '급여 합계'
		, concat('$ ', format(avg(salary), 2)) as '급여 평균'
		, concat('$ ', format(max(salary), 0)) as '급여 최대값'
        , concat('$ ', format(min(salary), 0)) as '급여 최소값'
        
from employees as a, departments as b
where a.department_id = b.department_id
	and a.department_id is not null
group by department_id
order by department_id;


```



## 조인

@ 가장 많은 부하 직원을 가지고 있는 직원은?

```mysql
select max(cnt)
from 
	(select manager_id, count(manager_id) as cnt
	from employees
	group by manager_id) as result;
```


@ job_id가 IT_PROG U(합집합) salary가 급여 테이블의 D 레벨에 있는 직원은?

```mysql
select employee_id, first_name, last_name, salary, job_id
from employees
where job_id like '%IT%'
union
select employee_id, first_name, last_name, salary, job_id
from employees,
	(select *
	from job_grades
	where grade_level = 'A') as g
where salary between g.lowest_sal and g.highest_sal;
```





[문제 1] HR 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후 사원수가 5명
이상인 부서의 부서명과 사원수를 출력하시오. 이때 사원수가 많은 순으로 정렬하시오.
> employees, departments

```mysql
select d.department_name as name, count(e.employee_id) as count
from employees e join departments d on e.department_id = d.department_id
group by e.department_name
having count(count) >= 5
order by 2 desc;
```



[문제 2] 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 급여 등급은 JOB_GRADES 테이
블에 표시된다. 해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무, 부서
명, 입사일, 급여, 급여등급을 출력하시오.

> employees, departments, job_grades

```mysql
select concat(e.first_name, ' ', e.last_name) as '이름'
       , e.job_id as '업무'
       , d.department_name as '부서 명'
       , e.hire_date as '입사일'
       , e.salary as '급여'
       , g.grade_level as '급여등급'
from employees e join departments d on e.department_id = d.department_id
	, job_grades g
where e.salary between g.lowest_sal and g.highest_sal;


```



[3] 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Nam으로 별칭), 업무, 급여, 입사일을 출력하시오.

```mysql
select d.department_name as '부서 명'
	   , concat(e.first_name, ' ', e.last_name) as '이름'
       , e.job_id as '업무'
       , min(e.salary) as '급여'
       , e.hire_date as '입사일'
from employees e join departments d on e.department_id = d.department_id
group by e.job_id;

```




[4] 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오

```mysql
select concat(first_name, ' ', last_name) as '이름'
       , salary as '급여'
       , department_id as '부서 번호'
       , job_id as '업무'
from employees e1
where salary > (select avg(salary)
				from employees
                where department_id=e1.department_id);
```





[5] 사원정보(Employees) 테이블에 JOB_ID는 사원의 현재 업무를 뜻하고, JOB_HISTORY에 JOB_ID는 사원의 이전 업무를 뜻한다. 
이 두 테이블을 교차해보면 업무가 변경된 사원의 정보도 볼 수 있지만 이전에 한번 했던 같은 업무를 그대로 하고 있는 사원의 정보도 볼 수 있다. 이전에 한번 했던 같은 업무를 보고 있는 사원의 사번과 업무를 출력하시오.
위 결과를 이용하여 출력된 176번 사원의 업무 이력의 변경 날짜 이력을 조회하시오.

```mysql
select employee_id, job_id, '' as start_date, '' as end_date
from employees
where employee_id=176
union
select employee_id, job_id, start_date, end_date
from job_history
where employee_id=176;
```






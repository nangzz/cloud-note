* substr(last_name, -1, 1);
// 맨 마지막부터 한글자 가져와라

* substr(first_name, 1, 1);
// 맨 처음부터 한글자 가져와라

<조인>

* inner join = join = ,

from 테이블명1 alias join 테이블명2 alias on <조인조건>
where <검색조건>

= , 사용하는 조인이랑 같음


* left, right outer join
: 한쪽에만 데이터가 있어서 그냥 한쪽은 null로 표시하더래도 데이터 가져오고 싶을 때

select  b.employee_id
		, concat(b.first_name, ' ', b.last_name) as 'name'
        , b.manager_id
        , concat(a.first_name, ' ', a.last_name) as 'manager name'
from employees a right outer join employees b
on a.employee_id = b.manager_id;


* 조인과 서브쿼리
--> 단일 데이터 가져올 때는 서브쿼리가 빠르지만 서브쿼리를 남발하면 안좋아
--> 쿼리가 복잡하거나 데이터 양이 많으면 조인을 사용

조인
select c.name, b.publisher
from order o join customer c on o.custid=c.custid
			 join book b on o.bookid=b.bookid;
			
			
서브쿼리
select (select name from customer where custid=o.custid) as name
       , (select publisher from book where bookid=o.bookid) as publisher
from order o



* union (합집합)
: 두개의 가져욜 컬럼의 수가 동일해야해



* create table
- unique 타입 쓸 때 null 가능하다.
- now() : 현재 날짜와 시간 가져오는 함수

* alter table
* drop table <테이블이름>

* truncate table
: drop은 테이블 통째로 지우지만 truncate은 데이터만 지운다.
: 이걸 쓰면 자동시퀀스도 초기화 해준다.
: delete로 데이터 지우면 시퀀스는 초기화 안된다.



* 

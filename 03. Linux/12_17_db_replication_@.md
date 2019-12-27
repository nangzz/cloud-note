# DB Replication (DB 복제하기)

***순서대로 따라할 것 ***

### 1. node02 만들기

* vagrantfile에서 

  ```shell
  # Ansible-Node02
    config.vm.define:"node02" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider:virtualbox do |vb|
          vb.name="Node02"
          vb.customize ["modifyvm", :id, "--cpus", 1]
          vb.customize ["modifyvm", :id, "--memory", 1024]
      end
      cfg.vm.host_name="node02"
      cfg.vm.network "public_network", ip: "192.168.56.12"
      cfg.vm.network "forwarded_port", guest: 22, host: 29211, auto_correct: false, id: "ssh"
      cfg.vm.network "forwarded_port", guest: 80, host: 20080
      cfg.vm.network "forwarded_port", guest: 3306, host: 23306
    end
  ```

  node02로 복붙하여 하나 더 만들어줌 (위 코드)

  

- $ vagrant ssh node01 에서

  github 자료 > mysql 설치 과정 따라하기
  (원래는 node02에도 해야하는데 어차피 node02 연결이 안돼서.. 나중에해도됨)





### 2. master (node01)

node01
Work/vagrant에서

```shell
$ vagrant up
$ mysql -u root -p # mysql 접속
```

```mysql
> create database cloud_db default character set utf8; # cloud_db 데이터베이스 생성
> show databases;

> create user 'user1'@'%' identified by 'test1234'; # user1 계정 생성
> set global validate_password_policy=LOW; # pw 설정

> grant all privileges on cloud_db.* to 'user1'@'%' identified by 'test1234'; 
# 계정에 권한 부여

> exit
```

```shell
$ mysql -u user2 -p -h 192.168.56.12 
# master에서 slave로 접속하는 것 / -h : 호스트네임
```



### 3. slave (node02)

node02
Work/vagrant에서

```shell
$ vagrant up
$ vagrant ssh node02 # node02로 접속
$ ps -el | grep mysql # mysql 작동 중인지 확인
$ mysql -u root -p # mysql 접속
```

```mysql
> create database cloud_db default character set utf8;

> create user 'user2'@'%' identified by 'test1234'; # user2 계정 생성
> set global validate_password_policy=LOW;

> grant all privileges on cloud_db.* to 'user2'@'%' identified by 'test1234';

> exit
```

```shell
$ mysql -u user1 -p -h 192.168.56.11 # slave에서 master로 접속하는 것 / -h : 호스트네임
: 접속 안돼서 설정 추가하고 방화벽 내려주는 작업 함(아래)
```





### 4. master, slave

```shell
<master랑 slave 둘다>
$ sudo vi /etc/my.cnf
    [mysqld]
    bind-address=0.0.0.0 # 모든 ip 허용시켜주겠다.
    추가
    esc 누르고 :wq! 하면 저장됨

$ sudo systemctl restart mysqld # 서버 재부팅
# $ sudo service mysql restart 이런 방법도 있지만 여기선 안씀
```



```shell
<master랑 slave 둘다>
$ sudo yum -y install net-tools
$ ifconfig # 이 명령어 사용 가능

$ sudo systemctl stop firewalld # 방화벽 내리는 것
$ netstat -nptl # 포트 확인 3306 열려있는지 확인 (0.0.0.0:3306)
```



```shell
<master>
$ mysql -u user2 -p -h 192.168.56.12 # m -> s 접속되는지 확인해


<slave>
$ mysql -u user2 -p -h 192.168.56.11 # s -> m 접속되는지 확인해
```



```shell
<master>
mysql> exit

$ sudo vi /etc/my.cnf
    [mysqld]
    bind-address=0.0.0.0 이 밑에다가

    server-id=1 (slave는 2)
    log_bin=mysql-bin (master)
    저장


<slave>
mysql> exit

$ sudo vi /etc/my.cnf
    [mysqld]
    bind-address=0.0.0.0 이 밑에다가

    server-id=2
    replicate-do-db='cloud_db'(slave) # cloud_db를 레플리케이션해서 가져올 것이라는 것이라는 뜻
    저장

둘다 서버 재부팅
$ sudo systemctl restart mysqld
```





### 5. mysql

```mysql
<master>
$ mysql -u root -p
> use mysql
> select host, user from user;
# replicate_user가 있어야하는데 없으면

> grant replication slave on *.* to 'replicate_user'@'%' identified by 'test1234' 
추가

> show master status # 파일이랑 포지션 숫자 기억해두기
```



```mysql
<slave>
$ mysql -u root -p
> change master to\
> master_host='192.168.56.11',\
> master_user='replicate_user',\
> master_password='test1234',\
> master_log_file='mysql-log_bin.000003',\ 
> master_log_pos=429;

> exit

$ sudo systemctl restart mysqld # 설정 변경후 서버 재부팅 필요
$ mysql -u root -p

> show slave status\G; # 설정 정보 확인 (포지션이랑 파일명 잘 맞춰져 있는지 확인)
> show database;
> use cloud_db;
> show tables; # 비어있는 것 확인
```





### 6. window (slave)

- 작동이 안돼서 윈도우로 대신하여 진행함.. 윈도우 로컬 아이피로 접속할 것
  127.0.0.1:13306

- 윈도우 slave로 하게될 것

  cmd

```mysql
$ mysql -u root -p

<master>
> show processlist\G;
> show master status; # 파일이랑 포지션 숫자 기억해두기

<window>
> create database cloud_db default character set utf8;
> create user 'user3'@'%' identified by 'test1234';
> grant all privileges on cloud_db.* to 'user3'@'%' with grant option; 
# 윈도우 grant 는 명령어가 좀 다름
> exit

$ code "C:\ProgramData\MySQL\MySQL Server 8.0\my.ini"
[mysqld]에다가 
    server-id=3
    replicate-do-db='cloud_db'
추가

$ mysql -u root -p 

> stop slave;

> change master to\
> master_host='127.0.0.1',\
> master_port=13306,\
> master_user='replicate_user',\
> master_password='test1234',\
> master_log_file='mysql-bin.000002',\ # 파일명 변경(master꺼)
> master_log_pos=154; # 포지션 숫자 변경(master꺼)


# 리눅스로 갈 때
change master to master_host='192.168.56.12', master_port=13306, master_user='replicate_user', master_password='test1234',\
master_log_file='mysql-log_bin.000004', master_log_pos=154; 


# 윈도우로 갈 때 (slave에)
change master to master_host='127.0.0.1', master_port=13306, master_user='replicate_user', master_password='test1234',\
master_log_file='mysql-log_bin.000005', master_log_pos=432; 

> 서버 재부팅
# 윈도우에서는 서버재부팅할 때 윈도우 서비스 가서 mysql80 재실행 시킴

> show slave status\G;
# : Slave_IO_running : yes인지 확인

> use cloud_db;
```





### 7. 연결 확인하기

```mysql
<master>
mysql

> create table members(id int, name varchar(20));
> insert into members values(1, 'test1');


<window(slave)>

> show tables;
> select * from members;
# master랑 연동됐는지 확인하기
# 연동 잘 됐으면 동기화, 복제 완료임
```





### 8. mission


* 새롭게 백업도 해보자!

  [mission link](https://github.com/nangzz/cloud-note/blob/master/03.%20Linux/12_17_db_replication_%40_backup.md)

  

** master의 바이너리로그 파일이 slave에서 작동하여 동기화가 되는거야 **
** master에 했던 설정을 slave하고 slave에 했던 설정을 master에 하면 양방향 동기화 **


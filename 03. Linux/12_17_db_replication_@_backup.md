# DB Replication Backup Mission

*** 사용중인 master db 복제 (cloud_db) ***
*** 백업하기! ***

- master 작업 도중에 slave로 동기화시켜야할 때 오류가능성이 높다.

- 그래서 master 백업을 통해 slave로 옮겨놓고 그 다음 동기화를 해주는 것이 안전하다!

	1. slave 에서 기존 cloud_db 삭제
	
	   ```mysql
	   drop database cloud_db
     ```
  
  
  
  2. master db에서 지금까지의 데이터를 백업 
	      * 그니까 master에 막 작업을 하다가 중간에 slave랑 동기화를 시키면 그 시점부터 동기화되니까 맞지가 않아
	       * 그래서 일단 master에 있는 db를 백업해서 slave에 복제시키고
	       * 그 다음에 동기화 작업해서 동기화 시키는거야
	       * 그럼 이제부터 똑같이 master랑 slave랑 작업된다.
	      
	      
	      
	      node01에서
	      
	      ```shell
	      mysqldump -u root -p cloud_db > backup.sql 
	      # cloud_db를 backup.sql에 백업하겠다.
	      # slave db에 cloud_db가 이미 있어야 백업이 가능한것이야
	      ```
	      
	      backup.sql 을 윈도우에서 사용할 수 있도록 복사(or 이동) 하기
	      
	      

    3. master db에서 백업한 데이터를 slave db에 복원
      - 이 작업들이 완성되면 master db와 slave db는 동기화 완료임
        
```shell
        mysql -u root -p cloud_db < backup.sql 
        # backup.sql 백업파일에 있는 것을 cloud_db에 가져오겠다(복원).
        ```
  
  
  ​      
  
    4. master db의 바이너리 로그 파일의 파일명과 포지션 숫자 확인
  
        ```mysql
        mysql> show master status;
        ```
  
          
  
  5. slave db에서
  
        - master db의 복제 설정 (change master to...)
        - slave db 재부팅
  
        
  
  6. 여기까지하면 master db에서의 변경 내용을 slave db에서 확인 가능하다!



---



### 위 문제에 대한 답안


<node01에서 - vagrant X>

파일 옮기기 위해 공유하도록 설정하기

```shell
$ code Vagrantfile
    10번째줄 밑에 추가
    cfg.vm.synced_folder "./data", "/home/vagrant/data" 
    # "" 앞에꺼는 윈도우 뒤에꺼는 리눅스 를 공유하겠다.

$ vagrant halt node01 # node01 중단
$ mkdir data
$ vagrant up node01 # node01 실행

$ vagrant ssh node01
$ mysqldump -u root -p cloud_db > backup.sql
$ ll # 백업파일 생겼는지 확인
$ mv backup.sql data # data 폴더로 옮기겠다.
```



<window (slave) 에서>

```shell
$ cd data
$ mysql -u root -p cloud_db < backup.sql # 하면 백업파일이 옮겨짐
```



---




* 메모리 확인 

  ```shell
  $ free -h
  ```

  

* cpu 사용량 

  ```shell
  $ top
  ```

  


# centOS 명령어 2



* 도움말 확인

  ```shell
  $ man ls # 명령어 ls에 대한 도움말
  $ man passwd # 명령어 passwd에 대한 도움말
  $ man -k passwd # -k 옵션을 쓰면 명령어가 잘 기억안날 때 일부 키워드만으로 포함된 명령어들을 찾아보겠다.
  ```

  


* 장치와 디렉토리 연결 끊기

  ```shell
  $ umount /dev/sr0 # /dev/sr0: 장치명
  ```

  


* 연결

  ```shell
  $ mount /dev/sr0(장치명에) /app(app 디렉토리를)
  ```

  


* 어떤 디렉토리로 연결됐는지 확인

  ```shell
  $ df -h
  ```

  


* 윈도우에 iso파일이 존재하는걸 centos로 파일을 가져다 쓰려는 것

* 가져다 쓰는 쪽이 클라이언트, 제공하는 쪽이 서버(여기서는 윈도우가 서버겠지)



---




* VM과 host간 file 공유 


  * VM-setting-Options-Shared Folders에서 폴더 지정

  * 그러고나서 터미널에서

    ```shell
    $ vmhgfs-fuse /mnt # mount 명령과 유사 / /mnt 폴더와 연결하라는 명령어
    $ df -h /mnt # 연결됐는지 확인
    $ cd /mnt
    $ ls
    $ cd share
    $ ls
    $ mkdir /centos
    $ mount -o loop Ce--.iso /centos # centos 폴더에 iso 파일을 mount 시키겠다.
    $ losetup -a
    $ df -h
    $ ls /centos
    ```





<ls>

```shell
$ ls -ld /etc
	drwxr-xr-x. 138 root root 8192 12월 20 12:46 /etc
```

- 138 - 2 = 136
- 2 빼준게 서브디렉토리 개수



```shell
$ ls -F
```

- 파일의 종류 표시
  - \*  : 실행 파일
  - / : 디렉터리
  - @ : 심벌릭 링크



```shell
$ ls -R
```

- 하위 디렉터리 목록 출력






<mkdir>
```shell
$ mkdir new1 new2
```

- 한번에 여러개 폴더 생성



```shell
$ mkdir temp/mid/han
```

- 만약에 mid라는 폴더가 없다면? 에러나겠지



```shell
$ mkdir -p temp/mid/han
```

- -p 옵션으로 없으면 자동 생성






<rmdir>
- 폴더 지우기

- 디렉터리가 비어있지않으면 삭제 불가

- ? 비어있지않은 폴더 삭제하려면?

  ```shell
  $ rm -rf <폴더명>
  ```





<파일 내용보기>

```shell
$ cat
$ more or less
```

- cat은 양이 많아도 주르륵 다 출력
- more이나 less는 파일 내용을 화면 단위로 출력 (스페이스바 누르면 다음 페이지)
  - tail -f /var/log/messages
    - 로그 확인 여기서하므로 실시간 모니터링 할 때 사용





<복사>

```shell
$ cp f1 f2 f3 <디렉토리>
```

- 파일 여러개 복사하려면 무조건 마지막에 디렉토리 와야해



```shell
$ cp -r dir1 dir2
```

- 디렉토리 복사는 -r 옵션 사용



```shell
$ cp -i f1 f2
```

-  -i 옵션을 이용하여 f2가 존재하면 덮어쓸 것인지 물어본다. (안전성을 위함)
  - 매번 -i 옵션 붙이기 귀찮아..

    ```shell
    $ alias cp='cp -i'
    # alias 등록해서 사용하면 자동
    ```






<파일>
* inode 테이블이 파일 상세정보랑 데이터블록 주소를 가지고 있음

  * 해당 데이터블록 주소를 따라가면 데이터블록에 바이너리 정보가 담겨있음

  * 데이터블록에는 파일에 대한 이름 등등 정보가 담겨있음

  * 디렉토리면 이름과 파일들 정보가 담겨있음

    ```shell
    $ ls -i
    // 하면 나오는 숫자가 inode 번호
    ```

    
```shell
$ cat test
```

하면 파일과 매핑되어있는 inode 번호를 찾고 그 번호의 데이터블록에 액세스해서 데이터를 조회



* 링크

  ```shell
  $ ln <원본> <바로가기>
  ```

  - 하드 링크 : 원본과 같은 inode 번호 참조해서 원본과 같은 데이터블록 참조

  

  ```shell
  $ ln -s <원본> <바로가기>
  ```

  - 심벌릭 링크 : 새로운 inode 번호 부여 받고 데이터블록에는 원본의 path가 있어서 그 파일 이름 따라 재참조하는 것

  

  *** 그래서 하드링크가 속도가 더 빠르지만 같은 파티션 내에서만 링크가 가능하다는 단점, 파일 단위로 링크 적용***

  

  ***반면에 속도는 하드링크에 비해 느릴지라도 심벌릭 링크는 inode가 달라지니까 서로 다른 파티션 내에서도 링크가 가능하는게 장점***

  

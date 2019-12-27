# Heroku & Github



## 1. Heroku

* heroku --> Paas (Platform as a Service)
* heroku의 회원가입 등 유저서비스들 --> Saas

```shell
$ git remote add <name> <url> # remote 연결
$ heroku apps # 있는 어플리케이션 확인

$ git remote add <name> <url> # remote 연결
$ heroku apps # 있는 어플리케이션 확인
```



---

 

```shell
$ heroku git:remote -a helloheroku9593  # -a : 에플리케이션 지정

$ git remote -v 

$ git push heroku master # local 에 있는 것을 remote에 있는 heroku 올리겠다.

$ npm start # 서버 시작
$ git add . # 하위에 있는 것 모두
$ git commit -m "update index.ejs file"  # 아직은 local에 올라간 것
$ git push heroku master # 클라우드에 최종 올라가서 외부에 공개

$ heroku ps # 현재 프로세스가 어떤 상태인지 알 수 있음(작동 중인지 중지 상태인지)
$ heroku ps:scale web=0 # 서버를 0개 쓰겠다 즉 아무것도 안쓰겠다. (서버 중지)
$ heroku ps # 작동 중인 프로세스 없음
$ heroku ps:scale web=1 # 서버 시작
$ heroku ps # 프로세스 작동

$ heroku logs --tail # --tail : 로그는 너무 기니까 마지막 부분을 보여달라

$ git remote remove heroku # heroku 란 이름의 repository를 지움
```





## 2. github과의 연동

```shell
$ git remote add origin https://github.com/kangahpro7/helloheroku9593.git # origin이라는 이름으로 remote에 add 할거야
$ git add
$ git commit -m "upload sample web app to GITHUB" # local에 올림
$ git push origin master # local에 있는 master가 origin 으로 보내짐
```




* 수동 deploys
: push 했을 때 local에서 github까지만 올라가고 heroku에서는 pull을 이용해서 따로 올려야 한다.

* automatic deploys
: push 했을 때 local에서 github에 올리면 자동으로 heroku(서버)로 올려준다.
: 서버 자도 재부팅

* 깃헙의 장점
: 버전 관리
: 수정사항 확인 가능
: 웹브라우저가지고 실시간으로 확인 가능





## 3. 실습

1. nodejs 프로젝트 생성
	- `express` ...
	
	```shell
	$ express --session --ejs --css stylus <project name> # express : nodejs 파일 템플릿 자동 생성해주는 것 
	$ cd <project name>
	$ npm install # 필요한 패키지 같은거 자동 설치 (node_modules 파일이 생기고 그 안에 다 다운됨)
	--개발 툴에서 express 통해 만든 폴더 오픈--
	--코드 변경 (개발)--
	```
	
	
	
2. nodejs의 프로젝트와 git 연동
	- `git init`, `add`, `remote`, `commit`, `push` ...
	
	```shell
	$ git init
	--add, push 등 해주기 위해 해야할 작업(.git이 있어야 하므로)--
	$ git init # (.git 생성)
	$ git commit -m "upload" # local repository에 올림
	$ git log # git log 사항
	$ git remote -v # remote가 어디로 연결되어있는가 를 보여줌
	$ git remote add <name>-주로 origin <url>-깃주소 # remote 연결
	$ git push origin master	
	```



3. heroku에 app 생성 (instance)
	- dashboard or CLI에서 생성 가능
		- `heroku apps:create` ...
	
	```shell
	$ heroku apps:destroy helloheroku9593 # 애플리케이션 삭제 (기존에 있던 것 삭제)
	$ heroku apps # 현재 있는 애플리케이션 확인
	--heroku 사이트 가서 만들거나 터미널 통해서 create해서 만들거나--
	$ heroku apps:create myheroku9
	$ dir # 만들어졌는지 확인
	$ dir /ah # 숨은 파일 확인
	$ git add . 
	```

​	


4. heroku와 github 연동
	- dashboard의 settings 메뉴
	-- heroku 사이트에서 github 눌러서 연결--
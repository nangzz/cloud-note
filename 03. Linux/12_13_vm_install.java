* virtual box 설치
* vagrant 설치
* ubuntu 이미지 파일 다운받아서 깔거나 vagrant 로 이용하는 방법

@
$ cd Work
$ mkdir vagrant
$ cd vagrant
$ vagrant init // Vagrantfile이 생성됨
$ code Vagrantfile // 비주얼스튜디오로 파일이 열림

* 깃헙의 vagrant 관련 2개 파일 vagrant 폴더에 복붙

$ vagrant up // vagrant 실행
$ vagrant status // running 나오면 작동 중

* 상태 확인하고 virtualbox 확인

$ vagrant ssh

..
안돼서 다시..
기존 파일 삭제..

$ vagrant status
$ vagrant destroy // 기존 파일 삭제

* 깃헙에서 받아서 다시 파일 복붙하고 
$ vagrant plugin install vagrant-vbguest
$ vagrant up
$ vagrant ssh node01
접속 완료


 
 
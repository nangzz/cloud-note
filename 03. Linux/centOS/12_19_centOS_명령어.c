http://59.29.224.67/ 에서
* centOS 설치
* vmware 설치
* Xshell5 설치
* ubuntu 설치

* 시스템 종료
$ poweroff
$ halt -p // 자동으로 전원까지 off 시킴
$ init 0
$ shutdown // 이 명령어 사용 권장 (기본 1분뒤 종료)


* 시스템 재부팅
$ shutdown -r now
$ reboot
$ init 6


* 런레벨 변경
$ init 0..6


* 현재 런레벨 실행 수준 확인
$ who -r


* ws
>갯수 세기
> 어떤 명령의 라인수들을 카운팅하려면..

$ ps -ef | wc -l // ps -ef 명령의 결과 라인 수를 센다.
> wc : 워드 카운트하겠다. 뭐를?
> -l : 라인 수를


* ip 설정 상태 확인
$ ip a


* dhclient ens33
> ip 안받아지면 받아오기위해 쓰는 명령어


* 커널 버전 확인
$ uname -a


* 런레벨
$ ls -l runlevel?.target // runlevel... 로 시작하고 .target 확장자 가진 파일 보여줘


* 서비스 제어
$ systemctl
$ systemctl get-default // default 상태 확인
$ systemctl set-default multi-user.target // multi-user.target으로 default 변경 (런레벨 변경)
$ shutdown -r now // 재부팅 해줘


* startx
> main은 3레벨인데 그래픽이 필요하다.. 이럴 때 데스크탑 그래픽 레벨(5레벨)을 띄울 수 있다.
> 레벨만 낮고 5레벨이랑 나머지 환경은 같아


* cd
$ cd // 그냥 cd만 치면 홈디렉터리로 이동


* cat
> 파일 열어서 보여주기
$ cat ifcfg-ens33 // ip에 대한 설정 파일이라 중요한 파일


* 가상 콘솔 띄우기
> ctrl + alt + F1..6
=
$ chvt 1..6


* 그래픽아닐 때 로그아웃
$ exit
=
ctrl + d


* 로그아웃안하고 계정변경하기 - 기본 위에 가상 콘솔 생성해주는 것
$ su - <계정명>
// root에서는 바로 되는데 다른데서 root로 가는건 암호 필요해
--> 가상터미널을 띄우는거기때문에 사용다하면 exit해서 종료시켜야해 (= ctrl+d)

* gedit
> vmware에서만 사용가능해서 리모트에서나 등등에는 vi 사용해야함


* 복사
$ cp ifcfg-ens33 /root // ifcfg-ens33을 root에 복붙 (backup)


* 네트워크 재실행
$ systemctl restart network (ubuntu - networking)
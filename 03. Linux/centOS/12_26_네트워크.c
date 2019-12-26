* FQDN (Fully Qualified Domain Name)
: 호스트이름 + 도메인이름

* ip 관련 설정은 이 파일에서 하는 것이 좋음(dns, gateway 등)
$ vi ifcfg-ens33
> /etcresolv.conf 파일에서 해도 되는데 원본은 ifcfg-ens33 라서 여기가 변경이 안되면 재부팅시 다시 돌아감

설정 변경 후에는 
$ systemctl restart network // centos
$ systemctl restart networking // ubuntu

* 게이트웨이

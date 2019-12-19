** 리눅스 **

> 부팅 : os를 메모리에 로드시키는 것
> 메모리는 휘발성 저장소라 시스템을 끄면 다 날아가
비휘발성 공간이 디스크이고 그래서 디스크에 저장을 시키는 것
> baremetal (host) : 기본 os
> baremetal과 다른 os를 설치해서 사용하고싶어 : 가상화솔루션 = 하이퍼바이져 (Virtual Box, vmware..안에 os를 설치) (guest)
> vmware에서 가상디스크, 가상메모리, 가상cpu 등을 할당하면 예를들어 가상머신에 50GB 정도 할당을하면 윈도우에는 50GB 짜리 .vmdk 확장자의 파일이 생성되는 것
> 컴퓨터끼리 통신하기 위해서는 네트워크 스위치가 필요해
: vmware에서는 가상스위치를 3개 제공 
(host-only : local 통신만 제공-vm간 통신, 
NAT : local 통신 + outbound 인터넷 가능-vm외로 나가는 것, (최적)
Bridged : local 통신 + outbound 인터넷 가능 + 물리망과 연동 가능-IP고갈 문제 가능성 존재
: 가상이더라도 같은 스위치에 연결되어야 연결이 됨

* vmware 핫 키
> 물리적 디바이스의 ownership을 vm에도 부여
> Ctrl + Alt
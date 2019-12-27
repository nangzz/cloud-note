# Linux (리눅스)

### (1) 부팅

> os를 메모리에 로드시키는 것

- 메모리는 휘발성 저장소라 시스템을 끄면 다 날아간다.

- 비휘발성 공간이 디스크이고  _그래서 디스크에 저장을 시키는 것_





### (2) BareMetal (host)

> 하드웨어에 직접 명령을 실행하는 컴퓨터

- 한마디로 window 같은 기본적으로 깔려있는 OS





### (3) Hypervisor (guest)

> = 가상화솔루션
>
> 하나의 컴퓨터에서 서로 다른 OS를 사용하는 가상 컴퓨터를 만들 수 있는 효과적인 가상화 엔진

- baremetal과 다른 os를 설치해서 사용하고싶어..

  - Virtual Box, vmware.. 안에 os를 설치

    - vmware에서 가상디스크, 가상메모리, 가상cpu 등을 할당하면 예를들어 가상머신에 50GB 정도 할당을하면 윈도우에는 50GB 짜리 .vmdk 확장자의 파일이 생성되는 것

    

- 컴퓨터끼리 통신하기 위해서는 네트워크 스위치가 필요한데 vmware에서는 가상스위치를 3개 제공 
  - host-only 
    - local 통신만 제공-vm간 통신
  - NAT
    -  local 통신 + outbound 인터넷 가능-vm외로 나가는 것 (최적)
  - Bridged
    - local 통신 + outbound 인터넷 가능 + 물리망과 연동 가능-IP고갈 문제 가능성 존재



* vmware 핫 키
  * 물리적 디바이스의 ownership을 vm에도 부여
    * Ctrl + Alt





### (4) Xshell

> centOS 리모트 하는 소프트웨어

- 셸에서 컨트롤하면 centOS에서 적용됨
  - 예를들면 셸에서 reboot 명령어 사용하면 centOS에서 reboot 되는 것


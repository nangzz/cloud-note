* 파일 내용 찾기
$ grep <찾을 내용> <파일>
$ grep -l hello *.c // -l : hello가 포함된 파일명을 출력한다.
$ grep -n unix *.txt // -n : unix가 포함된 행 번호를 출력한다.


* 파일 실행시킬 때!
> ./ 현재 위치부터 표시 해줘야 실행 가능


* 파일 생성
$ touch <파일명.확장자>


* 파일 종류 표시
$ file <파일>
$ file <폴더경로>


*
/etc/passwd:root:x:0:0:root:/root:/bin/bash
> 파일: 사용자이름:암호:사용자 ID:사용자가 소속된 그룹 ID:전체 이름:홈디렉토리:기본셀


* 
ubuntu의 sudo 와 비슷한게 wheel


*
'^sh' // sh로 시작하는
'sh$' // sh로 끝나는


* 사용자 추가
$ useradd <사용자명>
$ useradd -u 1111 newuser // -u : 아이디 지정
-g : 그룹 지정
-d : 홈 디렉토리 지정
> 옵션 안쓰면 기본으로 다 지정됨
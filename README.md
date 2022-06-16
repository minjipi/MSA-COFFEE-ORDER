MSA 프로젝트, 커피 주문 시스템 ☕️
================

> 2020년, 팀 프로젝트 서비스의 기능들을 구현하며 하나의 기능에 장애가 났을 때 전체 서비스가 먹통이 되는 점, <br />
> 그리고 이에 따라 서비스의 개선이 어렵고 수정 시 장애의 영향도 파악이 어렵다는 불편함을 느꼈습니다. <br />
> 이러한 문제를 해결하고, 또 추후 서비스가 커졌을 때 부분적인 scale-out이 수월한 'MSA 아키텍쳐'를 도입해야겠다고 생각했습니다. 그래서 자주 이용하던 스타벅스의 사이렌 오더(커피 주문 시스템)을 MSA 구조로 구현하는 MSA-COFFEE-ORDER 프로젝트를 진행하였습니다. <br />
<br />

## Why MSA?
+ 부분 장애가 전체 서비스로 전파된다.
+ 부분적인 서비스의 scale-out이 어렵다.
+ 서비스의 개선이 어렵고, 수정 시 장애의 영향도 파악이 어렵다. 
+ 서비스의 전체 코드가 하나의 프로젝트로 구성되어 배포가 오래걸린다.
<br />

## MSA 프로젝트의 목표
+ 하나의 서비스 장애가 다른 서비스로 전파되지 않는다.
+ 코드 복잡성 및 의존성을 제거해 영향도 파악을 용이하게 한다.
+ 추후 서비스의 고 가용성과 확장성을 확보한다.

<br />
<hr />

## 사용 기술
+ Kubernetes
+ Docker
<hr />

## 프로젝트 전체 구성
<img width="760" alt="msa00" src="https://user-images.githubusercontent.com/68539040/173878465-f58e8db6-4239-4142-94ef-0bf088dca791.png">
<br />
전체 구성도는 위와 같으며, 주요 서비스들은 쿠버네티스 환경에서 각각의 파드들로 동작하고 있고 <br />
서비스 운영 환경과 서비스 개발 환경 총 2개로 구분할 수 있습니다.
<br />
<br />

> 현재 비용 문제로 도메인 사이트 운영 중단된 상태입니다. <br />

<img width="700" alt="msa02" src="https://user-images.githubusercontent.com/68539040/173879867-761f06c8-e4a7-4996-b69c-96ecfd309ca8.png">
카페 점원(admin)이 http://www.minzy-pansy.kro.kr:8080/admin 도메인으로 접속하면, <br />
쿠버네티스 클러스터의 IP로 접속하게 되고, 쿠버네티스 클러스터에서는 8080:8080 포트포워딩을 이용해 sidecar-admin 파드에 연결되도록 설정하였습니다.<br />
그리고 고객(client)은 http://www.minzy-pansy.kro.kr/client 도메인으로 접속하면 쿠버네티스 클러스터의 IP로 접속하게 되고 <br />
쿠버네티스 클러스터에서는 80:8080 포트포워딩을 이용해 sidecar-client 파드에 연결되도록 설정하였습니다.<br />

<br />

<img width="760" alt="msa01" src="https://user-images.githubusercontent.com/68539040/173880429-932e1d36-144e-4ce6-af58-84f6459cf2a4.png">
프론트에 접속한 관리자, 고객은 Ajax를 이용해 Zuul 서버로 API를 호출하게 됩니다. 호출 가능한 API는 다음 표와 같습니다.
<br />
<br />
<img width="760" alt="msa03" src="https://user-images.githubusercontent.com/68539040/173880896-b845fd13-ab4b-4d23-8dde-a5b2383e6bd6.png">

관리자, 고객이 특정 API를 호출하게 되면 Zuul 서버는 Eureka서버에서 API에 해당하는 serviceId를 찾게됩니다.<br />
Eureka 서버에는 각 서비스들이 serviceId와 함께 해당 서비스가 동작하고 있는 서버의 IP주소가 등록되어 있으며<br />
Zuul 서버는 이 ip주소들로 라우팅해주어 각각의 서비스들이 동작하게됩니다.<br />


### 관리자 페이지
<br />

<img width="760" alt="msa04" src="https://user-images.githubusercontent.com/68539040/173881339-3c80725a-a9c5-4225-9efa-23073cbc8aa8.png">

<br />
관리자 페이지의 동작 방식 입니다.<br />
관리자가 페이지에 접속하면 고객이 주문한 주문이 화면에 표시되고,<br />
해당 주문의 완료 버튼을 누르면 고객의 화면의 주문내역의 상태가 완료로 변경됩니다.<br />

<img width="760" alt="msa05" src="https://user-images.githubusercontent.com/68539040/173970409-b6a07c3d-8ddc-46a3-8972-65606e1ab4a2.png">
<br />
동작 방식의 구조는 위와 같습니다. 관리자가 페이지에 접속하면,<br />
Ajax를 이용하여 GET 메소드로 status api를 3초마다 요청을 보내서 주문 내역을 계속 확인하다가 <br />
완료 버튼을 누르면 <br />

<img width="760" alt="msa06" src="https://user-images.githubusercontent.com/68539040/173970559-8a89e082-7573-4260-9676-c67161bf320c.png">
<br />
PUT 메소드로 status api에 다음과 같은 json 데이터를 보내고 <br />
이 때, statusName이 ORDERED에서 DONE으로 바뀌게 되는 것 입니다.
<br />

### 회원 페이지 접속 화면
<br />
<img width="760" alt="msa07" src="https://user-images.githubusercontent.com/68539040/173970653-c022ab00-eb27-48ae-b1b8-3e0b1152ac06.png">

<br />
주문자 페이지를 보겠습니다. 주문자는 웹브라우저를 통해 커피 주문 내역을 입력합니다. <br />
주문 번호는 시스템에서 자동으로 부여하고, 상단 빈칸에 회원명 입력, 메뉴 아이콘을 통해 커피 종류, 커피 개수를 입력하여 주문 버튼을 눌러 주문합니다.
<br />

동작 방식은 다음과 같습니다.
<br />
<br />
고객이 고객 페이지에 접속 후, 메뉴를 고른 고객이 주문하기 버튼을 누르게 되면
<br />
Ajax를 이용해 POST 메소드로 order api에 다음과 같은 데이터를 전송하고
₩₩₩
{
"_id" : "[주문 ID]",
"orderName" : "[메뉴]",
"userId" : "[고객 ID]",
"userName" : "[고객 이름]"
}
₩₩₩
Ajax를 이용해 GET 메소드로 status api를 3초마다 호출해서 내 주문 내역을 확인합니다.

<br />





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
<img width="700" alt="msa02" src="https://user-images.githubusercontent.com/68539040/173879867-761f06c8-e4a7-4996-b69c-96ecfd309ca8.png">
카페 점원(admin)이 http://www.minzy-pansy.kro.kr:8080/admin 도메인으로 접속하면, <br />
쿠버네티스 클러스터의 IP로 접속하게 되고, 쿠버네티스 클러스터에서는 8080:8080 포트포워딩을 이용해 sidecar-admin 파드에 연결되도록 설정하였습니다.<br />
그리고 고객(client)은 http://www.minzy-pansy.kro.kr/client 도메인으로 접속하면 쿠버네티스 클러스터의 IP로 접속하게 되고 <br />
쿠버네티스 클러스터에서는 80:8080 포트포워딩을 이용해 sidecar-client 파드에 연결되도록 설정하였습니다.<br />

> 현재 비용 문제로 사이트 운영 중단된 상태입니다.

<br />

<img width="760" alt="msa01" src="https://user-images.githubusercontent.com/68539040/173880429-932e1d36-144e-4ce6-af58-84f6459cf2a4.png">
프론트에 접속한 관리자, 고객은 Ajax를 이용해 Zuul 서버로 API를 호출하게 됩니다. 호출 가능한 API는 다음 표와 같습니다.
<br />

<img width="760" alt="msa03" src="https://user-images.githubusercontent.com/68539040/173880896-b845fd13-ab4b-4d23-8dde-a5b2383e6bd6.png">

관리자, 고객이 특정 API를 호출하게 되면 Zuul 서버는 Eureka서버에서 API에 해당하는 serviceId를 찾게됩니다.<br />
Eureka 서버에는 각 서비스들이 serviceId와 함께 해당 서비스가 동작하고 있는 서버의 IP주소가 등록되어 있으며<br />
Zuul 서버는 이 ip주소들로 라우팅해주어 각각의 서비스들이 동작하게됩니다.<br />

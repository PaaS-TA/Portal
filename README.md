## 포탈 개요

사용자 포탈은 어플리케이션의 배포 및 관리, 개발에 필요한 서비스 인스턴스 관리 및 계정관리와 공지사항 같은 포탈 관리 기능을 제공한다. 또한 어플리케이션 플랫폼에 배포되는 응용어플리케이션을 대한 모니터링을 제공하여 응용어플리케이션이 문제가 있는 부분을 포탈 사용자 관리자에게 제공하여 원활한 운영을 할 수 있게 지원한다.

운영자 포탈은 CCDB, UAADB, PORTALDB로부터 데이터를 조회하고 클라우드 컨트롤러에서 제공하는 REST API 호출을 통해 상호작용하며, 웹 사용자 인터페이스 환경에서 플랫폼을 관리할 수 있도록 한다.

다음은 각 구성 요소의 주요 역할과 기술 구조는 다음과 같다. 
 
1)	portal-web-user (openPaasPaastaPortalWebUser)

사용자 포탈은 웹 인터페이스를 통해 PaaS-TA에서 개발자 환경을 구성 할 수 있도록 하는 웹 애플리케이션이다. 
portal-api 어플리케이션의 REST API 를 호출하여 그 결과를 화면에 제공한다. 화면을 분리하여 UI 프레임워크 변경 시 API 서버와 영향도가 없이 구성한다.

2)	portal-web-admin (openPaasPaastaPortalWebAdmin)

운영자 포탈은 웹 인터페이스를 통해 PaaS-TA 운영환경의 데이터를 관리할 수 있도록 하는 웹 애플리케이션이다. 
portal-api 어플리케이션의 REST API 를 호출하여 그 결과를 화면에 제공한다. 화면을 분리하여 UI 프레임워크 변경 시 API 서버와 영향도가 없이 구성한다.

3)	portal-api (openPaasPaastaPortalApi)

PaaS-TA 실행환경의 Cloud Controller에서 제공하는 Java CF 1.0 LIB REST API와 포탈에서 필요한 REST API를 제공한다.

4)	portal-registration (openPaasPaastaPortalRegistration)

Spring-cloud 프로젝트의 Service discovery server로 Eureka 를 사용한 어플리케이션이다. 
포탈에서 사용하는 어플리케이션을 portal-registration 에 서비스로 등록하여 등록된 서비스들은 registration 서버에 등록한 서비스 이름으로 데이터를 요청한다. 또한 등록된 서비스들의 상태를 확인 할 수 있는 UI를 제공한다.

5)	portal-api-v2 (openPaasPaastaPortalApiV2)

PaaS-TA 실행환경의 Cloud Controller에서 제공하는 Java CF 2.0 LIB REST API를 제공한다.

6)	app-autoscaler (openPaasPaastaPortalAutoScaling)

Monitoring 서버를 통해 배포된 어플리케이션의 Auto Scale를 위한 Metrix 정보를 수집하고 사용자 포탈에서 설정한 Auto scale 조건과 비교하여 scale 여부를 판단하고 scale-in/out 를 수행하는 어플리케이션이다.

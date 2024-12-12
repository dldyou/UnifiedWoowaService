= 최종 산출물
== HW Platform 
배민 통합 서비스의 MSA에 해당하는 마이크로 서비스들의 jar 파일이 제공된다. 제공되는 jar 파일은 다음과 같다. 
- gateway.jar
- woowa.jar
- delivery.jar
- payment.jar

== SW Platform
#table(align: left, 
    columns: (auto, 1fr), 
    [*Language*], [Java],
    [*Runtime*], [JDK 17],
    [*Framwork*], [Spring boot],
    [*Library*], [Spring Cloud Gateway, Spring Data JPA, Query DSL],
    [*Infra*], [kafka],
)

== Code
github : https://github.com/kyoona/SoftwareArchitecture_Woowa.git

MSA에 해당하는 게이트웨이 서비스, 베민 서비스, 배달 서비스, 결제 서비스는 멀티 모듈 형태로 구성되어 있으며 모노 레파지토리로 관리된다.
모듈 정보는 다음과 같다.
- common
배민 서비스, 배달 서비스, 결제 서비스에서 사용하는 공통 클래스가 구현되어 있다. JPA 사용을 위한 엔티티들과 카프카를 통해 주고 받는 메세지 클래스가 이에 해당한다.
- gateway
사용자의 요청을 각 마이크로 서비스로 라우팅 하기 위한 게이트 웨이 서비스가 구현되어 있다.
- woowa
배민 서비스가 구현되어 있다.
- delivery
배달 서비스가 구현되어 있다.
- payment
결제 서비스가 구현되어 있다.

== 실행 방법
Database와 Kafka 서버는 AWS를 통해 배포되어 있다. 비용 절감을 위하여 각 MSA 서비스들은 AWS의 EC2를 통해 배포하지 않고, 로컬에서 포트를 분리하여 실행한다.\
gateway 서버는 8080, woowa서버는 8081, delivery서버는 8082, payment서버는 8083 포트를 사용한다.\
배민 통합 서비스를 사용하기 위해서는 http://localhost:8080 경로로 서비스를 요청하면된다.

터미널을 통해 다음 명령어를 수행하여 서버를 실행한다. 
- gateway 서버 실행
```bash
java -DMYSQL_USERNAME=admin \
     -DMYSQL_PASSWORD=sadb2024 \
     -DMYSQL_URL=jdbc:mysql://sa.cb66qoye058f.ap-northeast-2.rds.amazonaws.com:3306/unified_woowa \
     -DKAFKA_SERVER_URL=43.202.64.238:9092 \
     -DWOOWA_IP=http://localhost:8081 \
     -DELIVERY_IP=http://localhost:8082 \
     -DPAYMENT_IP=http://localhost:8083 \
     -jar gateway.jar
```\
- woowa 서버 실행
```bash
java -DMYSQL_USERNAME=admin \
     -DMYSQL_PASSWORD=sadb2024 \
     -DMYSQL_URL=jdbc:mysql://sa.cb66qoye058f.ap-northeast-2.rds.amazonaws.com:3306/unified_woowa \
     -DKAFKA_SERVER_URL=43.202.64.238:9092 \
     -jar woowa.jar
```\
- delivery 서버 실행
```bash
java -DMYSQL_USERNAME=admin \
     -DMYSQL_PASSWORD=sadb2024 \
     -DMYSQL_URL=jdbc:mysql://sa.cb66qoye058f.ap-northeast-2.rds.amazonaws.com:3306/unified_woowa \
     -DKAFKA_SERVER_URL=43.202.64.238:9092 \
     -jar delivery.jar
```\
- payment 서버 실행
```bash
java -DMYSQL_USERNAME=admin \
     -DMYSQL_PASSWORD=sadb2024 \
     -DMYSQL_URL=jdbc:mysql://sa.cb66qoye058f.ap-northeast-2.rds.amazonaws.com:3306/unified_woowa \
     -DKAFKA_SERVER_URL=43.202.64.238:9092 \
     -jar payment.jar
```

== 요청 가능한 서비스
=== 배민 서비스 
#table(
  align: left, 
  columns: (auto, 1fr),
  [*API Info*], [사용자 등록],
  [*Request URL*], [localhost:8080/woowa/users],
  [*HTTP Method*], [POST],
  [*Body Parameter*], [],
  [*userName*], [(String) 사용자 이름],
  [*locationName*], [(String) 장소 이름],
  [*x*], [(double) x좌표],
  [*y*], [(double) y좌표],
  [*userRole*], [(String) CUSTOMER, MANAGER, DELIVERYMAN 중 택1],
  [*Body Example*], [
```json
{
    "userName": "홍길동",
    "location": {
        "locationName": "장소1",
        "x" : 111,
        "y" : 111
    },
    "userRole" : "CUSTOMER"
}
```
  ],
  [*return*], [사용자 고유 아이디]
)

#table( align: left, 
columns: (auto, 1fr), 
[*API Info*], [가게 등록 요청],
[Request URL], [localhost:8080/woowa/users/2/stores/request],
[HTTP Method], [POST],
[Body Parameter], [],
[storeName], [(String) 가게 이름],
[locationName], [(String) 장소 이름],
[x], [(double) x좌표],
[y], [(double) y좌표],
[deliveryPrice], [(int) 배달비],
[minimumOrderPrice], [(int) 최소 주문 금액],
[Body Example], [
```json
{
    "storeName": "왕소구이",
    "location": {
        "locationName": "자양동",
        "x" : 111.1,
        "y" : 111.1
    },
    "deliveryPrice" : 3000,
    "minimumOrderPrice": 12000
}
```
],
)
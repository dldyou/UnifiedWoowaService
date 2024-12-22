#let SoftwareArchitecture = [
= SW Architecture
== Conceptural Model
#align(center, image("img/conceptual_model.svg", width: 100%))
Use-case를 통해 도출된 Conceptual Model은 위의 다이어그램과 같다.
== Deployment Diagram
#align(center, image("img/deployment-final.svg", width: 100%))
최종 구현 완료된 Deployment 상태는 위의 다이어그램과 같다. '배민 통합 서비스'는 마이크로 서비스 아키텍처로 구성되어 있다. 따라서 배민 서버, 배달 서버, 결제 서버 각각의 마이크로 서비스가 따로 구현되어 있다. 사용자의 요청을 요청에 알맞는 MSA로 라우팅하기 위한 Gateway 서버 또한 존재한다. MSA 서버간 통신을 위한 Kafk 서버, 데이터를 관리하기 위한 데이터베이스 서버가 존재한다.
각 측면에서 Deployment Diagram을 더 상세히 설명하도록 하겠다.
#align(center, image("img/deployment-gateway.svg", width: 100%))
각 MSA 서버는 다른 포트에서 실행된다. 
- 게이트웨이 서버 : 8080포트
- 배민 서버 : 8081포트
- 배달 서버 : 8082포트
- 결제 서버 : 8083포트
사용자는 게이트웨이 서버인 localhost:8080경로를 통해 모든 MSA 서비스를 포함한 '배민 통합 서비스'를 사용할 수 있다.
게이트 웨이 서버는 사용자로부터 요청이 오면 경로에 알맞게 각 MSA 서버로 라우팅을 하며, 각 MSA서버는 Grasp의 Controller패턴에 맞게 Controller계층에서 이를 핸들링하게 된다.
#align(center, image("img/deployment-kafka.svg", width: 100%))
마이크로 서비스간 통신을 위하여 Event Driven Architecture을 채택하였다. Event Driven Architecture를 적용하기 위해 해당 프로젝트에서는 'kafka'라는 기술을 도입하였다. kafka는 AWS의 EC2서비스를 통해 배포되어 있고 다음과 같은 토픽이 생성되어 있다.
- payment_request
고객으로부터 주문이 요청된 후 결제 서비스에 주문에 대한 결제를 요청하기 위한 토픽이다. 주문 고유 아이디, 주문 금액, 구매한 사용자의 정보가 저장된다.
- payment_response
결제 서비스에서 진행된 결제의 성공/실패 정보가 저장된다.
- delivery_status
배달 서비스에서 진행되는 주문에 대한 배달 상태(진행, 완료)가 저장된다.
\
\
각 MSA서버의 Controller 계층에 구현되어 있는 Consumer클래스가 토픽에 데이터가 생성되었을때 호출되어 이를 소비한다. 그리고 Service계층에 구현되어 있는 Producer가 각 토픽에 데이터를 생성한다.
Kafk 를 통해 MSA서버들은 중앙 집중적인 방식으로 서로 통신을 할 수 있다.
#align(center, image("img/deployment-db.svg", width: 100%))
데이터베이스는 AWS의 RDS를 통해 배포되어 있으며 My sql을 사용한다. 각 MSA 서버의 Repository계층에서 데이터베이스에 접근을 한다.
== Skeleton Architecture
각 서버들의 Skeleton Architecure이다. Quality Requirement에 따라 정제하였다.
=== 배민 서비스
#align(center, image("img/woowa_architecture.svg", width: 70%))
- Controller, Service, Repository, Domain으로 계층 구조를 이루고 있다.
- Controller 계층의 WoowaConsumer를 통해 message queue의 데이터를 consume하고 Service 계층의 WoowaProducer를 통해 message queue에 데이터를 produce한다. 이는 publish/subscribe패턴이 적용된 것으로 '각 분산 서비스가 다른 서비스의 결과에 따라 연쇄적으로 서비스가 실행되고 하나의 통합 서비스 처럼 보여야 한다.'라는 비기능적 요구 사항을 만족한다.
- Service계층의 SchedulerService에서는 스레드 풀을 통해 지정된 시간 이후에 실행되어야 하는 job들을 예약하는 로직이 구현되어 있다. 이를 통해 '고객의 주문 요청이 완료된 후, 가게로부터 3분 이내에 수락이 이루어 지지 않으면 주문 요청이 취소된다'라는 비기능적 요구사항을 만족한다.
- Controller 계층의 OrderEventHandler과 Service계층의 OrderEventPublisher은 observer패턴으로 구성되어 있다. 이는 주문이 요청되고, 자동 취소되고 등의 상태 변화를 observer패턴을 통해 변동하며 추적하고 있다.
=== 배달 서비스
#align(center, image("img/delivery_architecture.svg", width: 70%))
- Controller, Service, Repository, Domain으로 계층 구조를 이루고 있다.
- Controller 계층의 DeliveryConsumer를 통해 message queue의 데이터를 consume하고 Service 계층의 DeliveryProducer를 통해 message queue에 데이터를 produce한다. 이는 publish/subscribe패턴이 적용된 것으로 '각 분산 서비스가 다른 서비스의 결과에 따라 연쇄적으로 서비스가 실행되고 하나의 통합 서비스 처럼 보여야 한다.'라는 비기능적 요구 사항을 만족한다.
- Service계층의 SchedulerService에서는 스레드 풀을 통해 지정된 시간 이후에 실행되어야 하는 job들을 예약하는 로직이 구현되어 있다. 이를 통해 '기사가 배달 요청을 1분 이내에 수락하지 않을 시 요청을 취소하고, 다음 우선 순위의 기사에게 요청이 생성된다.'라는 비기능적 요구사항을 만족한다.
- Controller 계층의 DeliveryEventHandler과 Service계층의 DeliveryEventPublisher은 observer패턴으로 구성되어 있다. 이는 배달이 요청되고, 자동으로 취소되며, 이를 다음 순위의 기사에게 재요청하는 상태 변동 observer패턴을 통해 추적하고 있다.
- Service계층의 PriorityService를 통해 '가게가 배달을 요청했을 때 우선 순위에 따라 배달을 요청할 기사를 1초 이내에 판별해야 한다.'라는 비기능적 요구사항을 만족한다.
=== 결제 서비스
#align(center, image("img/payment_architecture.svg", width: 70%))
- Controller, Service, Repository, Domain으로 계층 구조를 이루고 있다.
- Controller 계층의 PaymentConsumer를 통해 message queue의 데이터를 consume하고 Service 계층의 PaymentProducer를 통해 message queue에 데이터를 produce한다. 이는 publish/subscribe패턴이 적용된 것으로 '각 분산 서비스가 다른 서비스의 결과에 따라 연쇄적으로 서비스가 실행되고 하나의 통합 서비스 처럼 보여야 한다.'라는 비기능적 요구 사항을 만족한다.
- Service계층의 ValidatorService를 통해 '결제 정보가 실제 존재하는 올바른 정보인 경우에만 결제에 성공해야 한다.'라는 비기능적 요구사항을 만족한다.
=== 카프카 서버
#align(center, image("img/kafka_architecture.svg", width: 30%))
== 적용한 아키텍처 및 디자인 패턴
=== Event Driven Architecture 
Kafka와 마이크로서비스 통신을 위한 이벤트 기반 아키텍처를 적용하였다.

=== Layered Architecture
각 마이크로서비스 구조에 대해 계층 설계를 적용하여 코드의 재사용성과 유지보수성을 높였다.
=== Observer Design pattern
각 마이크로 서비스 내의 이벤트 publish, subscribe 구조에 적용하여 상호작용에 유연하게 대응할 수 있도록 하였다.

=== Proxy Design pattern
SQL을 직접 작성하지 않고 Spring Data JPA를 활용하여 자동으로 생성되는 레파지토리를 사용하였다.

== Sequence Diagram
=== 배민 서비스
#align(center, image("img/seq1.png", width: 100%))
#align(center, image("img/seq2.png", width: 100%))
#align(center, image("img/seq3.png", width: 100%))
=== 결제 서비스
#align(center, image("img/seq4.png", width: 100%))
=== 배달 서비스
#align(center, image("img/deliverySequenceDiagram1.svg", width: 100%))
#align(center, image("img/deliverySequenceDiagram2.svg", width: 100%))
#align(center, image("img/deliverySequenceDiagram3.svg", width: 100%))
#align(center, image("img/deliverySequenceDiagram4.svg", width: 100%))
#align(center, image("img/deliverySequenceDiagram5.svg", width: 100%))
#align(center, image("img/deliverySequenceDiagram6.svg", width: 100%))

== Class Diagram
#align(center, image("img/class_diagram.svg", width: 100%))
위의 다이어그램은 최종적인 Class diagram이다. svg파일로 되어 있으며 확대 시 선명하게 확인할 수 있다. 아래는 class diagram을 구조화시킨 것이다.
#align(center, image("img/class_diagram2.png", width: 100%))
각 MSA서버들의 구현체를 확인할 수 있다. 배달 서비스, 배민 서비스, 결제 서비스에서 사용하는 클래스들이 정의되어 있으며, 하단에는 공통적으로 사용하는 응답, 도메인과 같은 클래스들이 정의되어 있다.
#align(center, image("img/class_diagram1.png", width: 100%))
각 MSA서버들은 내부적으로 계층구조로 설계되어 있다. 따라서 전체 클래스 다이어그램을 통해 이를 확인할 수 있다.

=== Woowa Class Diagram
#align(center, image("img/woowaClassDiagram.svg", width: 100%))

=== Delivery Class Diagram
#align(center, image("img/deliveryClassDiagram.svg", width: 100%))

=== Payment Class Diagram
#align(center, image("img/paymentClassDiagram.svg", width: 70%))
]
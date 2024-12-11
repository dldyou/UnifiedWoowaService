#let SoftwareArchitecture = [
= SW Architecture
== Initial Architecture
고객, 가게, 기사가 통합된 서비스를 이용할 수 있도록 한다.
#align(center, image("img/Initial_Architecture.svg", width: 70%))

== Conceptural Model
#align(center, image("img/conceptual_model.svg", width: 100%))
== Skeleton Architecture
Initial Architecture를 Quality Requirement에 따라 정제하였다.
#align(center, image("img/woowa_architecture.svg", width: 70%))
#align(center, image("img/delivery_architecture.svg", width: 70%))
#align(center, image("img/payment_architecture.svg", width: 70%))
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
#align(center, image("img/seq1.png", width: 100%))
#align(center, image("img/seq2.png", width: 100%))
#align(center, image("img/seq3.png", width: 100%))
#align(center, image("img/seq4.png", width: 100%))
#align(center, image("img/seq5.png", width: 100%))
#align(center, image("img/seq6.png", width: 100%))
== Class Diagram
#align(center, image("img/class_diagram.svg", width: 100%))
== Deployment Diagram
#align(center, image("img/deployment.svg", width: 100%))
]
#let SoftwareArchitecture = [
= SW Architecture
== 적용한 아키텍처 및 디자인 패턴
=== Event Driven Architecture 
Kafka와 마이크로서비스 통신을 위한 이벤트 기반 아키텍처를 적용하였다.

=== Layered Architecture
각 마이크로서비스 구조에 대해 계층 설계를 적용하여 코드의 재사용성과 유지보수성을 높였다.
=== Observer Design pattern
각 마이크로 서비스 내의 이벤트 publish, subscribe 구조에 적용하여 상호작용에 유연하게 대응할 수 있도록 하였다.

=== Proxy Design pattern
SQL을 직접 작성하지 않고 Spring Data JPA를 활용하여 자동으로 생성되는 레파지토리를 사용하였다.

== Conceptural Model
#align(center, image("img/conceptual_model.svg", width: 100%))
== Sequence Diagram
== Class Diagram
- 시스템 설계를 잘 나타낼 수 있는 다이어그램을 선택적으로 추가하기 (UML 참고)
- 적용한 Architecuture & Design Pattern에 대한 설명을 포함하기
== Deployment Diagram
]
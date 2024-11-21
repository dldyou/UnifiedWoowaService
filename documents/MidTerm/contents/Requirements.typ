#import "WoowaService.typ": WoowaService
#import "DeliveryService.typ": DeliveryService
#import "PaymentService.typ": PaymentService
#let Requirements = [
= 요구사항
== 기능요구사항
#WoowaService
#DeliveryService
#PaymentService
== 비기능요구사항
+ 사용자는 배민 통합서비스가 배민/배달 대행/결제 서비스로 분산되어있다는 것을 몰라야한다. 각 분산 서비스는 다른 서비스의 결과에 따라 연쇄적으로 서비스가 실행되고 하나의 통합 서비스처럼 보여야한다.
+ 고객의 주문 요청이 완료된 후 가게로부터 3분 이내에 수락이 이루어 지지 않으면 주문 요청이 취소된다.
+ 고객이 결제하는 수단은 3가지 이상이 지원된다
4. 고객의 결제 정보가 주문 요청 정보와 일치하는 유효한 정보일 경우에만 결제에 성공해야 한다.
+ 가게가 배달을 요청했을 때, 우선 순위에 따라 배달을 요청할 기사를 1초 이내에 판별해야 한다.
+ 기사가 배달 요청을 1분 이내에 수락하지 않을 시 요청을 취소하고, 다음 우선 순위의 기사에게 요청이 생성된다.
+ 모든 기사가 배달 요청을 거절했을 때, 배달 비용을 높여 처음부터 다시 배탈 요청을 진행한다.
]
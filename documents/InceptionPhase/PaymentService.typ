#let PaymentService = [
    = 결제 서비스
    == Use Case
    #align(center, image("img/payment_system_usecase.svg", width: 100%)) 
    == Actor
    - 배민 서비스 (WoowaService)
        - 결제 요청, 결제 취소 요청
    - 결제 서비스 (PaymentService) 
        - 결제 수단 인증, 결제 요청 승인, 결제 요청 거절, 결제 처리, 결제 취소
    == UseCase Brief Description
    === UC1: 결제 수단 인증하기 (Verify Payment Method)
    - 결제 서비스가 결제 수단를 확인하고 인증한다.
    === UC2: 결제 요청 승인하기 (Accept Payment Request)
    - 결제 서비스가 결제 요청을 승인한다.
    === UC3: 결제 요청 거절하기 (Reject Payment Request)
    - 결제 서비스가 결제 요청을 거절한다.
    === UC4: 결제 처리하기 (Process Payment)
    - 결제 서비스가 결제 수단에 따라 결제를 진행한다.
    === UC5: 결제 취소하기 (Cancel Payment)
    - 결제 서비스는 결제 정보를 통해 결제를 취소하고 결제 정보의 상태를 '취소'로 변경한다.
    == UseCase Description
    === UC1: 결제 수단 인증하기 (Verify Payment Method)
    #table(align: left,
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [결제 수단 인증하기 (Verify Payment Method)],
        [범위], [결제 서비스], 
        [수준], [결제 서비스 수준], 
        [주요 액터], [결제 서비스], 
        [사전 조건], [배민 서비스로부터 결제 요청을 받는다.], 
        [사후 조건], [배민 서비스에 결제 수단 인증 메세지가 전달된다.], 
        [기본 흐름], [
            1. 결제 서비스는 전달 받은 결제 수단이 고객의 명의로 등록되어 있는지 확인한다.
            2. 결제 서비스는 확인한 결제 수단 정보가 기재된 결제 수단 인증 완료 메세지를 배민 서비스에 전달한다.
        ], 
        [대체 흐름], [
            1a. 결제 수단이 등록되어 있지 않다면 결제 수단 인증이 거부된다.
        ],  
    )
    === UC2: 결제 요청 승인하기 (Accept Payment Request)
    #table(align: left,
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [결제 요청 승인하기 (Accept Payment Request)],
        [범위], [결제 서비스], 
        [수준], [결제 서비스 수준], 
        [주요 액터], [결제 서비스], 
        [사전 조건], [
            결제 수단 인증이 완료되었다. \
            배민 서비스로부터 결제 요청을 받는다.], 
        [사후 조건], [], 
        [기본 흐름], [
            1. 결제 정보의 현재 상태를 '승인됨'으로 변경한다.
            2. 결제 요청 승인 메세지를 배민 서비스에 전달한다.
        ], 
        [대체 흐름], [],  
    )
    === UC3: 결제 요청 거절하기 (Reject Payment Request)
    #table(align: left,
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [결제 요청 거절하기 (Reject Payment Request)],
        [범위], [결제 서비스], 
        [수준], [결제 서비스 수준], 
        [주요 액터], [결제 서비스], 
        [사전 조건], [
            결제 수단 인증이 완료되었다. \
            배민 서비스로부터 결제 요청을 받는다.], 
        [사후 조건], [], 
        [기본 흐름], [
            1. 결제 정보의 현재 상태를 '거부됨'으로 변경한다.
            2. 결제 요청 거부 메세지를 배민 서비스에 전달한다.
        ], 
        [대체 흐름], [],  
    )
    === UC4: 결제 처리하기 (Process Payment)
    #table(align: left,
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [결제 처리하기 (Process Payment)],
        [범위], [결제 서비스], 
        [수준], [결제 서비스 수준], 
        [주요 액터], [결제 서비스], 
        [사전 조건], [
            결제 수단 인증이 완료되었다. \
            배민 서비스로부터 결제 요청을 받는다.\
            결제 요청 승인이 완료되었다.], 
        [사후 조건], [결제 정보가 저장된다.], 
        [기본 흐름], [
            1. 결제 수단에 따라 결제를 진행한다.
            2. 결제 정보의 현재 상태를 '완료됨'으로 변경한다.
            2. 결제 정보를 저장하고 결제 금액 등의 정보가 기재된 결제 완료 메세지를 배민 서비스에 전달한다.
        ], 
        [대체 흐름], [
            1a. 결제가 실패하면 배민 서비스에 실패 사유 정보가 기재된 결제 실패 메세지를 전달한다.
        ],  
    )
    === UC5: 결제 취소하기 (Cancel Payment)
    #table(align: left,
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [결제 취소하기 (Cancel Payment)],
        [범위], [결제 서비스], 
        [수준], [결제 서비스 수준], 
        [주요 액터], [결제 서비스], 
        [사전 조건], [배민 서비스로부터 결제 취소 요청을 받는다.], 
        [사후 조건], [주문에 대한 결제 금액이 환불된다.], 
        [기본 흐름], [
            1. 결제 서비스는 주문에 대한 결제 정보가 저장되어 있는지 확인한다.
            2. 결제 정보가 있다면 결제 서비스는 지불된 금액을 환불하고 결제 정보의 현재 상태를 '취소됨'로 변경한다.
            3. 결제 취소가 성공적으로 완료되면 결제 서비스는 결제 취소 금액 등의 정보가 기재된 결제 취소 완료 메세지을 배민 서비스에 전달한다.
        ], 
        [대체 흐름], [
            1a. 결제 정보가 없는 경우, 결제 서비스는 결제 정보 없음 메세지를 배민 서비스에 전달한다.
        ],  
    )
]
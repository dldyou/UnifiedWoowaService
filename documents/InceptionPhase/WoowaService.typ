#let WoowaService = [
    = 배민 서비스 
    == UseCase
    #image("img/woowa_system_usecase.svg", width: 90%)
    == Actor 
    - 가게 (Store)
        - 서비스 등록 요청하기, 메뉴 등록하기, 주문 수락&거절하기
    - 서비스 관리자 (Service Manager)
        - 가게 추가 / 수정 / 삭제
    - 고객 (Customer)
        - 주문 요청하기

    == UseCase Brief Description 
    === UC1: 주문 요청하기 (Request Order)
    - 고객이 메뉴를 선택하여 가게에 주문을 요청한다

    === UC2: 결제 요청하기 (Request Payment)
    - 결제 서비스에 결제를 위임한다
    
    === UC3: 주문 취소하기 (Cancel Order)
    - 고객이 주문 목록 중 아직 배송이 취소되지 않은 주문을 취소한다

    === UC4: 결제 취소를 요청하기 (Request Cancle Payment)
    - 결제 서비스에 결제를 취소를 요청한다

    === UC5: 주문 확인하기 (Check Order Status)
    - 고객이 현재 주문의 상태를 확인한다

    === UC6: 서비스 등록 요청하기 (Request Service Registration)
    - 가게가 서비스에 가게 정보 등록을 요청한다

    === UC7: 메뉴 등록하기 (Register Menu)
    - 가게가 서비스에 메뉴를 등록한다

    === UC8: 주문 수락하기 (Accept Order)
    - 가게가 고객의 주문을 수락한다

    === UC9: 주문 거절하기 (Reject Order)
    - 가게가 고객의 주문을 거절한다

    === UC10: 서비스 등록 요청 수락하기 (Accept Service Registration Request)
    - 서비스 관리자가 가게의 등록 요청을 수락한다

    === UC11: 서비스 등록 요청 거절하기 (Reject Service Registration Request)
    - 서비스 관리자가 가게의 등록 요청을 거절한다

    == UseCase Description
    === UC1: 주문 요청하기 (Place Order)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [주문 요청하기 (Place Order)],
        [범위], [배달의 민족 서비스], 
        [수준], [사용자 수준], 
        [주요 액터], [Customer (고객)], 
        [사전 조건], [고객이 서비스에 로그인되어 있다], 
        [사후 조건], [
            주문 요청이 생성되고, 주문 번호가 반환된다. \
            주문에 대한 결제가 완료되면, 가게에 성공적으로 요청이 된다.
        ], 
        [기본 흐름], [
            1. 메뉴를 선택한다.
            2. 주문자 성함, 번호, 주소를 입력한다.
            2. 고객이 주문을 요청한다.
            3. 주문 번호가 고객에게 반환된다.
            4. 결제를 요청한다(UC2).
            5. 결제가 완료되면, 가게에 주문을 요청한다.
        ], 
        [대체 흐름], [
            1a. 메뉴의 총 가격이 가게의 최소 주문 금액 미달이면 주문이 거부된다. \
            4a. 결제가 진행되지 않으면 주문 요청은 생성되지만 가게에 주문이 요청되지 않는다.
        ],  
    )

    === UC2: 결제 요청하기 (Request Payment)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [결제 요청하기 (Request Payment)],
        [범위], [배달의 민족 서비스], 
        [수준], [시스템 수준], 
        [주요 액터], [Woowa Service (배민 서비스)], 
        [사전 조건], [고객이 주문을 요청한 후 결제 요청 정보가 생성된다.], 
        [사후 조건], [결제 서비스에 결제 요청 정보가 생성된다.], 
        [기본 흐름], [
            1. 주문 서비스가 고객의 이름, 번호, 결제 금액 등의 정보를 기재하여 결제 요청 정보를 생성한다.
            2. 결제 서비스에 결제 요청 정보를 전송한다.
        ], 
        [대체 흐름], [],  
    )

    === UC3: 주문 취소하기 (Cancel Order)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [주문 취소하기 (Cancel Order)],
        [범위], [배달의 민족 서비스], 
        [수준], [사용자 수준], 
        [주요 액터], [Customer (고객)], 
        [사전 조건], [주문 요청이 생성된 상태여야 한다], 
        [사후 조건], [주문이 취소된다], 
        [기본 흐름], [
            1. 고객이 주문 내역에서 주문을 선택한다.
            2. 주문 취소를 요청한다.
            3. 주문 메뉴, 환불 금액 등의 취소 정보가 반환된다.
            4. 결제 서비스에 환불을 요청한다(UC4).
        ], 
        [대체 흐름], [
            1a. 주문의 배송이 시작된 상태라면, 주문을 취소할 수 없다.
        ],  
    )

    === UC4: 결제 취소를 요청하기 (Request Cancel Payment)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [주문 취소하기 (Cancel Order)],
        [범위], [배달의 민족 서비스], 
        [수준], [사용자 수준], 
        [주요 액터], [Woowa Service (배민 서비스)], 
        [사전 조건], [주문 요청이 취소된 상태여야 한다], 
        [사후 조건], [결제 서비스에 결제 취소가 요청된다.], 
        [기본 흐름], [
            1. 고객의 이름, 번호, 결제 금액 등의 정보로 결제 취소 요청을 생성한다.
            2. 결제 취소를 요청한다.
        ], 
        [대체 흐름], [
            1a. 주문의 배송이 시작된 상태라면, 주문을 취소할 수 없다.
        ],  
    )

    === UC5: 주문 확인하기 (Check Order Status)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [주문 확인하기 (Check Order Status)],
        [범위], [배달의 민족 서비스], 
        [수준], [사용자 수준], 
        [주요 액터], [Customer (고객)], 
        [사전 조건], [주문 요청이 생성된 상태여야 한다], 
        [사후 조건], [주문 상태가 고객에게 표시된다], 
        [기본 흐름], [
            1. 고객이 주문 내역을 조회한다.
            2. 시스템이 현재 주문 상태(결제 전, 요청 중, 조리 중, 배송 중)를 표시한다.
        ], 
        [대체 흐름], [],  
    )

    === UC6: 서비스 등록 요청하기 (Request Service Registration)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [서비스 등록 요청하기 (Request Service Registration)],
        [범위], [배달의 민족 서비스], 
        [수준], [가게 수준], 
        [주요 액터], [Store (가게)], 
        [사전 조건], [가게가 시스템에 로그인한 상태여야 한다], 
        [사후 조건], [서비스 관리자에게 등록 요청이 전송된다], 
        [기본 흐름], [
            1. 가게가 가게 이름, 배달비, 최소 주문 금액을 입력한다.
            2. 서비스 등록을 요청한다.
        
        ], 
        [대체 흐름], [],  
    )

    === UC7: 메뉴 등록하기 (Register Menu)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [메뉴 등록하기 (Register Menu)],
        [범위], [배달의 민족 서비스], 
        [수준], [가게 수준], 
        [주요 액터], [Store (가게)], 
        [사전 조건], [가게가 시스템에 로그인한 상태여야 한다], 
        [사후 조건], [메뉴가 등록되고 고객에게 표시된다], 
        [기본 흐름], [
            1. 가게가 메뉴 등록 페이지를 연다.
            2. 가게가 메뉴 정보를 입력하고 등록을 완료한다.
        ], 
        [대체 흐름], [],  
    )

    === UC8: 주문 수락하기 (Accept Order)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [주문 수락하기 (Accept Order)],
        [범위], [배달의 민족 서비스], 
        [수준], [가게 수준], 
        [주요 액터], [Store (가게)], 
        [사전 조건], [가게가 주문 요청을 받은 상태여야 한다], 
        [사후 조건], [주문이 수락되어 고객에게 알림이 전송된다], 
        [기본 흐름], [
            1. 가게가 수신한 주문 요청을 검토한다.
            2. 가게가 주문을 수락한다.
        ], 
        [대체 흐름], [],  
    )

    === UC9: 주문 거절하기 (Reject Order)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [주문 거절하기 (Reject Order)],
        [범위], [배달의 민족 서비스], 
        [수준], [가게 수준], 
        [주요 액터], [Store (가게)], 
        [사전 조건], [가게가 주문 요청을 받은 상태여야 한다], 
        [사후 조건], [주문이 거절되어 고객에게 알림이 전송된다], 
        [기본 흐름], [
            1. 가게가 수신한 주문 요청을 검토한다.
            2. 가게가 주문을 거절하고, 거절 사유를 입력한다.
        ], 
        [대체 흐름], [],  
    )

    === UC10: 서비스 등록 요청 수락하기 (Accept Service Registration Request)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [서비스 등록 요청 수락하기 (Accept Service Registration Request)],
        [범위], [배달의 민족 서비스], 
        [수준], [관리자 수준], 
        [주요 액터], [Service Manager (서비스 관리자)], 
        [사전 조건], [가게의 서비스 등록 요청이 접수된 상태여야 한다], 
        [사후 조건], [가게의 서비스가 등록되고, 가게에게 알림이 전송된다], 
        [기본 흐름], [
            1. 서비스 관리자가 등록 요청 목록에서 가게 이름, 배달비, 최소 주문 금액 등의 정보를 검토한다.
            2. 관리자가 등록 요청을 수락한다.
        ], 
        [대체 흐름], [],  
    )

    === UC11: 서비스 등록 요청 거절하기 (Reject Service Registration Request)
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [서비스 등록 요청 거절하기 (Reject Service Registration Request)],
        [범위], [배달의 민족 서비스], 
        [수준], [관리자 수준], 
        [주요 액터], [Service Manager (서비스 관리자)], 
        [사전 조건], [가게의 서비스 등록 요청이 접수된 상태여야 한다], 
        [사후 조건], [가게의 서비스 등록 요청이 거절되고, 가게에게 알림이 전송된다], 
        [기본 흐름], [
            1. 서비스 관리자가 등록 요청 목록에서 가게 이름, 배달비, 최소 주문 금액 등의 정보를 검토한다.
            2. 관리자가 등록 요청을 거절한다.
        ], 
        [대체 흐름], [],  
    )

    == Conceptual Model
    #image("img/image.png", width: 10%) // sample image
]


#WoowaService
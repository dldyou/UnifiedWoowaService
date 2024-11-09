#let DeliveryService = [
    = 배달 대행 서비스 
    == Actor 
    - 가게 (Store)
        - 배달 요청하기, 기사 배정받기, 음식 전달하기, 서비스 등록 요청하기
    - 기사 (Delivery)
        - 배달 승인하기, 음식 전달받기, 음식 배달하기, 서비스 등록 요청하기
    - 배달 대행 서비스 (Delivery Service)
        - 배달 요청받기, 배달 요청하기, 배달 승인받기, 기사 배정하기
    - 서비스 관리자 (Service Manager)
        - 가게 추가 / 수정 / 삭제, 기사 추가 / 수정 / 삭제 
    - 고객 (Customer)
        - 음식 배달받기
    == UseCase Brief Description 
    === UC1: 배달 요청하기 (Request Delivery) 
    - 가게가 배달 대행 서비스에 특정 고객에게로의 배달을 요청한다.
    == UseCase Description 
    === UC1: 배달 요청하기 
    #table(align: center, 
        columns: 2, 
        [*UseCase*], [*Description*],
        [이름], [],
        [범위], [], 
        [수준], [], 
        [주요 액터], [], 
        [사전 조건], [], 
        [사후 조건], [], 
        [기본 흐름], [], 
        [대체 흐름], [],  
    )
    == Conceptual Model
    #image("img/image.png", width: 10%) // sample image
]
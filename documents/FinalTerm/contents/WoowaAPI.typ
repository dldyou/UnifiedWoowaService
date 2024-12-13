#let WoowaAPI = [
=== 배민 서비스 
#table(
    align: left, 
    columns: (auto, 1fr),
    [*API Info*], [사용자 등록],
    [*Request URL*], [http://localhost:8080/woowa/users],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - userName : (String) 사용자 이름
        - locationName : (String) 장소 이름
        - x : (double) x좌표
        - y : (double) y좌표
        - userRole : (String) CUSTOMER, MANAGER, DELIVERYMAN 중 택1
    ],
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
  [*return*], [userId : 사용자 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [가게 등록 요청],
    [*Request URL*], [http://localhost:8080/woowa/users/{userId}/stores/request],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - storeName : (String) 가게 이름
        - locationName : (String) 장소 이름
        - x : (double) x좌표
        - y : (double) y좌표
        - deliveryPrice : (int) 배달비
        - minimumOrderPrice : (int) 최소 주문 금액
    ],
    [*Body Example*], [
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
    [*return*], [storeId : 가게 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [가게 등록 요청 승인],
    [*Request URL*], [http://localhost:8080/woowa/users/{userId}/stores/{userId}/accept],
    [*HTTP Method*], [POST],
    [*return*], [storeId : 가게 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [가게 메뉴 추가],
    [*Request URL*], [http://localhost:8080/woowa/users/{userId}/stores/{storeId}],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - menuName : (String) 메뉴 이름
        - menuPrice : (int) 메뉴 가격
    ],
    [*Body Example*], [
        ```json
        {
            "menuName" : "제육볶음",
            "menuPrice" : 8000
        }
        ```
    ],
    [*return*], [storeId : 가게 고유 아이디]
)
]
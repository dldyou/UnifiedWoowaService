#let DeliveryAPI = [
=== 배달 서비스 
#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [유저 등록],
    [*Request URL*], [http://localhost:8080/delivery/users],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - userName : (String) 사용자 이름
        - locationName : (String) 장소 이름
        - x : (double) x좌표
        - y : (double) y좌표
        - userRole : (String) STORE, DELIVERYMAN, MANAGER 중 택1
    ],
    [*Body Example*], [
        ```json
        {
            "userName": "store1",
            "location": {
                "locationName": "loc1",
                "x" : 0.0,
                "y" : 0.0
            },
            "userRole" : "STORE"
        }
        ```
    ],
    [*return*], []
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [가게 서비스 요청],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/stores/request],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - storeName : (String) 가게 이름
        - locationName : (String) 장소 이름
        - x : (double) x좌표
        - y : (double) y좌표
        - deliveryPrice : (int) 배달 가격
        - minimumOrderPrice : (int) 최소 주문 가격
    ],
    [*Body Example*], [
        ```json
        {
            "storeName": "위락",
            "location": {
                "locationName": "자양동",
                "x" : 123.1,
                "y" : 123.1
            },
            "deliveryPrice" : 1500,
            "minimumOrderPrice": 10000
        }
        ```
    ],
    [*return*], []
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [가게 서비스 승인],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/stores/{requestId}/accept],
    [*HTTP Method*], [POST],
    [*return*], [storeId : 가게 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [가게 서비스 거절],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/stores/{requestId}/deny],
    [*HTTP Method*], [POST],
    [*return*], [storeId : 가게 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [기사 서비스 요청],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliverymen/request],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - deliveryManName : (String) 기사 이름
        - locationName : (String) 장소 이름
        - x : (double) x좌표
        - y : (double) y좌표
    ],
    [*Body Example*], [
        ```json
        {
            "deliveryManName": "기사1",
            "location": {
                "locationName": "장소3",
                "x": 3.0,
                "y": 5.0
            }
        }
        ```
    ],
    [*return*], [deliveryManId : 기사 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [기사 서비스 승인],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliverymen/{requestId}/accept],
    [*HTTP Method*], [POST],
    [*return*], [deliveryManId : 기사 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [기사 서비스 거절],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliverymen/{requestId}/deny],
    [*HTTP Method*], [POST],
    [*return*], [deliveryManId : 기사 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [배달 요청],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliveries/request],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - userName: (String) 사용자 이름
        - locationName: (String) 장소 이름
        - x: (double) x좌표
        - y: (double) y좌표
        - userRole: (String) CUSTOMER
        \
        - storeName: (String) 가게 이름
        - locationName: (String) 장소 이름
        - x: (double) x좌표
        - y: (double) y좌표
        - userRole: (String) STORE
        \
        - orderId: (Long) 주문 아이디
        - deliveryPrice: (int) 배달 가격
    ],
    [*Body Example*], [
        ```json
        {
            "user": {
                "userName": "고객1",
                "location": {
                    "locationName": "장소0",
                    "x": -2.0,
                    "y": 2.0
                },
                "userRole": "CUSTOMER"
            },
            "store": {
                "userName": "가게1",
                "location": {
                    "locationName": "장소1",
                    "x": 0.0,
                    "y": 0.0
                },
                "userRole": "STORE"
            },
            "orderId": 1,
            "deliveryPrice": 1000
        }
        ```
    ],
    [*return*], [deliveryId: 배달 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [배달 취소],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliveries/{deliveryId}],
    [*HTTP Method*], [DELETE],
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [배달 확인],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliveries/{deliveryId}],
    [*HTTP Method*], [GET],
    [*return*], [
        ```json
        {
            "deliveryId": 1,
            "customer": {
                "userName": "고객1",
                "location": {
                    "locationName": "장소0",
                    "x": -2.0,
                    "y": 2.0
                },
                "userRole": "CUSTOMER"
            },
            "store": {
                "userName": "가게1",
                "location": {
                    "locationName": "장소1",
                    "x": 0.0,
                    "y": 0.0
                },
                "userRole": "STORE"
            },
            "orderId": 1,
            "deliveryPrice": 1000
        }
        ```
    ]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [배달 승인 대기 목록],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliveries/wait],
    [*HTTP Method*], [GET],
    [*return*], [
        ```json
        [
            {
                "deliveryId": 1,
                "customer": {
                    "userName": "고객1",
                    "location": {
                        "locationName": "장소0",
                        "x": -2.0,
                        "y": 2.0
                    },
                    "userRole": "CUSTOMER"
                },
                "store": {
                    "userName": "가게1",
                    "location": {
                        "locationName": "장소1",
                        "x": 0.0,
                        "y": 0.0
                    },
                    "userRole": "STORE"
                },
                "orderId": 1,
                "deliveryPrice": 1000
            }
        ]
        ```
    ]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [배달 승인],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliveries/{deliveryId}/deliverymen/{deliveryManId}/accept],
    [*HTTP Method*], [POST],
    [*return*], [deliveryId : 배달 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [배달 거절],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliveries/{deliveryId}/deliverymen/{deliveryManId}/deny],
    [*HTTP Method*], [POST],
    [*return*], [deliveryId : 배달 고유 아이디]
)

#table( 
    align: left, 
    columns: (auto, 1fr), 
    [*API Info*], [배달 완료],
    [*Request URL*], [http://localhost:8080/delivery/users/{userId}/deliveries/{deliveryId}/deliverymen/{deliveryManId}/done],
    [*HTTP Method*], [POST],
    [*return*], [deliveryId : 배달 고유 아이디]
)
]
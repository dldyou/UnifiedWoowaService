#let PaymentAPI = [

=== 결제 서비스 
#table(
  align: left, 
    columns: (auto, 1fr),
    [*API Info*], [결제 요청],
    [*Request URL*], [http://localhost:8080/payment/request],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - orderId : (Long) 주문 ID
        - userId : (Long) 사용자 ID
        - paymentMethodType : (String) ACCOUNT_TRANSFER, CREDIT_CARD, WOOWA_PAYMENT 중 택1
        - paymentStatus : (String) WAIT, ACCEPT, DENY, PAID, REFUND 중 택1
    ],
    [*Body Example*], [
        ```json
        {
            "orderId": 111,
            "userId" : 333,
            "paymentMethodType" : "ACCOUNT_TRANSFER"
        }
        ```
    ],
    [*return*], [
        ```json
        {
            "orderId": 111,
            "paymentId": 222,
            "userId" : 333,
            "paymentMethodType" : "ACCOUNT_TRANSFER",
            "paymentStatus" : "WAIT"
        }
        ```
    ]
)

#table(
    align: left, 
    columns: (auto, 1fr),
    [*API Info*], [결제 수단 검증],
    [*Request URL*], [http://localhost:8080/payment/validate],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - userId : (Long) 사용자 ID
        - paymentMethodType : (String) ACCOUNT_TRANSFER, CREDIT_CARD, WOOWA_PAYMENT 중 택1
    ],
    [*Body Example*], [
        ```json
        {
            "userId" : 111,
            "paymentMethodType" : "ACCOUNT_TRANSFER"
        }
        ```
    ],
    [*return*], [
        ```json
        {
            "userId" : 111,
            "paymentMethodType" : "ACCOUNT_TRANSFER",
            "paymentStatus" : "ACCEPT"
        }
        ```
    ]
)

#table(
    align: left, 
    columns: (auto, 1fr),
    [*API Info*], [결제 취소],
    [*Request URL*], [http://localhost:8080/payment/cancel],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - paymentId : (Long) 결제 ID
        - paymentMethodType : (String) ACCOUNT_TRANSFER, CREDIT_CARD, WOOWA_PAYMENT 중 택1
    ],
    [*Body Example*], [
        ```json
        {
            "paymentId": 222,
            "paymentMethodType" : "CREDIT_CARD"
        }
        ```
    ],
    [*return*], [
        ```json
        {
            "paymentId": 222,
            "paymentMethodType" : "CREDIT_CARD",
            "paymentStatus" : "REFUND"
        }
        ```
    ]
)

#table(
    align: left, 
    columns: (auto, 1fr),
    [*API Info*], [계좌이체 결제 수단 등록],
    [*Request URL*], [http://localhost:8080/payment/save/account-transfer],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - userId : (Long) 사용자 ID
        - accountNumber : (String) 계좌번호
        - balance : (Long) 잔액
    ],
    [*Body Example*], [
        ```json
        {
            "userId" : 333,
            "accountNumber" : "123-456-789",
            "balance" : 100000
        }
        ```
    ],
    [*return*], []
)

#table(
    align: left, 
    columns: (auto, 1fr),
    [*API Info*], [신용카드 결제 수단 등록],
    [*Request URL*], [http://localhost:8080/payment/save/credit-card],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - userId : (Long) 사용자 ID
        - cardNumber : (String) 카드번호
        - bankName : (String) 은행명
    ],
    [*Body Example*], [
        ```json
        {
            "userId" : 333,
            "cardNumber" : "1234-5678-1234-5678",
            "bankName" : "우리은행"
        }
        ```
    ],
    [*return*], []
)

#table(
    align: left, 
    columns: (auto, 1fr),
    [*API Info*], [간편결제 결제 수단 등록],
    [*Request URL*], [http://localhost:8080/payment/save/woowa-payment],
    [*HTTP Method*], [POST],
    [*Body Parameter*], [
        - userId : (Long) 사용자 ID
        - password : (String) 비밀번호
        - balance : (Long) 잔액
    ],
    [*Body Example*], [
        ```json
        {
            "userId" : 333,
            "password" : "1234",
            "balance" : 100000
        }
        ```
    ],
    [*return*], []
)
]
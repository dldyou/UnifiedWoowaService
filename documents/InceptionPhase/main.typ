#import "template.typ": *
#import "WoowaService.typ": WoowaService
#import "DeliveryService.typ": DeliveryService
#import "PaymentService.typ": PaymentService

#show: project.with(title: title, authors: authors,)

#WoowaService
#DeliveryService
#PaymentService

= Conceptural Model
#align(center, image("img/conceptual_model.svg", width: 100%))
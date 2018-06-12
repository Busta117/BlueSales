//
//  ProductDetailMock.swift
//  BlueSalesTests
//
//  Created by Santiago Bustamante on 6/11/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import ObjectMapper

extension ProductDetail {
    
    class func mocked() -> ProductDetail? {
        
        let jsonText = """
{
  "product":  {
        "productId": 785359,
        "productName": "Fake Apple iPhone X id: 785359",
        "productText": "<p>Met iPhone X neemt Apple afscheid van zijn herkenbare smartphone uiterlijk met ronde home button onder het scherm. Deze knop heeft plaatsgemaakt voor een groot scherm dat de hele voorkant van het toestel in beslag neemt. Dankzij dit vrijwel randloze scherm geniet je van een groter beeldscherm terwijl de telefoon in zijn geheel kleiner is dan iPhone 7 Plus. De vingerafdrukscanner is verdwenen, maar is vervangen door het zogeheten Face ID. De smartphone maakt een 3D scan van je gezicht en ontgrendelt de telefoon zodra hij je herkent. Foto's maak je met de dubbele 12 megapixel camera met optische beeldstabilisatie. Deze camera levert scherpe foto's af, ook als je het toestel enigszins beweegt en bij weinig licht.</p>",
        "reviewInformation": {
            "reviews": [
                {
                    "reviewId": 8653068,
                    "pros": [
                        "Nieuw Design",
                        "Face ID",
                        "True Depth Camera",
                        "OLED-Scherm",
                        "Batterij"
                    ],
                    "cons": [
                        "Prijs"
                    ],
                    "creationDate": "2017-11-07T19:41:34+00:00",
                    "creatorName": "Zay.",
                    "description": "description of the review",
                    "title": "Beste iPhone sinds jaren...",
                    "rating": 9.6,
                    "languageCode": "nl"
                }
            ],
            "reviewSummary": {
                "reviewAverage": 9.2,
                "reviewCount": 218
            }
        },
        "USPs": [
            "256 GB opslagcapaciteit",
            "5,8 inch Retina HD scherm",
            "iOS 11"
        ],
        "pros": [
            "Dankzij Qi ondersteuning laad je jouw iPhone nu ook draadloos op.",
            "Via Face ID ontgrendel je de telefoon door er simpelweg naar te kijken.",
            "Met de dubbele camera met optische beeldstabilisatie maak je scherpe foto's."
        ],
        "cons": [
            "De camera zorgt voor een kleine uitstulping aan de achterkant."
        ],
        "availabilityState": 2,
        "salesPriceIncVat": 1249,
        "salesPriceExVat": 1032.2314,
        "productImages": [
            "https://image.coolblue.nl/1024x768/products/982903",
            "https://image.coolblue.nl/1024x768/products/982904",
            "https://image.coolblue.nl/1024x768/products/982905",
            "https://image.coolblue.nl/1024x768/products/982906",
            "https://image.coolblue.nl/1024x768/products/984073",
            "https://image.coolblue.nl/1024x768/products/982907",
            "https://image.coolblue.nl/1024x768/products/982908",
            "https://image.coolblue.nl/1024x768/products/984074",
            "https://image.coolblue.nl/1024x768/products/984075",
            "https://image.coolblue.nl/1024x768/products/982909"
        ],
        "deliveredWith": [
            "Oplader",
            "Lightning oordopjes",
            "Lightning naar 3,5 mm aansluiting",
            "Handleiding"
        ],
        "specificationSummary": [
            {
                "name": "RAM-geheugen",
                "value": "3 GB",
                "stringValue": "3 GB"
            },
            {
                "name": "Totale opslagcapaciteit",
                "value": "256 GB",
                "stringValue": "256 GB"
            },
            {
                "name": "Schermdiagonaal",
                "value": "5,8 inch",
                "stringValue": "5,8 inch"
            },
            {
                "name": "Batterijduur",
                "value": "Tussen de 9 en 10 uur",
                "stringValue": "Tussen de 9 en 10 uur"
            },
            {
                "name": "Vingerafdruksensor",
                "value": false,
                "booleanValue": false
            }
        ],
        "nextDayDelivery": true,
        "recommendedAccessories": [
            788435,
            792919,
            787407,
            788439,
            787454,
            787447,
            794863,
            742747,
            741123
        ]
    }
}
"""
        
        
        if let data = jsonText.data(using: .utf8) {
            do {
                let JSONObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable: Any]
                if let JSONObject = JSONObject, let product = JSONObject["product"] {
                    let parsedObject = Mapper<ProductDetail>(context: nil, shouldIncludeNilValues: false).map(JSONObject: product)
                    return parsedObject
                }
            } catch {
                return nil
            }
        }
        return nil
    }
    
}

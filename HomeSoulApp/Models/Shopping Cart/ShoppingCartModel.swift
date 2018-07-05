//
//  ShoppingCartModel.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 29/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import ObjectMapper

struct ShoppingCartModel: Mappable {
    
    var error: APIErrorModel?
    var products: [ShoppingCartProductModel]?
    var vouchers: [ShoppingCartVoucherModel]?
    var totals: [ShoppingCartTotalModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        error       <- map["error"]
        products       <- map["products"]
        vouchers     <- map["vouchers"]
        totals     <- map["totals"]
    }
}

struct ShoppingCartProductModel: Mappable {
    
    var cart_id: String?
    var product_id: String?
    var name: String?
    var model: String?
    var quantity: String?
    var stock: Bool?
    var shipping: String?
    var price: String?
    var total: String?
    var reward: Int?
    var option: [ShoppingCartProductOptionModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cart_id       <- map["cart_id"]
        product_id       <- map["product_id"]
        name       <- map["name"]
        model       <- map["model"]
        quantity       <- map["quantity"]
        stock       <- map["stock"]
        shipping       <- map["shipping"]
        price       <- map["price"]
        total       <- map["total"]
        reward       <- map["reward"]
        option       <- map["option"]
    }
}

struct ShoppingCartProductOptionModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
    }
}

struct ShoppingCartVoucherModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
    }
}

struct ShoppingCartTotalModel: Mappable {
    
    var title: String?
    var text: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title       <- map["title"]
        text       <- map["text"]
    }
}

struct APIErrorModel: Mappable {
    
    var warning: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        warning       <- map["warning"]
    }
}

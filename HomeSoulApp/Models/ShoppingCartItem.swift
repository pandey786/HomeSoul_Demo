//
//  ShoppingCartItem.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 07/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import RealmSwift

final class ShoppingCartItem: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var product_Name = ""
    @objc dynamic var product_Id = ""
    @objc dynamic var product_Price = ""
    @objc dynamic var product_Quantity = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//
//  ShoppingCartItem.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 07/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

class ShoppingCartItem: NSObject, Codable, NSCoding {
    var product_Id: String = ""
    var product_Title: String = ""
    var product_Image: String = ""
    var product_Price: String = ""
    var product_Quantity: String = ""
    
    init(product_Id: String, product_Title: String, product_Image: String, product_Price: String, product_Quantity: String) {
        self.product_Id = product_Id
        self.product_Title = product_Title
        self.product_Image = product_Image
        self.product_Price = product_Price
        self.product_Quantity = product_Quantity
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let product_Id = aDecoder.decodeObject(forKey: "product_Id") as! String
        let product_Title = aDecoder.decodeObject(forKey: "product_Title") as! String
        let product_Image = aDecoder.decodeObject(forKey: "product_Image") as! String
        let product_Price = aDecoder.decodeObject(forKey: "product_Price") as! String
        let product_Quantity = aDecoder.decodeObject(forKey: "product_Quantity") as! String
        self.init(product_Id: product_Id, product_Title: product_Title, product_Image: product_Image, product_Price: product_Price, product_Quantity: product_Quantity)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(product_Id, forKey: "product_Id")
        aCoder.encode(product_Title, forKey: "product_Title")
        aCoder.encode(product_Image, forKey: "product_Image")
        aCoder.encode(product_Price, forKey: "product_Price")
        aCoder.encode(product_Quantity, forKey: "product_Quantity")
    }
}



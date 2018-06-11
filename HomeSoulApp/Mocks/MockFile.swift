//
//  MockFile.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 07/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

// MARK: - Set Up Products
// MARK: -

func createProductList() -> [ProductModel] {
    
    var productArr = [ProductModel]()
    
    for i in 0..<20 {
        let prodModel = ProductModel()
        prodModel.product_Id = "\(i)"
        prodModel.product_Title = "Product \(i)"
        prodModel.product_Price = "\(i * 100)"
        productArr.append(prodModel)
    }
    
    return productArr
}

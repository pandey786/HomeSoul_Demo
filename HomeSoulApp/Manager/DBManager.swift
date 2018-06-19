//
//  DBManager.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 07/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    
    var database:Realm
    static let sharedInstance = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getShoppingCartItemsFromDB() ->   Results<ShoppingCartItem> {
        let results: Results<ShoppingCartItem> =   database.objects(ShoppingCartItem.self)
        return results
    }
    
    func addShoppingCartItem(object: ShoppingCartItem)   {
   
        try! database.write {
            database.add(object, update: false)
            print("Added new object")
        }
    }
    
    func deleteAllFromDatabase()  {
        
        try!   database.write {
            database.deleteAll()
        }
    }
    
    func deleteShoppingCartItemFromDb(object: ShoppingCartItem)   {
        
        try!   database.write {
            database.delete(object)
        }
    }
}

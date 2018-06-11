//
//  AppUtility.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 12/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import Foundation
import UIKit

struct StoryBoard {
    static let main: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
}

struct AppInstances {
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
}

public let textColor: UIColor = UIColor.init(red: 43.0/255.0, green: 65.0/255.0, blue: 107.0/255.0, alpha: 1.0)
public let bgColor: UIColor = UIColor.init(red: 250.0/255.0, green: 221.0/255.0, blue: 50.0/255.0, alpha: 1.0)

// MARK: - Shopping Cart Badge
// MARK: -
func updateShoppingCartBadge(currentCtrl: UIViewController) {
    
    let currentItems = DBManager.sharedInstance.getShoppingCartItemsFromDB()
    if let shoppingCartTabBarItem = currentCtrl.tabBarController?.tabBar.items?[2] {
        shoppingCartTabBarItem.badgeValue =  currentItems.count > 0 ? "\(currentItems.count)": nil
    }
}

// MARK: - UIView Extension
// MARK: -
extension UIView {
    
    func addDropShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false;
    }
    
    func addBorder() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = textColor.cgColor
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}

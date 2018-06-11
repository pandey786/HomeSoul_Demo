//
//  ShoppingCartViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 07/06/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    var shoppingCartItems = [ShoppingCartItem]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UINib.init(nibName: "ShoppingCartTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingCartTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.shoppingCartItems = Array(DBManager.sharedInstance.getShoppingCartItemsFromDB())
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingCartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cartItem: ShoppingCartTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell") as! ShoppingCartTableViewCell
        
        let shoppingCartItem = self.shoppingCartItems[indexPath.row]
        cartItem.labelProductTitle.text = shoppingCartItem.product_Name
        cartItem.labelProductDesc.text = "Product Description"
        cartItem.labelProdPrice.text = "Rs. \(shoppingCartItem.product_Price)"
        cartItem.labelQuantity.text = "\(shoppingCartItem.product_Quantity)"
        cartItem.labelTotalPrice.text = "Rs. \(Double(shoppingCartItem.product_Price)! * Double(shoppingCartItem.product_Quantity))"
        
        cartItem.selectionStyle = .none
        return cartItem
    }
}

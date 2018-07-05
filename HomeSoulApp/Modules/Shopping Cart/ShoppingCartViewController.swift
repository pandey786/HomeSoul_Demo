//
//  ShoppingCartViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 07/06/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit
import EMAlertController
import HGPlaceholders

class ShoppingCartViewController: UIViewController, IndicatableView {
    
    var shoppingCartItems = [ShoppingCartItem]()
    var hasSessionExpiredEarlier = false
    var placeholderTableView: TableView?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTotalAmount: UILabel!
    @IBOutlet weak var buttonCheckout: UIButton!
    @IBOutlet weak var constraintViewTotalAmountHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UINib.init(nibName: "ShoppingCartTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingCartTableViewCell")
        
        placeholderTableView = tableView as? TableView
        placeholderTableView?.placeholderDelegate = self
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.displayShoppingCartItems()
        
        placeholderTableView?.placeholdersProvider = .default2
        placeholderTableView?.showNoResultsPlaceholder()
    }
    
    func setUpCheckOutButton() {
        if self.shoppingCartItems.count > 0 {
            self.buttonCheckout.isEnabled = true
            self.buttonCheckout.backgroundColor = UIColor.init(hexString: "#FADD32")
            self.displayTotalAmountView(shouldDisplay: true)
            
        } else {
            self.buttonCheckout.isEnabled = false
            self.buttonCheckout.backgroundColor = UIColor.lightGray
            self.displayTotalAmountView(shouldDisplay: false)
        }
    }
    
    private func displayTotalAmountView(shouldDisplay: Bool) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.constraintViewTotalAmountHeight.constant = shouldDisplay ? 50.0: 0.0
            self.view.layoutIfNeeded()
        }
    }
    
    private func displayShoppingCartItems() {
        
        //Get Product List
        self.shoppingCartItems = AppInstances.appDelegate.getProductsFromShoppingCart()
        self.tableView.reloadData()
        
        self.labelTotalAmount.text = self.getTotalAmount()
        self.setUpCheckOutButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getTotalAmount() -> String {
        
        var prodTotalVal = 0.00
        
        for cartItem in self.shoppingCartItems {
            let prodTotal = Double(cartItem.product_Quantity.count > 0 ? cartItem.product_Quantity:"0")! * Double(cartItem.product_Price.count > 0 ? cartItem.product_Price:"0")!
            prodTotalVal += prodTotal
        }
        return "Rs. \(prodTotalVal)/-"
    }
    
    private func getShoppingCartItemsListFromOpenCart() {
        
        //get Products List
        self.showActivityIndicator()
        ShoppingCartService.getProductsList { (shoppingCartModel, isError, errorStr) in
            
            self.hideActivityIndicator()
            if !isError, let shoppingCartModel = shoppingCartModel {
                
                //Check If Session Expired
                if shoppingCartModel.error != nil, shoppingCartModel.error?.warning == "Warning: You do not have permission to access the API!", self.hasSessionExpiredEarlier == false {
                    
                    AppSessionManager.refreshAPIToken(completionHandler: { (isSucess, api_Token) in
                        
                        self.hasSessionExpiredEarlier = true
                        
                        //Refresh Shopping List
                        self.getShoppingCartItemsListFromOpenCart()
                    })
                }
            } else {
                //Error
            }
        }
    }
    
    @IBAction func buttonCheckoutTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "CheckOutViewController", sender: nil)
        
        /*
         let alertCtrl = EMAlertController.init(title: "Coming Soon...", message: "Hi,\n Thanks For your Patience.\n We are still in Development Phase, You will be able to enjoy complete features of HomeSoul Soon.")
         let okButton = EMAlertAction(title: "Awesome!", style: .cancel)
         alertCtrl.addAction(action: okButton)
         self.present(alertCtrl, animated: true, completion: nil)
         */
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
        cartItem.imageViewProduct.image = UIImage.init(named: shoppingCartItem.product_Title)
        cartItem.labelProductTitle.text = shoppingCartItem.product_Title
        cartItem.labelProductDesc.text = "Product Description"
        cartItem.labelProdPrice.text = "Rs. \(shoppingCartItem.product_Price)/meter"
        cartItem.labelQuantity.text = "\(shoppingCartItem.product_Quantity)"
        
        let prodTotal = Double(shoppingCartItem.product_Quantity.count > 0 ? shoppingCartItem.product_Quantity:"0")! * Double(shoppingCartItem.product_Price.count > 0 ? shoppingCartItem.product_Price:"0")!
        cartItem.labelTotalPrice.text = "Rs. \(prodTotal)/-"
        
        cartItem.buttonRemove.tag = indexPath.item
        cartItem.buttonRemove.addTarget(self, action: #selector(removeFromCartButtonTapped(sender:)), for: .touchUpInside)
        
        cartItem.selectionStyle = .none
        return cartItem
    }
    
    @objc func removeFromCartButtonTapped(sender: UIButton) {
        
        let prodModel = self.shoppingCartItems[sender.tag]
        AppInstances.appDelegate.removeProductFromCart(prodModel: prodModel)
        self.displayShoppingCartItems()
    }
}

extension ShoppingCartViewController: PlaceholderDelegate {
    
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
        placeholderTableView?.showDefault()
    }
    
}

// MARK: - Empty State
// MARK: -
extension ShoppingCartViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "Oops! Nothing Found Here";
        let font = UIFont.boldSystemFont(ofSize: 17.0)
        let textColor = UIColor.init(hexString: "#25282b")
        
        var textAttr = [NSAttributedStringKey: Any]()
        textAttr[.font] = font
        textAttr[.foregroundColor] = textColor
        
        let attrStr = NSAttributedString.init(string: text, attributes: textAttr)
        return attrStr
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let emptyPlaceHolderImage = UIImage.init(named: "placeholder_Empty")
        return emptyPlaceHolderImage
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.init(hexString: "#f0f3f5")
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}

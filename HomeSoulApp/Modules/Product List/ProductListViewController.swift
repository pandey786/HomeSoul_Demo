//
//  ProductListViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 13/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit
import DropDownMenuKit
import RAMAnimatedTabBarController

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var collectionViewProductList: UICollectionView!
    
    var navigationBarMenu: DropDownMenu!
    var titleView: DropDownTitleView!
    
    //Set Prod Category
    var productCategory: ProductCategory?
    var viewType: ViewType = .grid
    var productList = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = prepareNavigationBarMenuTitleView()
        self.prepareNavigationBarMenu(title)
        self.navigationBarMenu.container = self.view
        self.viewHeader.addDropShadow()
        
        //Set Up Data Source
        self.productList = createProductList()
        
        //Register Collection Cells
        self.collectionViewProductList.register(UINib.init(nibName: "ProdListCollectionViewCell_Grid", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_Grid")
        self.collectionViewProductList.register(UINib.init(nibName: "ProdListCollectionViewCell_List", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_List")
        
    }
    
    @IBAction func buttonBlockTapped(_ sender: Any) {
        self.collectionViewProductList.reloadData()
        
        let sortByCtrl: SortOrderViewController = StoryBoard.main.instantiateViewController(withIdentifier: "SortOrderViewController") as! SortOrderViewController
        self.present(sortByCtrl, animated: true, completion: nil)
        
    }
    
    @IBAction func buttonGridTapped(_ sender: Any) {
        self.viewType = .grid
        self.collectionViewProductList.reloadData()
    }
    
    @IBAction func buttonListTapped(_ sender: Any) {
        self.viewType = .list
        self.collectionViewProductList.reloadData()
    }
}

extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.viewType {
        case .grid:
            
            let collectionCell: ProdListCollectionViewCell_Grid = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdListCollectionViewCell_Grid", for: indexPath) as! ProdListCollectionViewCell_Grid
            
            let prodModel = self.productList[indexPath.item]
            collectionCell.labelProdTitle.text = prodModel.product_Title
            
            //Add Button Target
            collectionCell.buttonAddToCart.tag = indexPath.item
            collectionCell.buttonAddToCart.addTarget(self, action: #selector(addToCartButtonTapped(sender:)), for: .touchUpInside)
            
            collectionCell.viewContent.addDropShadow()
            collectionCell.viewAddToCart.addBorder()
            return collectionCell
            
        case .list:
            
            let collectionCell: ProdListCollectionViewCell_List = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdListCollectionViewCell_List", for: indexPath) as! ProdListCollectionViewCell_List
            
            let prodModel = self.productList[indexPath.item]
            collectionCell.labelProdTitle.text = prodModel.product_Title
            
            //Add Button Target
            collectionCell.buttonAddToCart.tag = indexPath.item
            collectionCell.buttonAddToCart.addTarget(self, action: #selector(addToCartButtonTapped(sender:)), for: .touchUpInside)
            
            collectionCell.viewContent.addDropShadow()
            collectionCell.viewAddToCart.addBorder()
            return collectionCell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch self.viewType {
        case .grid:
            let itemSize = CGSize.init(width: collectionView.frame.size.width/2 - 5, height: 200)
            return itemSize
            
        case .list:
            let itemSize = CGSize.init(width: collectionView.frame.size.width - 10, height: 120)
            return itemSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ProductDetailsViewController", sender: nil)
    }
    
    @objc func addToCartButtonTapped(sender: UIButton) {
        
        let prodModel = self.productList[sender.tag]
        
        let currentItems = DBManager.sharedInstance.getShoppingCartItemsFromDB()
        if let existingItem = currentItems.filter(NSPredicate.init(format: "product_Id == %@", prodModel.product_Id)).first {
            try! DBManager.sharedInstance.database.write {
                existingItem.product_Quantity =  existingItem.product_Quantity + 1
            }
        } else {
            
            let shoppingCartItem = ShoppingCartItem()
            shoppingCartItem.product_Id = prodModel.product_Id
            shoppingCartItem.product_Name = prodModel.product_Title
            shoppingCartItem.product_Price = prodModel.product_Price
            shoppingCartItem.product_Quantity =  shoppingCartItem.product_Quantity + 1
            
            DBManager.sharedInstance.addShoppingCartItem(object: shoppingCartItem)
        }
        
        updateShoppingCartBadge(currentCtrl: self)
    }
}

extension ProductListViewController: DropDownMenuDelegate {
    
    func prepareNavigationBarMenuTitleView() -> String {
        titleView = DropDownTitleView()
        titleView.addTarget(self,
                            action: #selector(ProductListViewController.willToggleNavigationBarMenu(_:)),
                            for: .touchUpInside)
        titleView.addTarget(self,
                            action: #selector(ProductListViewController.didToggleNavigationBarMenu(_:)),
                            for: .valueChanged)
        titleView.titleLabel.textColor = UIColor.black
        
        navigationItem.titleView = titleView
        
        return titleView.title!
    }
    
    func prepareNavigationBarMenu(_ currentChoice: String) {
        navigationBarMenu = DropDownMenu(frame: view.bounds)
        navigationBarMenu.delegate = self
        
        let productsArray = ["Embroidered", "Outdoor", "Plain & Texture", "Printed", "Wooven"]
        
        for product in productsArray {
            let prodCell = DropDownMenuCell()
            prodCell.textLabel?.text = product
            prodCell.menuAction = #selector(ProductListViewController.choose(_:))
            prodCell.menuTarget = self
            prodCell.rowHeight = 57
            
            if currentChoice == product {
                prodCell.accessoryType = .checkmark
            }
            navigationBarMenu.menuCells.append(prodCell)
        }
        
        navigationBarMenu.selectMenuCell(navigationBarMenu.menuCells.first!)
        
        // For a simple gray overlay in background
        navigationBarMenu.backgroundView = UIView(frame: navigationBarMenu.bounds)
        navigationBarMenu.backgroundView!.backgroundColor = UIColor.black
        navigationBarMenu.backgroundAlpha = 0.7
    }
    
    func updateMenuContentInsets() {
        var visibleContentInsets: UIEdgeInsets
        
        if #available(iOS 11, *) {
            visibleContentInsets = view.safeAreaInsets
        } else {
            visibleContentInsets =
                UIEdgeInsets(top: navigationController!.navigationBar.frame.size.height + statusBarHeight(),
                             left: 0,
                             bottom: navigationController!.toolbar.frame.size.height,
                             right: 0)
        }
        
        navigationBarMenu.visibleContentInsets = visibleContentInsets
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            // If we put this only in -viewDidLayoutSubviews, menu animation is
            // messed up when selecting an item
            self.updateMenuContentInsets()
        }, completion: nil)
    }
    
    // MARK: - Updating UI
    
    func validateBarItems() {
        navigationItem.leftBarButtonItem?.isEnabled = titleView.isUp && !navigationBarMenu.menuCells.isEmpty
        navigationItem.rightBarButtonItem?.isEnabled = titleView.isUp
    }
    
    // MARK: - Actions
    @IBAction func choose(_ sender: AnyObject) {
        titleView.title = (sender as! DropDownMenuCell).textLabel!.text
        showToolbarMenu()
    }
    
    @IBAction func removeNavigationBarMenuCell() {
        navigationBarMenu.menuCells = Array(navigationBarMenu.menuCells.dropLast())
        validateBarItems()
    }
    
    @IBAction func addNavigationBarMenuCell() {
        let cell = DropDownMenuCell()
        
        cell.textLabel!.text = String(navigationBarMenu.menuCells.count)
        cell.menuAction = #selector(ProductListViewController.choose(_:))
        cell.menuTarget = self
        
        navigationBarMenu.menuCells += [cell]
        validateBarItems()
    }
    
    @IBAction func changeTitleIcons() {
        titleView.iconSize = CGSize(width: 24, height: 24)
        titleView.menuDownImageView.image = UIImage(named: "Ionicons-ios-checkmark-outline")
        titleView.menuDownImageView.transform = CGAffineTransform.identity
        titleView.menuDownImageView.tintColor = UIColor.green
        titleView.menuUpImageView.image = UIImage(named: "Ionicons-ios-search")
    }
    
    @IBAction func sort(_ sender: AnyObject) {
        print("Sent sort action")
    }
    
    @IBAction func showToolbarMenu() {
        if titleView.isUp {
            titleView.toggleMenu()
        }
    }
    
    @IBAction func willToggleNavigationBarMenu(_ sender: DropDownTitleView) {
        
        if sender.isUp {
            navigationBarMenu.hide()
        } else {
            navigationBarMenu.show()
        }
    }
    
    @IBAction func didToggleNavigationBarMenu(_ sender: DropDownTitleView) {
        print("Sent did toggle navigation bar menu action")
        validateBarItems()
    }
    
    func didTapInDropDownMenuBackground(_ menu: DropDownMenu) {
        if menu == navigationBarMenu {
            titleView.toggleMenu()
        } else {
            menu.hide()
        }
    }
}

func statusBarHeight() -> CGFloat {
    let statusBarSize = UIApplication.shared.statusBarFrame.size
    return min(statusBarSize.width, statusBarSize.height)
}

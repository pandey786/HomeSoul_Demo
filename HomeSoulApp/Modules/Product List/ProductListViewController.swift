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
    
    var productCategoryList = [ProductCategoryModel]()
    var productList = [ProductModel]()
    var selectedProduct: ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up Data Source
        self.productCategoryList = MockData().createMockData()
        self.loadProductList(prodCategory: self.productCategoryList.first!)
        
        let title = prepareNavigationBarMenuTitleView()
        self.prepareNavigationBarMenu(title)
        self.navigationBarMenu.container = self.view
        self.viewHeader.addDropShadow()
        
        //Register Collection Cells
        self.collectionViewProductList.register(UINib.init(nibName: "ProdListCollectionViewCell_Grid", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_Grid")
        self.collectionViewProductList.register(UINib.init(nibName: "ProdListCollectionViewCell_List", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_List")
        
        self.collectionViewProductList.emptyDataSetDelegate = self
        self.collectionViewProductList.emptyDataSetSource = self
    }
    
    private func loadProductList(prodCategory: ProductCategoryModel) {
        self.productList = prodCategory.category_Catalog
        self.collectionViewProductList.reloadData()
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
            collectionCell.setUpData(prodModel: prodModel)
            
            //Add Button Target
            collectionCell.buttonAddToCart.tag = indexPath.item
            collectionCell.buttonAddToCart.addTarget(self, action: #selector(addToCartButtonTapped(sender:)), for: .touchUpInside)
            
            collectionCell.viewContent.addDropShadow()
            collectionCell.viewAddToCart.addBorder()
            return collectionCell
            
        case .list:
            
            let collectionCell: ProdListCollectionViewCell_List = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdListCollectionViewCell_List", for: indexPath) as! ProdListCollectionViewCell_List
            
            let prodModel = self.productList[indexPath.item]
            collectionCell.setUpData(prodModel: prodModel)
            
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
            let itemSize = CGSize.init(width: collectionView.frame.size.width/2 - 5, height: 240)
            return itemSize
            
        case .list:
            let itemSize = CGSize.init(width: collectionView.frame.size.width - 10, height: 120)
            return itemSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedProduct = self.productList[indexPath.item]
        self.performSegue(withIdentifier: "ProductDetailsViewController", sender: nil)
    }
    
    @objc func addToCartButtonTapped(sender: UIButton) {
        
        let prodModel = self.productList[sender.tag]
        AppInstances.appDelegate.addProductToCart(prodModel: prodModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProductDetailsViewController" {
            let prodDetail: ProductDetailsViewController = segue.destination as! ProductDetailsViewController
            prodDetail.selectedProduct = selectedProduct
        }
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
        
        for product in self.productCategoryList {
            let prodCell = DropDownMenuCell()
            prodCell.textLabel?.text = product.category_Design
            prodCell.menuAction = #selector(ProductListViewController.choose(_:))
            prodCell.menuTarget = self
            prodCell.rowHeight = 44
            
            if currentChoice == product.category_Design {
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
        
        //get Product Category
        if let selectedProdCategory: ProductCategoryModel = self.productCategoryList.filter({ (prodCatModel) -> Bool in
            return prodCatModel.category_Design == titleView.title
        }).first {
            self.loadProductList(prodCategory: selectedProdCategory)
        }
        
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

// MARK: - Empty State
// MARK: -
extension ProductListViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
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


//
//  ProductDetailsViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 15/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var constraintDetailsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewProductDetails: UIScrollView!
    @IBOutlet weak var constraintPeopleAlsoViewedHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintSimilarProductsHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewSimilarPoductsArrow: UIImageView!
    @IBOutlet weak var imageViewPeopleAlsoViewedArrow: UIImageView!
    @IBOutlet weak var viewOtherTextureList: UIView!
    
    @IBOutlet weak var collectionViewProductImages: UICollectionView!
    @IBOutlet weak var collectionViewTextures: UICollectionView!
    @IBOutlet weak var collectionViewAvailableDesigns: UICollectionView!
    
    @IBOutlet weak var viewProductRatings: UIView!
    @IBOutlet weak var buttonShowHideDetails: UIButton!
    
    //Similar Products
    @IBOutlet weak var constraintViewAllSimilarprodheight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewSimilarProducts: UICollectionView!
    
    var arraySimilarProducts = [String]()
    
    //People Also Viewed
    @IBOutlet weak var constraintViewAllAlsoViewedheight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewPeopleAlsoViewed: UICollectionView!
    
    var arrayPeopleAlsoViewed = [String]()
    
    var peopleAlsoViewedHeight = 300.0
    var similarProductsHeight = 300.0
    
    var isSimilarProductsExpanded = false
    var isPeopleAlsoViewedExpanded = false
    var isDetailsExpanded = false
    
    var arrayProductImages = [String]()
    var arrayTextures = [String]()
    var arrayAvailableDesigns = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewProductRatings.addDropShadowToView()
        self.viewOtherTextureList.addShadow(location: .top, color: UIColor.darkGray, opacity: 0.4, radius: 30.0)
        
        //Mock Array
        for i in 0...15 {
            arrayProductImages.append(String(i))
            arrayTextures.append(String(i))
            arrayAvailableDesigns.append(String(i))
            arraySimilarProducts.append(String(i))
            arrayPeopleAlsoViewed.append(String(i))
        }
        
        //Set Up Views
        self.setUpSimilarProductsView()
        self.setUpPeopleAlsoViewedView()
        
        //Register Collection Cells
        self.collectionViewSimilarProducts.register(UINib.init(nibName: "ProdListCollectionViewCell_Grid", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_Grid")
        self.collectionViewPeopleAlsoViewed.register(UINib.init(nibName: "ProdListCollectionViewCell_Grid", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_Grid")
        
        //Collapse All Sections Initially
        self.animateSimilarProductsView(shouldExpand: false)
        self.animatePeopleAlsoViewedView(shouldExpand: false)
    }
    
    func setUpSimilarProductsView() {
       
        //Set Height
        self.similarProductsHeight = Double((self.arraySimilarProducts.count/2) * 230 > 470 ? 470: (self.arraySimilarProducts.count/2) * 230)
        
        //Show View All Button
        if self.arraySimilarProducts.count > 4 {
            self.constraintViewAllSimilarprodheight.constant = 50.0
        } else {
            self.constraintViewAllSimilarprodheight.constant = 0.0
        }
    }
    
    func setUpPeopleAlsoViewedView() {
        
        //Set Height
        self.peopleAlsoViewedHeight = Double((self.arrayPeopleAlsoViewed.count/2) * 230 > 470 ? 470: (self.arrayPeopleAlsoViewed.count/2) * 230)
        
        //Show View All Button
        if self.arrayPeopleAlsoViewed.count > 4 {
            self.constraintViewAllAlsoViewedheight.constant = 50.0
        } else {
            self.constraintViewAllAlsoViewedheight.constant = 0.0
        }
    }
    
    // MARK: - Actions
    // MARK: -
    @IBAction func buttonSimilarProductsTapped(_ sender: Any) {
        self.isSimilarProductsExpanded = !self.isSimilarProductsExpanded
        self.animateSimilarProductsView(shouldExpand: self.isSimilarProductsExpanded)
    }
    
    @IBAction func buttonPeopleAlsoViewedTapped(_ sender: Any) {
        self.isPeopleAlsoViewedExpanded = !self.isPeopleAlsoViewedExpanded
        self.animatePeopleAlsoViewedView(shouldExpand: self.isPeopleAlsoViewedExpanded)
    }
    
    @IBAction func buttonShowHideDetailsTapped(_ sender: Any) {
        
        self.isDetailsExpanded = !self.isDetailsExpanded
        let detailViewHeight = self.isDetailsExpanded ? 100.0: 0.0
        let buttonText = self.isDetailsExpanded ? "Hide details": "View more details"
        
        self.buttonShowHideDetails.setTitle(buttonText, for: .normal)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.constraintDetailsViewHeight.constant = CGFloat(detailViewHeight)
            self.view.layoutIfNeeded()
        }) { (success) in
        }
    }
    
    func animateSimilarProductsView(shouldExpand: Bool) {
        let viewHeight = shouldExpand ? self.similarProductsHeight: 0.0
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.constraintSimilarProductsHeight.constant = CGFloat(viewHeight)
            self.imageViewSimilarPoductsArrow.image = shouldExpand ? UIImage.init(named: "collapseArrow"): UIImage.init(named: "expandArrow")
            self.view.layoutIfNeeded()
        }) { (success) in
            
            let bottomOffset = CGPoint(x: 0, y: self.scrollViewProductDetails.contentSize.height - self.scrollViewProductDetails.bounds.size.height)
            self.scrollViewProductDetails.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    func animatePeopleAlsoViewedView(shouldExpand: Bool) {
        let viewHeight = shouldExpand ? self.peopleAlsoViewedHeight: 0.0
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.constraintPeopleAlsoViewedHeight.constant = CGFloat(viewHeight)
            self.imageViewPeopleAlsoViewedArrow.image = shouldExpand ? UIImage.init(named: "collapseArrow"): UIImage.init(named: "expandArrow")
            self.view.layoutIfNeeded()
        }) { (success) in
            
            let bottomOffset = CGPoint(x: 0, y: self.scrollViewProductDetails.contentSize.height - self.scrollViewProductDetails.bounds.size.height)
            self.scrollViewProductDetails.setContentOffset(bottomOffset, animated: true)
        }
    }
}

// MARK: - Collection View
// MARK: -
extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case 111:
            return self.arrayProductImages.count
        case 222:
            return self.arrayTextures.count
        case 333:
            return self.arrayAvailableDesigns.count
        case 444:
            return self.arraySimilarProducts.count
        case 555:
            return self.arrayPeopleAlsoViewed.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 111:
            let prodImageCell: ProdImagesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdImagesCollectionViewCell", for: indexPath) as! ProdImagesCollectionViewCell
            return prodImageCell
        case 222:
            let textureCell: TextureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextureCollectionViewCell", for: indexPath) as! TextureCollectionViewCell
            return textureCell
        case 333:
            let availableDesignsCell: AvailableDesignsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvailableDesignsCollectionViewCell", for: indexPath) as! AvailableDesignsCollectionViewCell
            return availableDesignsCell
        case 444:
            let collectionCell: ProdListCollectionViewCell_Grid = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdListCollectionViewCell_Grid", for: indexPath) as! ProdListCollectionViewCell_Grid
            return collectionCell
        case 555:
            let collectionCell: ProdListCollectionViewCell_Grid = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdListCollectionViewCell_Grid", for: indexPath) as! ProdListCollectionViewCell_Grid
            return collectionCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag {
        case 111:
            let prodImageCellSize = CGSize.init(width: 60, height: collectionView.frame.size.height - 10)
            return prodImageCellSize
        case 222:
            let prodImageCellSize = CGSize.init(width: 40, height: collectionView.frame.size.height - 10)
            return prodImageCellSize
        case 333:
            let prodImageCellSize = CGSize.init(width: 80, height: collectionView.frame.size.height - 10)
            return prodImageCellSize
        case 444:
            let itemSize = CGSize.init(width: collectionView.frame.size.width/2 - 15, height: 200)
            return itemSize
        case 555:
            let itemSize = CGSize.init(width: collectionView.frame.size.width/2 - 15, height: 200)
            return itemSize
        default:
            return CGSize.zero
        }
    }
}


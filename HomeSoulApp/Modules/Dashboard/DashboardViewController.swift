//
//  DashboardViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 12/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit
import AACarousel
import Kingfisher
import AVKit
import WebKit

public enum ProductCategory: String {
    case collections
    case curtains
    case bedLinen
    case wallpaper
    case rmc
    case cushions
    case rugs
}

public enum ViewType {
    case grid
    case list
}

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var scrollViewMain: UIScrollView!
    @IBOutlet weak var imageCarouselView: AACarousel!
    @IBOutlet weak var constraintImageCarouselViewHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintCatelogViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewProductList: UICollectionView!
    @IBOutlet weak var viewVideoPlayer: UIView!
    var selectedProductCategory: ProductCategory?
    
    //product List
    var viewType: ViewType = .grid
    var productList = ["WOOVEN", "PRINTED", "EMBROIDERED", "OUTDOOR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavigationView()
        updateShoppingCartBadge(currentCtrl: self)
        
        //Set Top View height
        self.constraintImageCarouselViewHeight.constant = self.view.bounds.size.height - 64.0 - 50.0
        self.constraintCatelogViewHeight.constant = CGFloat((self.productList.count/2) * 200 + 100)
        
        //Set Up Carousel
        let pathArray = ["http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                         "https://ak.picdn.net/assets/cms/97e1dd3f8a3ecb81356fe754a1a113f31b6dbfd4-stock-photo-photo-of-a-common-kingfisher-alcedo-atthis-adult-male-perched-on-a-lichen-covered-branch-107647640.jpg",
                         "https://imgct2.aeplcdn.com/img/800x600/car-data/big/honda-amaze-image-12749.png",
                         "http://www.conversion-uplift.co.uk/wp-content/uploads/2016/09/Lamborghini-Huracan-Image-672x372.jpg"]
        self.setUpCarouselViewWithImagesArray(imageStrArray: pathArray)
        
        //Register Collection Cells
        self.collectionViewProductList.register(UINib.init(nibName: "DashBoardProductCell", bundle: nil), forCellWithReuseIdentifier: "DashBoardProductCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
         //Add Video Player
         let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
         let player = AVPlayer(url: videoURL!)
         let playerController = AVPlayerViewController()
         playerController.player = player
         self.addChildViewController(playerController)
         self.viewVideoPlayer.addSubview(playerController.view)
         playerController.view.frame = self.view.frame
         player.play() */
    }
    
    func setUpNavigationView() {
        let navImage = UIImage.init(named: "logo_small")
        let navImageView = UIImageView.init(image: navImage)
        navImageView.contentMode = .scaleAspectFit
        navImageView.frame = CGRect.init(origin: .zero, size: CGSize.init(width: 105, height: 40))
        self.navigationItem.titleView = navImageView
    }
    
    // MARK: - Actions
    // MARK: -
    @IBAction func buttonStartExploringTapped(_ sender: Any) {
        let bottomOffset = CGPoint(x: 0, y: scrollViewMain.contentSize.height - scrollViewMain.bounds.size.height)
        scrollViewMain.setContentOffset(bottomOffset, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProductListViewController" {
            let prodListCtrl: ProductListViewController = segue.destination as! ProductListViewController
            prodListCtrl.productCategory = self.selectedProductCategory
        }
    }
}

// MARK: - AACarousel
// MARK: -
extension DashboardViewController: AACarouselDelegate {
    
    func setUpCarouselViewWithImagesArray(imageStrArray: [String]) {
        
        self.imageCarouselView.delegate = self
        self.imageCarouselView.setCarouselData(paths: imageStrArray,  describedTitle: [], isAutoScroll: true, timer: 5.0, defaultImage: "image_Placeholder")
        self.imageCarouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: UIColor.clear, layerColor: UIColor.clear)
        
    }
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "image_Placeholder"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    func downloadImages(_ url: String, _ index: Int) {
        
        //here is download images area
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "image_Placeholder"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            
            if let imageDownloaded = downloadImage {
                self.imageCarouselView.images[index] = imageDownloaded
            }
        })
    }
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        
    }
}

// MARK: - Product List Collection View
// MARK: -
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell: DashBoardProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashBoardProductCell", for: indexPath) as! DashBoardProductCell
        collectionCell.labelTitle.text = self.productList[indexPath.row]
        collectionCell.imageView.image = UIImage.init(named: self.productList[indexPath.row])
        collectionCell.viewContent.addDropShadow()
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = CGSize.init(width: collectionView.frame.size.width/2 - 5, height: 200)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Navigate To Product Details page
        self.performSegue(withIdentifier: "ProductListViewController", sender: nil)
    }
}

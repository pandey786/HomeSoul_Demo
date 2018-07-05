//
//  ProductDetailsViewController.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 15/04/18.
//  Copyright © 2018 HomeSoul. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelProductTitle: UILabel!
    @IBOutlet weak var labelProductCode: UILabel!
    @IBOutlet weak var labelAvailability: UILabel!
    @IBOutlet weak var labelProdcutPrice: UILabel!
    @IBOutlet weak var textFieldProductQuantity: UITextField!
    @IBOutlet weak var labelWidth: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelComposition: UILabel!
    @IBOutlet weak var labelTearStrength: UILabel!
    @IBOutlet weak var labelAbrasionResistance: UILabel!
    @IBOutlet weak var labelColorFastness: UILabel!
    @IBOutlet weak var labelPilingResistance: UILabel!
    @IBOutlet weak var labelEndUse: UILabel!
    
    var selectedProduct: ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail"
        
        //Add Shadow
        self.imageViewProduct.addDropShadow()
        
        //Set Up Data
        if let selectedProdModel = selectedProduct {
            self.setUpData(productModel: selectedProdModel)
        }
    }
    
    private func setUpData(productModel: ProductModel) {
        
        var productImage = UIImage.init(named: productModel.product_Image)
        if let prodImage =  productImage {
            productImage = scaleUIImageToSize(image: prodImage, size: self.imageViewProduct.frame.size)
        }
        
        self.imageViewProduct.image = productImage
        self.labelProductTitle.text = productModel.product_Title
        self.labelProductCode.text = productModel.product_Title
        self.labelAvailability.text = "In Stock"
        self.labelProdcutPrice.text = "Rs. \(productModel.product_Price)/meter"
        self.textFieldProductQuantity.text = "1"
        self.labelWidth.text = "--"
        self.labelWeight.text = "--"
        self.labelComposition.text = "--"
        self.labelTearStrength.text = "--"
        self.labelAbrasionResistance.text = "--"
        self.labelColorFastness.text = "--"
        self.labelPilingResistance.text = "--"
        self.labelEndUse.text = "--"
    }
    
    @IBAction func buttonAddToCartTapped(_ sender: Any) {
        
        if let selectedProductModel = self.selectedProduct {
            AppInstances.appDelegate.addProductToCart(prodModel: selectedProductModel)
        }
    }
}

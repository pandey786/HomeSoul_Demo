//
//  MockData.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 26/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

class MockData {
    
    public func createMockData() -> [ProductCategoryModel] {
        
        var prodCategoryList = [ProductCategoryModel]()
        
        //Messier
        var prodCatMESSIER = ProductCategoryModel()
        prodCatMESSIER.category_Id = ""
        prodCatMESSIER.category_Design = "MESSIER"
        prodCatMESSIER.width = ""
        prodCatMESSIER.category_Code = "HS101 - HS112"
        
        for i in 1...12 {
            var productModel = ProductModel()
            productModel.product_Title = "Messier \(i)"
            prodCatMESSIER.category_Catalog.append(productModel)
        }
        
        prodCategoryList.append(prodCatMESSIER)
        
        //MILKYWAY
        var prodCatMILKYWAY = ProductCategoryModel()
        prodCatMILKYWAY.category_Id = ""
        prodCatMILKYWAY.category_Design = "MILKYWAY"
        prodCatMILKYWAY.width = ""
        prodCatMILKYWAY.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatMILKYWAY)
        
        //LEO
        var prodCatLEO = ProductCategoryModel()
        prodCatLEO.category_Id = ""
        prodCatLEO.category_Design = "LEO"
        prodCatLEO.width = ""
        prodCatLEO.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatLEO)
        
        //COMET
        var prodCatCOMET = ProductCategoryModel()
        prodCatCOMET.category_Id = ""
        prodCatCOMET.category_Design = "COMET"
        prodCatCOMET.width = ""
        prodCatCOMET.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatCOMET)
        
        //CARTWHEEL
        var prodCatCARTWHEEL = ProductCategoryModel()
        prodCatCARTWHEEL.category_Id = ""
        prodCatCARTWHEEL.category_Design = "CARTWHEEL"
        prodCatCARTWHEEL.width = ""
        prodCatCARTWHEEL.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatCARTWHEEL)
        
        //TADPOLE
        var prodCatTADPOLE = ProductCategoryModel()
        prodCatTADPOLE.category_Id = ""
        prodCatTADPOLE.category_Design = "TADPOLE"
        prodCatTADPOLE.width = ""
        prodCatTADPOLE.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatTADPOLE)
        
        //COSMOS
        var prodCatCOSMOS = ProductCategoryModel()
        prodCatCOSMOS.category_Id = ""
        prodCatCOSMOS.category_Design = "COSMOS"
        prodCatCOSMOS.width = ""
        prodCatCOSMOS.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatCOSMOS)
        
        //CANIS
        var prodCatCANIS = ProductCategoryModel()
        prodCatCANIS.category_Id = ""
        prodCatCANIS.category_Design = "CANIS"
        prodCatCANIS.width = ""
        prodCatCANIS.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatCANIS)
        
        //MALIN
        var prodCatMALIN = ProductCategoryModel()
        prodCatMALIN.category_Id = ""
        prodCatMALIN.category_Design = "MALIN"
        prodCatMALIN.width = ""
        prodCatMALIN.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatMALIN)
        
        //STELLAR
        var prodCatSTELLAR = ProductCategoryModel()
        prodCatSTELLAR.category_Id = ""
        prodCatSTELLAR.category_Design = "STELLAR"
        prodCatSTELLAR.width = ""
        prodCatSTELLAR.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatSTELLAR)
        
        //PINWHEEL
        var prodCatPINWHEEL = ProductCategoryModel()
        prodCatPINWHEEL.category_Id = ""
        prodCatPINWHEEL.category_Design = "PINWHEEL"
        prodCatPINWHEEL.width = ""
        prodCatPINWHEEL.category_Code = "HS101 - HS112"
        prodCategoryList.append(prodCatPINWHEEL)
        
        return prodCategoryList
    }
}

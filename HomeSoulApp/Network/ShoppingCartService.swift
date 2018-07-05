//
//  ShoppingCartService.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 29/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ShoppingCartService {
    
    static func getProductsList(completionHandler: @escaping (_ shoppingCartModel: ShoppingCartModel?, _ isError: Bool, _ error: String?) -> ()) {
        
        AppSessionManager.getAPIToken { (isSucess, apiToken) in
            
            if isSucess, let api_Token = apiToken {
                
                let getProductsUrl = API.kGetProductsUrl + "&api_token=" + api_Token
                Alamofire.request(getProductsUrl, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil)
                    .responseString(completionHandler: { (responseStr) in
                        print(responseStr)
                    })
                    .responseObject(completionHandler: { (response: DataResponse<ShoppingCartModel>) in
                        switch response.result {
                        case .success(let data):
                            completionHandler(data, false, nil)
                        case .failure:
                            completionHandler(nil, true, response.error?.localizedDescription)
                        }
                    })
            }
        }
    }
    
    static func addProductsToCart(_ shoppingCartModel: ShoppingCartModel?, completionHandler: @escaping (_ isError: Bool, _ error: String?) -> ()) {
        
        AppSessionManager.getAPIToken { (isSucess, apiToken) in
            
            if isSucess, let api_Token = apiToken {
                
                let getProductsUrl = API.kAddProductsUrl + "&api_token=" + api_Token
                let parameters = ["product_id": String(100 + arc4random() % 40), "quantity": "1"]
                Alamofire.request(getProductsUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                    .responseString(completionHandler: { (responseStr) in
                        print(responseStr)
                    })
                    .responseObject(completionHandler: { (response: DataResponse<ShoppingCartModel>) in
                        switch response.result {
                        case .success(let _):
                            completionHandler(false, nil)
                        case .failure:
                            completionHandler(true, response.error?.localizedDescription)
                        }
                    })
            }
        }
    }
}

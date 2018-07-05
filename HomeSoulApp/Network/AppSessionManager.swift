//
//  AppSessionManager.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 29/06/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AppSessionManager {
    
    static func getAPIToken(completionHandler: @escaping (_ isSuccessFull: Bool, _ api_Token: String?) -> ()) {
        
        //Get Stored API Token
        if let api_Token = UserDefaults.standard.value(forKey: "api_token") as? String {
            completionHandler(true, api_Token)
        } else {
            
            //get API Token from Open Cart
            AppSessionManager.getAPITokenFromOpenCart { (isSuccess, apiToken) in
                
                //Set API Token to UserDefault
                UserDefaults.standard.set(apiToken, forKey: "api_token")
                completionHandler(isSuccess, apiToken)
            }
        }
    }
    
    static func refreshAPIToken(completionHandler: @escaping (_ isSuccessFull: Bool, _ api_Token: String?) -> ()) {
        
        //Set API Token to UserDefault
        UserDefaults.standard.set(nil, forKey: "api_token")
        UserDefaults.standard.synchronize()
        
        //Get New Token
        AppSessionManager.getAPIToken { (isSuccess, api_Token) in
            completionHandler(isSuccess, api_Token)
        }
    }
    
    static func getAPITokenFromOpenCart(completionHandler: @escaping (_ isSuccessFull: Bool, _ api_Token: String?) -> ()) {
        
        let appSessionUrl = API.kAppSessionUrl
        let appSessionParam = ["username": API.kOpenCartApiUserName, "key": API.kOpenCartApiKey]
        
        Alamofire.request(appSessionUrl, method: .post, parameters: appSessionParam, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                
                switch response.result {
                case .success(let data):
                    if let responseDict = data as? [String: String] {
                        let api_token = responseDict["api_token"]
                        completionHandler(true, api_token)
                    }
                case .failure:
                    completionHandler(false, nil)
                }
        }
    }
    
}

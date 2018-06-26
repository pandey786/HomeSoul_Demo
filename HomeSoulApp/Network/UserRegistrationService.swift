//
//  ITunesMusicAPIService.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 01/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class UserRegistrationService {
    
    static func sendOTP(_ mobileNumber: String, completionHandler: @escaping (_ isSuccessFull: Bool, _ error: String?) -> ()) {
        
        let sendOtpUrl = API.kSendSMSUrl + mobileNumber
        Alamofire.request(sendOtpUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString { (responseString) in
            
            if let responseString = responseString.result.value {
                if  responseString == ResponseString.kOTPSentSuccessFull {
                    completionHandler(true, nil)
                } else {
                    completionHandler(false, responseString)
                }
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    static func validateOTP(_ mobileNumber: String, otp: String, completionHandler: @escaping (_ isSuccessFull: Bool, _ error: String?) -> ()) {
        
        let verifyOtpUrl = API.kVerifySMSUrl + mobileNumber + "&otp=" + otp
        Alamofire.request(verifyOtpUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString { (responseString) in
            
            if let responseString = responseString.result.value {
                if  responseString == ResponseString.kOTPVerifiedSuccessFull {
                    completionHandler(true, nil)
                } else {
                    completionHandler(false, responseString)
                }
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    static func getTermsAndConditions(completionHandler: @escaping (_ htmlString: String?) -> ()) {
        
        let getTnCUrl = API.kGetTnCUrl
        Alamofire.request(getTnCUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString { (responseString) in
            completionHandler(responseString.result.value)
        }
    }
}

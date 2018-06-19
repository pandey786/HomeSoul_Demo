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
    
    /*
     static func fetchMusicList(_ searchText: String, completionHandler: @escaping (_ musicList: ItunesMusicResultModel?, _ isError: Bool, _ error: String?) -> ()) {
     
     let itunesSearchUrl = Endpoints.ITunesMusicSearch.fetch.url + searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
     
     Alamofire.request(itunesSearchUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
     .validate()
     .responseString(completionHandler: { (responseString) in
     print(responseString.value ?? "Could not get proper response")
     })
     .responseObject { (response: DataResponse<ItunesMusicResultModel>) in
     
     switch response.result {
     case .success(let musicList):
     
     //Response received successfully
     completionHandler(musicList, false, nil)
     break
     case .failure(let error):
     
     //There was an error
     completionHandler(nil, true, error.localizedDescription)
     break
     }
     }
     } */
}

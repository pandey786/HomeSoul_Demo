//
//  Endpoints.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 30/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

struct API {
    static let kSendSMSUrl = "http://homesoul.co.in/addons/txtlcl/sendsms.php?num="
    static let kVerifySMSUrl = "http://homesoul.co.in/addons/txtlcl/verifyMobile.php?num="
    static let kGetTnCUrl = "http://homesoul.co.in/index.php?route=information/information/agree&information_id=3"
    
    static let kAppSessionUrl = "http://homesoul.co.in/index.php?route=api/login"
    static let kOpenCartApiKey = "iZLaJqfhY6E0j5HEQSzlFcCEWKV6hEb1UfrqFp3mbnafT6PDyQwNdJL38DOhJyEw0KzIjnxjzYFdFJPwvGCFU5lj8igppiyGYP6hQZySTw4FmKmrH2IFlcDut6ZG8QCWM4r7CoXb4rFhtZObBwR7Qk32B0h3QaZaXafxUducEj20lC0QSS0HzdbQVicKrJBaszM0sy68BjdKQFzP1oUEWAYbRxlGCVE4b8iinQpbGfEmFnkfH1QUfTUfEfodm41F"
    static let kOpenCartApiUserName = "app_user"
    
    static let kGetProductsUrl = "http://homesoul.co.in/index.php?route=api/cart/products"
    static let kAddProductsUrl = "http://homesoul.co.in/index.php?route=api/cart/add"
}

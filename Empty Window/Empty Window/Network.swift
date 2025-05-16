//
//  Network.swift
//  Empty Window
//
//  Created by jerli on 2022/11/29.
//

import Foundation
import Alamofire


func performRequest() {
    AF.request("https://httpbin.org/get").response { response in
        print(response)
    }
}

//
//  NetworkTools.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/24.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    // swift3中，闭包默认是非逃逸的（@noescape），逃逸闭包需要用@escaping声明
    class func requestData(_ type: MethodType, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping (_ result: Any) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            finishedCallback(result)
        }
    }
    class func test() {
        
    }
}

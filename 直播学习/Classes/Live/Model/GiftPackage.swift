//
//  GiftPackage.swift
//  直播学习
//
//  Created by 焦英博 on 2017/10/4.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class GiftPackage: BaseModel {
    var t: Int = 0
    var title: String = ""
    var list: [GiftModel] = [GiftModel]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" {
            if let listArray = value as? [[String: Any]] {
                for listDict in listArray {
                    list.append(GiftModel(dict: listDict))
                }
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

//
//  GiftModel.swift
//  直播学习
//
//  Created by 焦英博 on 2017/10/4.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class GiftModel: BaseModel {
    var img2: String = "" //图片
    var coin: Int = 0 // 价格
    var subject: String = "" {
        didSet {
            if subject.contains("(有声)") {
                subject = subject.replacingOccurrences(of: "(有声)", with: "")
            }
        }
    }
}

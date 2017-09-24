//
//  WaterfallLayout.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/24.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

@objc protocol WaterfallLayoutDataSource: class {
    
}

class WaterfallLayout: UICollectionViewFlowLayout {
    // 公有属性
    weak var dataSource: WaterfallLayoutDataSource?
}

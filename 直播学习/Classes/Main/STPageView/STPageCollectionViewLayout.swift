//
//  STPageCollectionViewLayout.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/23.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class STPageCollectionViewLayout: UICollectionViewFlowLayout {
    var cols: Int = 4
    var rows: Int = 2
    
    fileprivate lazy var cellAttrs: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxWidth: CGFloat = 0
}

extension STPageCollectionViewLayout {
    
}

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
    override func prepare() {
        super.prepare()
        
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemH = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(rows - 1)) / CGFloat(rows)
        
        let sectionCount = collectionView!.numberOfSections
        
        var prePageCount: Int = 0
        for i in 0..<sectionCount {
            let itemCount = collectionView!.numberOfItems(inSection: i)
            
            for j in 0..<itemCount {
                let indexPath = IndexPath(item: j, section: i)
                
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                // 计算j第几页第几个
                let page = j / (cols * rows)
                let index = j % (cols * rows)
                
                // 设置frame
                let itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(index / cols)
                let itemX = CGFloat(prePageCount + page) * collectionView!.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(index % cols)
                attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                cellAttrs.append(attr)
            }
            
            prePageCount += (itemCount - 1) / (cols * rows) + 1
        }
        
        maxWidth = CGFloat(prePageCount) * collectionView!.bounds.width
    }
}
extension STPageCollectionViewLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
}


extension STPageCollectionViewLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxWidth, height: 0)
    }
}

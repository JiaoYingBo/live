//
//  WaterfallLayout.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/24.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

@objc protocol WaterfallLayoutDataSource: class {
    func waterfallLayout(_ layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat
    @objc optional func numberOfColsInWaterfallLayout(_ layout: WaterfallLayout) -> Int
}

class WaterfallLayout: UICollectionViewFlowLayout {
    // 公有属性
    weak var dataSource: WaterfallLayoutDataSource?
    
    // 私有属性
    fileprivate lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate var totalHeight: CGFloat = 0
    fileprivate lazy var colHeights: [CGFloat] = {
        // 这种懒加载只能初次使用时获取数量，外部数量改变后不会跟随改变？
        // ?? 是简单的三目运算
        let cols = self.dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        var colHeights = Array(repeating: self.sectionInset.top, count: cols)
        return colHeights
    }()
    fileprivate var maxH: CGFloat = 0
    fileprivate var startIndex = 0
}

extension WaterfallLayout {
    override func prepare() {
        super.prepare()
        
        // item的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        // 列数
        let cols = dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        
        // 计算Item的宽度
        let itemW = (collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) / CGFloat(cols)
        
        // 计算所有的item的属性
        for i in startIndex..<itemCount {
            
            let indexPath = IndexPath(item: i, section: 0)
            
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            guard let height = dataSource?.waterfallLayout(self, indexPath: indexPath) else {
                fatalError("请设置数据源,并且实现对应的数据源方法")
            }
            
            // 取出最小列的位置
            var minH = colHeights.min()!
            let index = colHeights.index(of: minH)!
            minH = minH + height + minimumLineSpacing
            colHeights[index] = minH
            
            // 设置item的属性
            attrs.frame = CGRect(x: self.sectionInset.left + (self.minimumInteritemSpacing + itemW) * CGFloat(index), y: minH - height - self.minimumLineSpacing, width: itemW, height: height)
            attrsArray.append(attrs)
        }
        
        // 记录最大值
        maxH = colHeights.max()!
        
        startIndex = itemCount
    }
}

extension WaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxH + sectionInset.bottom - minimumLineSpacing)
    }
}

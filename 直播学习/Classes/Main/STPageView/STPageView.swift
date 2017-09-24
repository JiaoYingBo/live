//
//  STPageView.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/23.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class STPageView: UIView {
    // 私有属性
    fileprivate var titles : [String]!
    fileprivate var style : STTitleStyle!
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    
    fileprivate var titleView : STTitleView!
    fileprivate var contentView : STContentView!
    
    init(frame: CGRect, titles: [String], style: STTitleStyle, childVcs: [UIViewController], parentVc: UIViewController) {
        assert(titles.count == childVcs.count, "标题和控制器数量不同!")
        
        self.style = style
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        parentVc.automaticallyAdjustsScrollViewInsets = false
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 设置UI
extension STPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = 44
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = STTitleView(frame: titleFrame, titles: titles, style : style)
        titleView.delegate = self
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = STContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}

extension STPageView: STTitleViewDelegate {
    func titleView(_ titleView: STTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}

extension STPageView: STContentViewDelegate {
    func contentView(_ contentView: STContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: STContentView) {
        titleView.contentViewDidEndScroll()
    }
}

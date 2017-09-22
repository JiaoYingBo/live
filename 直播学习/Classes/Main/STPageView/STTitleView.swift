//
//  STTitleView.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/21.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

protocol STTitleViewDelegate: class {
    func titleView(_ titleView: STTitleView, selectedIndex index: NSInteger)
}

class STTitleView: UIView {
    //MARK:public属性
    weak var delegate: STTitleViewDelegate?
    
    //MARK:private属性
    fileprivate var titles: [String]!
    fileprivate var style: STTitleStyle!
    fileprivate var currentIndex: NSInteger = 0

}

//
//  NibLoadable.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/28.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

protocol NibLoadable {
    //static func loadFromNib(_ nibname: String) -> Self
}

extension NibLoadable where Self : UIView {
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}

//
//  KingfisherExtension.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/25.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ URLString: String?, _ placeHolderName: String?) {
        guard let URLString = URLString else { return }
        guard let placeHolderName = placeHolderName else { return }
        guard let url = URL(string: URLString) else { return }
        
        kf.setImage(with: url, placeholder: UIImage(named: placeHolderName))
    }
}

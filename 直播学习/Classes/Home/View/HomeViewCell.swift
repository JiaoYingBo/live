//
//  HomeViewCell.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/25.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewCell: UICollectionViewCell {
    
    // MARK: 控件属性
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleLabel: UIButton!
    
    // MARK: 定义属性
    var anchorModel : AnchorModel? {
        didSet {
            albumImageView.setImage(anchorModel!.isEvenIndex ? anchorModel?.pic74 : anchorModel?.pic51, "home_pic_default")
            liveImageView.isHidden = anchorModel?.live == 0
            nickNameLabel.text = anchorModel?.name
            onlinePeopleLabel.setTitle("\(anchorModel?.focus ?? 0)", for: .normal)
        }
    }
}

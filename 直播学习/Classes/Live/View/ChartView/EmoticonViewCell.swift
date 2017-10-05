//
//  EmoticonViewCell.swift
//  直播学习
//
//  Created by 焦英博 on 2017/10/5.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    var emoticon : Emoticon? {
        didSet {
            iconImageView.image = UIImage(named: emoticon!.emoticonName)
        }
    }
}

//
//  ChatContentCell.swift
//  直播学习
//
//  Created by 焦英博 on 2017/10/5.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class ChatContentCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.textColor = UIColor.white
        selectionStyle = .none
        contentView.backgroundColor = UIColor.clear
    }
    
}

//
//  RoomToolView.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/29.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit
import SnapKit

class RoomToolView: UIView {
    
    fileprivate lazy var chartBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = 0
        btn.setImage(UIImage(named: "room_btn_chat"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var giftBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = 1
        btn.setImage(UIImage(named: "room_btn_gift"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var likeBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = 2
        btn.setImage(UIImage(named: "room_btn_qfstar"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RoomToolView {
    fileprivate func setupUI() {
        addSubview(chartBtn)
        chartBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
            make.width.equalToSuperview().multipliedBy(0.33)
        }
        
        addSubview(giftBtn)
        giftBtn.snp.makeConstraints { (make) in
            make.top.bottom.centerX.equalTo(self)
            make.width.equalTo(chartBtn)
        }
        
        addSubview(likeBtn)
        likeBtn.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(chartBtn)
        }
    }
}

extension RoomToolView {
    @objc func btnClick(btn: UIButton) {
        switch btn.tag {
        case 0:
            print("聊天")
        case 1:
            print("礼物")
        case 2:
            print("点赞")
        default:
            fatalError("未处理按钮")
        }
    }
}

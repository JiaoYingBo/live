//
//  RoomViewController.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/27.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class RoomViewController: BaseViewController {

    var anchor : AnchorModel?
    
    fileprivate lazy var closeBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: kScreenW-60, y: 20, width: 50, height: 50)
        btn.setImage(UIImage(named: "menu_btn_close"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(closeClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var toolView: RoomToolView = {
        let tool = RoomToolView(frame: CGRect(x: 0, y: kScreenH - 50, width: kScreenW, height: 50))
        return tool
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension RoomViewController {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.lightGray
        view.addSubview(closeBtn)
        view.addSubview(toolView)
    }
}

extension RoomViewController {
    @objc fileprivate func closeClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

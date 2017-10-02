//
//  RoomViewController.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/27.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class RoomViewController: BaseViewController, Emitterable {

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
//        tool.btnClickBlock = { [weak self](button: UIButton) ->() in
//            print("----->\(button.tag, self?.view, self)")
//            // 在这里无法调用协议里的方法
//        }
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
    
    deinit {
        print("RoomViewController deinit")
    }
}

extension RoomViewController {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.lightGray
        view.addSubview(closeBtn)
        view.addSubview(toolView)
        
        // 官方推荐使用[weak self]的方式去弱引用，需要注意解包
        toolView.btnClickBlock = { [weak self](button: UIButton) -> () in
            switch button.tag {
            case 0:
                print("聊天")
            case 1:
                print("礼物")
            case 2:
                button.isSelected = !button.isSelected
                let point = CGPoint(x: button.center.x, y: self!.view.bounds.height - button.bounds.height * 0.5)
                button.isSelected ? self?.startEmittering(point) : self?.stopEmittering()
            default:
                fatalError("未处理按钮")
            }
        }
    }
}

extension RoomViewController {
    @objc fileprivate func closeClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

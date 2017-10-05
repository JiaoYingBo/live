//
//  RoomViewController.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/27.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

private let kChatToolsViewHeight : CGFloat = 44
private let kChatContentViewHeight : CGFloat = 200
private let kGiftlistViewHeight : CGFloat = kScreenH * 0.5

class RoomViewController: BaseViewController, Emitterable {

    // MARK: 公有属性
    var anchor : AnchorModel?
    
    // MARK: 私有属性
    fileprivate lazy var closeBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: kScreenW-60, y: 20, width: 50, height: 50)
        btn.setImage(UIImage(named: "menu_btn_close"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(closeClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var toolView: RoomToolView = {
        let tool = RoomToolView(frame: CGRect(x: 0, y: kScreenH - 50, width: kScreenW, height: 50))
        //tool.btnClickBlock = { [weak self](button: UIButton) ->() in
        //    print("----->\(button.tag, self?.view, self)")
        //    // 在这里无法调用协议里的方法
        //}
        return tool
    }()
    
    fileprivate lazy var bgImageView: UIImageView = {
        let img = UIImageView(frame: self.view.bounds)
        
        return img
    }()
    fileprivate lazy var giftListView: GiftListView = GiftListView.loadFromNib()
    
    // MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupToolViewBlock()
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
        view.addSubview(bgImageView)
        view.addSubview(closeBtn)
        view.addSubview(toolView)
        
        setupBlurView()
        setupBottomView()
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    fileprivate func setupBottomView() {
        giftListView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftlistViewHeight)
        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(giftListView)
        giftListView.delegate = self
    }
}

// MARK: 监听用户输入的内容
extension RoomViewController: GiftListViewDelegate {
    
    func giftListView(giftView: GiftListView, giftModel: GiftModel) {
        
    }
}

// MARK: 事件监听
extension RoomViewController {
    @objc fileprivate func closeClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.25, animations: {
            self.giftListView.frame.origin.y = kScreenH
        })
    }
    
    fileprivate func setupToolViewBlock() {
        // 官方推荐使用[weak self]的方式去弱引用，需要注意解包
//        toolView.btnClickBlock = { [weak self](button: UIButton) -> () in
//            switch button.tag {
//            case 0:
//                print("聊天")
//            case 1:
//                UIView.animate(withDuration: 0.25, animations: {
//                    self?.giftListView.frame.origin.y = kScreenH - kGiftlistViewHeight
//                })
//            case 2:
//                button.isSelected = !button.isSelected
//                let point = CGPoint(x: button.center.x, y: self!.view.bounds.height - button.bounds.height * 0.5)
//                button.isSelected ? self?.startEmittering(point) : self?.stopEmittering()
//            default:
//                fatalError("未处理按钮")
//            }
//        }
    }
}

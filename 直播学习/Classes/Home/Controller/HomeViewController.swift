//
//  HomeViewController.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/21.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension HomeViewController {
    fileprivate func setupUI() {
        setupNavigationBar()
        
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    fileprivate func setupContentView() {
        let homeTypes = loadTypesData()
        
        let style = STTitleStyle()
        style.isShowCover = true
        style.isScrollEnable = true
        let pageFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kScreenH - kNavigationBarH - kStatusBarH - 44)
        /*
        var titles = [String]()
        for type in homeTypes {
            titles.append(type.title)
        }
        */
        /*
        let titles = homeTypes.map { (type: HomeType) -> String in
            return type.title
        }
        */
        let titles = homeTypes.map({$0.title})
        var childVcs = [AnchorViewController]()
        for type in homeTypes {
            let anchorVc = AnchorViewController()
            anchorVc.homeType = type
            childVcs.append(anchorVc)
        }
        
        let pageView = STPageView(frame: pageFrame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }
    
    // 这里也是各种不提示，日了狗了!
    fileprivate func loadTypesData() -> [HomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String: Any]]
        var tempArray = [HomeType]()
        for dict in dataArray {
            tempArray.append(HomeType(dict: dict))
        }
        return tempArray
    }
}

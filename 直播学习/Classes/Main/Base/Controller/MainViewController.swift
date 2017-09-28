//
//  MainViewController.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/21.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(vcName: "HomeViewController", title: "直播", imageName: "live")
        addChildVC(vcName: "RankViewController", title: "排行", imageName: "ranking")
        addChildVC(vcName: "DiscoverViewController", title: "发现", imageName: "found")
        addChildVC(vcName: "MineViewController", title: "我的", imageName: "mine")
    }

    fileprivate func addChildVC(vcName: String, title:String, imageName:String) {
        // 动态获取命名空间，参考http://www.jianshu.com/p/f2503afff164
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 拼接类名的完整格式,即namespace.类名,vcName即控制器的类名
        let clsName = namespace + "." + vcName
        // 将字符串转换为类
        let cls: AnyClass? = NSClassFromString(clsName)
        // 将AnyClass转为指定的类型
        let vcCls = cls as! UIViewController.Type
        
        // 通过class创建对象
        let vc = vcCls.init()
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let nav = BaseNavigationController(rootViewController: vc)
        
        addChildViewController(nav)
    }

}

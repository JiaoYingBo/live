//
//  HomeViewModel.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/24.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class HomeViewModel {
    lazy var anchorModels = [AnchorModel]()
}

extension HomeViewModel {
    func loadHomeData(type: HomeType, index: Int, finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "", parameters: ["type": type.type, "index": index, "size": 48]) { (result) in
            guard let resultDict = result as? [String: Any] else { return }
            guard let messageDict = resultDict["message"] as? [String: Any] else { return }
            guard let dataArray = messageDict["anchors"] as? [[String: Any]] else { return }
            
            for (index, dict) in dataArray.enumerated() {
                let anchor = AnchorModel(dict: dict)
                anchor.isEvenIndex = index % 2 == 0
                self.anchorModels.append(anchor)
            }
            
            finishedCallback()
        }
    }
}

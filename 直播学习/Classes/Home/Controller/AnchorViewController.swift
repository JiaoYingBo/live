//
//  AnchorViewController.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/24.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

private let kEdgeMargin: CGFloat = 8
private let kAnchorCellID = "kAnchorCellID"

class AnchorViewController: UIViewController {

    var homeType: HomeType!
    
    // 私有属性
    fileprivate lazy var homeVM: HomeViewModel = HomeViewModel()
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = WaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: kEdgeMargin, left: kEdgeMargin, bottom: kEdgeMargin, right: kEdgeMargin)
        layout.minimumLineSpacing = kEdgeMargin
        layout.minimumInteritemSpacing = kEdgeMargin
        layout.dataSource = self
        
        // 下面各种不提示，玩蛋？
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: kAnchorCellID)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(index: 0)
    }
}

//MARK: 设置UI
extension AnchorViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

//MARK: 网络请求
extension AnchorViewController {
    fileprivate func loadData(index: Int) {
        homeVM.loadHomeData(type: homeType, index: index) { 
            self.collectionView.reloadData()
        }
    }
}

extension AnchorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.anchorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAnchorCellID, for: indexPath) as! HomeViewCell
        
        cell.anchorModel = homeVM.anchorModels[indexPath.item]
        
        if indexPath.item == homeVM.anchorModels.count - 1 {
            loadData(index: homeVM.anchorModels.count)
        }
        
        return cell
    }
}

extension AnchorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = RoomViewController()
        roomVc.anchor = homeVM.anchorModels[indexPath.item]
        navigationController?.pushViewController(roomVc, animated: true)
    }
}

extension AnchorViewController: WaterfallLayoutDataSource {
    func waterfallLayout(_ layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat {
        return indexPath.item % 2 == 0 ? kScreenW * 2 / 3 : kScreenW * 0.5
    }
}

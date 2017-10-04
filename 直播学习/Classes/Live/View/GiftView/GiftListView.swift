//
//  GiftListView.swift
//  直播学习
//
//  Created by 焦英博 on 2017/10/4.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

private let kGiftCellID = "kGiftCellID"

protocol GiftListViewDelegate : class {
    func giftListView(giftView : GiftListView, giftModel : GiftModel)
}

class GiftListView: UIView, NibLoadable {

    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!

    fileprivate var pageCollectionView : STPageCollectionView!
    fileprivate var currentIndexPath : IndexPath?
    fileprivate var giftVM : GiftViewModel = GiftViewModel()
    
    weak var delegate : GiftListViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupGiftView()
        loadGiftData()
    }
}

extension GiftListView {
    fileprivate func setupUI() {
        setupGiftView()
    }
    
    //MARK: 一个问题是xib拖的view在初始化时是跟xib一样大小的，导致内部控件不能跟随变化，如下面的pageCollectionView
    fileprivate func setupGiftView() {
        let style = STTitleStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        
        let layout = STPageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.cols = 4
        layout.rows = 2
        
        let pageViewFrame = giftView.bounds
        pageCollectionView = STPageCollectionView(frame: pageViewFrame, titles: ["热门", "高级", "豪华", "专属"], style: style, isTitleInTop: true, layout : layout)
        pageCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        giftView.addSubview(pageCollectionView)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        
        pageCollectionView.register(nib: UINib(nibName: "GiftViewCell", bundle: nil), identifier: kGiftCellID)
    }
}

// MARK: 加载数据
extension GiftListView {
    fileprivate func loadGiftData() {
        giftVM.loadGiftData {
            self.pageCollectionView.reloadData()
        }
    }
}

// MARK: 数据设置
extension GiftListView : STPageCollectionViewDataSource, STPageCollectionViewDelegate {
    
    func numberOfSections(in pageCollectionView: STPageCollectionView) -> Int {
        return giftVM.giftlistData.count
    }
    
    func pageCollectionView(_ collectionView: STPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = giftVM.giftlistData[section]
        return package.list.count
    }
    
    func pageCollectionView(_ pageCollectionView: STPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGiftCellID, for: indexPath) as! GiftViewCell
        
        let package = giftVM.giftlistData[indexPath.section]
        cell.giftModel = package.list[indexPath.item]
        
        return cell
    }
    
    func pageCollectionView(_ pageCollectionView: STPageCollectionView, didSelectedItemAt indexPath: IndexPath) {
        sendGiftBtn.isEnabled = true
        currentIndexPath = indexPath
    }
}

extension GiftListView {
    @IBAction func sendGiftBtnClick(_ sender: UIButton) {
        print("send gift")
    }

}

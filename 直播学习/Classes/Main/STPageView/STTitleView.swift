//
//  STTitleView.swift
//  直播学习
//
//  Created by 焦英博 on 2017/9/21.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

protocol STTitleViewDelegate: class {
    func titleView(_ titleView: STTitleView, selectedIndex index: NSInteger)
}

class STTitleView: UIView {
    // 公有属性
    weak var delegate: STTitleViewDelegate?
    
    // 私有属性
    fileprivate var titles: [String]!
    fileprivate var style: STTitleStyle!
    fileprivate var currentIndex: NSInteger = 0

    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    
    // 私有UI控件
    fileprivate lazy var scrollView: UIScrollView = {
        let scl = UIScrollView()
        scl.frame = self.bounds
        scl.showsHorizontalScrollIndicator = false
        scl.scrollsToTop = false
        return scl
    }()
    // 底部分割线
    fileprivate lazy var splitLineView: UIView = {
        let split = UIView()
        split.backgroundColor = UIColor.lightGray
        let h: CGFloat = 0.5
        split.frame = CGRect(x: 0, y: self.frame.height-h, width: self.frame.width, height: h)
        return split
    }()
    // 底部选中线
    fileprivate lazy var bottomLine: UIView = {
        let bottom = UIView()
        bottom.backgroundColor = self.style.bottomLineColor
        return bottom
    }()
    // 遮罩
    fileprivate lazy var coverView: UIView = {
        let cover = UIView()
        cover.backgroundColor = self.style.coverBgColor
        cover.alpha = 0.7
        return cover
    }()
    
    // 颜色
    fileprivate lazy var normalColorRGB: (r: CGFloat, g: CGFloat, b:CGFloat) = self.getRGBWithColor(self.style.normalColor)
    fileprivate lazy var selectedColorRGB: (r: CGFloat, g: CGFloat, b:CGFloat) = self.getRGBWithColor(self.style.selectedColor)
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles: [String], style: STTitleStyle) {
        // 在父类初始化前必须先初始化子类的必选属性，并且初始化顺序是从子类到父类，跟OC相反
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 获取RGB的值
extension STTitleView {
    fileprivate func getRGBWithColor(_ color: UIColor) -> (CGFloat, CGFloat, CGFloat) {
        guard let components = color.cgColor.components else { fatalError("请使用RGB的方式给Title赋值颜色") }
        return (components[0]*255, components[1]*255, components[2]*255)
    }
}

// MARK: 设置UI界面
extension STTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        addSubview(splitLineView)
        setupTitleLables()
        setupTitleLabelsPosition()
        
        // 底部滚动条
        if style.isShowBottomLine {
            setupBottomLine()
        }
        // 遮罩
        if style.isShowCover {
            setupCoverView()
        }
    }
    
    fileprivate func setupTitleLables() {
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.tag = index
            label.text = title
            label.textColor = index==0 ? style.selectedColor : style.normalColor
            label.font = style.font
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_ :)))
            label.addGestureRecognizer(tap)
            
            scrollView.addSubview(label)
            
            titleLabels.append(label)
        }
    }
    
    fileprivate func setupTitleLabelsPosition() {
        var titleX: CGFloat = 0
        let titleY: CGFloat = 0
        var titleW: CGFloat = 0
        let titleH: CGFloat = frame.height
        
        let count = titles.count
        
        for (index, label) in titleLabels.enumerated() {
            if style.isScrollEnable {
                // 不提示的地方先在外边写好再copy进去
                let rect = (label.text! as NSString).boundingRect(with: CGSize(width:CGFloat(MAXFLOAT), height:0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: style.font], context: nil)
                titleW = rect.width
                if index == 0 {
                    titleX = style.titleMargin * 0.5
                } else {
                    let preLabel = titleLabels[index - 1]
                    titleX = preLabel.frame.maxX + style.titleMargin
                }
            } else {
                titleW = frame.width / CGFloat(count)
                titleX = titleW * CGFloat(index)
            }
            
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            
            // 放大
            if index == 0 {
                let scale = style.isNeedScale ? style.scaleRange : 1.0
                label.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        if style.isScrollEnable {
            scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX+style.titleMargin*0.5, height: 0)
        }
    }
    
    fileprivate func setupBottomLine() {
        scrollView.addSubview(bottomLine)
        bottomLine.frame = titleLabels.first!.frame
        bottomLine.frame.size.height = style.bottomLineH
        bottomLine.frame.origin.y = bounds.height - style.bottomLineH
    }
    
    fileprivate func setupCoverView() {
        scrollView.insertSubview(coverView, at: 0)
        let firstLabel = titleLabels[0]
        var coverW = firstLabel.frame.width
        let coverH = style.coverH
        var coverX = firstLabel.frame.origin.x
        let coverY = (bounds.height - coverH) / 2.0
        
        if style.isScrollEnable {
            coverX = coverX - style.coverMargin
            coverW = coverW + style.coverMargin * 2
        }
        
        coverView.frame = CGRect(x: coverX, y: coverY, width: coverW, height: coverH)
        coverView.layer.cornerRadius = style.coverRadius
        coverView.layer.masksToBounds = true
    }
}

// MARK: 事件处理
extension STTitleView {
    @objc fileprivate func titleLabelClick(_ tap: UITapGestureRecognizer) {
        guard let currentLabel = tap.view as? UILabel else { return }
        if currentLabel.tag == currentIndex { return }
        
        let preLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = style.selectedColor
        preLabel.textColor = style.normalColor
        
        currentIndex = currentLabel.tag
        
        delegate?.titleView(self, selectedIndex: currentIndex)
        
        // 居中显示
        contentViewDidEndScroll()
        
        // 调整bottomLine
        if style.isShowBottomLine {
            UIView.animate(withDuration: 0.15, animations: { 
                self.bottomLine.frame.origin.x = currentLabel.frame.origin.x
                self.bottomLine.frame.size.width = currentLabel.frame.size.width
            })
        }
        
        // 调整比例
        if style.isNeedScale {
            preLabel.transform = CGAffineTransform.identity
            currentLabel.transform = CGAffineTransform(scaleX: style.scaleRange, y: style.scaleRange)
        }
        
        // 移动遮罩
        if style.isShowCover {
            let coverX = style.isScrollEnable ? (currentLabel.frame.origin.x - style.coverMargin) : currentLabel.frame.origin.x
            let coverW = style.isScrollEnable ? (currentLabel.frame.width + style.coverMargin * 2) : currentLabel.frame.width
            UIView.animate(withDuration: 0.15, animations: {
                self.coverView.frame.origin.x = coverX
                self.coverView.frame.size.width = coverW
            })
        }
    }
}

// MARK: 公有方法
extension STTitleView {
    // MARK: 进度滚动
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 颜色渐变
        // 取出变化的范围
        let colorDelta = (selectedColorRGB.0 - normalColorRGB.0, selectedColorRGB.1 - normalColorRGB.1, selectedColorRGB.2 - normalColorRGB.2)
        
        sourceLabel.textColor = UIColor(r: selectedColorRGB.0 - colorDelta.0 * progress, g: selectedColorRGB.1 - colorDelta.1 * progress, b: selectedColorRGB.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: normalColorRGB.0 + colorDelta.0 * progress, g: normalColorRGB.1 + colorDelta.1 * progress, b: normalColorRGB.2 + colorDelta.2 * progress)
                
        // 记录最新的index
        currentIndex = targetIndex
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveTotalW = targetLabel.frame.width - sourceLabel.frame.width
        
        // 计算滚动的范围差值
        if style.isShowBottomLine {
            bottomLine.frame.size.width = sourceLabel.frame.width + moveTotalW * progress
            bottomLine.frame.origin.x = sourceLabel.frame.origin.x + moveTotalX * progress
        }
        
        // 放大的比例
        if style.isNeedScale {
            let scaleDelta = (style.scaleRange - 1.0) * progress
            sourceLabel.transform = CGAffineTransform(scaleX: style.scaleRange - scaleDelta, y: style.scaleRange - scaleDelta)
            targetLabel.transform = CGAffineTransform(scaleX: 1.0 + scaleDelta, y: 1.0 + scaleDelta)
        }
        
        // 计算遮罩的滚动
        if style.isShowCover {
            coverView.frame.size.width = style.isScrollEnable ? (sourceLabel.frame.width + 2 * style.coverMargin + moveTotalW * progress) : (sourceLabel.frame.width + moveTotalW * progress)
            coverView.frame.origin.x = style.isScrollEnable ? (sourceLabel.frame.origin.x - style.coverMargin + moveTotalX * progress) : (sourceLabel.frame.origin.x + moveTotalX * progress)
        }
    }
    
    // MARK: 居中滚动
    func contentViewDidEndScroll() {
        guard style.isScrollEnable else { return }
        
        let targetLabel = titleLabels[currentIndex]
        
        // scrollview中间靠左的不滚动
        var offsetX = targetLabel.center.x - bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        
        // scrollview最多只能滚动maxOffset宽度
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offsetX > maxOffset {
            offsetX = maxOffset
        }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

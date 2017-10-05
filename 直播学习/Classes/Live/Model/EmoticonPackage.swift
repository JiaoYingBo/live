//
//  EmoticonPackage.swift
//  直播学习
//
//  Created by 焦英博 on 2017/10/5.
//  Copyright © 2017年 jyb. All rights reserved.
//

import UIKit

class EmoticonPackage {
    
    lazy var emoticons: [Emoticon] = [Emoticon]()
    
    init(plistName: String) {
        guard let path = Bundle.main.path(forResource: plistName, ofType: nil) else {
            return
        }
        
        guard let emotionArray = NSArray(contentsOfFile: path) as? [String] else {
            return
        }
        
        for str in emotionArray {
            emoticons.append(Emoticon(emoticonName: str))
        }
    }
}

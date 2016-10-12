//
//  MyLabelExtension.swift
//  FSZCItem
//
//  Created by 马耀 on 16/8/22.
//  Copyright © 2016年 Mrshan. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     文字两边对齐
     未考虑换行，未考虑设置颜色等其他东西
     
     - parameter text: 需要设置的文字
     */
    func attributedTextFullJustified(text:String){
        let rectStr = (text as NSString).substringToIndex(1) as NSString
        let rect = rectStr.boundingRectWithSize(CGSizeMake(self.frame.size.width,self.frame.size.height), options: [.UsesLineFragmentOrigin,.UsesFontLeading] , attributes: [NSFontAttributeName:self.font], context: nil)
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSKernAttributeName, value: ((self.frame.size.width / rect.size.width - CGFloat((text as NSString).length)) * rect.size.width)/(CGFloat((text as NSString).length) - 1), range: NSMakeRange(0, (text as NSString).length - 1))
        self.attributedText = attrString
    }

}
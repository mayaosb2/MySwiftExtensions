//
//  MyCharacterExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/16.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation
public extension Character {
    
    /// 根据int 得到字符
    ///
    /// :return UInt32 表示的字符
    public var ord: UInt32 {
        get {
            let desc = self.description
            return desc.unicodeScalars[desc.unicodeScalars.startIndex].value
        }
    }
    
    /// 将字符转换为字符串
    ///
    /// :return 字符串
    public var description: String {
        get {
            return String(self)
        }
    }
    
    /**
    如果字符是一个适合int整数，返回对应的整数。
    */
    public func toInt () -> Int? {
        return Int(String(self))
    }
}


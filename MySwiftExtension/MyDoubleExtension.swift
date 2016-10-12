//
//  MyDoubleExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/15.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation

public extension Double {
    
    /**
    绝对值
    
    - returns: 绝对值后的值
    */
    func abs () -> Double {
        return Foundation.fabs(self)
    }
    
    /**
    平方根
    
    - returns: 开平方后的数
    */
    func sqrt () -> Double {
        return Foundation.sqrt(self)
    }
    
    /**
    比自己小的最大蒸熟.
    
    - returns:  比自己小的最大蒸熟.
    */
    func bigSelf () -> Double {
        return Foundation.floor(self)
    }
    
    /**
    比自己小的最大整数
    
    - returns: 比自己小的最大整数
    */
    func smallSelf () -> Double {
        return Foundation.ceil(self)
    }
    
    /**
    与自己相近的最大整数
    
    - returns: 与自己相近的最大整数
    */
    func round () -> Double {
        return Foundation.round(self)
    }
    
    /**
    指定自己的范围.
    
    - parameter min: 最小
    - parameter max: 最大
    - returns: 范围内的值
    */
    func clamp (min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    
    
    /**
    随机数
    
    - parameter min:下届
    - parameter max:上届
    - returns: 随机数
    */
    static func random(min: Double = 0, max: Double) -> Double {
        let diff = max - min;
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min;
    }
    
    /**
    格式化输出
    
    - parameter format: 如何格式化
    
    - returns: 返回字符串
    */
    func analyzingString(format:String)->String{
        return String(format:"%\(format)",self)
    }
    
    /**
     返回默认两位小数的 DOUBLE 数据 ，字符串类型
     
     - returns: 拥有两位小数的DOUBLE 字符串
     */
    func analyzingStringFormatWithdefaultinfo()->String {
        return String(format:"%.2f",self)
    }
    
}

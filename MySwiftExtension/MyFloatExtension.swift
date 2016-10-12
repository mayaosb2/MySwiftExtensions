//
//  MyFloatExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/15.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation
public extension Float {
    
    /**
    绝对值
    
    - returns: 绝对值后的值
    */
    func abs () -> Float {
        return fabsf(self)
    }
    
    /**
    平方根
    
    - returns: 开平方后的数
    */
    func sqrt () -> Float {
        return sqrtf(self)
    }
    
    /**
    比自己小的最大蒸熟.
    
    - returns:  比自己小的最大蒸熟.
    */
    func bigSelf () -> Float {
        return floorf(self)
    }
    
    /**
    比自己小的最大整数
    
    - returns: 比自己小的最大整数
    */
    func smallSelf () -> Float {
        return ceilf(self)
    }
    
    /**
    与自己相近的最大整数
    
    - returns: 与自己相近的最大整数
    */
    func near () -> Float {
        return roundf(self)
    }
    
    /**
    指定自己的范围.
    
    - parameter min: 最小
    - parameter max: 最大
    - returns: 范围内的值
    */
    func clamp (min: Float, _ max: Float) -> Float {
        return Swift.max(min, Swift.min(max, self))
    }
    
    /**
    随机数
    
    - parameter min:下届
    - parameter max:上届
    - returns: 随机数
    */
    static func random(min: Float = 0, max: Float) -> Float {
        let diff = max - min;
        let rand = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min;
    }
    
}


//
//  MyNSNumberExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/22.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation

public extension NSNumber{
    
    var toInt : Int{
        return self.longValue
    }
    
    var toInt64 : Int64{
        return self.longLongValue
    }
    
    var toString : String {
        return self.stringValue
    }
    
    
}

//MARK:TimeInterval

public extension NSTimeInterval{
    
    var toDouble : Double{
        return Double(self)
    }
    var toInt64 : Int64{
        return Int64(self)
    }
    var toInt : Int{
        return Int(self)
    }
    

    public var second: NSTimeInterval {
        return self.seconds
    }
    
    public var seconds: NSTimeInterval {
        return self
    }
    
    public var minute: NSTimeInterval {
        return self.minutes
    }
    
    public var minutes: NSTimeInterval {
        let secondsInAMinute = 60 as NSTimeInterval
        return self * secondsInAMinute
    }
    
    public var day: NSTimeInterval {
        return self.days
    }
    
    public var days: NSTimeInterval {
        let secondsInADay = 86_400 as NSTimeInterval
        return self * secondsInADay
    }
    
    public var before: NSDate {
        let timeInterval = self
        return NSDate().dateByAddingTimeInterval(-timeInterval)
    }
    
    public var after : NSDate{
        
        let timeInterval = self
        return NSDate().dateByAddingTimeInterval(+timeInterval)
    }
}
//
//  MyDateExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/7.
//  Copyright © 2015年 东正. All rights reserved.
//

import UIKit

extension NSDate{

    /// 返回字符串 请注意不要有空格在最前或者最后
    ///
    /// :param format: yyyy-MM-dd HH:mm:ss / yyyy-MM-dd / yyyyMMddHHmmss / MMddHHmmss
    ///
    /// returns: 字符串
    func dateToString(format:String)->String{
        let formats = NSDateFormatter()
        formats.dateFormat = format
        formats.timeZone = NSTimeZone(name: "GMT")
        let str = formats.stringFromDate(self)
        return str.substringToIndex(format.length)
    }
    
    // 转换成字符串 此方法会默认使用东八区的时间 时间相互转化可能会出问题， 请使用dateToString  
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
    
    ///强制转换成字符串
    func toString()->String{
        return String(self)
    }
    
    ///比较时间
    func dateCompare(compareData:NSDate)->Bool{
        let now = self.timeIntervalSinceDate(compareData)
        if(now > 0){
            
            return true
        }else{
            
            return false
        }
    
    }
    
    ///更换日期格式
    func changeFormate(newFormate:String,oldFormate:String)->NSDate{

        let str = self.dateToString(oldFormate)
        return str.dateValue(newFormate)!
        
    }
    ///提前几天
    func beforeDate(befor:Int)->NSDate{
        let time = self.timeIntervalSince1970
        let newDate = NSDate(timeIntervalSince1970: time - Double(befor * 3600 * 24))
        return newDate
    }
    ///推迟几天
    func nextDate(befor:Int)->NSDate{
        let time = self.timeIntervalSince1970
        let newDate = NSDate(timeIntervalSince1970: time + Double(befor * 3600 * 24))
        return newDate
    }
    ///设置格式
    func dateFormate(formate:String)->NSDate{
        let formats = NSDateFormatter()
        formats.dateFormat = formate
        let str = formats.stringFromDate(self)
        let newStr = str.substringToIndex(formate.length)
        print(newStr)
        return  newStr.dateValue(formate)!
    }
    
    
    /**
    在自身上添加时间
    
    - parameter seconds: 秒
    - parameter minutes: 分钟
    - parameter hours: 小时
    - parameter days: 天
    - parameter weeks: 周
    - parameter months: 月
    - parameter years: 年
    - returns: 当前时间加上参数之后的时间
    */
    public func add(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        
        let version = floor(NSFoundationVersionNumber)
        
        if version <= NSFoundationVersionNumber10_9_2 {
            var component = NSDateComponents()
            component.setValue(seconds, forComponent: .Second)
            
            var date : NSDate! = calendar.dateByAddingComponents(component, toDate: self, options: [])!
            component = NSDateComponents()
            component.setValue(minutes, forComponent: .Minute)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(hours, forComponent: .Hour)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(days, forComponent: .Day)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(weeks, forComponent: .WeekOfMonth)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(months, forComponent: .Month)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(years, forComponent: .Year)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            return date
        }
        
        var date : NSDate! = calendar.dateByAddingUnit(.Second, value: seconds, toDate: self, options: [])
        date = calendar.dateByAddingUnit(.Minute, value: minutes, toDate: date, options: [])
        date = calendar.dateByAddingUnit(.Day, value: days, toDate: date, options: [])
        date = calendar.dateByAddingUnit(.Hour, value: hours, toDate: date, options: [])
        date = calendar.dateByAddingUnit(.WeekOfMonth, value: weeks, toDate: date, options: [])
        date = calendar.dateByAddingUnit(.Month, value: months, toDate: date, options: [])
        date = calendar.dateByAddingUnit(.Year, value: years, toDate: date, options: [])
        return date
    }
    
    /**
    增加秒
    
    - parameter seconds: 需要增加的秒
    - returns: 增加秒后的时间
    */
    public func addSeconds (seconds: Int) -> NSDate {
        return add(seconds)
    }
    
    /**
    增加分钟
    
    - parameter minutes: 需要增加的分钟
    - returns: 增加分钟后的时间
    */
    public func addMinutes (minutes: Int) -> NSDate {
        return add(minutes: minutes)
    }
    
    /**
    增加小时
    
    - parameter hours: 小时
    - returns: 增加小时后的时间
    */
    public func addHours(hours: Int) -> NSDate {
        return add(hours: hours)
    }
    
    /**
    增加天
    
    - parameter days: 天数
    - returns: 增加天后的时间
    */
    public func addDays(days: Int) -> NSDate {
        return add(days: days)
    }
    
    /**
    增加星期
    
    - parameter weeks: 周数
    - returns: 增加周数之后的时间
    */
    public func addWeeks(weeks: Int) -> NSDate {
        return add(weeks: weeks)
    }
    
    
    /**
    增加月
    
    - parameter months: 月数
    - returns: 增加月之后的时间
    */
    
    public func addMonths(months: Int) -> NSDate {
        return add(months: months)
    }
    
    /**
    增加年
    
    - parameter years: 年数
    - returns: 增加年后的时候
    */
    public func addYears(years: Int) -> NSDate {
        return add(years: years)
    }
    
    /**
    检查相等
    
    - parameter date: 需要比较的时间
    - returns: True 相等
    */
    func isEqualsTo(date: NSDate) -> Bool {
        return self.compare(date) == NSComparisonResult.OrderedSame
    }
    
    /**
    检查自己是不是在输入时间之后
    
    - parameter date: 需要比较的时间
    - returns: True 自身在输入之后
    */
    public func isAfter(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedDescending)
    }
    
    /**
    检查自己是不是在输入时间之后
    
    - parameter date: 需要比较的时间
    - returns: True 自身在输入之前
    */
    public func isBefore(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedAscending)
    }
    
    /**
    年
    */
    public var year : Int {
        get {
            return getComponent(.Year)
        }
    }
    
    /**
    月
    */
    public var month : Int {
        get {
            return getComponent(.Month)
        }
    }
    
    /**
    这个星期的周几  请注意这是从周日是第一天开始算的！
    */
    public var weekday : Int {
        get {
            return getComponent(.Weekday)
        }
    }
    
    /// 这是周几
    public var week : String{
        get{
            if(self.weekday == 1){
                return "周日"
            }
            if(self.weekday == 2){
                return "周一"
            }
            if(self.weekday == 3){
                return "周二"
            }
            if(self.weekday == 4){
                return "周三"
            }
            if(self.weekday == 5){
                return "周四"
            }
            if(self.weekday == 6){
                return "周五"
            }
            if(self.weekday == 7){
                return "周六"
            }
            return "未知星期"
        }
    }
    
    /**
    这个星期是这个月的第几个星期  
    */
    public var weekMonth : Int {
        get {
            return getComponent(.WeekOfMonth)
        }
    }
    
    
    /**
    天
    */
    public var days : Int {
        get {
            return getComponent(.Day)
        }
    }
    
    /**
    小时
    */
    public var hours : Int {
        
        get {
            return getComponent(.Hour)
        }
    }
    
    /**
    分钟
    */
    public var minutes : Int {
        get {
            return getComponent(.Minute)
        }
    }
    
    /**
    秒
    */
    public var seconds : Int {
        get {
            return getComponent(.Second)
        }
    }
    
    /**
    当月有几天
    */
    public func numOfDayFormMouth()->Int{
        let calendar = NSCalendar.currentCalendar()
        let range = calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self)

        return range.length
    }
    
    /**
    今年的当月有几天
    */
    public func numOfDayFormMouthInTheNowYear(mouth:Int)->Int{
        let newDateStr = "\(self.year)-\(mouth)"
        let newDate = newDateStr.toDate("yyyy-MM")
        return (newDate?.numOfDayFormMouth())!
    }
    
    /**
   返回根据历法所取到的值
    
    - parameter component: NSCalendarUnit 历法
    - returns: 根据历法所需要的值
    */
    
    public func getComponent (component : NSCalendarUnit) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(component, fromDate: self)

        return components.valueForComponent(component)
    }
    
    /// 根据输入的年月日生成日期对象
    ///
    /// :param year
    /// :param month
    /// :param day
    /// :return Date
    public class func from(year year: Int, month: Int, day: Int) -> NSDate? {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        if let gregorian = NSCalendar(identifier: NSCalendarIdentifierGregorian) {
            return gregorian.dateFromComponents(c)
        } else {
            return .None
        }
    }
    
    /// 根据unix时间戳生成日期对象
    ///
    /// :param unix timestamp
    /// :return Date
    public class func from(unix unix: Double) -> NSDate {
        return NSDate(timeIntervalSince1970: unix)
    }
    
    /// 基于格式解析日期并返回一个新的日期对象
    ///
    /// :param dateStr String version of the date
    /// :param format 默认的格式
    /// :return Date
    public class func parse(dateStr: String, format: String = "yyyy-MM-dd") -> NSDate {
        let dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = format
        return dateFmt.dateFromString(dateStr)!
    }
    
    /// 通过日期获取时间戳活着返回当前的时间戳
    ///
    /// :param date
    /// :return Double
    public class func unix(date: NSDate = NSDate()) -> Double {
        return date.timeIntervalSince1970 as Double
    }
    

}
extension NSDate: Strideable {
    /**
    返回到某一时间点的时间间距
    
    - parameter other:时间点
    - returns: 时间间隔
    */
    public func distanceTo(other: NSDate) -> NSTimeInterval {
        return other - self
    }
    /**
    快进秒数
    
    - parameter other:需要快进的秒
    - returns: 快进之后的时间
    */
    public func advancedBy(n: NSTimeInterval) -> Self {
        return self.dynamicType.init(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate + n)
    }
}
// MARK: Arithmetic
/// 加
func +(date: NSDate, timeInterval: Int) -> NSDate {
    return date + NSTimeInterval(timeInterval)
}
/// 减
func -(date: NSDate, timeInterval: Int) -> NSDate {
    return date - NSTimeInterval(timeInterval)
}

func +=(inout date: NSDate, timeInterval: Int) {
    date = date + timeInterval
}

func -=(inout date: NSDate, timeInterval: Int) {
    date = date - timeInterval
}

func +(date: NSDate, timeInterval: Double) -> NSDate {
    return date.dateByAddingTimeInterval(NSTimeInterval(timeInterval))
}

func -(date: NSDate, timeInterval: Double) -> NSDate {
    return date.dateByAddingTimeInterval(NSTimeInterval(-timeInterval))
}

func +=(inout date: NSDate, timeInterval: Double) {
    date = date + timeInterval
}

func -=(inout date: NSDate, timeInterval: Double) {
    date = date - timeInterval
}

func -(date: NSDate, otherDate: NSDate) -> NSTimeInterval {
    return date.timeIntervalSinceDate(otherDate)
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedSame
}

extension NSDate: Comparable {
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}

public typealias Date = NSDate
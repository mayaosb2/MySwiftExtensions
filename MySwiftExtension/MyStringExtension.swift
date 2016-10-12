//
//  MyStringExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/7.
//  Copyright © 2015年 东正. All rights reserved.
//

import UIKit

import CryptoSwift

/**
 数据类型
 
 - NSListType:     顺序集合结构
 - NSSetType:      无顺序集合结构
 - NSObjectType:   系统非集合类型
 - UnNSObjectType: 自定义类型
 */
public enum ObjectType{
    case NSListType
    case NSSetType
    case NSObjectType
    case UnNSObjectType
}

public extension String{
    
    /**
     将字符串按字母排序升序(不考虑大小写)
     
     - returns:
     */
    func sortAsc() -> String {
        var chars = [Character](self.characters)
        chars.sortInPlace({$0 < $1})
        
        return String(chars)
    }
    
    /**
     将字符串按字母排序降序(不考虑大小写)
     
     - returns:
     */
    func sortDesc() -> String {
        var chars = [Character](self.characters)
        chars.sortInPlace({$0 > $1})
        
        return String(chars)
    }
    
    /**
     转化成base64
     
     - returns: base64
     */
    func toBase64String()->String?{
       let data =  self.dataUsingEncoding(NSASCIIStringEncoding)
        return data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
    }
    
    /**
    格式化手机号码
    
    - parameter phonenumber: 原来手机号
    */
    func formatPhoneNumber(phonenumber:String)->String{
        //to index  to 这个字母不包含，from index 是包含 INDEX这个数组的
        return phonenumber.substringToIndex(3) + "-" + phonenumber.substringWithRange(NSMakeRange(3, 4)) + "-" + phonenumber.substringFromIndex(7)
    }
    
    /**
    拼接url
     */
    func appendUrl(nextUrl:String)->String{
        if(self.contains("?")){
            return self + "&" + nextUrl
        }else{
            return self + "?" + nextUrl
        }
    }
    
    /**
     版本号比较
     
     - parameter : true 表示输入参数比当前大   false 表示输入参数比当前小
     */
    func isCheckVersion(version:String)->Bool{
        //数据可能为空
        if(version == "" || self == ""){
            
            return false
        }
        
        //如果特殊情况不包含。分隔符
        if !version.containsString(".") ||  !self.containsString(".") {
            
            return false
        }
        
        let versionArr =  version.componentsSeparatedByString(".")
        let selfArr =  self.componentsSeparatedByString(".")
        
        //如果分隔符数量不足
        if selfArr.count != 3 || versionArr.count != 3 {
            
            return false
        }
        
        //比较第一位
        if versionArr[0].toDouble()! > selfArr[0].toDouble()! {
            
            return true
        }else if versionArr[0].toDouble()! == selfArr[0].toDouble()! {
            //比较第二位
            if versionArr[1].toDouble()! > selfArr[1].toDouble()! {
                
                return true
            }else if versionArr[1].toDouble()! == selfArr[1].toDouble()! {
                //比较第三位
                if versionArr[2].toDouble()! > selfArr[2].toDouble()! {
                    
                    return true
                }else {
                    
                    return false
                }
                
            }else {
                
                return false
            }
        }else {
            
            return false
        }
        
    }
    
    func aesEncrypt(key: String, iv: String) throws -> String{
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        let enc = try AES(key: key, iv: iv, blockMode:.ECB).encrypt(data!.arrayOfBytes(), padding: PKCS7())
        let encData = NSData(bytes: enc, length: Int(enc.count))
        let base64String: String = encData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
        let result = String(base64String)
        return result
    }
    
    /**
     这个方法传入的KEY是[byte]
     
     - parameter key:
     
     - throws:
     
     - returns:     
     */
    func aesEncryptmrshan(key:[UInt8]) throws ->String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        let enc = try AES(key: key, iv: [], blockMode: .ECB).encrypt(data!.arrayOfBytes(), padding: PKCS7())
        let encData = NSData(bytes: enc, length: Int(enc.count))
        let base64String: String = encData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
        let result = String(base64String)
        return result
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0))
        let dec = try AES(key: key, iv: iv, blockMode:.ECB).decrypt(data!.arrayOfBytes(), padding: PKCS7())
        let decData = NSData(bytes: dec, length: Int(dec.count))
        let result = NSString(data: decData, encoding: NSUTF8StringEncoding)
        return String(result!)
    }
    
    func substringWithRange(range:NSRange)->String{
        let str = self as NSString
        return str.substringWithRange(range)
    }
    
    func substringFromIndex(from:Int)->String{
        let str = self as NSString
        return str.substringFromIndex(from)
    }
    
    func substringToIndex(to:Int)->String{
        let str = self as NSString
        return str.substringToIndex(to)
    }
    
    /// 返回时间
    ///
    /// :param format: yyyy-MM-dd HH:mm:ss / yyyy-MM-dd / yyyyMMddHHmmss / MMddHHmmss
    ///
    /// returns: 时间
    func dateValue(format:String)->NSDate?{
        let formats = NSDateFormatter()
        formats.dateFormat = format
        formats.timeZone = NSTimeZone(name: "GMT")
        return formats.dateFromString(self)
    }
    
    func pathComponents()->[String]{
        
        let newNstr = self as NSString
        return newNstr.pathComponents
        
    }
    func absolutePath()->Bool{
        
        let newNstr = self as NSString
        return newNstr.absolutePath
    }
    
    func lastPathComponent()->String{
        
        let newNstr = self as NSString
        return newNstr.lastPathComponent
    }
    
    
    func stringByDeletingLastPathComponent()->String{
        
        let newNstr = self as NSString
        return newNstr.stringByDeletingLastPathComponent
    }
    
    func stringByAppendingPathComponent(str: String)->String{
        
        let newNstr = self as NSString
        return newNstr.stringByAppendingPathComponent(str)
    }
    
    func stringByDeletingPathExtension()->String{
        
        let newNstr = self as NSString
        return newNstr.stringByDeletingPathExtension
    }
    func stringByAppendingPathExtension(str: String)->String?{
        
        let newNstr = self as NSString
        return newNstr.stringByAppendingPathExtension(str)
    }
    
    func stringByAbbreviatingWithTildeInPath()->String{
        
        let newNstr = self as NSString
        return newNstr.stringByAbbreviatingWithTildeInPath
    }
    
    func stringByExpandingTildeInPath()->String{
        
        let newNstr = self as NSString
        return newNstr.stringByExpandingTildeInPath
    }
    
    func stringByStandardizingPath()->String{
        
        let newNstr = self as NSString
        return newNstr.stringByStandardizingPath
    }
    func stringByResolvingSymlinksInPath()->String{
        
        let newNstr = self as NSString
        return newNstr.stringByResolvingSymlinksInPath
    }
    func stringsByAppendingPaths(paths: [String])->[String]{
        
        let newNstr = self as NSString
        return newNstr.stringsByAppendingPaths(paths)
    }
    
    /**
     格式化金额
     
     - returns: string
     */
    func stringFormatterCurrency()->String{
        
        if(self != "0" && self != ""){
            
            let stringArr = self.componentsSeparatedByString(".")
            
            let firstString = stringArr.first
            
            let lastString = stringArr.last
            
            if firstString!.length <= 3 {
                
                return self
                
            }else{
                
                let formatter = NSNumberFormatter()
                formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                
                let s = firstString!.toDouble()
                let newAmount = formatter .stringFromNumber(NSNumber(double: s!))
                
                return newAmount! + "." + lastString!
            }
            
        }
        
        return self
        
    }

    
    
    /// 返回扩展名
    /// :returns: 扩展名
    func pathExtension()->String{
        let newNstr = self as NSString
        return newNstr.pathExtension
    }
    
    
    func integerValue()->Int{
        
        let newNstr = self.removeSpaces() as NSString
        return newNstr.integerValue
    }
    
    func longLongValue()->Int64{
        
        let newNstr = self.removeSpaces() as NSString
        return newNstr.longLongValue
    }
    
    func intValue()->Int32{
        
        let newNstr = self.removeSpaces() as NSString
        return newNstr.intValue
        
    }
    
    //    func floatValue()->Float{
    //
    //        let newNstr = self.removeSpaces() as NSString
    //        return newNstr.floatValue
    //
    //    }
    //
    //    func doubleValue()->Double{
    //
    //        let newNstr = self.removeSpaces() as NSString
    //        return newNstr.doubleValue
    //
    //    }
    
    func boolValue()->Bool?{
        let text = self.removeSpaces().lowercaseString
        if(text == "true" || text == "false" || text == "yes" || text == "no" || text == "YES" || text == "NO"){
            let newNstr = self as NSString
            return newNstr.boolValue
            
        }else{
            
            return nil
        }
        
    }
    
    /// 返回长度
    /// :returns: 字符串长度
    public var length: Int {
        get {
            return self.characters.count
        }
    }
    
    /// 返回首字母
    ///
    /// :param: string 需要转换的字符串
    /// :param: allFirst 是否需要所有的字符 false不需要(只要第一个字的首字母) true需要
    /// :returns: 首字母
    func GetTheFirstLetter(string:String?, allFirst:Bool=false)->String{
        var py="#"
        if let s = string {
            if s == "" {
                return py
            }
            let str = CFStringCreateMutableCopy(nil, 0, s)
            CFStringTransform(str, nil, kCFStringTransformToLatin, Bool(0))
            CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, Bool(0))
            
            py = ""
            if allFirst { for x in (str as String).componentsSeparatedByString(" ") {
                
                py += GetTheFirstLetter(x)
                
                }
            }
            else {
                py = (str as NSString).substringToIndex(1).uppercaseString
            }
        }
        return py
        
    }
    
    
    /// 返回拼音
    ///
    /// :param: string 需要转换的字符串
    /// :param: allFirst 是否需要所有的字符 false不需要(只要第一个字的拼音) true需要
    /// :returns: 首字母
    func GetTheSpelling(string:String?, allFirst:Bool=false)->String{
        var py="#"
        if let s = string {
            if s == "" {
                return py
            }
            let str = CFStringCreateMutableCopy(nil, 0, s)
            CFStringTransform(str, nil, kCFStringTransformToLatin, Bool(0))
            CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, Bool(0))
            
            py = ""
            if allFirst { for x in (str as String).componentsSeparatedByString(" ") {
                
                py += GetTheSpelling(x)
                
                }
            }
            else {
                py = (str as NSString).uppercaseString
            }
        }
        return py
        
    }
    
    /**
    return Double
    */
    func toDouble() -> Double? {
        
        let scanner = NSScanner(string: self)
        var double: Double = 0
        if scanner.scanDouble(&double) {
            return double
        }
        
        return nil
        
    }
    
    /**
    return Float
    */
    func toFloat() -> Float? {
        
        let scanner = NSScanner(string: self)
        var float: Float = 0
        
        if scanner.scanFloat(&float) {
            return float
        }
        
        return nil
        
    }
    
    /**
    returns: UInt
    */
    func toUInt() -> UInt? {
        if let val = Int(self.removeSpaces()) {
            if val < 0 {
                return nil
            }
            return UInt(val)
        }
        
        return nil
    }
    
    
    func toBool() -> Bool? {
        return self.boolValue()
    }
    
    /**
    解析日期字符串
    默认格式yyyy-MM-dd，但可以修改。
    
    - returns: 解析NSDate 如果不是的话，就为空
    */
    func toDate(format : String? = "yyyy-MM-dd") -> NSDate? {
        let text = self.removeSpaces().lowercaseString
        let dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        if let fmt = format {
            dateFmt.dateFormat = fmt
        }
        return dateFmt.dateFromString(text)
    }
    
    /**
    解析日期字符串
    默认格式yyyy-MM-dd HH-mm-ss，但可以修改。
    
    - returns: 解析NSDate 如果不是的话，就为空
    */
    func toDateTime(format : String? = "yyyy-MM-dd HH-mm-ss") -> NSDate? {
        return toDate(format)
    }
    
    /**
    删除最左边和参数一样的字符 若空则删除空格
    
    - returns: Stripped string
    */
    func trimmedLeft (characterSet set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()) -> String {
        if let range = rangeOfCharacterFromSet(set.invertedSet) {
            return self[range.startIndex..<endIndex]
        }
        
        return ""
    }
    
    /**
    删除最右边和参数一样的字符 若空则删除空格
    
    - returns: Stripped string
    */
    func trimmedRight (characterSet set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()) -> String {
        if let range = rangeOfCharacterFromSet(set.invertedSet, options: NSStringCompareOptions.BackwardsSearch) {
            return self[startIndex..<range.endIndex]
        }
        
        return ""
    }
    
    /**
    删除字符串首部和最后空格
    
    - returns: Stripped string
    */
    func removeSpaces() -> String {
        return trimmedLeft().trimmedRight()
    }
    
    /**
    删除左边和参数相同的字符
    
    - returns: Stripped string
    */
    func removeLeftSpaces(str:String) -> String {
        return trimmedLeft(characterSet: NSCharacterSet(charactersInString: str))
    }
    
    /**
    删除右边和参数相同的字符
    
    - returns: Stripped string
    */
    func removeRightSpaces(str:String) -> String {
        return trimmedRight(characterSet: NSCharacterSet(charactersInString: str))
    }
    
    /**
    驼峰拼写法
    */
    public var camelCase: String {
        get {
            return self.deburr().words().reduceWithIndex("") { (result, index, word) -> String in
                let lowered = word.lowercaseString
                return result + (index > 0 ? lowered.capitalizedString : lowered)
            }
        }
    }
    
    /**
    用－把单词分开拼写法
    */
    public var kebabCase: String {
        get {
            return self.deburr().words().reduceWithIndex("", combine: { (result, index, word) -> String in
                return result + (index > 0 ? "-" : "") + word.lowercaseString
            })
        }
    }
    
    /**
    用_把单词分开拼写法
    */
    public var snakeCase: String {
        get {
            return self.deburr().words().reduceWithIndex("", combine: { (result, index, word) -> String in
                return result + (index > 0 ? "_" : "") + word.lowercaseString
            })
        }
    }
    
    /**
    用空格把单词分开
    */
    public var startCase: String {
        get {
            return self.deburr().words().reduceWithIndex("", combine: { (result, index, word) -> String in
                return result + (index > 0 ? " " : "") + word.capitalizedString
            })
        }
    }
    
    /**
    根据索引返回字符
    
    - i : 索引值
    - return :  根据索引返回的字符
    */
    
    public subscript(i: Int) -> Character? {
        if let char = Array(self.characters).get(i) {
            return char
        }
        return .None
    }
    
    /// 根据输入字符在字符串里找，如果找到就输出，未找到就输出nil
    ///
    /// :return 找到的字符
    public subscript(pattern: String) -> String? {
        if let range = Regex(pattern).rangeOfFirstMatch(self).toRange() {
            return self[range]
        }
        return .None
    }
    
    /// 根据范围查找字符
    ///
    /// :param range 范围
    /// :return Substring
    public subscript(range: Range<Int>) -> String {
        let start = startIndex.advancedBy(range.startIndex)
        let end = startIndex.advancedBy(range.endIndex)
        return self.substringWithRange(Range(start: start, end: end))
    }
    
    /// 查找输入的字符在字符串中的位置
    ///
    /// :return start index of .None if not found
    public func indexOf(char: Character) -> Int? {
        return self.indexOf(char.description)
    }
    
    /// 查找输入的字符串在字符串中的位置
    ///
    /// :return start index of .None if not found
    public func indexOf(str: String) -> Int? {
        return self.indexOfRegex(Regex.escapeStr(str))
    }
    
    /// 根据输入的正则表达式在字符串中的查找位置
    ///
    /// :return 开始位置 如果未发现输出.None
    public func indexOfRegex(pattern: String) -> Int? {
        if let range = Regex(pattern).rangeOfFirstMatch(self).toRange() {
            return range.startIndex
        }
        return .None
    }
    
    /// 根据输入的分隔符，把字符串分割成数组
    ///
    /// :return Array
    public func split(delimiter: Character) -> [String] {
        return self.componentsSeparatedByString(String(delimiter))
    }
    
    /// 删除字符串前的空格
    ///
    /// :return 没有前置空格的String
    public func lstrip() -> String {
        return self["[^\\s]+.*$"]!
    }
    
    /// 删除字符串后的空格
    ///
    /// :return 没有后置空格的String
    public func rstrip() -> String {
        return self["^.*[^\\s]+"]!
    }
    
    /// 删除字符串前后的空格
    ///
    /// :return 没有前后空格的String
    public func strip() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    /// 字符串拆分成单词数组
    func words() -> [String] {
        let hasComplexWordRegex = try! NSRegularExpression(pattern: RegexHelper.hasComplexWord, options: [])
        let wordRange = NSMakeRange(0, self.characters.count)
        let hasComplexWord = hasComplexWordRegex.rangeOfFirstMatchInString(self, options: [], range: wordRange)
        let wordPattern = hasComplexWord.length > 0 ? RegexHelper.complexWord : RegexHelper.basicWord
        let wordRegex = try! NSRegularExpression(pattern: wordPattern, options: [])
        let matches = wordRegex.matchesInString(self, options: [], range: wordRange)
        let words = matches.map { (result: NSTextCheckingResult) -> String in
            if let range = self.rangeFromNSRange(result.range) {
                return self.substringWithRange(range)
            } else {
                return ""
            }
        }
        return words
    }
    
    /// Strip string of accents and diacritics
    func deburr() -> String {
        let mutString = NSMutableString(string: self)
        CFStringTransform(mutString, nil, kCFStringTransformStripCombiningMarks, false)
        return mutString as String
    }
    
    /// Converts an NSRange to a Swift friendly Range supporting Unicode
    ///
    /// :param nsRange the NSRange to be converted
    /// :return A corresponding Range if possible
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
                return from ..< to
        } else {
            return nil
        }
    }
    
    
}

infix operator =~ {}

/// Regex match the string on the left with the string pattern on the right
///
/// :return true if string matches the pattern otherwise false
public func =~(str: String, pattern: String) -> Bool {
    return Regex(pattern).test(str)
}

/// Concat the string to itself n times
///
/// :return concatenated string
public func * (str: String, n: Int) -> String {
    var stringBuilder = [String]()
    n.times {
        stringBuilder.append(str)
    }
    return stringBuilder.joinWithSeparator("")
}

protocol StringType{
    var characters: String.CharacterView { get }
}

extension String{
    
    public func subString(startIndex: Int, length: Int) -> String{
        let start = self.startIndex.advancedBy(startIndex)
        
        let end = self.startIndex.advancedBy(startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }
    
    public func indexOf(target: String) -> Int{
        let range = self.rangeOfString(target)
        if let tempRange = range {
            return self.startIndex.distanceTo(tempRange.startIndex)
        } else {
            return -1
        }
    }
    
    public func indexOf(target: String, startIndex: Int) -> Int{
        let startRange = self.startIndex.advancedBy(startIndex)
        
        let range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
        
        if let range = range {
            return self.startIndex.distanceTo( range.startIndex)
        }
        else {
            return -1
        }
    }
    
    
    
    public func isMatch(regex: String, options: NSRegularExpressionOptions) -> Bool{
        var exp : NSRegularExpression?
        
        do{
            exp = try NSRegularExpression(pattern: regex, options: options)
            
        }catch let error as NSError{
            print("\(error.localizedDescription)")
        }
        
        let matchCount = exp!.numberOfMatchesInString(self, options: [], range: NSMakeRange(0, self.length))
        return matchCount > 0
    }
    
    public func getMatches(regex: String, options: NSRegularExpressionOptions) -> [NSTextCheckingResult]{
        
        var exp : NSRegularExpression?
        
        do{
            exp = try NSRegularExpression(pattern: regex, options: options)
            
        }catch let error as NSError{
            print("\(error.localizedDescription)")
        }
        let matches = exp!.matchesInString(self, options: [], range: NSMakeRange(0, self.length))
        return matches as [NSTextCheckingResult]
    }
    
    private var vowels: [String]{
        return ["a", "e", "i", "o", "u"]
    }
    
    private var consonants: [String]{
        return ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
    }
    
    public func pluralize(count: Int) -> String
    {
        if count == 1 {
            return self
        } else {
            let lastChar = self.subString(self.length - 1, length: 1)
            let secondToLastChar = self.subString(self.length - 2, length: 1)
            var prefix = "", suffix = ""
            
            if lastChar.lowercaseString == "y" && vowels.filter({x in x == secondToLastChar}).count == 0 {
                prefix = self[0...self.length - 1]
                suffix = "ies"
            } else if lastChar.lowercaseString == "s" || (lastChar.lowercaseString == "o" && consonants.filter({x in x == secondToLastChar}).count > 0) {
                prefix = self[0...self.length]
                suffix = "es"
            } else {
                prefix = self[0...self.length]
                suffix = "s"
            }
            
            return prefix + (lastChar != lastChar.uppercaseString ? suffix : suffix.uppercaseString)
        }
    }
    
    public func regexMatchesInString(regexString:String) -> [String] {
        
        var arr :[String] = []
        var rang = Range(start: self.startIndex, end: self.endIndex)
        var foundRange:Range<String.Index>?
        
        repeat{
            
            foundRange = self.rangeOfString(regexString, options: NSStringCompareOptions.RegularExpressionSearch, range: rang, locale: nil)
            
            if let a = foundRange {
                arr.append(self.substringWithRange(a))
                rang.startIndex = a.endIndex
            }
        }
            while foundRange != nil
        
        
        return arr
        //"Hello".regexMatchesInString("[^Hh]{1,}")
    }
    
}


public extension String{
    
    var toInt : Int{
        return Int(self)!
    }
    
    var toInt32 : Int32{
        return Int32(self)!
    }
    
    var toInt64 : Int64{
        // 32 bit check needed
        return (Int(self) != nil) ? Int64(self)! : ((self as NSString).longLongValue)
    }
    
    var toNumber : NSNumber{
        return NSNumber(integer: self.toInt)
    }
    
    var toNumber_32Bit : NSNumber{
        return NSNumber(int: self.toInt32)
    }
    
    var toNumber_64Bit : NSNumber{
        return NSNumber(longLong: self.toInt64)
    }
}

//MARK: BASIC
public extension String{
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    func trimNewLine() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func contains(str:String?)->Bool{
        return (self.rangeOfString(str!) != nil) ? true : false
    }
    
    func replaceCharacterWith(characters: String, toSeparator: String) -> String {
        let characterSet = NSCharacterSet(charactersInString: characters)
        let components = self.componentsSeparatedByCharactersInSet(characterSet)
        let result = components.joinWithSeparator(toSeparator)
        return result
    }
    
    func wipeCharacters(characters: String) -> String {
        return self.replaceCharacterWith(characters, toSeparator: "")
    }
    
    func replace(find findStr: String, replaceStr: String) -> String{
        return self.stringByReplacingOccurrencesOfString(findStr, withString: replaceStr, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func splitStringWithLimit(delimiter:String?="", limit:Int=0) -> [String]{
        let arr = self.componentsSeparatedByString((delimiter != nil ? delimiter! : ""))
        return Array(arr[0..<(limit > 0 ? min(limit, arr.count) : arr.count)])
        
        // use : print(s.split(",", limit:2))  //->["part1","part2"]
    }
    
    func createURL() -> NSURL{
        return NSURL(string: self)!
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(email)
        
        return result
    }
    
    /**
    检查是不是手机号
    
    - returns: true 是手机号
    */
    func isTelNumber()->Bool
    {
        let mobile = "^1+[34578]+\\d{9}"
        let newMobile = "/^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestNewmobile = NSPredicate(format: "SELF MATCHES %@",newMobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(self) == true)
            || (regextestNewmobile.evaluateWithObject(self)  == true)
            || (regextestcm.evaluateWithObject(self)  == true)
            || (regextestct.evaluateWithObject(self) == true)
            || (regextestcu.evaluateWithObject(self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    /**
    验证是不是身份证号
    
    - returns: true 是身份证号
    */
    func isUserIdCard()-> Bool{
//       let isIDCard1 = "/^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$/"
//       let isIDCard2 = "/^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$/"
//        let pattern = "\(isIDCard1)|\(isIDCard2)"
//        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X|x)$)"
        let partternTwo = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[X])$)$"
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",partternTwo)
        if(regextestcm.evaluateWithObject(self) == true){
            if(self == "111111111111111111"){
                
                return false
            }
            return true
        }else{
            
            return false
        }
    }
    
    /**
    判断是不是英文或者数字
    */
    func isEnglishOrNumber()->Bool{
        let emailRegEx = "^[a-zA-Z0-9]+$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    /**
     判断是不是英文
     */
    func isEnglish()->Bool{
        let emailRegEx = "^[a-zA-Z]+$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }

    /**
     判断是不是数字
     */
    func isNumber()->Bool{
        let emailRegEx = "^[0-9]+$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(self)
    }
    
    /**
    判断是不是汉字 ➋ 这种东西可能导致 某些机型不能输入汉字
    */
    func isHanZi()->Bool{
        let emailRegEx = "([\\u4e00-\\u9fa5]{1,4})|([\\u4e00-\\u9fa5]{2,9})"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(self)
    }
    
    /**
     判断是不是汉字英文或者数字
     */
    func isHanZiOrEnglishOrNumber()->Bool{
        let emailRegEx = "[\\u4e00-\\u9fa5\\w]+"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluateWithObject(self)
    }
    
    /**
     监测对象的类型
     
     - returns: 对象类型ObjectType
     */
    func checkObjectType()-> ObjectType{
        switch self{
        case "NSArray": return .NSListType
        case "NSMutableArray": return .NSListType
        case "Array": return .NSListType
        case "NSSet": return .NSSetType
        case "NSMutableSet": return .NSSetType
        case "Set": return .NSSetType
        case "String": return .NSObjectType
        case "Dictionary": return .NSObjectType
        case "Int": return .NSObjectType
        case "Int8": return .NSObjectType
        case "Int16": return .NSObjectType
        case "Int32": return .NSObjectType
        case "Int64": return .NSObjectType
        case "Float": return .NSObjectType
        case "Double": return .NSObjectType
        case "CGFloat": return .NSObjectType
        default:
            if(self.containsString("NS")){
                return .NSObjectType
            }else{
                return .UnNSObjectType
            }
        }
        
    }
    
    /**
    to400-000-1234
    */
    func to400Type()->String{
        if(self.length > 0){
            let befor = self.substringToIndex(4)
            let center = self.substringFromIndex(4)
            return  "\(befor)-\(center)"
        }else{
            return ""
        }
    }
    /**
     提取字符串中的数字
     [NSCharacterSet alphanumericCharacterSet];          //所有数字和字母(大小写)
     [NSCharacterSet decimalDigitCharacterSet];          //0-9的数字
     [NSCharacterSet letterCharacterSet];                //所有字母
     [NSCharacterSet lowercaseLetterCharacterSet];       //小写字母
     [NSCharacterSet uppercaseLetterCharacterSet];       //大写字母
     [NSCharacterSet punctuationCharacterSet];           //标点符号
     [NSCharacterSet whitespaceAndNewlineCharacterSet];  //空格和换行符
     [NSCharacterSet whitespaceCharacterSet];            //空格
     - returns: 返回数字字符串
     */
    func getNumberForString()->String{
    
        let str = self as NSString
        
        let numberArr = str.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        
        let numberString = (numberArr as NSArray).componentsJoinedByString("")
        
        return numberString
        
    }
    
    
}

extension String {
    
    /**
     根据类名生成实例对象
     
     - returns: 实例对象
     */
    func classFromString() -> NSObject? {
        // get the project name
        if  let appName: String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
            let classStringName = "\(appName).\(self)"
            let classType = NSClassFromString(classStringName) as? NSObject.Type
            if let type = classType {
                let newClass = type.init()
                return newClass
            }
        }
        return nil;
    }
    
    
}

extension String{
    
    func contain(subStr subStr: String) -> Bool {return (self as NSString).rangeOfString(subStr).length > 0}
    
    func explode (separator: Character) -> [String] {
        return self.characters.split(isSeparator: { (element: Character) -> Bool in
            return element == separator
        }).map { String($0) }
    }
    
    func replacingOccurrencesOfString(target: String, withString: String) -> String{
        return (self as NSString).stringByReplacingOccurrencesOfString(target, withString: withString)
    }
    
    func deleteSpecialStr()->String{
        
        return self.replacingOccurrencesOfString("Optional<", withString: "").replacingOccurrencesOfString(">", withString: "")
    }
    
    var floatValue: Float? {return NSNumberFormatter().numberFromString(self)?.floatValue}
    var doubleValue: Double? {return NSNumberFormatter().numberFromString(self)?.doubleValue}
    
    func repeatTimes(times: Int) -> String{
        
        var strM = ""
        
        for _ in 0..<times {
            strM += self
        }
        
        return strM
    }
}

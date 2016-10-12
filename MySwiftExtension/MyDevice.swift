//
//  MyDevice.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/22.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation
import UIKit

struct Device {
    
    // MARK: - 单利
    ///当前设备
    static var CurrentDevice: UIDevice {
        
        struct Singleton {
            static let device = UIDevice.currentDevice()
        }
        return Singleton.device
    }
    ///当前设备版本
    static var CurrentDeviceVersion: Float {
        
        struct Singleton {
            static let version = Float(UIDevice.currentDevice().systemVersion.componentsSeparatedByString(".")[0])
        }
        return Singleton.version!
    }
    ///当前设备高度
    static var CurrentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.mainScreen().bounds.size.height
        }
        return Singleton.height
    }
    // MARK: - 设备
    ///手机还是pad  
    ///return iPhone or iPad or Not iPhone no iPad
    static var PHONE_OR_PAD: String {
        if isPhone() {
            return "iPhone"
        } else if isPad() {
            return "iPad"
        }
        return "Not iPhone no iPad"
    }
    
    ///Debug还是Release
    ///return Debug or Release
    static var DEBUG_OR_RELEASE: String {
        #if DEBUG
            return "Debug"
            #else
            return "Release"
        #endif
    }
    
    ///Device还是Simulator
    ///return Simulator or Device
    static var SIMULATOR_OR_DEVICE: String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return "Simulator"
            #else
            return "Device"
        #endif
    }
    
    
    static func isPhone() -> Bool {
        return CurrentDevice.userInterfaceIdiom == .Phone
    }
    
    static func isPad() -> Bool {
        return CurrentDevice.userInterfaceIdiom == .Pad
    }
    
    static func isDebug() -> Bool {
        return DEBUG_OR_RELEASE == "Debug"
    }
    
    static func isRelease() -> Bool {
        return DEBUG_OR_RELEASE == "Release"
    }
    
    static func isSimulator() -> Bool {
        return SIMULATOR_OR_DEVICE == "Simulator"
    }
    
    static func isDevice() -> Bool {
        return SIMULATOR_OR_DEVICE == "Device"
    }
    
    // MARK: - 设备版本检查
    
    enum Versions: Float {
        case Five = 5.0
        case Six = 6.0
        case Seven = 7.0
        case Eight = 8.0
        case Nine = 9.0
    }
    
    ///检查是不是某版本
    static func isVersion(version: Versions) -> Bool {
        return CurrentDeviceVersion >= version.rawValue && CurrentDeviceVersion < (version.rawValue + 1.0)
    }
    ///检查是不是某版本之后
    static func isVersionOrLater(version: Versions) -> Bool {
        return CurrentDeviceVersion >= version.rawValue
    }
    ///检查是不是某版本之前
    static func isVersionOrEarlier(version: Versions) -> Bool {
        return CurrentDeviceVersion < (version.rawValue + 1.0)
    }
    ///当然系统版本
    static var CURRENT_VERSION: String {
        return "\(CurrentDeviceVersion)"
    }
    
    // MARK: 检查 iOS 5
    
    static func IS_OS_5() -> Bool {
        return isVersion(.Five)
    }
    
    static func IS_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(.Five)
    }
    
    static func IS_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Five)
    }
    
    // MARK: 检查 iOS 6
    
    static func IS_OS_6() -> Bool {
        return isVersion(.Six)
    }
    
    static func IS_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(.Six)
    }
    
    static func IS_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Six)
    }
    
    // MARK: 检查 iOS 7
    
    static func IS_OS_7() -> Bool {
        return isVersion(.Seven)
    }
    
    static func IS_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(.Seven)
    }
    
    static func IS_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Seven)
    }
    
    // MARK: 检查 iOS 8
    
    static func IS_OS_8() -> Bool {
        return isVersion(.Eight)
    }
    
    static func IS_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(.Eight)
    }
    
    static func IS_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Eight)
    }
    
    // MARK: 检查 iOS 9
    
    static func IS_OS_9() -> Bool {
        return isVersion(.Nine)
    }
    
    static func IS_OS_9_OR_LATER() -> Bool {
        return isVersionOrLater(.Nine)
    }
    
    static func IS_OS_9_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Nine)
    }
    
    // MARK: - 检查设备高度
    
    enum Heights: CGFloat {
        case Inches_3_5 = 480
        case Inches_4 = 568
        case Inches_4_7 = 667
        case Inches_5_5 = 736
    }
    
    ///判断size 是否匹配
    static func isSize(height: Heights) -> Bool {
        return CurrentDeviceHeight == height.rawValue
    }
    
    static func isSizeOrLarger(height: Heights) -> Bool {
        return CurrentDeviceHeight >= height.rawValue
    }
    
    static func isSizeOrSmaller(height: Heights) -> Bool {
        return CurrentDeviceHeight <= height.rawValue
    }
    
    static var CURRENT_SIZE: String {
        if IS_3_5_INCHES() {
            return "3.5 Inches"
        } else if IS_4_INCHES() {
            return "4 Inches"
        } else if IS_4_7_INCHES() {
            return "4.7 Inches"
        } else if IS_5_5_INCHES() {
            return "5.5 Inches"
        }
        return "\(CurrentDeviceHeight) Points"
    }
    
    // MARK: 检查是不是视网膜屏幕
    
    static func IS_RETINA() -> Bool {
        return UIScreen.mainScreen().respondsToSelector("scale")
    }
    
    // MARK: 3.5 Inch Checks
    
    static func IS_3_5_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_3_5)
    }
    
    static func IS_3_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_3_5)
    }
    
    static func IS_3_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.Inches_3_5)
    }
    
    // MARK: 4 Inch Checks
    
    static func IS_4_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_4)
    }
    
    static func IS_4_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4)
    }
    
    static func IS_4_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.Inches_4)
    }
    
    // MARK: 4.7 Inch Checks
    
    static func IS_4_7_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_4_7)
    }
    
    static func IS_4_7_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4_7)
    }
    
    static func IS_4_7_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4_7)
    }
    
    // MARK: 5.5 Inch Checks
    
    static func IS_5_5_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_5_5)
    }
    
    static func IS_5_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_5_5)
    }
    
    static func IS_5_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_5_5)
    }
    
    // MARK: - 国际化
    ///当然所处区域
    static var CURRENT_REGION: String {
        return NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
    }
}

public extension NSBundle {
    
    var applicationVersionNumber: String {
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "Version Number Not Available"
    }
    
    var applicationBuildNumber: String {
        if let build = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String {
            return build
        }
        return "Build Number Not Available"
    }
}
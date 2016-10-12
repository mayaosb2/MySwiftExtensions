//
//  MyUISwitchExtension.swift
//  FSZCItem
//  
//  Created by mrshan on 16/1/13.
//  Copyright © 2016年 Mrshan. All rights reserved.
//
//	        =       =         =====    =          =      =    =
//         = =     = =        =        =        =   =    ==   =
//        =   =   =   =       =====    =====    =====    =  = =
//       =     = =     =          =    =   =    =   =    =   ==
//      =       =       =     =====    =   =    =   =    =    =
//
//   GithubAddress:https://github.com/hatjs880328/…
//   connectMe:shanwenzheng@qq.com
//   corporation:JiNanDongzheng Information&Technology Co.,Ltd
//
import UIKit
import Foundation

var switchClosure:[Int:((ifOpen:Bool)->())] = [:]//这个数组的作用是保存每一个实例化对象的闭包，用哈希确保每一个KEY都是唯一的
extension UISwitch {
    
    public func switchValueChange(newAction:(ifOpen:Bool)->Void){
        addClosure(newAction)
        valueChange()
    }
    
    private func valueChange(){
        self.addTarget(self, action: "selfValueChange", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func selfValueChange(){
        executeClosure(self.on)
    }
    
    private func addClosure(newAction:(ifOpen:Bool)->Void){
        switchClosure[self.hashValue] = newAction
    }
    
    private func executeClosure(ifopen:Bool){
        let closure = switchClosure[self.hashValue]
        closure!(ifOpen:ifopen)
    }
}
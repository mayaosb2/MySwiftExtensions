//
//  MyViewControllerExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/7.
//  Copyright © 2015年 东正. All rights reserved.
//

import UIKit

var blockActionDict : [String : ( () -> () )] = [:]
extension UIView{
    /// 返回所在控制器
    /// :returns: 所在控制器
    func ViewController() -> UIViewController? {
        var next = self.nextResponder()
        while((next) != nil){
            if(next!.isKindOfClass(UIViewController.self)){
                
                let rootVc = next as! UIViewController
                return rootVc
                
            }
            next = next?.nextResponder()
        }
        return nil
    }
    
    /**
    view以及其子类的block点击方法
    - parameter action: 单击时执行的block
    */
    func tapActionsGesture(action:( () -> Void )){
        addBlock(action)//添加点击block
        whenTouchOne()//点击block
    }
    
    private func addBlock(block:()->()){
        //创建唯一标示  方便在点击的时候取出
//        blockActionDict[String(NSValue(nonretainedObject: self))] = block
        blockActionDict[String(self.hashValue)] = block
    }
    
    private func whenTouchOne(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: "tapActions")
        self.addGestureRecognizer(tapGesture)
    }
    
    /**
    私有方法，禁止调用
    */
    func tapActions(){
        //取出唯一标示 并执行block里面的方法
//        blockActionDict[String(NSValue(nonretainedObject:self))]!()
        blockActionDict[String(self.hashValue)]!()
    }
}


/// 全局变量 for Xib相关拓展属性
var defaultCornerRadius = "defaultCornerRadius"
var defaultBorderColor = "defaultBorderColor"
var defaultBorderWidth = "defaultBorderWidth"

var defaultShadowColor = "defaultShadowColor"
var defaultShadowOffset = "defaultShadowOffset"
var defaultShadowRadius = "defaultShadowRadius"
var defaultShadowOpacity = "defaultShadowOpacity"

// MARK: - Xib相关拓展属性
extension UIView{
    
    //MARK:圆角相关
    /// 圆角
    @IBInspectable var cornerRadiu: CGFloat{
        get{
            if(objc_getAssociatedObject(self, &defaultCornerRadius) == nil){
                objc_setAssociatedObject(self, &defaultCornerRadius, 0,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return 0
            }else{
                
                return objc_getAssociatedObject(self,&defaultCornerRadius) as! CGFloat
            }
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = true
            objc_setAssociatedObject(self, &defaultCornerRadius, newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    /// 边框颜色
    @IBInspectable var borderColor: UIColor{
        get{
            if(objc_getAssociatedObject(self, &defaultBorderColor) == nil){
                objc_setAssociatedObject(self, &defaultBorderColor, UIColor(),.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return UIColor()
            }else{
                
                return objc_getAssociatedObject(self,&defaultBorderColor) as! UIColor
            }
        }
        set{
            layer.borderColor = newValue.CGColor
            objc_setAssociatedObject(self, &defaultBorderColor, newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    /// 边框宽度
    @IBInspectable var borderWidth: CGFloat{
        get{
            if(objc_getAssociatedObject(self, &defaultBorderWidth) == nil){
                objc_setAssociatedObject(self, &defaultBorderWidth, 0,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return 0
            }else{
                
                return objc_getAssociatedObject(self,&defaultBorderWidth) as! CGFloat
            }
        }
        set{
            
            layer.borderWidth = newValue
            objc_setAssociatedObject(self, &defaultBorderWidth, newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    //MARK:阴影相关
    
    /// 阴影颜色
    @IBInspectable var shadowColor: UIColor{
        get{
            if(objc_getAssociatedObject(self, &defaultShadowColor) == nil){
                objc_setAssociatedObject(self, &defaultShadowColor, UIColor(),.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return UIColor()
            }else{
                
                return objc_getAssociatedObject(self,&defaultShadowColor) as! UIColor
            }
        }
        set{
            layer.shadowColor = newValue.CGColor
            objc_setAssociatedObject(self, &defaultShadowColor, newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    /// 阴影圆角
    @IBInspectable var shadowRadius: CGFloat{
        get{
            if(objc_getAssociatedObject(self, &defaultShadowRadius) == nil){
                objc_setAssociatedObject(self, &defaultShadowRadius, 0,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return 0
            }else{
                
                return objc_getAssociatedObject(self,&defaultShadowRadius) as! CGFloat
            }
        }
        set{
            layer.shadowRadius = newValue
            objc_setAssociatedObject(self, &defaultShadowRadius, newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    /// 阴影偏移量 x为正向右，y为正向下 这个方法无法获取属性
    @IBInspectable var shadowOffset: CGSize{
        get{
            
            return CGSize()
        }
        set{
            
            layer.shadowOffset = newValue
        }
    }
    
    /// 阴影透明度
    @IBInspectable var shadowOpacity: Float{
        get{
            if(objc_getAssociatedObject(self, &defaultShadowOpacity) == nil){
                objc_setAssociatedObject(self, &defaultShadowOpacity, 0,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return 0
            }else{
                
                return objc_getAssociatedObject(self,&defaultShadowOpacity) as! Float
            }
        }
        set{
            layer.shadowOpacity = newValue
            objc_setAssociatedObject(self, &defaultShadowOpacity, newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
}

// MARK: - 模态
extension UIViewController{
    ///是否模态
    public var isModal: Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
}

// MARK: - RunTime
//extension UIViewController{
//    public override class func initialize(){
//        struct Static{
//            static var token:dispatch_once_t = 0
//        }
//        if self != UIViewController.self{
//            return
//        }
//        dispatch_once(&Static.token, {
//            _ in
//            let viewDidLoad = class_getInstanceMethod(self, Selector("viewDidLoad"))
//            let viewDidLoaded = class_getInstanceMethod(self, Selector("myViewDidLoad"))
//            method_exchangeImplementations(viewDidLoad,viewDidLoaded)
//        })
//    }
//    func myViewDidLoad(){
//        self.myViewDidLoad()
//        print("\(self)在viewDidLoad创建了😄")
//    }
//}

// MARK: - 用block实现RunTime
//typealias _IMP = @convention(c)(id:AnyObject,sel:UnsafeMutablePointer<Selector>)->AnyObject
//typealias _VIMP = @convention(c)(id:AnyObject,sel:UnsafeMutablePointer<Selector>)->Void
//
//extension UIViewController{
//    public override class func initialize(){
//        struct Static{
//            static var token:dispatch_once_t = 0
//        }
//        if self != UIViewController.self{
//            return
//        }
//
//        dispatch_once(&Static.token, {
//            _ in
//            let viewDidLoad:Method = class_getInstanceMethod(self, Selector("viewDidLoad"))
//            let viewDidLoad_VIMP:_VIMP = unsafeBitCast(method_getImplementation(viewDidLoad),_VIMP.self)
//            let block:@convention(block)(UnsafeMutablePointer<AnyObject>,UnsafeMutablePointer<Selector>)->Void = {
//                (id,sel) in
//                viewDidLoad_VIMP(id: id.memory, sel: sel)
//                print("viewDidLoad func execu over id ---> \(id.memory)");
//            }
//            let imp:COpaquePointer = imp_implementationWithBlock(unsafeBitCast(block, AnyObject.self))
//            method_setImplementation(viewDidLoad,imp)
//        })
//    }
//}

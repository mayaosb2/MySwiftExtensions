//
//  MyCacheExtension.swift
//  FSZCItem
//
//  Created by 马耀 on 16/5/17.
//  Copyright © 2016年 Mrshan. All rights reserved.
//

import UIKit
struct MyCache {
    
    /// MARK: - 读取缓存大小
    static func readCacheSize(filePath: String = "/Library/Caches") -> String {
        
        let cacheFilePath = NSHomeDirectory() + filePath
        let cacheSize = forderSizeAtPath(cacheFilePath)/1024/1024
        return String(format: "%.2f", cacheSize) + "MB"
    }
    
    ///遍历所有目录及子目录
    static func forderSizeAtPath(folderPath: String) -> Double {
        let manage = NSFileManager.defaultManager()
        guard manage.fileExistsAtPath(folderPath) else { return 0 }
        let childFilePath = manage.subpathsAtPath(folderPath)!
        var fileSize:Double = 0
        for path in childFilePath {
            let fileAbsoluePath = folderPath + "/" + path
            fileSize += returnFileSzie(fileAbsoluePath)
        }
        return fileSize
    }
    
    ///处理每个文件路径下文件 —> 大小
    static func returnFileSzie(path: String) -> Double {
        let manage = NSFileManager.defaultManager()
        var fileSize:Double = 0
        do {
            fileSize = try manage.attributesOfItemAtPath(path)["NSFileSize"] as! Double
        } catch {
            print(error)
        }
        return fileSize
    }
    
    
    ///MARK: - 清除缓存
    static func cleanCache(filePath: String = "/Library/Caches", competion:() -> Void = { print("清除完毕") } ) {
        
        deleteFolder(NSHomeDirectory() + filePath)
        competion()
    }
    
    ///删除文件夹的所有文件
    static func deleteFolder(folderPath: String) {
        let manage = NSFileManager.defaultManager()
        guard manage.fileExistsAtPath(folderPath) else { return }
        let childFilePath = manage.subpathsAtPath(folderPath)
        for path in childFilePath! {
            let fileAbsoluePath = folderPath + "/" + path
            deleteFile(fileAbsoluePath)
        }
    }
    
    //删除单个文件
    static func deleteFile(path: String) {
        let manage = NSFileManager.defaultManager()
        do {
            try manage.removeItemAtPath(path)
        } catch {
            print(error)
        }
    }
}
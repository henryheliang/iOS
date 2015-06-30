//
//  CourierInfo.swift
//  Courier
//
//  Created by Henry on 15/6/24.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit

class Courier
{
    var username: String = ""
    var password: String = ""
    var isAutoLogin: Bool = false
    var didLoaded: Bool = false
    var userid:Int = 0
    
    func loadUserProfile()
    {
        username = NSUserDefaults.standardUserDefaults().stringForKey( "username" )!
        password = NSUserDefaults.standardUserDefaults().stringForKey("password")!
        isAutoLogin = NSUserDefaults.standardUserDefaults().boolForKey("autologin")
        
        didLoaded = true
    }
    
    func saveUserProfile()
    {
        NSUserDefaults.standardUserDefaults().setObject( username, forKey: "username" )
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: "password" )
        NSUserDefaults.standardUserDefaults().setBool(isAutoLogin, forKey: "autologin" )
    }
    
    init()
    {
        //加载用户缓存信息
        loadUserProfile()
    }
    
    deinit
    {
        //保存用户缓存信息
        saveUserProfile()
    }
}

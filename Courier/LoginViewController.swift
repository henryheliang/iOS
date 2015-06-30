//
//  loginViewController.swift
//  Courier
//
//  Created by Henry on 15/6/23.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController,HttpProtocol {
    

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var labelTips: UILabel!
    @IBOutlet weak var switchAutoLogin: UISwitch!
    @IBOutlet weak var buttonLogin: UIButton!
    
    //HTTP POST URL
    var url = ""
    
    //源视图代理句柄
    var sourceTVC:OrderTableViewController!
    
    //创建保存登录信息实例
    var courier:Courier = Courier()
    
    //为访问网络建立回调接口实例
    var cHttp:HttpController = HttpController()
    
    
    @IBAction func login(sender: AnyObject) {
        
        //校验用户是否输入用户名和密码
        if( tfUserName.text == "" || tfPassword.text == "" )
        {
                labelTips.text = "请输入用户名和密码!"
                return
        }
        
        //读取输入的用户信息
        courier.username = tfUserName.text!
        courier.password = tfPassword.text!
        courier.isAutoLogin = switchAutoLogin.on
        
        //提交登录请求
        cHttp.onLogin( url, username:courier.username, password:courier.password )
    }
    
    func loadUserProfile()
    {
        //清空登录提示信息
        labelTips.text = ""
        labelTips.textColor = UIColor.redColor()
        
        //检查是否之前有预配置信息
        if( courier.username != "" )
        {
            tfUserName.text = courier.username
            switchAutoLogin.on = courier.isAutoLogin
            
            if( courier.isAutoLogin ) { tfPassword.text = courier.password }
        }
    }
    
    func didHttpResponse(response: AnyObject) {
        
        //将返回数据翻译为JSON字典
        let json = JSON( response )
        
        //检查是否登录成功
        if json.count > 0 && json["command"].string == "login" {
            
            let subjson:JSON = json["data"]
            let loginid = subjson["loginid"].int
            
            if( loginid != nil ) {
                
                courier.userid = loginid!
                sourceTVC.loginid = loginid!
                
                self.dismissViewControllerAnimated( true, completion:nil )
                
                return
            }
        }
        
        labelTips.text = "登录信息错误，请重新输入！"
        if !buttonLogin.enabled { buttonLogin.enabled = true }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserProfile()
        
        cHttp.delegate = self
    }
    
    override func viewDidAppear( animated: Bool ){
        super.viewDidAppear( animated )
        
        //是否需要自动登录
        if courier.isAutoLogin {
            labelTips.text = "正在自动登录，请稍后。。。"
            buttonLogin.enabled = false
            cHttp.onLogin( url, username:courier.username, password:courier.password)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

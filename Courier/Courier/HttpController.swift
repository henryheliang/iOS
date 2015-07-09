//
//  HttpController.swift
//  Courier
//
//  Created by Henry on 15/6/20.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit
import Alamofire

protocol HttpProtocol{
    //定义一个方法接收回应数据
    func didHttpResponse(respone:AnyObject)
}


class HttpController: NSObject {
    
    //定义一个可选代理
    var delegate:HttpProtocol?
    
    //定义一个方法运过来获取网络数据，接收参数为网址
    func onSearch(url:String, Parameters: [String : AnyObject],  Encoding: Alamofire.ParameterEncoding = Alamofire.ParameterEncoding.URL )
    {
    
        /*
        Alamofire.request(.POST,  URLString: "http://10.0.0.2:88/dl/data2.php",
            parameters: ["command":"login","username": "henry", "password":"helloworld"], encoding: Encoding )
            .responseJSON(options: NSJSONReadingOptions.MutableContainers ) { (request, response, data, error) in
                print( "request: \(request)" )
                print( "response: \(response)" )
                if data != nil {
                    let json = JSON(data!)
                    print( "count:\(json.count)" )
                    print( "data: \(json)" )
                }
                print( "error: \(error)" )
        }
        */
    
        Alamofire.request(.POST, URLString:url, parameters: Parameters, encoding: Encoding ).responseJSON(options: NSJSONReadingOptions.MutableContainers ) { (request, response, data, error) -> Void in
            
            print( "HTTP request: \(request)" )
            print( "HTTP response: \(response)" )
            
            if data != nil {
                let json = JSON(data!)
                print( "data: \(json)" )
                self.delegate?.didHttpResponse(data!)
            }
            else{
                print( "HTTP error: \(error)" )
            }
        }
    }
    
    
    //定义带参数POST登录方法
    func onLogin( url:String, username:String, password:String )
    {
        let parameters = ["command":"login","username":username, "password":password]
        onSearch(url, Parameters: parameters )
    }
    
    //定义带参数POST获取列表方法
    func onOrderList( url:String, status:Int, loginID:Int )
    {
        let parameters = [ "command":"orderlist", "orderstatus":"\(status)", "loginid":"\(loginID)"]
        onSearch( url, Parameters: parameters )
    }
    
    //定义带参数更新订单状态方法
    func OnUpdateOrder( url:String, status:Int, loginID:Int, OrderID:String )
    {
        let parameters = ["command":"updateorder", "orderstatus":"\(status)", "loginid":"\(loginID)", "orderid":"\(OrderID)"]
        onSearch( url, Parameters: parameters )
    }
}

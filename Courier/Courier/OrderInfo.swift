//
//  OrderInfo.swift
//  Courier
//
//  Created by Henry on 15/6/25.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit

class Order{
    //订单ID
    var orderID:String = ""
    //配送员ID
    var courierID:Int = 0
    //下单时间
    var orderTime:NSDate!
    //配送时间
    var expressTime:NSDate!
    //联系人
    var userName:String = ""
    //联系电话
    var mobileNo:String = ""
    //支付金额
    var payment:Float = 0.0
    //支付方式
    var payType = 1
    //配送区域
    var location:String = ""
    //配送地址
    var address:String = ""
    //订单状态
    var orderStatus:Int = 0
}

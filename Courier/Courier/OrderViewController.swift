//
//  OrderViewController.swift
//  Courier
//
//  Created by Henry on 15/6/24.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    var didLogin: Bool = false
    var username: String?
    var orders:[Order] = []
    
    /* 应用外呼拨号用例
    {
        let url1 = NSURL(string: "tel://13060088922")
        UIApplication.sharedApplication().openURL(url1!)
    }
    */
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var orderTypeSegmentedControl: UISegmentedControl!
    
    //预置Demo数据进行展示
    func loadSampleOrders()
    {
        let newOrder = Order()
        for var i=0; i<6; i++
        {
            newOrder.address = "5-301"
            newOrder.location = "中国成都南城都汇1期"
            newOrder.mobileNo = "13012345678"
            newOrder.expressTime = NSDate()
            newOrder.userName = "刚哥"
            newOrder.payment = (Float)("20")!
            newOrder.payType = 1
            newOrder.orderStatus = 1
            
            orders.append( newOrder )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载订单列表
        //loadSampleOrders()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear( animated )
        
        //启动以后默认进去登录界面进行用户认证
        if !didLogin
        {
            self.performSegueWithIdentifier("loginSegue", sender: self)
            didLogin = true
        }
        else{
            loadSampleOrders()
            orderTableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath) as! orderTableViewCell
        
        let order = orders[indexPath.row]
        cell.labelExpressTime.text = "配送时间：\(order.expressTime)"
        cell.labelAddress.text = "配送地址：\(order.location) \(order.address)"
        cell.labelContact.text = "联系方式：\(order.userName) \(order.mobileNo)"
        if( order.payType == 1 ){
            cell.labelPayment.text = "付款信息：\(order.payment) (货到付款)"
        }
        else{
            cell.labelPayment.text = "付款信息：\(order.payment) (在线支付)"
        }
        
        return cell
    }
    
    func tableView( tableView: UITableView, commitEditingStyle editingStyle:UITableViewCellEditingStyle, forRowAtIndexPath indexPath:NSIndexPath ) {
        if editingStyle == .Delete {
            orders.removeAtIndex( indexPath.row )
            tableView.deleteRowsAtIndexPaths( [indexPath], withRowAnimation: .Fade )
        } else if editingStyle == .Insert {
            
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "开始配送"
    }
 }

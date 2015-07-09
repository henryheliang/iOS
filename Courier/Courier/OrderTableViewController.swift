//
//  OrderTableViewController.swift
//  Courier
//
//  Created by Henry on 15/6/29.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController,HttpProtocol {
    
    var didLogin: Bool = false
    var username: String = ""
    var loginid: Int = 0
    var orders:[Order] = []
    var refreshTime = NSDate()
    //var array:[[Order]] = [[]]
    
    @IBOutlet weak var orderTypeSC: UISegmentedControl!
    @IBAction func onPhoneCall(sender: UIButton) {
        
        let cell = sender.superview?.superview as! orderTableViewCell
        let indexPath = self.tableView.indexPathForCell( cell )
        let url1 = NSURL( string: "tel://\(orders[(indexPath!.row)].mobileNo)" )
        
        UIApplication.sharedApplication().openURL( url1! )
    }
    
    //HTTP POST URL
    let url = "http://dalinoo.com/dl/appdata.php"
    
    //为访问网络建立回调接口实例
    var cHttp:HttpController = HttpController()
    
    /* 应用外呼拨号用例
    {
    let url1 = NSURL(string: "tel://13060088922")
    UIApplication.sharedApplication().openURL(url1!)
    }
    */
    @IBAction func orderListChanged(sender: AnyObject) {
        
        let segment:UISegmentedControl = sender as! UISegmentedControl
        
        cHttp.onOrderList( url, status: segment.selectedSegmentIndex+1, loginID: loginid )
    }
    
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
    
    func loadOrderList( json:JSON )
    {
        var orderdata:JSON!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        orders.removeAll()
        
        for var i = 0; i<json.count; i++ {
                
            let newOrder = Order()
            orderdata = json[i]
                
            newOrder.mobileNo = orderdata["mobile_no"].stringValue
            newOrder.orderID = orderdata["order_id"].stringValue
            newOrder.payment = orderdata["order_amount"].floatValue
            newOrder.payType = orderdata["order_type"].intValue
            newOrder.userName = orderdata["user_name"].stringValue
            newOrder.orderTime = dateFormatter.dateFromString( orderdata["order_time"].stringValue )
            newOrder.expressTime = dateFormatter.dateFromString( orderdata["send_time"].stringValue )
            newOrder.orderStatus = orderTypeSC.selectedSegmentIndex+1
            newOrder.location = orderdata["location_name"].stringValue
            newOrder.address = orderdata["address_info"].stringValue
                
            orders.append( newOrder )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderTypeSC.selectedSegmentIndex = 0
        orderTypeSC.setTitle( "未接单", forSegmentAtIndex: 0 )
        orderTypeSC.setTitle( "已接单", forSegmentAtIndex: 1 )
        
        cHttp.delegate = self
        
        self.refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged )
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        refreshControl!.attributedTitle = NSAttributedString( string: "上次刷新时间：\(dateFormatter.stringFromDate(NSDate()))" )
        self.tableView.addSubview( refreshControl! )
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
            //获取订单数据
            cHttp.onOrderList( url, status: orderTypeSC.selectedSegmentIndex+1, loginID: loginid)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath) as! orderTableViewCell
        
        let dateformat = NSDateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let order = orders[indexPath.row]
        cell.labelExpressTime.text = "配送时间：\(dateformat.stringFromDate(order.expressTime))"
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
    
    override func tableView( tableView: UITableView, commitEditingStyle editingStyle:UITableViewCellEditingStyle, forRowAtIndexPath indexPath:NSIndexPath ) {
        
        if editingStyle == .Delete {
            
            cHttp.OnUpdateOrder( url, status: orders[indexPath.row].orderStatus+1, loginID: loginid, OrderID: orders[indexPath.row].orderID )
            
            orders.removeAtIndex( indexPath.row )
            tableView.deleteRowsAtIndexPaths( [indexPath], withRowAnimation: .Fade )
            
            self.tableView.reloadData()
            
            let index = orderTypeSC.selectedSegmentIndex
            switch  index {
                case 0: orderTypeSC.setTitle( "未接单 (\(orders.count))", forSegmentAtIndex: index )
                case 1: orderTypeSC.setTitle( "已接单 (\(orders.count))", forSegmentAtIndex: index )
            default: print( "已完成" )
            }

            
        } else if editingStyle == .Insert {
            
        }
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        switch orderTypeSC.selectedSegmentIndex {
        case 0: return "开始配送"
        case 1: return "配送完成"
        default:
            return "完成"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let loginVC = segue.destinationViewController as! LoginViewController
        loginVC.sourceTVC = self
        loginVC.url = url
    }
    
    func didHttpResponse(response: AnyObject) {
        
        //将返回数据翻译为JSON字典
        let json = JSON( response )
        
        if json["command"].stringValue == "orderlist" {
            loadOrderList( json["data"] )
            
            self.tableView.reloadData()
            
            let index = orderTypeSC.selectedSegmentIndex
            let subJson = json["data"]
            switch  index {
                case 0: orderTypeSC.setTitle( "未接单 (\(subJson.count))", forSegmentAtIndex: index )
                case 1: orderTypeSC.setTitle( "已接单 (\(subJson.count))", forSegmentAtIndex: index )
                default: print( "已完成" )
            }
        }
        else if json["command"].stringValue == "updateorder" {
          //  let subJson:JSON = json["data"] as JSON
         /*
            if subJson["orderid"].stringValue != nil
            {
                
            }
        */
        }
    }
    
    func refresh()
    {
        self.refreshControl?.endRefreshing()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        refreshControl!.attributedTitle = NSAttributedString( string: "上次刷新时间：\(dateFormatter.stringFromDate(NSDate()))" )
        
        cHttp.onOrderList( url, status: orderTypeSC.selectedSegmentIndex+1, loginID: loginid )
    }
}
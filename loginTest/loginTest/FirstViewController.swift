//
//  FirstViewController.swift
//  loginTest
//
//  Created by Henry on 15/6/25.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var isLogin:Bool = false
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidAppear(animated: Bool) {
        if !isLogin
        {
            isLogin = true
            self.performSegueWithIdentifier( "login", sender: self )
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as UITableViewCell
        
        return cell
    }

}

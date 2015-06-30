//
//  demoViewController.swift
//  demoshow
//
//  Created by Henry on 15/6/25.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit

class demoViewController: UIViewController {
    
    @IBOutlet weak var demoTableView: UITableView!

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("demoCell", forIndexPath: indexPath) as UITableViewCell
        
        return cell
    }
}

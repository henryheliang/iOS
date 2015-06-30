//
//  ViewController.swift
//  callTest
//
//  Created by Henry on 15/6/26.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func callTest(sender: UIButton) {
        let url1 = NSURL(string: "tel://13060088922")
        UIApplication.sharedApplication().openURL(url1!)
        
        let callView:UIWebView = UIWebView()
        let request = NSURLRequest( URL: url1! )
        
        callView.loadRequest( request )
        self.view.addSubview( callView )
        callView.
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


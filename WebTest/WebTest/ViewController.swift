//
//  ViewController.swift
//  WebTest
//
//  Created by Henry on 15/6/19.
//  Copyright © 2015年 Henry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBAction func goWeb(sender: AnyObject) {
        let url = NSURL( string: "http://www.baidu.com" )
        let request = NSURLRequest( URL:url! )
        webView.loadRequest( request)
        
        print( url )
        
        print( request.description )
        
        print( "go go go!!!" )
        
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


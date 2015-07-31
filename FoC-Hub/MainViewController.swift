//
//  ViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit
import Darwin

var alert = "None"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Redirects to a new view controller handling the news feed
    @IBAction func browsePosts(sender: AnyObject) {
        
    }
    
    @IBAction func mapRedirect(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yc.norbye.com/includes/social.php")!)
        
    }
    
    //Redirects the user to a webpage
    @IBAction func redirectToWebpage(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yc.norbye.com/")!)
    }
    
    

}


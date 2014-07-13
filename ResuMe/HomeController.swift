//
//  PrincipalController.swift
//  ResuMe
//
//  Created by Joel Humberto Gómez Paredes on 13/07/14.
//  Copyright (c) 2014 Joel Humberto Gómez Paredes. All rights reserved.
//

import UIKit
import QuartzCore

class HomeController: UIViewController {
    
    
    @IBOutlet var meImage : UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meImage.layer.cornerRadius = meImage.frame.width/2
        meImage.layer.masksToBounds = true;
        
        // Now escape anything else that isn't URL-friendly
        
        var urlPath = "https://script.google.com/macros/s/AKfycbyx9FM2Athv6v0yuKzES1jZI7sCdqbY3mbtcnzrdnSblsmh0AQ/exec"
        var url: NSURL = NSURL(string: urlPath)
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if(error) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err?) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            var results: NSArray = jsonResult["cursos"] as NSArray
            dispatch_async(dispatch_get_main_queue(), {
               println(results.count)
                })
            })
        task.resume()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle()->UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }

}

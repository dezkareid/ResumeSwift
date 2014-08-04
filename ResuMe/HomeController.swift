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
    
    
    @IBOutlet weak var meImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meImage.layer.cornerRadius = meImage.frame.width/2
        meImage.layer.masksToBounds = true;
        
        
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

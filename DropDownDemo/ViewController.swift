//
//  ViewController.swift
//  DropDownDemo
//
//  Created by Brian Heller on 10/28/15.
//  Copyright © 2015 Reaper Sofware Solution. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menu: BHDropDownMenu!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        menu.backgroundColor = self.view.backgroundColor!
        menu.barColor = UIColor.whiteColor()
        menu.setBars(3)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        menu.parentWidth = self.view.frame.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


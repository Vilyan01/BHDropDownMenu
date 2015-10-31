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
        let btnArray = NSArray(array: ["Test", "Test2", "Test3", "Test4"])
        let segueArray = NSArray(array: ["One","Two","Three","Four"])
        menu.parentVC = self
        menu.setSegues(segueArray)
        menu.setButtons(btnArray)
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


//
//  BHDropDownMenu.swift
//  DropDownDemo
//
//  Created by Brian Heller on 10/28/15.
//  Copyright © 2015 Reaper Sofware Solution. All rights reserved.
//

import UIKit

class BHDropDownMenu: UIView {
    
    var barColor:UIColor = UIColor.blackColor()
    var parentWidth:CGFloat = 383.0 // standard for iphone 6, I believe
    var extendedHeight:Int = 160
    var origHeight:Int?
    
    var parentVC:UIViewController?
    
    let menuBars:NSMutableArray = NSMutableArray()
    let menuItems:NSMutableArray = NSMutableArray()
    let menuSegues:NSMutableArray = NSMutableArray()
    
    var stage0Frame:CGRect?
    var stage1Frame:CGRect?
    
    //var closeMenuButton:UIView?
    
    func setButtons(btnNames:NSArray) {
        //closeMenuButton = UIView(frame: self.frame)
        setBars(btnNames.count - 1)
        var count = 0
        for btnName in btnNames {
            let btnFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
            let btn = UIButton(frame: btnFrame)
            btn.setTitle(btnName as? String, forState: UIControlState.Normal)
            btn.setTitleColor(barColor, forState: UIControlState.Normal)
            btn.addTarget(self, action: "performAction:", forControlEvents: UIControlEvents.TouchUpInside)
            btn.tag = count
            btn.hidden = true
            menuItems.addObject(btn)
            self.addSubview(btn)
            count++
        }
        //self.addSubview(closeMenuButton!)
        //closeMenuButton!.hidden = true
    }
    
    func setSegues(segues:NSArray) {
        for segue in segues {
            menuSegues.addObject(segue)
        }
    }
    
    private func setBars(numBars:Int) {
        let height = Int(self.frame.height)
        let spacing = height / (numBars + 1)
        extendedHeight = ((numBars + 1) * 40) + Int(self.frame.height)
        origHeight = Int(self.frame.height)
        for(var i = 0; i < numBars; i++) {
            let yPos = (i + 1) * spacing
            let frame = CGRect(x: 5, y: yPos, width: Int(self.frame.width) - 10, height: 1)
            let bar : UIImageView = UIImageView(frame: frame)
            bar.backgroundColor = barColor
            menuBars.addObject(bar)
            self.addSubview(bar)
            //closeMenuButton?.addSubview(bar)
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let tap = UITapGestureRecognizer(target: self, action: "startAnimation")
        self.addGestureRecognizer(tap)
        self.stage0Frame = self.frame
    }
    
    func startAnimation() {
        NSLog("Tapped menu")
        self.animateOut()
    }
    
    func performAction(sender:UIButton) {
        let ind = sender.tag
        if let validVC = parentVC {
            fadeOut()
            //let segueTitle = menuSegues.objectAtIndex(ind) as! String
            //validVC.performSegueWithIdentifier(segueTitle, sender: self)
        }
    }
}

// #MARK - Animations
extension BHDropDownMenu {
    func animateOut() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            let newFrame = CGRect(x: 0, y:0 , width: Int(self.parentWidth), height: Int(self.frame.height))
            self.frame = newFrame
            for(var i = 0; i < self.menuBars.count; i++) {
                let curMenuBar = self.menuBars.objectAtIndex(i) as! UIImageView
                let newBarFrame = CGRect(x: 5, y: Int(curMenuBar.frame.origin.y), width: Int(self.parentWidth) - 10, height: 1)
                curMenuBar.frame = newBarFrame
            }
            }) { (comp) -> Void in
                if(comp == true) {
                    NSLog("Done animating out, now animate down")
                    self.stage1Frame = self.frame
                    self.animateDown()
                }
        }
    }
    
    func animateDown() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            let newFrame = CGRect(x: 0, y:0 , width: Int(self.parentWidth), height: self.extendedHeight)
            self.frame = newFrame
            let newHeight = self.extendedHeight - self.origHeight!
            let newSpacing = newHeight / (self.menuBars.count + 1)
            NSLog("New Spacing = \(newSpacing)")
            for(var i = 0; i < self.menuBars.count; i++) {
                let curMenuBar = self.menuBars.objectAtIndex(i) as! UIImageView
                let newYPos = ((i + 1) * newSpacing) + self.origHeight!
                let newBarFrame = CGRect(x: 5, y: newYPos, width: Int(self.parentWidth) - 10, height: 1)
                curMenuBar.frame = newBarFrame
            }
            
            var yPos = self.origHeight!
            for(var i = 0; i < self.menuItems.count; i++) {
                let curBtn = self.menuItems.objectAtIndex(i) as! UIButton
                let newBtnFrame = CGRect(x: 0, y: yPos, width: Int(self.parentWidth), height: 40)
                curBtn.frame = newBtnFrame
                yPos += 40
            }

            }) { (done) -> Void in
                NSLog("Done!")
                if(done == true) {
                    let path = UIBezierPath(rect: self.bounds)
                    self.layer.masksToBounds = false
                    self.layer.shadowColor = UIColor.blackColor().CGColor
                    self.layer.shadowOffset = CGSizeMake(0.0, 0.5)
                    self.layer.shadowOpacity = 0.5
                    self.layer.shadowPath = path.CGPath
                    self.fadeIn()
                }
        }
    }
    
    func fadeIn() {
        UIView.animateWithDuration(1.0) { () -> Void in
            for(var i = 0; i < self.menuItems.count; i++) {
                let curMenuItem = self.menuItems.objectAtIndex(i) as! UIButton
                curMenuItem.hidden = false
            }
            //self.closeMenuButton!.hidden = false
        }
    }
    
    func fadeOut() {
        self.layer.shadowOpacity = 0
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            for(var i = 0; i < self.menuItems.count; i++) {
                let curMenuItem = self.menuItems.objectAtIndex(i) as! UIButton
                curMenuItem.hidden = true
            }
            }) { (succ) -> Void in
                self.animateUp()
        }
    }
    
    func animateUp() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = self.stage1Frame!
            let spacing = self.origHeight! / (self.menuBars.count + 1)
            for(var i = 0; i < self.menuBars.count; i++) {
                let curMenuBar = self.menuBars.objectAtIndex(i) as! UIImageView
                let newYPos = (i + 1) * spacing
                let barFrame = CGRect(x: 5, y: newYPos, width: Int(self.frame.width) - 10, height: 1)
                curMenuBar.frame = barFrame
            }
            }) { (succ) -> Void in
                self.animateIn()
        }
    }
    
    func animateIn() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = self.stage0Frame!
            for(var i = 0; i < self.menuBars.count; i++) {
                let curMenuBar = self.menuBars.objectAtIndex(i) as! UIImageView
                let barFrame = CGRect(x: 5, y: Int(curMenuBar.frame.origin.y), width: self.origHeight! - 10, height: 1)
                curMenuBar.frame = barFrame
            }
            }) { (succ) -> Void in
                
        }
    }
}

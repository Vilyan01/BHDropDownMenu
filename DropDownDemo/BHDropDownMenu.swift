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
    
    let menuBars:NSMutableArray = NSMutableArray()
    
    func setBars(numBars:Int) {
        let height = Int(self.frame.height)
        let spacing = height / (numBars + 1)
        extendedHeight = ((numBars + 1) * 40) + Int(self.frame.height)
        origHeight = Int(self.frame.height)
        for(var i = 0; i < numBars; i++) {
            let yPos = (i + 1) * spacing
            let frame = CGRect(x: 5, y: yPos, width: Int(self.frame.width) - 10, height: 1)
            let bar : UIImageView = UIImageView(frame: frame)
            bar.backgroundColor = self.barColor
            menuBars.addObject(bar)
            self.addSubview(bar)
        }
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let tap = UITapGestureRecognizer(target: self, action: "startAnimation")
        self.addGestureRecognizer(tap)
        //setBars(3)
    }
    
    func startAnimation() {
        NSLog("Tapped menu")
        self.animateOut()
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
            for(var i = 0; i < self.menuBars.count; i++) {
                let curMenuBar = self.menuBars.objectAtIndex(i) as! UIImageView
                let newYPos = ((i + 1) * newSpacing) + self.origHeight!
                let newBarFrame = CGRect(x: 5, y: newYPos, width: Int(self.parentWidth) - 10, height: 1)
                curMenuBar.frame = newBarFrame
            }

            }) { (done) -> Void in
                NSLog("Done!")
        }
    }
}

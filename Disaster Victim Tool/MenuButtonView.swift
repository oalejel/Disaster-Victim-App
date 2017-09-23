//
//  MenuButtonView.swift
//  Disaster Victim Tool
//
//  Created by Omar Al-Ejel on 9/23/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit

class MenuButtonView: UIView {
    var menuViewController: ViewController!
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //add a gesture recognizer to take our custom touches
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        
    }
    
    @objc func tapped(thing: MenuButtonView) {
        print("tapped")
        rescaleButton()
        menuViewController.mapButtonViewPressed()
    }
    
    var completedSqueeze = true
    var pendingOut = false
    
    var shrinkTime = 0.2 ///animation time when shrinking
    var expandTime = 0.2 ///animation time when expanding
    
    var standardCornerRadius: CGFloat = 10
    
    //    override var backgroundColor: UIColor? {
    //        didSet {
    //            //nice to implement later on... update needed!
    //           testForWhite()
    //        }
    //    }
    
    ///Looks best when corners are round
    init(frame: CGRect, cornerRadius: CGFloat) {
        super.init(frame: frame)
        layer.cornerRadius = cornerRadius
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = standardCornerRadius
    }
    
    func setBordered() {
        layer.borderColor = ThemeRed.cgColor
        layer.borderWidth = 3
    }
    
    //    func testForWhite() {
    //        if (backgroundColor?.cgColor.components == UIColor.white.cgColor) {
    //
    //        }
    //    }
    
    ///Animates in when touches begin
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        press()
    }
    
    ///animates out when touch ends
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        rescaleButton()
    }
    
    func press() {
        UIView.animateKeyframes(withDuration: shrinkTime, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: { () -> Void in
            self.completedSqueeze = false
            self.transform = self.transform.scaledBy(x: 0.9, y: 0.9)
        }) { (done) -> Void in
            self.completedSqueeze = true
            if self.pendingOut {
                self.rescaleButton()
                self.pendingOut = false
            }
        }
    }
    
    func rescaleButton() {
        if completedSqueeze {
            UIView.animateKeyframes(withDuration: expandTime, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: { () -> Void in
                self.transform = self.transform.scaledBy(x: 1/0.9, y: 1/0.9)
            }) { (done) -> Void in
                ///completion work once it rescales
            }
        } else {
            pendingOut = true
        }
    }

    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  ViewController.swift
//  Disaster Victim Tool
//
//  Created by Omar Al-Ejel on 9/23/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapButtonView: MenuButtonView!
    
    @IBOutlet weak var mapImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapImageView.layer.cornerRadius = 10
        mapImageView.layer.masksToBounds = true
        
        mapButtonView.menuViewController = self
    }
    
    func mapButtonViewPressed() {
        performSegue(withIdentifier: "showVictimSearch", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


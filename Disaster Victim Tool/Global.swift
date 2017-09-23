//
//  Global.swift
//  speak2me
//
//  Created by Omar Al-Ejel on 9/15/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("button pressed: " + (self.titleLabel?.text ?? "label has no title"))
        super.touchesBegan(touches, with: event)
    }
}

public let ThemeRed = UIColor(red: 0.910, green: 0.043, blue: 0.122, alpha: 1)

var country = ""
var city = ""
var state = ""
var context = ""

func saveSettings() {
    let locationComponents = ["country": country, "city": city, "state": state, "context": context]
    NSKeyedArchiver.archiveRootObject(["locationsettings":locationComponents], toFile: settingsArchivePath().path)
}

func getSettings() {
    let dict = NSKeyedUnarchiver.unarchiveObject(withFile: settingsArchivePath().path) as? [String:AnyObject]
    if let locationComponents = dict?["locationsettings"] as? [String:String] {
        if let _country = locationComponents["country"] {
            country = _country
            if let _state = locationComponents["state"] {
                state = _state
                if let _city = locationComponents["city"] {
                    city = _city
                    if let _context = locationComponents["context"] {
                        context = _context
                    }
                }
            }
        }
    }
}

func settingsArchivePath() -> URL {
    let documentDirectories = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentDirectory = documentDirectories.first
            let x = documentDirectory! + "/customsettings.plist"
            return URL(string: x)!
    
//    let fm = FileManager.default
//    var containerURL = fm.containerURL(forSecurityApplicationGroupIdentifier: "group.athanUtil")
//    containerURL = containerURL?.appendingPathComponent("customsettings.plist")
//    return containerURL!
}

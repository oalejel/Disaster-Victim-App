//
//  DatabaseManager.swift
//  Disaster Victim Tool
//
//  Created by Omar Al-Ejel on 9/23/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit
import Firebase

@objc class DatabaseManager: NSObject {
    @objc static let sharedInstance: DatabaseManager! = DatabaseManager()
    //do not use this in student mode – you should eventually make this code safer
    
    
    var ref: DatabaseReference!
    var transcriptDict: [String:String] = [:]
    
    override init() {
        ref = Database.database().reference()
    }
    
    @objc public func setupDatabaseEntry() {
//        transcriptDict["lang"] = streamingLanguageCode
//        ref.child("instructors").child(instructorCode).setValue(["lang":streamingLanguageCode])
    }
    
    @objc public func clearSession() {
    }
    
    func setupDatabaseListener() {
        
        //setup streamingLanguageCode
        //        let langDatabaseRef = ref.child("instructors").child(instructorCode).child("lang").key
        //        print("&&&&" + langDatabaseRef)
        
        //        streamingLanguageCode = (ref.child("instructors").child(instructorCode).child("lang") as? String) ?? "en-US"
        //        print("----- THE LANGUAGE CODE::::: " + streamingLanguageCode);
        //ref.child("instructors").observeSingleE
//        ref.child("instructors").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            let d = snapshot.value as! [String:[String:String]]
//            //            print(d[self.instructorCode])
//            //            self.streamingLanguageCode = arr.object(forKey: "lang") as? String ?? "en-US"
//
//            self.streamingLanguageCode = d[self.instructorCode]?["lang"]
//            print("our langauge is: ")
//            print(self.streamingLanguageCode)//((snapshot.value as! NSArray).object(at: ) as? String ?? "errrrrrr"))
//        }) { (error) in
//            print(error)
//        }
        
//        ref.child("instructors").child(instructorCode).observe(.childAdded, with: { (snapshot) in
//            let untranslatedString = (snapshot.value as! String)
//            print("utranslated input: " + untranslatedString)
//        })
    }
    
    @objc public func post(text: String) {
//        transcriptDict["\(lastEntryIndex)"] = text
//        ///!!!make this line not have to reset the entire array every tiem -- NOT EFFICENT!!
//        ref.child("instructors").child(instructorCode).setValue(transcriptDict)
//        lastEntryIndex += 1
    }
    
    //    func sendTranscriptClip
}


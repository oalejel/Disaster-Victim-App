//
//  DatabaseManager.swift
//  Disaster Victim Tool
//
//  Created by Omar Al-Ejel on 9/23/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit
import Firebase

struct UtilityRating {
//    var locationString = ""
    var hasElectricity = false
    var hasFood = false
    var hasWater = false
}

struct PersonActivity {
    var name = ""
    var status = 2
    var location = ""
}


@objc class DatabaseManager: NSObject {
    @objc static let sharedInstance: DatabaseManager! = DatabaseManager()
    //do not use this in student mode – you should eventually make this code safer
    
    var ref: DatabaseReference!
    var transcriptDict: [String:String] = [:]
    
    var mapController: VictimsMapViewController?
    
    var locationsRatings: [String:UtilityRating] = [:]
    var peopleActivities: [String:PersonActivity] = [:]
    
    override init() {
        ref = Database.database().reference()
    }
    
    @objc public func clearSession() {
        //TODO
    }
    

    
    func setupDatabaseListener(buildings: Bool) {
        if buildings {
            ref.child("DataType").child("Buildings").child(state.lowercased()).observe(.value, with: { (snapshot) in
                
                if let citiesDict = (snapshot.value as? NSDictionary) {
                    print("first item in single time snapshot: ")
                    print(citiesDict)
                    if let sublocationsDict = citiesDict.object(forKey: city.lowercased()) as? NSDictionary {
                        print(sublocationsDict)
                        if let sublocationNames = sublocationsDict.allKeys as? [String] {
                            print(sublocationNames)
                            for sublocation in sublocationNames {
                                if let sublocationInfoDict = sublocationsDict[sublocation] as? NSDictionary {
                                    if let utilityDict = sublocationInfoDict["utilities"] as? NSDictionary {
                                        var rating = UtilityRating()
                                        let locString = "\(sublocation), \(city), \(state), \(country)"
                                        if let electricity = utilityDict["electricity"] as? Bool {
                                            rating.hasElectricity = electricity
                                        }
                                        if let food = utilityDict["food"] as? Bool {
                                            rating.hasFood = food
                                        }
                                        if let water = utilityDict["water"] as? Bool {
                                            rating.hasWater = water
                                        }
                                        
                                        if self.locationsRatings.index(forKey: locString) != nil {
                                            // if it doesnt match exactly, then tell the map controller that there should be an update
                                            if !(rating.hasElectricity == self.locationsRatings[locString]?.hasElectricity && rating.hasFood == self.locationsRatings[locString]?.hasFood && rating.hasWater == self.locationsRatings[locString]?.hasWater) {
                                                self.locationsRatings[locString] = rating
                                                self.mapController?.updateLocationInfo(locationString: locString)
                                            } else {
                                                //if they are exactly the same, do nothing
                                            }
                                        } else {
                                            self.locationsRatings[locString] = rating
                                            self.mapController?.addLocation(locationString: locString)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            })
        } else {
            //if we're listening for changes to people in the area...
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            ref.child("DataType").child("People").child(state.lowercased()).observe(.value, with: { (snapshot) in
                
                if let citiesDict = (snapshot.value as? NSDictionary) {
                    print("first item in single time snapshot: ")
                    print(citiesDict)
                    if let phoneNumbersDict = citiesDict.object(forKey: city.lowercased()) as? NSDictionary {
                        print(phoneNumbersDict)
                        if let phoneNumbers = phoneNumbersDict.allKeys as? [String] {
                            print(phoneNumbers)
                            for phoneNum in phoneNumbers {
                                if let userDict = phoneNumbersDict[phoneNum] as? NSDictionary {
//                                    if let utilityDict = sublocationInfoDict["utilities"] as? NSDictionary {
                                        var activity = PersonActivity()
//                                        let locString = "\(sublocation), \(city), \(state), \(country)"
                                        if let location = userDict["location"] as? String {
                                            activity.location = location
                                        }
                                        if let name = userDict["name"] as? String {
                                            activity.name = name
                                        }
                                        if let status = userDict["status"] as? Int {
                                            activity.status = status
                                        }

                                        if self.peopleActivities.index(forKey: phoneNum) != nil {
                                            // if it doesnt match exactly, then tell the map controller that there should be an update
                                            if !(activity.name == self.peopleActivities[phoneNum]?.name && activity.location == self.peopleActivities[phoneNum]?.location && activity.status == self.peopleActivities[phoneNum]?.status) {
                                                self.peopleActivities[phoneNum] = activity
                                                self.mapController?.updatePersonInfo(num: phoneNum)
                                            } else {
                                                //if they are exactly the same, do nothing
                                            }
                                        } else {
                                            self.peopleActivities[phoneNum] = activity
                                            self.mapController?.addPerson(phoneNum: phoneNum)
                                        }
//                                    }
                                }
                            }
                        }
                    }
                }
            })
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
    }
}

















//                let langDatabaseRef = ref.child("random test - confirms iphoen connecting").setValue("ok")

//                print("&&&&" + langDatabaseRef)

//        streamingLanguageCode = (ref.child("instructors").child(instructorCode).child("lang") as? String) ?? "en-US"
//        print("----- THE LANGUAGE CODE::::: " + streamingLanguageCode);
//ref.child("instructors").observeSingleE

//TODO: add organization by country
//        ref.child("DataType").child("Buildings").child(state.lowercased()).observeSingleEvent(of: .value, with: { (snapshot) in
//            if let citiesDict = (snapshot.value as? NSDictionary) {
//                print("first item in single time snapshot: ")
//                print(citiesDict)
//                if let sublocationsDict = citiesDict.object(forKey: city.lowercased()) as? NSDictionary {
//                    print(sublocationsDict)
//                    if let sublocationNames = sublocationsDict.allKeys as? [String] {
//                        print(sublocationNames)
//                        for sublocation in sublocationNames {
//                            if let sublocationInfoDict = sublocationsDict[sublocation] as? NSDictionary {
//                                if let utilityDict = sublocationInfoDict["utilities"] as? NSDictionary {
//                                    var rating = UtilityRating()
//                                    rating.locationString = "\(sublocation), \(city), \(state), \(country)"
//                                    if let electricity = utilityDict["electricity"] as? Bool {
//                                        rating.hasElectricity = electricity
//                                    }
//                                    if let food = utilityDict["food"] as? Bool {
//                                        rating.hasFood = food
//                                    }
//                                    if let water = utilityDict["water"] as? Bool {
//                                        rating.hasWater = water
//                                    }
//                                    self.locationsRatings.append(rating)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
////            print(d.allKeys)
//            //            print(d[self.instructorCode])
//            //            self.streamingLanguageCode = arr.object(forKey: "lang") as? String ?? "en-US"
//
////            self.streamingLanguageCode = d[self.instructorCode]?["lang"]
////            print("our langauge is: ")
////            print(self.streamingLanguageCode)//((snapshot.value as! NSArray).object(at: ) as? String ?? "errrrrrr"))
//        }) { (error) in
//            print(error)
//        }


//
//  Location.swift
//  IAGuide
//
//  Created by Omar Alejel
//


import Foundation
import MapKit

class Location: NSObject, MKAnnotation {
    //below 2 are required
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    var identifierString = ""

//    public var coordinate: CLLocationCoordinate2D
    
    init(activity: PersonActivity, coordinate coord: CLLocationCoordinate2D, phoneNum: String) {
        self.coordinate = coord
        
        var safetyLevel = ""
        var safetyEmoji = " 🗣"
        if activity.status == 0 {
            safetyLevel = "Unsafe"
        } else if activity.status == 1 {
            safetyLevel = "Safe"
            safetyEmoji 
        } else {
            safetyLevel = "Safety Uknown"
        }
        
        title = activity.name +
        
        identifierString = "\(activity.name), #: \(phoneNum), [\(safetyLevel)]"
    }
    
    init(ranking: UtilityRating, coordinate coord: CLLocationCoordinate2D, locStr: String) {
        self.coordinate = coord
        
        var t = ""
        if ranking.hasWater {t += "🚰"}
        if ranking.hasElectricity {t += "💡"}
        if ranking.hasFood {t += "🍪"}
        title = t
        
        identifierString = locStr
        
        super.init()
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

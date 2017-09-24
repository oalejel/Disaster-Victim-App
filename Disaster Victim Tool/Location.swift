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
    
    var locationStr = ""

//    public var coordinate: CLLocationCoordinate2D
    
    init(ranking: UtilityRating, coordinate coord: CLLocationCoordinate2D, locStr: String) {
        self.coordinate = coord
        
        var t = ""
        if ranking.hasWater {t += "🚰"}
        if ranking.hasElectricity {t += "💡"}
        if ranking.hasFood {t += "🍪"}
        title = t
        
        locationStr = locStr
        
        super.init()
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

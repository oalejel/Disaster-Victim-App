//
//  VictimsMapViewController.swift
//  Disaster Victim Tool
//
//  Created by Omar Al-Ejel on 9/23/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit
import MapKit

class VictimsMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var backButton: SqueezeButton!
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var victimsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setBordered()

//        // Do any additional setup after loading the view.
//        let clPlacemark = CLPlacemark()
//        clPlacemark.locality = "city"
////        clPlacemark.subLocality =
//        clPlacemark.country = country
//        clPlacemark.administrativeArea = state
//        let placemark = MKPlacemark(placemark: clPlacemark)
//        let x = placemark.coordinate
        
        let location = "\(context), \(city), \(state), \(country)"
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location) { (placemarks, error) in
            if let clPlacemark = placemarks?[0] {
                let placemark = MKPlacemark(placemark: clPlacemark)
                var region = self.mapView.region
                
                region.center.latitude = (placemark.location?.coordinate.latitude)!
                region.center.longitude =
                    (placemark.location?.coordinate.longitude)!
                
                let spanLevel: Double = context != "" ? 0.03 : 0.5
                region.span = MKCoordinateSpan(latitudeDelta: spanLevel, longitudeDelta: spanLevel)
                self.mapView.setRegion(region, animated: true)
            }
            
        }
        
//        let cam = MKMapCamera(lookingAtCenter: <#T##CLLocationCoordinate2D#>, fromEyeCoordinate: <#T##CLLocationCoordinate2D#>, eyeAltitude: <#T##CLLocationDistance#>)
//        mapView.setCamera(<#T##camera: MKMapCamera##MKMapCamera#>, animated: <#T##Bool#>)
    }

    @IBAction func backPressed(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

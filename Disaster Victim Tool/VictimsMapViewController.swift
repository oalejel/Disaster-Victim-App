//
//  VictimsMapViewController.swift
//  Disaster Victim Tool
//
//  Created by Omar Al-Ejel on 9/23/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit
import MapKit

class VictimsMapViewController: UIViewController, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: SqueezeButton!
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var mapTypeSegment: UISegmentedControl!
    @IBOutlet weak var victimsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setBordered()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "annotationId")
        DatabaseManager.sharedInstance.mapController = self
        DatabaseManager.sharedInstance.setupDatabaseListener(buildings: true)
        
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
    
        let location = "\(context), \(city), \(state), \(country)"
        
        getRegion(fromString: location) { (region: MKCoordinateRegion) in
            var _region = region
            let spanLevel: Double = context != "" ? 0.03 : 0.5
            _region.span = MKCoordinateSpan(latitudeDelta: spanLevel, longitudeDelta: spanLevel)
            self.mapView.setRegion(_region, animated: true)
        }

        mapView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    
    @IBAction func mapSegmentChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
//        if sender.selectedSegmentIndex == 1 {
        mapView.removeAnnotations(mapView.annotations)
        DatabaseManager.sharedInstance.peopleActivities = [:]
        DatabaseManager.sharedInstance.locationsRatings = [:]
//        }
        
        DatabaseManager.sharedInstance.setupDatabaseListener(buildings: sender.selectedSegmentIndex == 0)
    }
    
    func getRegion(fromString str: String, block: @escaping (_ region: MKCoordinateRegion) -> ()) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(str) { (placemarks, error) in
            if let clPlacemark = placemarks?[0] {
                let placemark = MKPlacemark(placemark: clPlacemark)
                var region = self.mapView.region
                
                region.center.latitude = (placemark.location?.coordinate.latitude)!
                region.center.longitude =
                    (placemark.location?.coordinate.longitude)!
                
                block(region)
            }
        }
    }

    @IBAction func backPressed(_ sender: Any) {
        DatabaseManager.sharedInstance.mapController = nil
    }

    func addLocation(locationString: String) {
        if filterSegmentControl.selectedSegmentIndex == 0 {
            let rank = DatabaseManager.sharedInstance.locationsRatings[locationString]
            
            getRegion(fromString: locationString) { (region: MKCoordinateRegion) in
                let newAnnotation = Location(ranking: rank!, coordinate: region.center, locStr: locationString)
                print("we now have a region!")
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(newAnnotation)
                }
                
            }
            
            tableView.reloadData()
        }
        
    }
    
    func addPerson(phoneNum: String) {
        if filterSegmentControl.selectedSegmentIndex == 1 {
            let activity = DatabaseManager.sharedInstance.peopleActivities[phoneNum]
            
            getRegion(fromString: activity!.location) { (region: MKCoordinateRegion) in
                let newAnnotation = Location(activity: activity!, coordinate: region.center, phoneNum: phoneNum)
                print("we now have a region!")
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(newAnnotation)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is Location {
            var pin: MKPinAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationId") as! MKPinAnnotationView
            if pin == nil {
                pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationId")
            }

            pin.canShowCallout = true
            pin.animatesDrop = true
            pin.isDraggable = false

            return pin
        }
        return nil
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        view.canShowCallout =
//    }
    
    func updateLocationInfo(locationString: String) {
        
    }
    
    func updatePersonInfo(num: String) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //////// TABLES
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterSegmentControl.selectedSegmentIndex == 0 {
            return DatabaseManager.sharedInstance.locationsRatings.count
        } else {
            return DatabaseManager.sharedInstance.peopleActivities.count 
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if filterSegmentControl.selectedSegmentIndex == 0 {
            //buildings mode
            let text = Array(DatabaseManager.sharedInstance.locationsRatings.keys)[indexPath.row]
            cell.textLabel?.text = text
        } else {
            let phoneNum = Array(DatabaseManager.sharedInstance.peopleActivities.keys)[indexPath.row]
            //unsafe setup, but the text MUST be organized as "name: number"
            
            let activity = DatabaseManager.sharedInstance.peopleActivities[phoneNum]!
            var safetyLevel = ""
            if activity.status == 0 {
                safetyLevel = "Unsafe"
            } else if activity.status == 1 {
                safetyLevel = "Safe"
            } else {
                safetyLevel = "Safety Uknown"
            }
            let text = "\(activity.name), #: \(phoneNum), [\(safetyLevel)]"
            cell.textLabel?.text = text
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        for ann in mapView.annotations {
            if (ann as! Location).identifierString == tableView.cellForRow(at: indexPath)!.textLabel!.text {
                mapView.selectAnnotation(ann, animated: true)
            }
            
        }
    }
}

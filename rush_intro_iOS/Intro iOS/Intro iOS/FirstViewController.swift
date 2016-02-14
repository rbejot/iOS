//
//  FirstViewController.swift
//  Intro iOS
//
//  Created by Tony DENION on 2/13/16.
//  Copyright © 2016 Tony DENION. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var GeolocButton: UIButton!
    @IBOutlet weak var s: UISegmentedControl!
    
    let LocationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 48.896678, longitude: 2.318387)
    let regionRadius: CLLocationDistance = 100
    
  func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
       mapView.setRegion(coordinateRegion, animated: true)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centerMapOnLocation(initialLocation)
        self.LocationManager.delegate = self
        self.LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.LocationManager.requestWhenInUseAuthorization()
        self.LocationManager.startUpdatingLocation()
        let artwork = Artwork(title: "42",
            locationName: "C'est ici",
            discipline: "School",
            coordinate: CLLocationCoordinate2D(latitude: 48.896678, longitude: 2.318387))
        mapView.addAnnotation(artwork)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Seg(sender: AnyObject) {
        if(s.selectedSegmentIndex == 0)
        {
            mapView.mapType = .Standard;
        }
        else if(s.selectedSegmentIndex == 1)
        {
            mapView.mapType = .Satellite;
        }
        else if(s.selectedSegmentIndex == 2)
        {
            mapView.mapType = .Hybrid;
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil {
                print("Error")
            }
            
            if let pm = placemarks?.first {
                self.displayLocationInfo(pm)
            }
            else{
                print("Error : erreur Data")
            }
        })
    }
    
    @IBAction func centerMapOnUser(sender: AnyObject) {
        let locManager = CLLocationManager()
        var currentLocation = CLLocation!()
        currentLocation = locManager.location
        centerMapOnLocation(currentLocation)
    }
    
    func displayLocationInfo (placemark : CLPlacemark){
        self.LocationManager.stopUpdatingLocation()

        print(placemark.subThoroughfare)
        print(placemark.thoroughfare)
        print(placemark.locality)
        print(placemark.postalCode)
        print(placemark.subAdministrativeArea)
        print(placemark.administrativeArea)
        print(placemark.country)
        
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error :" + error.localizedDescription)
    }
    
}


//
//  ViewController.swift
//  A1_A2_iOS_Bhautik_C0854487
//
//  Created by Bhautik Pethani on 2022-05-24.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var btnCurrentLocation: UIButton!
    @IBOutlet weak var btnNavigation: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    var locationMnager = CLLocationManager()
    var destination: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        map.isZoomEnabled = true;
        map.showsUserLocation = true;
        
        btnNavigation.isHidden = true;
        
        locationMnager.delegate = self;
        locationMnager.desiredAccuracy = kCLLocationAccuracyBest
        locationMnager.requestWhenInUseAuthorization()
        locationMnager.startUpdatingLocation()
        
        let latitude: CLLocationDegrees = 43.651070
        let longitude: CLLocationDegrees = -79.347015
        
        displayLocation(latitude: latitude, longitude: longitude, title: "Toronto", subtitle: "You are here")
    }

    func displayLocation(latitude: CLLocationDegrees,
                         longitude: CLLocationDegrees,
                         title: String,
                         subtitle: String) {
        // 2nd step - define span
        let latDelta: CLLocationDegrees = 0.05
        let lngDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        // 3rd step is to define the location
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // 4th step is to define the region
        let region = MKCoordinateRegion(center: location, span: span)
        
        // 5th step is to set the region for the map
        map.setRegion(region, animated: true)
        
        // 6th step is to define annotation
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = location
        map.addAnnotation(annotation)
    }

}


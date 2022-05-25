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
    
    var city = ["A","B","C"];
    var places = [Place]();
    var counter = 0;
    
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
        
        let latitude: CLLocationDegrees = 43.64;
        let longitude: CLLocationDegrees = -79.38;
        
        displayLocation(latitude: latitude, longitude: longitude, title: "Toronto City", subtitle: "You are here");
        singleTap()
        
        map.delegate = self
        
    }

//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
////        print(locations.count)
//        let userLocation = locations[0]
//
//        let latitude = userLocation.coordinate.latitude
//        let longitude = userLocation.coordinate.longitude
//
//        displayLocation(latitude: latitude, longitude: longitude, title: "Current Location", subtitle: "you are here")
//    }
    
    func addAnnotationsForPlaces() {
        map.addAnnotations(places)
        
        let overlays = places.map {MKCircle(center: $0.coordinate, radius: 2000)}
        map.addOverlays(overlays)
    }
    
    func addPolyline() {
        let coordinates = places.map {$0.coordinate}
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        map.addOverlay(polyline)
    }
    
    func addPolygon() {
        let coordinates = places.map {$0.coordinate}
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        map.addOverlay(polygon)
    }
    
    func removePolyline() {
        for overlay in map.overlays {
            map.removeOverlay(overlay)
        }
        //map.removeOverlays(map.overlays)
    }
    
    @IBAction func goToToronto(_ sender: Any) {
        let latitude: CLLocationDegrees = 43.651070;
        let longitude: CLLocationDegrees = -79.347015;
        
        displayLocation(latitude: latitude, longitude: longitude, title: "Toronto", subtitle: "You are here");
    }
    
    func singleTap() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin));
        singleTap.numberOfTapsRequired = 1;
        map.addGestureRecognizer(singleTap);
        
    }
    
    func removePin() {
        for annotation in map.annotations {
            map.removeAnnotation(annotation)
        }
        map.removeAnnotations(map.annotations)
        
        let latitude: CLLocationDegrees = 43.64;
        let longitude: CLLocationDegrees = -79.38;
        
        displayLocation(latitude: latitude, longitude: longitude, title: "Toronto City", subtitle: "You are here");
        singleTap()
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        
        if(counter<=2){
            let touchPoint = sender.location(in: map)
            let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
            let annotation = MKPointAnnotation()
            if(counter==0){
                annotation.title = "A";
                places.append(Place(name: "A", coordinate: coordinate));
            }else if(counter==1){
                annotation.title = "B";
                places.append(Place(name: "B", coordinate: coordinate));
            }else{
                annotation.title = "C";
                places.append(Place(name: "C", coordinate: coordinate));
            }
            
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
            //addAnnotationsForPlaces()
            
            
//            destination = coordinate
//            btnNavigation.isHidden = false
            if(counter==2){
                addPolyline();
                places.append(places[0]);
                addPolyline();
                addPolygon();
            }
            counter+=1;
            addPolyline();
            addPolygon();
        }else{
            places.removeAll();
            removePolyline();
            removePin();
            counter = 0;
        }
        
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

extension ViewController: MKMapViewDelegate {
    //MARK: - viewFor annotation method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        switch annotation.title {
        case "Current Location":
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
            annotationView.markerTintColor = UIColor.blue
            return annotationView
        case "Toronto City":
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
            annotationView.markerTintColor = UIColor.blue
            return annotationView
        case "A":
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
            annotationView.markerTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            return annotationView
        case "B":
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
            annotationView.markerTintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            return annotationView
        case "C":
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
            annotationView.markerTintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            return annotationView
        default:
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let rendrer = MKCircleRenderer(overlay: overlay)
            rendrer.fillColor = UIColor.green.withAlphaComponent(0.5)
            rendrer.strokeColor = UIColor.green
            rendrer.lineWidth = 2
            return rendrer
        } else if overlay is MKPolyline {
            let rendrer = MKPolylineRenderer(overlay: overlay)
            rendrer.strokeColor = UIColor.green.withAlphaComponent(0.5)
            rendrer.lineWidth = 3
            return rendrer
        } else if overlay is MKPolygon {
            let rendrer = MKPolygonRenderer(overlay: overlay)
            rendrer.fillColor = UIColor.green.withAlphaComponent(0.5)
            rendrer.strokeColor = UIColor.yellow
            rendrer.lineWidth = 2
            return rendrer
        }
        return MKOverlayRenderer()
    }
}


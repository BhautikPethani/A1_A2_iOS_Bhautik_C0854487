//
//  Place.swift
//  A1_A2_iOS_Bhautik_C0854487
//
//  Created by Bhautik Pethani on 2022-05-24.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation {
    var name: String;
    var coordinate: CLLocationCoordinate2D;
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name;
        self.coordinate = coordinate;
    }
    
    func getName() -> String{
        return self.name;
    }
    
    func getName() -> CLLocationCoordinate2D{
        return self.coordinate;
    }
}

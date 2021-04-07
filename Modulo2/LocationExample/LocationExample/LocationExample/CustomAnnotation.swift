//
//  CustomAnnotation.swift
//  LocationExample
//
//  Created by Israel Torres Alvarado on 06/04/21.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?,
         locationName: String?,
         coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
}

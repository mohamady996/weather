//
//  customAnnotation.swift
//  maps
//
//  Created by mohamad ghonem on 20/01/2025.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    // Custom variables
    var address: String = ""
    var category: String = ""
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = ""
        self.subtitle = ""
        self.address = ""
        self.category = ""
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, address: String, category: String) {
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
            self.address = address
            self.category = category
        }
}

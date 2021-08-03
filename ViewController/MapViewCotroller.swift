//
//  MapViewCotroller.swift
//  Group2Project
//
//  Created by user197710 on 8/2/21.
//

import UIKit
import MapKit
import CoreLocation


protocol MapViewDelegate{
    func settingMapLocation(latitude: Double, longitude: Double, address: String)
}

class MapViewCotroller: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    var delegate: MapViewDelegate?
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.delegate?.settingMapLocation(latitude: 0,longitude: 0, address: "")
    }


}

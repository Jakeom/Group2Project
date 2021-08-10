//
//  MapViewCotroller.swift
//  Group2Project
//
//  Created by Seonghoon Yim on 8/2/21.
//

import UIKit
import MapKit
import CoreLocation

// Make deleagate
protocol MapViewDelegate{
    func settingMapLocation(latitude: Double, longitude: Double, address: String)
}

class MapViewCotroller: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    // Define Delegate
    var delegate: MapViewDelegate?
    
    var lati = 0.0
    var longi = 0.0
    var addr = ""
    
    // Click Select Select button
    @IBAction func actionSelect(_ sender: Any) {
        // Setting location Data using delete to CreateMeoory class
        self.delegate?.settingMapLocation(latitude: lati,longitude: longi, address: addr)
        // return back page
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    // Call CLLocationManager becuase using map kit
    var locationManager = CLLocationManager()
    // Get now location
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // map kit base setting
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        
    }
    
    // Click Search Button
    @IBAction func direcBtn(_ sender: Any) {
        getAddress() // Express Location on Map
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(locations)
//    }
    
    // Express Location on Map
    func getAddress(){
        let geoCoder = CLGeocoder()
        // Get Address and GPS point
        geoCoder.geocodeAddressString(myTextField.text!) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
            else {
                print("No location is found")
                return
            }
            //print(location)
            // get GPS point
            self.lati = location.coordinate.latitude
            self.longi = location.coordinate.longitude
            
            
            // Make Address
            var addressString : String = ""
            addressString += placemarks.first?.subLocality ?? ""
            addressString += " "
            addressString += placemarks.first?.thoroughfare ?? ""
            addressString += " "
            addressString += placemarks.first?.locality ?? ""
            addressString += " "
            addressString += placemarks.first?.country ?? ""
            addressString += " "
            addressString += placemarks.first?.postalCode ?? ""

            self.addr = addressString

            // Add pin on map
            self.setPinUsingMKPlacemark(location: location.coordinate)
        }
        
    }
    
    // Make pin on Map
    func setPinUsingMKPlacemark(location: CLLocationCoordinate2D) {
        
        // All pin clear on Map
        self.mapView.removeAnnotations(mapView.annotations)
        
        // Add new pin on Map
        let pin = MKPlacemark(coordinate: location)
        let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(pin)
        self.view.endEditing(true)
    }


}

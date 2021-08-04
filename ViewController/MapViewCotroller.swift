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
    
    var lati = 0.0
    var longi = 0.0
    var addr = ""
    
    @IBAction func actionSelect(_ sender: Any) {
        self.delegate?.settingMapLocation(latitude: lati,longitude: longi, address: addr)
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
    }
    
    @IBAction func direcBtn(_ sender: Any) {
        getAddress()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func getAddress(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(myTextField.text!) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
            else {
                print("No location is found")
                return
            }
            print(location)
            self.lati = location.coordinate.latitude
            self.longi = location.coordinate.longitude
            
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
            
            //self.mapRoute(destinationCord: location.coordinate)
            self.setPinUsingMKPlacemark(location: location.coordinate)
        }
        
    }
    
    func setPinUsingMKPlacemark(location: CLLocationCoordinate2D) {
        
        self.mapView.removeAnnotations(mapView.annotations)
        let pin = MKPlacemark(coordinate: location)
        let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(pin)
        self.view.endEditing(true)
    }


}

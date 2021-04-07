//
//  ViewController.swift
//  LocationExample
//
//  Created by Israel Torres Alvarado on 05/04/21.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

//    private let mapView = MKMapView(frame: .zero)
    private let rangeInMeters: Double = 25000
        
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            //mapView.mapType = .satelliteFlyover
            mapView.showsUserLocation = true
        }
    }
    
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var lblAddress: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //appDelegate.locationManager.delegate = self
        //appDelegate.locationManager.distanceFilter  = 30
        //appDelegate.locationManager.allowsBackgroundLocationUpdates = true
        //appDelegate.locationManager.startUpdatingLocation()
        //layoutUI()
        checkLocationServices()
        
        setCustomAnnotation()
    }
    
    @IBAction func searchAddress(_ sender: UIButton) {
       
        guard let searchAddress = txtAddress.text,
              !searchAddress.isEmpty else { return }
        
        dump("search....\(searchAddress)")
        
        self.getCoordinate(forAddress: searchAddress)
        
    }
    
    func getCoordinate(forAddress address: String) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = address
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { (res, error) in
            
            guard let response = res else {
                return
            }
            
            dump(response.mapItems)
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            _ = response.mapItems.map({
                let annotation = MKPointAnnotation()
                annotation.coordinate = $0.placemark.coordinate
                        annotation.title = $0.name
                if let city = $0.placemark.locality,
                   let state = $0.placemark.administrativeArea {
                            annotation.subtitle = "\(city) \(state)"
                }
                
                self.mapView.addAnnotation(annotation)
                
            })
            
            
            
        }
        
        
//        let geocoder = CLGeocoder()
//
//        geocoder.geocodeAddressString(address) { (resultPlaces, error) in
//            if let err = error {
//                print("Geocoding error: \(err.localizedDescription)")
//            } else {
//
//                dump(resultPlaces)
//                guard let places = resultPlaces  else {
//                    return
//                }
//
//                for place in places {
//
//                    let anotation = CustomAnnotation(title: place.name,
//                                                     locationName: place.locality,
//                                                     coordinate: CLLocationCoordinate2D(latitude: place.location?.coordinate.latitude ?? 0.0, longitude: place.location?.coordinate.longitude ?? 0.0))
//
//                    self.mapView.addAnnotation(anotation)
//
//                }
//
//            }
//        }
        
    }
    
    func setCustomAnnotation() {
       
//        let airport = CustomAnnotation(title: "Aeropuerto Internacional Benito Juárez de la Ciudad de México", locationName: nil,
//            coordinate: CLLocationCoordinate2D(latitude: 19.4360762, longitude: -99.0719083))
//
//        mapView.addAnnotation(airport)
        
    }
    
    
      private func layoutUI() {
//          mapView.translatesAutoresizingMaskIntoConstraints = false
//          view.addSubview(mapView)
//
//          NSLayoutConstraint.activate([
//              mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//              mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//              mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//              mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//          ])
      }
    
    private func checkAuthorizationForLocation() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            centerViewOnUser()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Here we must tell user how to turn on location on device
            break
        case .notDetermined:
            //locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        case .restricted:
                // Here we must tell user that the app is not authorize to use location services
            break
        @unknown default:
            break
        }
    
    }
    
    private func checkLocationServices() {
        
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
            
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorizationForLocation()
    
    }
    
    private func centerViewOnUser(_ location: CLLocation? = nil) {
        
        var locationLoc: CLLocation? = location
        
        if location == nil {
            locationLoc = locationManager.location
        }
        
        guard let coordinate = locationLoc?.coordinate else { return }
        
        dump(coordinate.latitude)
        dump(coordinate.longitude)
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: rangeInMeters,
                                                  longitudinalMeters: rangeInMeters)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

extension ViewController: CLLocationManagerDelegate {
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationForLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        centerViewOnUser(location)
    
    }
    
}


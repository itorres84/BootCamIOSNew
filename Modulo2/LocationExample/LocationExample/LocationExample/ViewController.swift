//
//  ViewController.swift
//  LocationExample
//
//  Created by Israel Torres Alvarado on 05/04/21.
//

import UIKit
import CoreLocation
import MapKit
import Speech

class ViewController: UIViewController, LocationSearchTableShowResult {
    
    private let rangeInMeters: Double = 1000
        
    var resultSearchController: UISearchController? = nil
    
    var selectedPin:MKPlacemark? = nil
    var route: MKRoute?
    var stepCounter: Int = 0
    
    var inRoute: Bool = false
    
    let synthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsUserLocation = true
            mapView.delegate = self
        }
    }
    
//    @IBOutlet weak var txtAddress: UITextField!
//    @IBOutlet weak var lblAddress: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
        setCustomAnnotation()
        
        guard let storyboard = self.storyboard,
              let locationSearchTable = storyboard.instantiateViewController(identifier: "LocationSearchTable") as? LocationSearchTable
              else {
            return
        }
        
        locationSearchTable.mapView = mapView
        locationSearchTable.delegate = self
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        guard let searchBar = resultSearchController?.searchBar else {
            return
        }
        
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        
        self.navigationItem.searchController = resultSearchController
        
        resultSearchController?.hidesNavigationBarDuringPresentation = true
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }
    
//    @IBAction func searchAddress(_ sender: UIButton) {
//
//        guard let searchAddress = txtAddress.text,
//              !searchAddress.isEmpty else { return }
//        self.getCoordinate(forAddress: searchAddress)
//
//    }
    
    func getCoordinate(forAddress address: String) {
        
//        //Step 1
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = address
//        request.region = mapView.region
//
//        //Step 2
//        let search = MKLocalSearch(request: request)
//
//        //Step 3
//        search.start { (res, _ ) in
//
//            guard let response = res else {
//                return
//            }
//
//            self.mapView.removeAnnotations(self.mapView.annotations)
//
//            _ = response.mapItems.map({
//
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = $0.placemark.coordinate
//                        annotation.title = $0.name
//                if let city = $0.placemark.locality,
//                   let state = $0.placemark.administrativeArea {
//                            annotation.subtitle = "\(city) \(state)"
//                }
//
//                self.mapView.addAnnotation(annotation)
//
//            })
//
//        }
        
        
//        let geocoder = CLGeocoder()
//
//        geocoder.geocodeAddressString(address) { (resultPlaces, error) in
//
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
    
    func showResult(placemark: MKPlacemark) {
        
        selectedPin = placemark
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annnotation = MKPointAnnotation()
        
        annnotation.coordinate = placemark.coordinate
        annnotation.title = placemark.name
        
        if let city = placemark.locality,
           let state = placemark.administrativeArea {
            annnotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annnotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    
    }
    
    fileprivate func mapToRoute(destionationCoordinate: CLLocationCoordinate2D) {
        
        guard let sourceCoordinate = locationManager.location?.coordinate else {
            return
        }
        
        let sourcePlaceMarck = MKPlacemark(coordinate: sourceCoordinate)
        let destiationPlaceMarck = MKPlacemark(coordinate: destionationCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMarck)
        let destinationItem = MKMapItem(placemark: destiationPlaceMarck)
        
        
        let routeRequest = MKDirections.Request()
        routeRequest.source = sourceItem
        routeRequest.destination = destinationItem
        routeRequest.transportType = .walking
        
        let directions = MKDirections(request: routeRequest)
        
        directions.calculate { (response, err) in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response, let route = response.routes.first else { return }
            
            self.route = route
            
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 16, left:16, bottom: 16, right: 16), animated: true)
            self.getRouteSteps(routes: route)
            
        }

    }
    
    fileprivate func getRouteSteps(routes: MKRoute) {
        
        for monitoredRegion in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: monitoredRegion)
        }
        
        let steps = routes.steps.enumerated()
        let stepsDos = routes.steps
        
        _ = steps.map({ (index, elemet)  in
            let region = CLCircularRegion(center: elemet.polyline.coordinate, radius: 20, identifier: "\(index)")
            locationManager.startMonitoring(for: region)
        })
        
        stepCounter += 1
        
        let initialMessange = "En \(stepsDos[stepCounter].distance) metros  \(stepsDos[stepCounter].instructions), luego en \(stepsDos[stepCounter + 1].distance) metros, \(stepsDos[stepCounter + 2].instructions)"
        
        let spetch = AVSpeechUtterance(string: initialMessange)
        spetch.voice = AVSpeechSynthesisVoice(language: "es-MX")
        synthesizer.speak(spetch)
        startNavigation()
    }
    
    fileprivate func startNavigation() {
        centerViewOnUser()
    }

}

extension ViewController: CLLocationManagerDelegate {
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationForLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last, !inRoute else { return }
        
        centerViewOnUser(location)
    
    }
    
}

extension ViewController: MKMapViewDelegate {
    // 1
    func mapView( _ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      // 2
      guard let annotation = annotation as? MKPointAnnotation else {
        return nil
      }
      // 3
      let identifier = "pin"
      var view: MKMarkerAnnotationView
      // 4
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
        
        dequeuedView.annotation = annotation
        view = dequeuedView
      
      } else {
        // 5
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .close)
      }
      return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
      guard let anotation = view.annotation as? MKPointAnnotation else {
        return
      }
    
      inRoute = true
      mapToRoute(destionationCoordinate: anotation.coordinate)
      
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        return renderer

    }
    
}



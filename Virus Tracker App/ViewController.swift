//
//  ViewController.swift
//  Virus Tracker App
//
//  Created by Jehad on 5/7/21.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    

    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        configureLocationServices()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureLocationServices() {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
           beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    private func addAnnotations() {
        
        let appleParkAnnotation = MKPointAnnotation()
        appleParkAnnotation.title = "COVID-19 Case"
        appleParkAnnotation.subtitle = "COVID-19 Case reported in this area."
        appleParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.332072300 , longitude:-122.011138100)
        
        let ortegaParkAnnotation = MKPointAnnotation()
        ortegaParkAnnotation.title = "COVID-19 Case"
        ortegaParkAnnotation.subtitle = "COVID-19 Case reported in this area."
        ortegaParkAnnotation.coordinate = CLLocationCoordinate2D(latitude:    37.342226 , longitude: -122.025617)
        
        let anzaCollegeAnnotation = MKPointAnnotation()
        anzaCollegeAnnotation.title = "COVID-19 Case"
        anzaCollegeAnnotation.subtitle = "COVID-19 Case reported in this area."
        anzaCollegeAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3193, longitude: -122.0448)
        
        let sanJoseAnnotation = MKPointAnnotation()
        sanJoseAnnotation.title = "COVID-19 Case"
        sanJoseAnnotation.subtitle = "COVID-19 Case reported in this area."
        sanJoseAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3639, longitude: -121.9289)
        
        let sanAntonioAnnotation = MKPointAnnotation()
        sanAntonioAnnotation.title = "COVID-19 Case"
        sanAntonioAnnotation.subtitle = "COVID-19 Case reported in this area."
        sanAntonioAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3332, longitude: -122.1090)
        
        let santaClaraAnnotation = MKPointAnnotation()
        santaClaraAnnotation.title = "COVID-19 Case"
        santaClaraAnnotation.subtitle = "COVID-19 Case reported in this area."
        santaClaraAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3496, longitude: -121.9390)
        
        let stevensCreekAnnnotation = MKPointAnnotation()
        stevensCreekAnnnotation.title = "COVID-19 Case"
        stevensCreekAnnnotation.subtitle = "COVID-19 Case reported in this area."
        stevensCreekAnnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3043, longitude: -122.0730)
        
        let serraParkAnnotation = MKPointAnnotation()
        serraParkAnnotation.title = "COVID-19 Case"
        serraParkAnnotation.subtitle = "COVID-19 Case reported in this area."
        serraParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3428, longitude: 122.0423)
        
        
        mapView.addAnnotation(appleParkAnnotation)
        mapView.addAnnotation(ortegaParkAnnotation)
        mapView.addAnnotation(anzaCollegeAnnotation)
        mapView.addAnnotation(sanJoseAnnotation)
        mapView.addAnnotation(sanAntonioAnnotation)
        mapView.addAnnotation(santaClaraAnnotation)
        mapView.addAnnotation(stevensCreekAnnnotation)
        mapView.addAnnotation(serraParkAnnotation)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location")
        
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
            addAnnotations()
        }
    
        currentCoordinate = latestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       print("The status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if let title = annotation.title, title == "COVID-19 Case" {
            annotationView?.image = UIImage(named: "bacteria")
        }else if annotation === mapView.userLocation {
    annotationView?.image = UIImage(named: "usericon2")
}
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annotation was selected: \(String(describing: view.annotation?.title))")
    }
}

/*import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear( _ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy  = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.first{
            manager.stopUpdatingLocation()
            render(location: location)
        }
    }
    func render(location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "COVID-19 Case"
        pin.subtitle = "There is COVID-19 cases in your area. "
        mapView.addAnnotation(pin)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            //Create the view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "viruscase")
        return annotationView
    }
    
    
    
}*/

/*import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy  = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            render(location: location)
        }
    }
    
    func render(location: CLLocation){
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "COVID-19 Case"
        pin.subtitle = "There is COVID-19 cases in your area. "
        mapView.addAnnotation(pin)
        
        
    }
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //Create the view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            
            annotationView?.canShowCallout = true
        }
        else{
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "viruscase")
       
        
        return annotationView
        
    }

    
}*/



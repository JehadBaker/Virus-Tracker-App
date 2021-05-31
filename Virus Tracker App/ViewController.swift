//
//  ViewController.swift
//  Virus Tracker App
//
//  Created by Jehad on 5/7/21.
//

import UIKit
import MapKit



class ViewController: UIViewController {
    

    @IBAction func emailButton(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "mailto:example@email.com")! as URL, options: [:], completionHandler: nil)
    }
    
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
        appleParkAnnotation.title = "Low COVID-19 Cases"
        appleParkAnnotation.subtitle = "7 COVID-19 Cases reported in this area."
        appleParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.332072300 , longitude:-122.011138100)
        
        let ortegaParkAnnotation = MKPointAnnotation()
        ortegaParkAnnotation.title = "Several COVID-19 Cases"
        ortegaParkAnnotation.subtitle = " 18 COVID-19 Cases reported in this area."
        ortegaParkAnnotation.coordinate = CLLocationCoordinate2D(latitude:    37.342226 , longitude: -122.025617)
        
        let anzaCollegeAnnotation = MKPointAnnotation()
        anzaCollegeAnnotation.title = "High COVID-19 Cases"
        anzaCollegeAnnotation.subtitle = "55 COVID-19 Cases reported in this area."
        anzaCollegeAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3193, longitude: -122.0448)
        
        let sanJoseAnnotation = MKPointAnnotation()
        sanJoseAnnotation.title = "High COVID-19 Cases"
        sanJoseAnnotation.subtitle = "106 COVID-19 Cases reported in this area."
        sanJoseAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3639, longitude: -121.9289)
        
        let sanAntonioAnnotation = MKPointAnnotation()
        sanAntonioAnnotation.title = "Several COVID-19 Cases"
        sanAntonioAnnotation.subtitle = "23 COVID-19 Cases reported in this area."
        sanAntonioAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3332, longitude: -122.1090)
        
        let santaClaraAnnotation = MKPointAnnotation()
        santaClaraAnnotation.title = "Low COVID-19 Cases"
        santaClaraAnnotation.subtitle = "9 COVID-19 Cases reported in this area."
        santaClaraAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3496, longitude: -121.9390)
        
        let stevensCreekAnnnotation = MKPointAnnotation()
        stevensCreekAnnnotation.title = "Several COVID-19 Cases"
        stevensCreekAnnnotation.subtitle = "32 COVID-19 Cases reported in this area."
        stevensCreekAnnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3043, longitude: -122.0730)
        
        let serraParkAnnotation = MKPointAnnotation()
        serraParkAnnotation.title = "High COVID-19 Cases"
        serraParkAnnotation.subtitle = "62 COVID-19 Cases reported in this area."
        serraParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3428, longitude: -122.0423)
        
        let medicalCenterAnnotation = MKPointAnnotation()
        medicalCenterAnnotation.title = "High COVID-19 Cases"
        medicalCenterAnnotation.subtitle = "48 COVID-19 Cases reported in this area."
        medicalCenterAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3357083, longitude: -121.9990281)
        
        let sunkenGardensAnnotation = MKPointAnnotation()
        sunkenGardensAnnotation.title = "Low COVID-19 Cases"
        sunkenGardensAnnotation.subtitle = "3 COVID-19 Cases reported in this area."
        sunkenGardensAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.354896745458, longitude: -122.0105419264)
        
        
        mapView.addAnnotation(appleParkAnnotation)
        mapView.addAnnotation(ortegaParkAnnotation)
        mapView.addAnnotation(anzaCollegeAnnotation)
        mapView.addAnnotation(sanJoseAnnotation)
        mapView.addAnnotation(sanAntonioAnnotation)
        mapView.addAnnotation(santaClaraAnnotation)
        mapView.addAnnotation(stevensCreekAnnnotation)
        mapView.addAnnotation(serraParkAnnotation)
        mapView.addAnnotation(medicalCenterAnnotation)
        mapView.addAnnotation(sunkenGardensAnnotation)
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
        
        if let title = annotation.title, title == "Low COVID-19 Cases" {
            annotationView?.image = UIImage(named: "bacteria")
        }else if let title = annotation.title, title == "Several COVID-19 Cases"{
            annotationView?.image = UIImage(named: "bacteria-yellow")
        }else if let title = annotation.title, title == "High COVID-19 Cases"{
            annotationView?.image = UIImage(named: "bacteria-red1")
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



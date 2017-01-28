//
//  MapVC.swift
//  LocateKangarooAR
//
//  Created by Abel Fernandez on 28/01/2017.
//  Copyright © 2017 Abel Fernandez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    let minimumDistance:Double = 100.0

    @IBOutlet var mapView: MKMapView!
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // location manager configuration
        self.configureLocationManager()
        self.mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: custom methods
    private func configureLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
    }


}

extension MapVC:CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if (locations.count > 0) {
            let location:CLLocation = locations.last!


            if (location.horizontalAccuracy < minimumDistance) {
                manager.stopUpdatingLocation()

                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                self.mapView.region = region

            }
        }
    }

}
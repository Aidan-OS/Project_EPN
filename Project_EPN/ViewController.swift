//
//  ViewController.swift
//  Project_EPN
//
//  Created by Dana Smith on 2016-09-15.
//  Copyright © 2016 ShamothSoft. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // CLLocationManagerDelegate implementation
    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let center = locations.last?.coordinate
        let span = MKCoordinateSpan (latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion (center: center!, span: span)
        mapView.setRegion (region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed: " + error.localizedDescription)
    }
}


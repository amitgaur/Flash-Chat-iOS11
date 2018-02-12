//
//  MapViewController.swift
//  Flash Chat
//
//  Created by Amit Gaur on 2/9/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD
class MapViewController: UIViewController, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        
    }
    
    //MARK: Location Management Functions
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print ("location authorization changed \(status.rawValue)")
        guard (status ==  CLAuthorizationStatus.authorizedAlways ||  status == CLAuthorizationStatus.authorizedWhenInUse) else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("unable to get authorization \(error.localizedDescription)")
        SVProgressHUD.show(withStatus: "Unable to get location :please make sure location sharing is enabled")
        SVProgressHUD.dismiss()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("got updated locations")
        
        guard (locations.count>0 &&  locations[locations.count-1].horizontalAccuracy>0) else {
            print ("Not valid locations yets")
            return
        }
        mapView.camera = GMSCameraPosition(target: locations[locations.count-1].coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

extension MapViewController : GMSMapViewDelegate{
    
}

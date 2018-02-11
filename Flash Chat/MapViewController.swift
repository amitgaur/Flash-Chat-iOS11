//
//  MapViewController.swift
//  Flash Chat
//
//  Created by Amit Gaur on 2/9/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("view controller loaded")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapViewController : GMSMapViewDelegate{
    
}

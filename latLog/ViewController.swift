//
//  ViewController.swift
//  latLog
//
//  Created by Suraj B on 12/6/17.
//  Copyright © 2017 CZSM. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    lazy var geocoder = CLGeocoder()


    @IBOutlet var latitudeTextField: UITextField!
    @IBOutlet var longitudeTextField: UITextField!
    
    @IBOutlet var geocodeButton: UIButton!
    @IBOutlet var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func geocode(_ sender: Any) {
        
        guard let latAsString = latitudeTextField.text, let lat = Double(latAsString) else { return }
        guard let lngAsString = longitudeTextField.text, let lng = Double(lngAsString) else { return }
        
        let location = CLLocation(latitude: lat, longitude: lng)
        
        // Geocode Location
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
        // Process Response
         processResponse(withPlacemarks: placemarks, error: error)
            
            
        }
      
        geocodeButton.isHidden = true
     func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        // Update View
            geocodeButton.isHidden = false
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
                locationLabel.text = "Unable to Find Address for Location"
                } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    locationLabel.text = placemark.compactAddress
                } else {
                    locationLabel.text = "No Matching Addresses Found"
                }
            }
                }
       }//@IBAction
    }//class

extension CLPlacemark {
    var compactAddress: String? {
        if let name = name {
            var result = name
            
            if let street = thoroughfare {
                result += ", \(street)"
            }
            
            if let city = locality {
                result += ", \(city)"
            }
            
            if let country = country {
                result += ", \(country)"
            }
             return result
            }
             return nil
                 }
          }





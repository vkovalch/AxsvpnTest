//
//  MapVC.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import UIKit
import CoreLocation
import MapKit

class MapVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(handleTap))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    //MARK: - Objc Methods
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        getAddress(coordinate)
    }
    
    //MARK: - Objc Methods
    func getAddress(_ coord: CLLocationCoordinate2D) {
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: coord.latitude, longitude:coord.longitude)) { (places, error) in
            if error == nil{
                if let place = places?[0] {
                    print(place)
                    var addressString : String = ""
                    if place.subLocality != nil
                    {
                        addressString = addressString + place.subLocality! + ", "
                    }
                    if place.thoroughfare != nil {
                        addressString = addressString + place.thoroughfare! + ", "
                    }
                    if place.locality != nil {
                        addressString = addressString + place.locality! + ", "
                    }
                    if place.country != nil
                    {
                        addressString = addressString + place.country! + ", "
                    }
                    if place.postalCode != nil
                    {
                        addressString = addressString + place.postalCode! + " "
                    }
                    
                    self.addressLabel.text = addressString
                    print(addressString)
                }
            }
        }
    }
    
}


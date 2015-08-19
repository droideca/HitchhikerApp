//
//  InterfaceController.swift
//  HitchhikerApp WatchKit Extension
//
//  Created by Carolina Barreiro Cancela on 17/08/15.
//  Copyright © 2015 CarolinaBarreiro. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class RequestSpaceshipController: WKInterfaceController, CLLocationManagerDelegate {

	let locationManager = CLLocationManager()
	@IBOutlet var userLocalizationMap: WKInterfaceMap!
	
	override func awakeWithContext(context: AnyObject?) {
			super.awakeWithContext(context)
		
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
	
		// Determine a location to display
		let mapLocation = CLLocationCoordinate2DMake(37, -122)
		let coordinateSpan = MKCoordinateSpanMake(1, 1)
		userLocalizationMap.setRegion(MKCoordinateRegion(center: mapLocation, span: coordinateSpan))
	}
	
	// MARK: - CLLocationManagerDelegate
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			print(location.coordinate)
			let coordinateSpan = MKCoordinateSpanMake(1, 1)
			userLocalizationMap.addAnnotation(location.coordinate, withPinColor: WKInterfaceMapPinColor.Purple)
			userLocalizationMap.setRegion(MKCoordinateRegion(center: location.coordinate, span: coordinateSpan))
			locationManager.stopUpdatingLocation()
		}
	}
	
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		locationManager.stopUpdatingLocation()
		print("Error finding location. Don't panic! Here is the reason:  \(error.localizedDescription)")
		// TODO: Show error to the user
	}
}

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

class RequestSpaceshipController: WKInterfaceController, WCSessionDelegate {

	var session : WCSession!
	@IBOutlet var userLocalizationMap: WKInterfaceMap!
	
	override func awakeWithContext(context: AnyObject?) {
			super.awakeWithContext(context)
		
		// Determine a location to display
		let mapLocation = CLLocationCoordinate2DMake(37, -122)
		let coordinateSpan = MKCoordinateSpanMake(1, 1)
		userLocalizationMap.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Purple)
		userLocalizationMap.setRegion(MKCoordinateRegion(center: mapLocation, span: coordinateSpan))
	}

	override func willActivate() {
		super.willActivate()
		if (WCSession.isSupported()) {
			session = WCSession.defaultSession()
			session.delegate = self
			session.activateSession()
		}
	}

	@IBAction func checkClosestSpaceShipAction() {

		
	}

}

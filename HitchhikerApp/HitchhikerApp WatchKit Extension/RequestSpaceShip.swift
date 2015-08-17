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

class RequestSpaceShip: WKInterfaceController, WCSessionDelegate {

	var session : WCSession!
	@IBOutlet var userLocalizationMap: WKInterfaceMap!
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
			// Determine a location to display
			let mapLocation = CLLocationCoordinate2DMake(37, -122)
			let coordinateSpan = MKCoordinateSpanMake(1, 1)
			userLocalizationMap.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Purple)
			userLocalizationMap.setRegion(MKCoordinateRegion(center: mapLocation, span: coordinateSpan))
		
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
			if (WCSession.isSupported()) {
				session = WCSession.defaultSession()
				session.delegate = self
				session.activateSession()
			}
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

	@IBAction func checkClosestSpaceShipAction() {
		let applicationDict = ["emoji":"merda"]

		session.sendMessage(applicationDict, replyHandler: {(_: [String : AnyObject]) -> Void in
			// handle reply from iPhone app here
			}, errorHandler: {(error ) -> Void in
				// catch any errors here
		})
	}

}

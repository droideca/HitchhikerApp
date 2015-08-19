//
//  SpaceShipInfoController.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 18/08/15.
//  Copyright © 2015 CarolinaBarreiro. All rights reserved.
//

import WatchKit

class SpaceshipInfoController: WKInterfaceController {

	@IBOutlet var nameDriverLabel: WKInterfaceLabel!
	@IBOutlet var driverImage: WKInterfaceImage!
	@IBOutlet var specieDriverLabel: WKInterfaceLabel!
	@IBOutlet var planetDriverLabel: WKInterfaceLabel!
	
	@IBOutlet var groupLabels: WKInterfaceGroup!
	@IBOutlet var buttonLabel: WKInterfaceLabel!
	
	var shipInfo : Spaceship!
	
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
		if let context = context, let spaceship = Spaceship.decodeJson(context) {
			shipInfo = spaceship
			reloadData()
		} else {
			// TODO: Show error
		}
  }

	func reloadData(){
		nameDriverLabel.setText(shipInfo.nameDriver)
		specieDriverLabel.setText(shipInfo.specie)
		planetDriverLabel.setText(shipInfo.planet)
		driverImage.setImageWithUrl(shipInfo.pictureDriver)
		buttonLabel.setText("Request " + shipInfo.typeSpaceship)
	}
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
	
}

//
//  AvailableSpaceShips.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 18/08/15.
//  Copyright (c) 2015 CarolinaBarreiro. All rights reserved.
//

import WatchKit

class AvailableSpaceshipsController: WKInterfaceController, ConnectionProtocol {
	
	@IBOutlet var table: WKInterfaceTable!
	
	let cellIdentifier = "AvailableSpaceshipCell"
	let segueIdentifierShipInfo = "SegueSpaceshipInfo"
	var connectionManager: ConnectionManager = ConnectionManager()
	var availablesSpaceships: [Spaceship] = []

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
		connectionManager.delegate = self
		connectionManager.retrieveSpaceships()
  }
	
	override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
			return availablesSpaceships[rowIndex].encodeJson()
	}
	
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
	
	func didRecieveError(error: ErrorType!){
		print(error)
		// TODO: Show error
	}
	
	func didRecieveResults(spaceships: [Spaceship]){
		if spaceships.count > 0 {
			availablesSpaceships = spaceships
			reloadTable()
		} else {
			// TODO: Show in table "There is no spaceships next to you, but Don't panic!"
		}
	}
	
	func reloadTable() {
		table.setNumberOfRows(availablesSpaceships.count, withRowType: cellIdentifier)
		for (index,ship) in availablesSpaceships.enumerate() {
			if let row = table.rowControllerAtIndex(index) as? AvailableSpaceshipCell {
				row.spaceshipNameLabel.setText(ship.typeSpaceship)
				if let data:NSData = NSData(contentsOfURL: ship.pictureSpaceship) {
					if let placeholder = UIImage(data: data) {
						dispatch_async(dispatch_get_main_queue()) {
						row.groupBackground.setBackgroundImage(placeholder)
						}
					}
				}
			}
		}
	}

}

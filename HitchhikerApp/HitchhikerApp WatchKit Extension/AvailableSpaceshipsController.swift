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
		
		table.setNumberOfRows(1, withRowType: cellIdentifier)
		if let row = table.rowControllerAtIndex(0) as? AvailableSpaceshipCell {
			row.spaceshipNameLabel.setText("Loading")
		}
		
		connectionManager.delegate = self
		connectionManager.retrieveSpaceships()
  }
	
	override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
			return availablesSpaceships[rowIndex].encodeJson()
	}
	
  override func willActivate() {
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
				row.spaceshipImage.setImageWithUrl(ship.pictureSpaceship)
			}
		}
	}

}

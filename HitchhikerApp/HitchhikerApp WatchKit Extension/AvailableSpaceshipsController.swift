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
	@IBOutlet var loadingImage: WKInterfaceImage!
	
	let cellIdentifier = "AvailableSpaceshipCell"
	let segueIdentifierShipInfo = "SegueSpaceshipInfo"
	var connectionManager: ConnectionManager = ConnectionManager()
	var availablesSpaceships: [Spaceship] = []

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
		connectionManager.delegate = self
		connectionManager.retrieveSpaceships()
	}
	
	override func willActivate() {
		super.willActivate()
	}
	
	override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
			return availablesSpaceships[rowIndex].encodeJson()
	}
	
	func didRecieveError(error: ErrorType!){
		print(error)
		// TODO: Show error
	}
	
	func didRecieveResults(spaceships: [Spaceship]){
		if spaceships.count > 0 {
			availablesSpaceships = spaceships
			loadingImage.setHidden(true)
			reloadTable()
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

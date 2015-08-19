//
//  AvailableSpaceShips.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 18/08/15.
//  Copyright (c) 2015 CarolinaBarreiro. All rights reserved.
//

import WatchKit

class AvailableSpaceshipsController: WKInterfaceController {
	
	@IBOutlet var table: WKInterfaceTable!
	
	let cellIdentifier = "AvailableSpaceshipCell"
	let segueIdentifierShipInfo = "SegueSpaceshipInfo"
	
	var availablesSpaceships: [Spaceship] = []

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    // Configure interface objects here.
		var task: NSURLSessionDataTask?
    let url = NSURL(string:Constants.API.AvailableSpaceshipURL)!
    let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: conf)
    task = session.dataTaskWithURL(url) { (data, res, error) -> Void in
      if let e = error {
        print("dataTaskWithURL fail: \(e.debugDescription)")
        return
      }
      if let d = data{
				let results = NSString(data: d, encoding: NSUTF8StringEncoding)
				print(results)
        self.parseResults(d)
      }
    }
    task!.resume()
  }
  
  func parseResults(data: NSData){
    do {
      if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
				if let arrayJson = json["data"] as? NSArray {
					var spaceships: [Spaceship] = []
					for itemJson in arrayJson {
						if let ship = Spaceship.decodeJson(itemJson) {
							spaceships.append(ship)
						}
					}
					availablesSpaceships.extend(spaceships)
					reloadTable()
        }
      }
    } catch {
      print(error)
    }
  }
	
	override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
			return availablesSpaceships[rowIndex].encodeJson()
	}
	
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
	
	func reloadTable() {
		//		if let data:NSData = NSData(contentsOfURL: shipInfo.pictureSpaceship) {
		//			if let placeholder = UIImage(data: data) {
		//				dispatch_async(dispatch_get_main_queue()) {
		//					self.groupLabels.setBackgroundImage(placeholder)
		//				}
		//			}
		//		}
		table.setNumberOfRows(availablesSpaceships.count, withRowType: cellIdentifier)
		for (index,ship) in availablesSpaceships.enumerate() {
			if let row = table.rowControllerAtIndex(index) as? AvailableSpaceshipCell {
				//row.spaceshipImage.setImageWithUrl(ship.pictureSpaceship)
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

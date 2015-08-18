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
	var availablesSpaceships: [AvailableSpaceship] = []
	let cellIdentifier = "AvailableSpaceshipCell"

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
      if let json: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
        var spaceships: [AvailableSpaceship] = []
        for itemJson in json {
          if let itemDictionary = itemJson as? NSDictionary {
						if let ship = AvailableSpaceship.decodeJson(itemDictionary) {
							spaceships.append(ship)
						}
          }
        }
        availablesSpaceships.extend(spaceships)
				reloadTable()
      }
    } catch {
      print(error)
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
	
	func reloadTable() {
		table.setNumberOfRows(availablesSpaceships.count, withRowType: cellIdentifier)
		for (index,ship) in availablesSpaceships.enumerate() {
			if let row = table.rowControllerAtIndex(index) as? AvailableSpaceshipCell {
				row.spaceshipImage.setImageWithUrl(ship.pictureShip)
				row.spaceshipNameLabel.setText(ship.typeSpaceship)
			}
		}
	}

  
//  func getImage(){
//    let url = NSURL(string:"https://pbs.twimg.com/profile_images/3186881240/fa714ece16d0fabccf903cec863b1949_400x400.png")!
//    let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
//    let session = NSURLSession(configuration: conf)
//    self.task = session.dataTaskWithURL(url) { (data, res, error) -> Void in
//      if let e = error {
//        print("dataTaskWithURL fail: \(e.debugDescription)")
//        return
//      }
//      if let d = data {
//        _ = UIImage(data: d)
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
////          if self.isActive {
////            self.image.setImage(image)
////          }
//        })
//      }
//    }
//    task!.resume()
//  }

}

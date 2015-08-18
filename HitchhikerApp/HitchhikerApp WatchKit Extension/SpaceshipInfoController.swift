//
//  SpaceShipInfoController.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 18/08/15.
//  Copyright © 2015 CarolinaBarreiro. All rights reserved.
//

import WatchKit

class SpaceshipInfoController: WKInterfaceController {
  //http://blog.andydrizen.co.uk/blog/2015/01/03/making-watchkit-animations/

	@IBOutlet var nameDriverLabel: WKInterfaceLabel!
	@IBOutlet var driverImage: WKInterfaceImage!
	@IBOutlet var specieDriverLabel: WKInterfaceLabel!
	@IBOutlet var planetDriverLabel: WKInterfaceLabel!
	
	@IBOutlet var spaceshipImage: WKInterfaceGroup!
	@IBOutlet var buttonLabel: WKInterfaceLabel!
	
	var shipInfo : SpaceshipInfo!
	
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
        self.parseResults(d)
      }
    }
    task!.resume()
  }
  
  func parseResults(data: NSData){
    do {
      if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
        let ship = SpaceshipInfo.decodeJson(json)
        print(ship!.id)
      }
    } catch {
      print(error)
    }
  }
	
	func reloadData(){
		
	}
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

	@IBAction func requestSpaceship() {
	}
	
	
	
}

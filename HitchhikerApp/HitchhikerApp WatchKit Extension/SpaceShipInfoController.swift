//
//  SpaceShipInfoController.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 18/08/15.
//  Copyright © 2015 CarolinaBarreiro. All rights reserved.
//

import WatchKit

class SpaceShipInfoController: WKInterfaceController {
  //
  //http://blog.andydrizen.co.uk/blog/2015/01/03/making-watchkit-animations/
  var task: NSURLSessionDataTask?

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    // Configure interface objects here.
    let url = NSURL(string:"http://beta.json-generator.com/api/json/get/N1qzN12o")!
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
        let ship = SpasceShipInfo.decodeJson(json)
        print(ship!.id)
      }
    } catch {
      print(error)
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
}

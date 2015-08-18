//
//  AvailableSpaceShips.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 18/08/15.
//  Copyright (c) 2015 CarolinaBarreiro. All rights reserved.
//

import WatchKit

class AvailableSpaceShipsController: WKInterfaceController {
  var task: NSURLSessionDataTask?

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    // Configure interface objects here.
    let url = NSURL(string:"http://beta.json-generator.com/api/json/get/E1Cs-Jno")!
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
      if let json: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
        var spaceShip: [AvailableSpaceShip] = []
        for itemJson in json {
          if let itemDictionary = itemJson as? NSDictionary {
            let ship = AvailableSpaceShip.decodeJson(itemDictionary)
            spaceShip.append(ship!)
          }
        }
        print(spaceShip.count)
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
  
  func getImage(){
    let url = NSURL(string:"https://pbs.twimg.com/profile_images/3186881240/fa714ece16d0fabccf903cec863b1949_400x400.png")!
    let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: conf)
    self.task = session.dataTaskWithURL(url) { (data, res, error) -> Void in
      if let e = error {
        print("dataTaskWithURL fail: \(e.debugDescription)")
        return
      }
      if let d = data {
        _ = UIImage(data: d)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//          if self.isActive {
//            self.image.setImage(image)
//          }
        })
      }
    }
    task!.resume()
  }

}

//
//  ConnectionManager.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 18/08/15.
//  Copyright © 2015 CarolinaBarreiro. All rights reserved.
//

import Foundation

protocol ConnectionProtocol {
	func didRecieveError(error: ErrorType!)
	func didRecieveResults(spaceships: [Spaceship])
}

class ConnectionManager {
	
	var delegate: ConnectionProtocol!
	
	init() {
		
	}

	func retrieveSpaceships(){
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
		guard let delegate = self.delegate else {
			assertionFailure("You need to provide a delegate")
			return
		}
		do {
			if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
				if let arrayJson = json["data"] as? NSArray {
					var spaceships: [Spaceship] = []
					for itemJson in arrayJson {
						if let ship = Spaceship.decodeJson(itemJson) {
							spaceships.append(ship)
						}
					}
					if spaceships.count > 0 {
						delegate.didRecieveResults(spaceships)
					} else {
						print(NSString(data: data, encoding: NSUTF8StringEncoding))
						delegate.didRecieveError(nil)
					}
					
				}
			}
		} catch {
			print(error)
			delegate.didRecieveError(error)
		}
	}
	
	
	
}
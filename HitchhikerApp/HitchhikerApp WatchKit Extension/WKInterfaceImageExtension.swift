//
//  WKInterfaceImageExtension.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 18/08/15.
//  Copyright © 2015 CarolinaBarreiro. All rights reserved.
//

import Foundation
import WatchKit

extension WKInterfaceImage {
	
	func setImageWithUrl(url:NSURL) -> WKInterfaceImage? {
		
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
			if let data:NSData = NSData(contentsOfURL: url) {
				if let placeholder = UIImage(data: data) {
					dispatch_async(dispatch_get_main_queue()) {
						self.setImage(placeholder)
					}
				}
			}
		}
		
		return self
	}
	
}
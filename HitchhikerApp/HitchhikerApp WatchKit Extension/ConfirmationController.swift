//
//  ConfirmationController.swift
//  HitchhikerApp
//
//  Created by Carolina Barreiro Cancela on 25/08/15.
//  Copyright © 2015 CarolinaBarreiro. All rights reserved.
//

import WatchKit

class ConfirmationController: WKInterfaceController {
	
	@IBOutlet var handAnimationImageView: WKInterfaceImage!
	
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)
		
		handAnimationImageView.setImageNamed("hand")
		handAnimationImageView.startAnimating()
		
	}
}

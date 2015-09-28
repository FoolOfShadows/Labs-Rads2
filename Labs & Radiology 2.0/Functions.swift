//
//  Functions.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 7/14/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Foundation
import Cocoa

func processLists(buttonArray: [NSButton!], stringArray: [String])-> [String] {
	var returnArray = [String]()
	for var i = 0; i < buttonArray.count; i++ {
		if (buttonArray[i].state == NSOnState) {
			returnArray.append(stringArray[i])
		}
	}
	return returnArray
	
}
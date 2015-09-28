//
//  NUCHandler.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 2/26/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

//Need to import Cocoa instead of Foundation in order to get access to the needed delegates
import Cocoa

//Create a class with the delegates needed to connect to windows and controllers and receive notifications
//From the window this class is handling
class NUCHandler : NSObject, NSApplicationDelegate, NSWindowDelegate {
//Create outlet for the window this class will be the delegate of
    @IBOutlet weak var winNUC: NSWindow!
    
    @IBOutlet weak var radView: NSTextField!
    
    @IBOutlet weak var giCLNView: NSButton!
    @IBOutlet weak var giEGDView: NSButton!
    @IBOutlet weak var nucGallbladderView: NSButton!
    @IBOutlet weak var nucNGESView: NSButton!
    @IBOutlet weak var nucThyroidView: NSButton!
    @IBOutlet weak var nucBreastView: NSButton!
    @IBOutlet weak var nucBoneView: NSButton!
    
    //Create a struct to hold variables available to the AppDelegate module
    struct NUCVars {
        //Create an array variable to hold the results of this window in
        static var nucOrderList = [String]()
        //Create an integer variable to hold this window's refresh status
        static var nucStateInt = Int()
    }
    
    @IBAction func takeNUCProcess(sender: AnyObject) {
        if radView.stringValue != "" {
            NUCVars.nucOrderList.append(radView.stringValue)
        }
        //Create a dictionary of the controllers being processed and the values attached to them
		let nucVarList = [nucThyroidView, nucGallbladderView, nucNGESView, nucBreastView, nucBoneView, giCLNView, giEGDView]
		let nucVerbiageList = ["Nuclear - Thyroid uptake scan","Nuclear - Gallbladder HIDA scan","Nuclear - NGES Nuclear Gastric Emptying Study","Nuclear - Breast scan","Nuclear - Bone scan 3 phase","Colonoscopy","EGD"]
        //Process the controllers in the window and collect the results in an array
		for var i = 0; i < nucVarList.count; i++ {
			if (nucVarList[i].state == NSOnState) {
				NUCVars.nucOrderList.append(nucVerbiageList[i])
			}
		}
        //Set the Radioloty text box to the collected array as a comma delimited string
        radView.stringValue = NUCVars.nucOrderList.joinWithSeparator(", ")
        //Close the window controlled by this class/handler
        winNUC.orderOut(self)
    }
   
    
    func clearNUCCheckBoxes(){
        giCLNView.state = NSOffState
        giEGDView.state = NSOffState
        nucGallbladderView.state = NSOffState
        nucNGESView.state = NSOffState
        nucThyroidView.state = NSOffState
        nucBreastView.state = NSOffState
        nucBoneView.state = NSOffState
        
        NUCVars.nucOrderList = []
    }
    
    func windowDidBecomeKey(notification: NSNotification) {
            if NUCVars.nucStateInt == 1 {
            clearNUCCheckBoxes()
            }
            NUCVars.nucStateInt = 0
    }
}

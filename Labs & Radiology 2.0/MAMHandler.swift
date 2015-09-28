//
//  MAMHandler.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 2/4/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

//Need to import Cocoa instead of Foundation in order to get access to the needed delegates
import Cocoa

//Create a class with the delegates needed to connect to windows and controllers and receive notifications
//From the window this class is handling
class MAMHandler : NSObject, NSApplicationDelegate, NSWindowDelegate {
    //Create outlet for the window this class will be the delegate of
    @IBOutlet weak var winMam: NSWindow!
    //Create outlets for the controllers on that window
    @IBOutlet weak var mamSBView: NSButton!
    @IBOutlet weak var mamDBView: NSButton!
    @IBOutlet weak var mamDRView: NSButton!
    @IBOutlet weak var mamDLView: NSButton!
	@IBOutlet weak var bmdView: NSButton!
    
    //Create an outlet to the controller on the main window you want the final values returned to
    @IBOutlet weak var radView: NSTextField!
    
    //Create a struct to hold variables available to the AppDelegate module
    struct MAMVars {
    //Create an array variable to hold the results of this window in
    static var mamOrderList = [String]()
        //Create an integer variable to hold this window's refresh status
        static var mamStateInt = Int()
    }
    
    
    //Process the data in this window when the button is clicked
    @IBAction func takeMAMProcess(sender: AnyObject){
        //Check to see if there is already a value in the Radiology text box from a different
        //window, and if there is append it to the array which will be collecting the values
        //from processing this window.
        if radView.stringValue != "" {
        MAMVars.mamOrderList.append(radView.stringValue)
        }
        //Create a dictionary of the controllers being processed and the values attached to them
		let mamVarList = [mamSBView, mamDBView, mamDRView, mamDLView, bmdView]
		let mamVerbiageList = ["Mammogram - Screening Bilateral","Mammogram - Diagnostic Bilateral","Mammogram - Diagnostic Right","Mammogram - Diagnostic Left", "BMD - Dexa Bone Mineral Density"]
        //Process the controllers in the window and collect the results in an array
		for var i = 0; i < mamVarList.count; i++ {
			if (mamVarList[i].state == NSOnState) {
				MAMVars.mamOrderList.append(mamVerbiageList[i])
			}
		}

    //Set the Radioloty text box to the collected array as a comma delimited string
    radView.stringValue = MAMVars.mamOrderList.joinWithSeparator(", ")
    //Close the window controlled by this class/handler
    winMam.orderOut(self)
    }
    
    //A function to set all the controllers in the window to their desired default state
    func clearMAMCheckBoxes(){
        mamSBView.state = NSOffState
        mamDBView.state = NSOffState
        mamDRView.state = NSOffState
        mamDLView.state = NSOffState
		bmdView.state = NSOffState
        
        MAMVars.mamOrderList = []
    }
    
    //Function to automatically call the clear function if the window is being freshly opened
    //by the calling button on the main window, or not if it's just becoming key again after
    //having lost key status for some other reason
    func windowDidBecomeKey(notification: NSNotification) {
        //Checks the state of the window
        if MAMVars.mamStateInt == 1 {
        //Calls the clear function
        clearMAMCheckBoxes()
        }
        //Sets the window state to already opened
        MAMVars.mamStateInt = 0
    }

}
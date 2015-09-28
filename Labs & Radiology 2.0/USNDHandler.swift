//
//  USNDHandler.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 2/26/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

//Need to import Cocoa instead of Foundation in order to get access to the needed delegates
import Cocoa

//Create a class with the delegates needed to connect to windows and controllers and receive notifications
//From the window this class is handling
class USNDHandler : NSObject, NSApplicationDelegate, NSWindowDelegate {
//Create outlet for the window this class will be the delegate of
    @IBOutlet weak var winUSND: NSWindow!
    
    @IBOutlet weak var radView: NSTextField!
    
    @IBOutlet weak var usndThyroidView: NSButton!
    @IBOutlet weak var usndGallbladderView: NSButton!
    @IBOutlet weak var usndAbView: NSButton!
    @IBOutlet weak var usndKidneysView: NSButton!
    @IBOutlet weak var usndPelvicView: NSButton!
    @IBOutlet weak var usndTransVagView: NSButton!
    @IBOutlet weak var usndTesticleView: NSButton!
    @IBOutlet weak var usndBreastBiView: NSButton!
    @IBOutlet weak var usndBreastRView: NSButton!
    @IBOutlet weak var usndBreastLView: NSButton!
    @IBOutlet weak var usndArteryView: NSButton!
    @IBOutlet weak var usndVDBLEView: NSButton!
    @IBOutlet weak var usndVDLLEView: NSButton!
    @IBOutlet weak var usndVDRLEView: NSButton!
    @IBOutlet weak var usndVDBUEView: NSButton!
    @IBOutlet weak var usndVDLUEView: NSButton!
    @IBOutlet weak var usndVDRUEView: NSButton!
    @IBOutlet weak var usndRefluxBLEView: NSButton!
    @IBOutlet weak var usndADBLEView: NSButton!
    @IBOutlet weak var usndADLLEView: NSButton!
    @IBOutlet weak var usndADRLEView: NSButton!
    @IBOutlet weak var usndADBUEView: NSButton!
    @IBOutlet weak var usndADLUEView: NSButton!
    @IBOutlet weak var usndADRUEView: NSButton!
    
    //Create a struct to hold variables available to the AppDelegate module
    struct USNDVars {
        //Create an array variable to hold the results of this window in
        static var usndOrderList = [String]()
        //Create an integer variable to hold this window's refresh status
        static var usndStateInt = Int()
    }
    
    
    @IBAction func takeUSNDProcess(sender: AnyObject) {
        //Check to see if there is already a value in the Radiology text box from a different
        //window, and if there is append it to the array which will be collecting the values
        //from processing this window.
        if radView.stringValue != "" {
            USNDVars.usndOrderList.append(radView.stringValue)
        }
        //Create a dictionary of the controllers being processed and the values attached to them
		let usndVarList1 = [usndThyroidView, usndGallbladderView, usndAbView, usndKidneysView, usndPelvicView, usndTransVagView, usndTesticleView, usndBreastBiView, usndBreastRView, usndBreastLView]
		let usndVerbiageList1 = ["Ultrasound - Thyroid","Ultrasound - Gallbladder/RUQ","Ultrasound - Complete abdominal","Ultrasound - Kidneys","Ultrasound - Pelvic","Ultrasound - Pelvic - Transvaginal","Ultrasound - Testicle/Scrotum","Ultrasound - Breasts - Bilateral","Ultrasound - Breast - Right","Ultrasound - Breast - Left"]
		let usndVarList2 = [usndArteryView, usndVDBLEView, usndVDLLEView, usndVDRLEView, usndVDBUEView, usndVDLUEView, usndVDRUEView, usndRefluxBLEView, usndADBLEView, usndADLLEView, usndADRLEView, usndADBUEView, usndADLUEView, usndADRUEView]
		let usndVerbiageList2 = ["Ultrasound - Carotid Artery Doppler","Ultrasound - Venous Doppler - Bilateral Lower Extremities","Ultrasound - Venous Doppler - Left Lower Extremities","Ultrasound - Venous Doppler - Right Lower Extremities","Ultrasound - Venous Doppler - Bilateral Upper Extremities","Ultrasound - Venous Doppler - Left Upper Extremities","Ultrasound - Venous Doppler - Right Upper Extremities","Ultrasound - Venous Reflux Doppler - Bilateral Lower Extremities","Ultrasound - Arterial Doppler - Bilateral Lower Extremities","Ultrasound - Arterial Doppler - Left Lower Extremities","Ultrasound - Arterial Doppler - Right Lower Extremites","Ultrasound - Arterial Doppler - Bilateral Upper Extremities","Ultrasound - Arterial Doppler - Left Upper Extremities","Ultrasound - Arterial Doppler - Right Upper Extremities"]
        //Process the controllers in the window and collect the results in an array
		for var i = 0; i < usndVarList1.count; i++ {
			if (usndVarList1[i].state == NSOnState) {
				USNDVars.usndOrderList.append(usndVerbiageList1[i])
			}
		}
		for var i = 0; i < usndVarList2.count; i++ {
			if (usndVarList2[i].state == NSOnState) {
				USNDVars.usndOrderList.append(usndVerbiageList2[i])
			}
		}
        //Set the Radioloty text box to the collected array as a comma delimited string
        radView.stringValue = USNDVars.usndOrderList.joinWithSeparator(", ")
        //Close the window controlled by this class/handler
        winUSND.orderOut(self)
    }
    
    func clearUSNDCheckBoxes(){
        usndThyroidView.state = NSOffState
        usndGallbladderView.state = NSOffState
        usndAbView.state = NSOffState
        usndKidneysView.state = NSOffState
        usndPelvicView.state = NSOffState
        usndTransVagView.state = NSOffState
        usndTesticleView.state = NSOffState
        usndBreastBiView.state = NSOffState
        usndBreastRView.state = NSOffState
        usndBreastLView.state = NSOffState
        usndArteryView.state = NSOffState
        usndVDBLEView.state = NSOffState
        usndVDLLEView.state = NSOffState
        usndVDRLEView.state = NSOffState
        usndVDBUEView.state = NSOffState
        usndVDLUEView.state = NSOffState
        usndVDRUEView.state = NSOffState
        usndRefluxBLEView.state = NSOffState
        usndADBLEView.state = NSOffState
        usndADLLEView.state = NSOffState
        usndADRLEView.state = NSOffState
        usndADBUEView.state = NSOffState
        usndADLUEView.state = NSOffState
        usndADRUEView.state = NSOffState
        
        USNDVars.usndOrderList = []
    }
    
    //Function to automatically call the clear function if the window is being freshly opened
    //by the calling button on the main window, or not if it's just becoming key again after
    //having lost key status for some other reason
    func windowDidBecomeKey(notification: NSNotification) {
            //Checks the state of the window
            if USNDVars.usndStateInt == 1 {
            //Calls the clear function
            clearUSNDCheckBoxes()
            }
            //Sets the window state to already opened
            USNDVars.usndStateInt = 0
    }
}

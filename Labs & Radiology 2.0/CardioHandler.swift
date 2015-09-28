//
//  CardioHandler.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 2/26/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

//Need to import Cocoa instead of Foundation in order to get access to the needed delegates
import Cocoa

//Create a class with the delegates needed to connect to windows and controllers and receive notifications
//From the window this class is handling
class CardioHandler : NSObject, NSApplicationDelegate, NSWindowDelegate {
//Create outlet for the window this class will be the delegate of
    @IBOutlet weak var winCardio: NSWindow!
    
    @IBOutlet weak var radView: NSTextField!
    
    @IBOutlet weak var cardioECHOView: NSButton!
    @IBOutlet weak var cardioTransECHOView: NSButton!
    @IBOutlet weak var cardioBubbleECHOView: NSButton!
    @IBOutlet weak var cardioEKGView: NSButton!
    @IBOutlet weak var cardioStressExerciseView: NSButton!
    @IBOutlet weak var cardioStressTreadmillView: NSButton!
    @IBOutlet weak var cardioStressLexiscanView: NSButton!
    @IBOutlet weak var cardioTreadmillECHOView: NSButton!
    @IBOutlet weak var cardio24HolterView: NSButton!
    @IBOutlet weak var cardio48HolterView: NSButton!
	@IBOutlet weak var cardio30DayEventView: NSButton!
    @IBOutlet weak var cardioTiltTableView: NSButton!
    @IBOutlet weak var resSleepHomeView: NSButton!
    @IBOutlet weak var resPolysomView: NSButton!
    @IBOutlet weak var resSleepSplitView: NSButton!
    @IBOutlet weak var resCPAPView: NSButton!
    @IBOutlet weak var resMSLTView: NSButton!
    @IBOutlet weak var resMWTView: NSButton!
    @IBOutlet weak var resPulsOxView: NSButton!
    @IBOutlet weak var resPFTCompleteView: NSButton!
    @IBOutlet weak var resPFTBasicView: NSButton!
    @IBOutlet weak var resSpiroView: NSButton!
    @IBOutlet weak var resSpiroPostBronchView: NSButton!
    @IBOutlet weak var resSpiroExerciseView: NSButton!
    @IBOutlet weak var resABGRoomAirView: NSButton!
    @IBOutlet weak var resABGO2View: NSButton!
    
    //Create a struct to hold variables available to the AppDelegate module
    struct CardioVars {
        //Create an array variable to hold the results of this window in
        static var cardioOrderList = [String]()
        //Create an integer variable to hold this window's refresh status
        static var cardioStateInt = Int()
    }
    
    @IBAction func takeCardioProcess(sender: AnyObject) {
        //Check to see if there is already a value in the Radiology text box from a different
        //window, and if there is append it to the array which will be collecting the values
        //from processing this window.
        if radView.stringValue != "" {
            CardioVars.cardioOrderList.append(radView.stringValue)
        }
        //Create a dictionary of the controllers being processed and the values attached to them
		let cardioVarList1 = [cardioECHOView, cardioTransECHOView, cardioBubbleECHOView, cardioEKGView, cardioStressExerciseView, cardioStressTreadmillView, cardioStressLexiscanView, cardioTreadmillECHOView, cardio24HolterView, cardio48HolterView, cardio30DayEventView, cardioTiltTableView, resSleepHomeView]
		let cardioVerbiageList1 = ["ECHO","Trans Esophageal ECHO","ECHO w bubble study","EKG","Stress Test: EKG Exercise","Stress Test: Treadmill Myoview","Stress Test: Lexiscan Myoview","Stress Test: Treadmill Stress ECHO","24 Hr Holter Monitor","48 Hr Holter Monitor","30 Day Cardiac Event Monitor", "Tilt Table Test","Home Sleep Study"]
		let cardioVarList2 = [resPolysomView, resSleepSplitView, resCPAPView, resMSLTView, resMWTView, resPulsOxView, resPFTCompleteView, resPFTBasicView, resSpiroView, resSpiroPostBronchView, resSpiroExerciseView, resABGRoomAirView, resABGO2View]
		let cardioVerbiageList2 = ["Sleep Study (Polysomnagram","Sleep Study - Split Night","Sleep Study - CPAP Titration Study","MSLT (Multiple Sleep Latency Test)","MWT (Maintenance of Wakefulness Test)","Overnight Pulse Ox","PFT Complete","PFT Basic","Spirometry","Spirometry w Pre/Post Bronchodilator","Spirometry Exercise","ABG Room Air","ABG w/O2"]
        //Process the controllers in the window and collect the results in an array
		for var i = 0; i < cardioVarList1.count; i++ {
			if (cardioVarList1[i].state == NSOnState) {
				CardioVars.cardioOrderList.append(cardioVerbiageList1[i])
			}
		}
		for var i = 0; i < cardioVarList2.count; i++ {
			if (cardioVarList2[i].state == NSOnState) {
				CardioVars.cardioOrderList.append(cardioVerbiageList2[i])
			}
		}

        //Set the Radioloty text box to the collected array as a comma delimited string
        radView.stringValue = CardioVars.cardioOrderList.joinWithSeparator(", ")
        //Close the window controlled by this class/handler
        winCardio.orderOut(self)
    }
    
    func clearCardioCheckBoxes() {
        cardioECHOView.state = NSOffState
        cardioTransECHOView.state = NSOffState
        cardioBubbleECHOView.state = NSOffState
        cardioEKGView.state = NSOffState
        cardioStressExerciseView.state = NSOffState
        cardioStressTreadmillView.state = NSOffState
        cardioStressLexiscanView.state = NSOffState
        cardioTreadmillECHOView.state = NSOffState
        cardio24HolterView.state = NSOffState
        cardio48HolterView.state = NSOffState
		cardio30DayEventView.state = NSOffState
        cardioTiltTableView.state = NSOffState
        resSleepHomeView.state = NSOffState
        resPolysomView.state = NSOffState
        resSleepSplitView.state = NSOffState
        resCPAPView.state = NSOffState
        resMSLTView.state = NSOffState
        resMWTView.state = NSOffState
        resPulsOxView.state = NSOffState
        resPFTCompleteView.state = NSOffState
        resPFTBasicView.state = NSOffState
        resSpiroView.state = NSOffState
        resSpiroPostBronchView.state = NSOffState
        resSpiroExerciseView.state = NSOffState
        resABGRoomAirView.state = NSOffState
        resABGO2View.state = NSOffState
        CardioVars.cardioOrderList = []
    }
    
    func windowDidBecomeKey(notification: NSNotification) {
            if CardioVars.cardioStateInt == 1 {
            clearCardioCheckBoxes()
            }
            CardioVars.cardioStateInt = 0
    }

}

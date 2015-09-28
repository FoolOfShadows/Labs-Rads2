//
//  MRIHandler.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 2/25/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

//Need to import Cocoa instead of Foundation in order to get access to the needed delegates
import Cocoa

//Create a class with the delegates needed to connect to windows and controllers and receive notifications
//From the window this class is handling
class MRIHandler : NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    @IBOutlet weak var winMRI: NSWindow!
    @IBOutlet weak var radView: NSTextField!
    @IBOutlet weak var mriBrainWView: NSButton!
    @IBOutlet weak var mriBrainWOView: NSButton!
    @IBOutlet weak var mriBrainWWOView: NSButton!
    @IBOutlet weak var mriCSpineView: NSButton!
    @IBOutlet weak var mriTSpineView: NSButton!
    @IBOutlet weak var mriLSpineView: NSButton!
    @IBOutlet weak var mriCTLSpineView: NSButton!
    @IBOutlet weak var mriNeckView: NSButton!
    @IBOutlet weak var mriExtremityView: NSButton!
    @IBOutlet weak var mriExtremityTextView: NSTextField!
    @IBOutlet weak var mriAbView: NSButton!
    @IBOutlet weak var mriAbPelvisWOView: NSButton!
    @IBOutlet weak var mriAbPelvisPOIVView: NSButton!
    @IBOutlet weak var mriAbPelvisPOView: NSButton!
    @IBOutlet weak var mriChestWView: NSButton!
    @IBOutlet weak var mriChestWOView: NSButton!
    @IBOutlet weak var mriChestWWOView: NSButton!
    @IBOutlet weak var mriSinusView: NSButton!
    @IBOutlet weak var mraBrainWView: NSButton!
    @IBOutlet weak var mraBrainWOView: NSButton!
    @IBOutlet weak var mraBrainWWOView: NSButton!
    @IBOutlet weak var mraNeckView: NSButton!
    @IBOutlet weak var mraBUEView: NSButton!
    @IBOutlet weak var mraBLEView: NSButton!
    @IBOutlet weak var mraAbPelvisView: NSButton!
    @IBOutlet weak var eegView: NSButton!
	@IBOutlet weak var emgView: NSButton!
    @IBOutlet weak var petVeiw: NSButton!
    @IBOutlet weak var petTextView: NSTextField!
    
    
    //Create a struct to hold the result of the takeMRIProcess function in a variable available to the AppDelegate module
    struct MRIVars {
        static var mriOrderList = [String]()
        static var mriStateInt = Int()
    }
    
    //Process the data when the button is clicked
    @IBAction func takeMRIProcess(sender: AnyObject) {
        if radView.stringValue != "" {
        MRIVars.mriOrderList.append(radView.stringValue)
        }
		let mriVarList1 = [mriBrainWView, mriBrainWOView, mriBrainWWOView, mriCSpineView, mriTSpineView, mriLSpineView, mriCTLSpineView, mriNeckView, mriExtremityView, mriAbView, mriAbPelvisWOView, mriAbPelvisPOIVView]
		let mriVerbiageList1 = ["MRI - Brain w Contrast","MRI - Brain wo Contrast","MRI - Brain wwo Contrast","MRI - C spine","MRI - T spine","MRI - L spine","MRI - CTL spine","MRI - Neck Soft Tissue","MRI - Extremity - \(mriExtremityTextView.stringValue)","MRI - Abdomen","MRI - Abdomen & Pelvis wo Contrast","MRI - Abdomen & Pelvis w PO&IV Contrast"]
		let mriVarList2 = [mriAbPelvisPOView, mriChestWView, mriChestWOView, mriChestWWOView, mriSinusView, mraBrainWView, mraBrainWOView, mraBrainWWOView, mraNeckView, mraBUEView, mraBLEView, mraAbPelvisView, eegView, emgView, petVeiw]
		let mriVerbiageList2 = ["MRI - Abdomen & Pelvis w PO Contrast","MRI - Chest w Contrast","MRI - Chest wo Contrast","MRI - Chest wwo Contrast","MRI - Sinuses","MRA - Brain w Contrast","MRA - Brain wo Contrast","MRA - Brain wwo Contrast","MRA - Neck and great vessels","MRA - Bilateral Upper Extremities","MRA - Bilateral Lower Extremities","MRA -Abdomen & Pelvis","EEG", "EMG - Nerve conduction study", "PET - \(petTextView.stringValue)"]
		
		for var i = 0; i < mriVarList1.count; i++ {
			if (mriVarList1[i].state == NSOnState) {
				MRIVars.mriOrderList.append(mriVerbiageList1[i])
			}
		}
		for var i = 0; i < mriVarList2.count; i++ {
			if (mriVarList2[i].state == NSOnState) {
				MRIVars.mriOrderList.append(mriVerbiageList2[i])
			}
		}
        
        radView.stringValue = MRIVars.mriOrderList.joinWithSeparator(", ")
        winMRI.orderOut(self)
    }
    
    func clearMRICheckBoxes() {
        mriBrainWView.state = NSOffState
        mriBrainWOView.state = NSOffState
        mriBrainWWOView.state = NSOffState
        mriCSpineView.state = NSOffState
        mriTSpineView.state = NSOffState
        mriLSpineView.state = NSOffState
        mriCTLSpineView.state = NSOffState
        mriNeckView.state = NSOffState
        mriExtremityView.state = NSOffState
        mriExtremityTextView.stringValue = ""
        mriAbView.state = NSOffState
        mriAbPelvisWOView.state = NSOffState
        mriAbPelvisPOIVView.state = NSOffState
        mriAbPelvisPOView.state = NSOffState
        mriChestWView.state = NSOffState
        mriChestWOView.state = NSOffState
        mriChestWWOView.state = NSOffState
        mriSinusView.state = NSOffState
        mraBrainWView.state = NSOffState
        mraBrainWOView.state = NSOffState
        mraBrainWWOView.state = NSOffState
        mraNeckView.state = NSOffState
        mraBUEView.state = NSOffState
        mraBLEView.state = NSOffState
        mraAbPelvisView.state = NSOffState
        eegView.state = NSOffState
        petVeiw.state = NSOffState
        petTextView.stringValue = ""
        
        MRIVars.mriOrderList = []
    }
    
    func windowDidBecomeKey(notification: NSNotification) {
        if MRIVars.mriStateInt == 1 {
            clearMRICheckBoxes()
        }
        MRIVars.mriStateInt = 0
    }
}
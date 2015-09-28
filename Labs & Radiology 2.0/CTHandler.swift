//
//  CTHandler.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 2/26/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

//Need to import Cocoa instead of Foundation in order to get access to the needed delegates
import Cocoa

//Create a class with the delegates needed to connect to windows and controllers and receive notifications
//From the window this class is handling
class CTHandler : NSObject, NSApplicationDelegate, NSWindowDelegate {

    @IBOutlet weak var winCT: NSWindow!

    @IBOutlet weak var radView: NSTextField!

    @IBOutlet weak var ctAngioBrainView: NSButton!
    @IBOutlet weak var ctAngioAbView: NSButton!
    @IBOutlet weak var ctBrainWView: NSButton!
    @IBOutlet weak var ctBrainWOView: NSButton!
    @IBOutlet weak var ctBrainWWOView: NSButton!
    @IBOutlet weak var ctChestWView: NSButton!
    @IBOutlet weak var ctChestWOView: NSButton!
    @IBOutlet weak var ctChestWWOView: NSButton!
    @IBOutlet weak var ctPEView: NSButton!
    @IBOutlet weak var ctLowDoseView: NSButton!
    @IBOutlet weak var ctCalciumView: NSButton!
    @IBOutlet weak var ctArteriesView: NSButton!
    @IBOutlet weak var ctAbView: NSButton!
    @IBOutlet weak var ctAbPelvWOView: NSButton!
    @IBOutlet weak var ctAbPelvPOIVView: NSButton!
    @IBOutlet weak var ctAbPelvPOView: NSButton!
    @IBOutlet weak var ctRenalStoneView: NSButton!
    @IBOutlet weak var ctSinusView: NSButton!
    @IBOutlet weak var ctNeckView: NSButton!
    @IBOutlet weak var ctExtremityView: NSButton!
    @IBOutlet weak var ctExtremityTextView: NSTextField!
    @IBOutlet weak var ctCSpineView: NSButton!
    @IBOutlet weak var ctTSpineView: NSButton!
    @IBOutlet weak var ctLSpineView: NSButton!
    @IBOutlet weak var ctCTLSpineView: NSButton!
    
    
    //Create a struct to hold variables available to the AppDelegate module
    struct CTVars {
        //Create an array variable to hold the results of this window in
        static var ctOrderList = [String]()
        //Create an integer variable to hold this window's refresh status
        static var ctStateInt = Int()
    }
    
    @IBAction func takeCTProcess(sender: AnyObject) {
        if radView.stringValue != "" {
            CTVars.ctOrderList.append(radView.stringValue)
        }
        let ctVarList1 = [ctAngioBrainView, ctAngioAbView, ctBrainWView, ctBrainWOView, ctBrainWWOView, ctChestWView, ctChestWOView, ctChestWWOView, ctPEView, ctLowDoseView, ctCalciumView, ctArteriesView]
		let ctVerbiageList1 = ["CT - Angio Brain","CT - Angio Abdomen/Pelvis w/runoff","CT - Brain w Contrast","CT - Brain wo Contrast","CT - Brain wwo Contrast","CT - Chest w Contrast","CT - Chest wo Contrast","CT - Chest wwo Contrast","CT - Chest PE Protocol","CT - Chest Low Dose Lung Cancer Screen","CT - Coronary Calcium","CT - Coronary Arteries"]
		let ctVarList2 = [ctAbView, ctAbPelvWOView, ctAbPelvPOIVView, ctAbPelvPOView, ctRenalStoneView, ctSinusView, ctNeckView,ctExtremityView, ctCSpineView, ctTSpineView, ctLSpineView, ctCTLSpineView]
		let ctVerbiageList2 = ["CT - Abdomen","CT - Abdomen & Pelvis wo Contrast","CT - Abdomen & Pelvis w PO&IV Contrast","CT - Abdomen & Pelvis w PO Contrast","CT - Abdomen & Pelvis Renal stone Protocol","CT - Sinus","CT - Neck Soft Tissue","CT - Extremity - \(ctExtremityTextView.stringValue)","CT - Myelogram C Spine","CT - Myelogram T Spine","CT - Myelogram L Spine","CT - Myelogram CTL Spine"]
		
		for var i = 0; i < ctVarList1.count; i++ {
			if (ctVarList1[i].state == NSOnState) {
				CTVars.ctOrderList.append(ctVerbiageList1[i])
			}
		}
		for var i = 0; i < ctVarList2.count; i++ {
			if (ctVarList2[i].state == NSOnState) {
				CTVars.ctOrderList.append(ctVerbiageList2[i])
			}
		}
        
		
        radView.stringValue = CTVars.ctOrderList.joinWithSeparator(", ")
        winCT.orderOut(self)
    }
    
    func clearCTCheckBoxes(){
        ctAngioBrainView.state = NSOffState
        ctAngioAbView.state = NSOffState
        ctBrainWView.state = NSOffState
        ctBrainWOView.state = NSOffState
        ctBrainWWOView.state = NSOffState
        ctChestWView.state = NSOffState
        ctChestWOView.state = NSOffState
        ctChestWWOView.state = NSOffState
        ctPEView.state = NSOffState
        ctLowDoseView.state = NSOffState
        ctCalciumView.state = NSOffState
        ctArteriesView.state = NSOffState
        ctAbView.state = NSOffState
        ctAbPelvWOView.state = NSOffState
        ctAbPelvPOIVView.state = NSOffState
        ctAbPelvPOView.state = NSOffState
        ctRenalStoneView.state = NSOffState
        ctSinusView.state = NSOffState
        ctNeckView.state = NSOffState
        ctExtremityView.state = NSOffState
        ctExtremityTextView.stringValue = ""
        ctCSpineView.state = NSOffState
        ctTSpineView.state = NSOffState
        ctLSpineView.state = NSOffState
        ctCTLSpineView.state = NSOffState
        
        CTVars.ctOrderList = []
    }
    
    func windowDidBecomeKey(notification: NSNotification) {
            if CTVars.ctStateInt == 1 {
            clearCTCheckBoxes()
            }
            CTVars.ctStateInt = 0
    }
}
//
//  XRAYHandler.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 2/25/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

import Cocoa

class XRAYHandler : NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    @IBOutlet weak var winXRAY: NSWindow!
    @IBOutlet weak var xrayChestView: NSButton!
    @IBOutlet weak var xrayRibView: NSButton!
    @IBOutlet weak var xrayAbView: NSButton!
    @IBOutlet weak var xrayCSpineView: NSButton!
    @IBOutlet weak var xrayTSpineView: NSButton!
    @IBOutlet weak var xrayLSSpineView: NSButton!
    @IBOutlet weak var xrayShoulderView: NSButton!
    @IBOutlet weak var xrayKneeView: NSButton!
    @IBOutlet weak var xrayHipView: NSButton!
    @IBOutlet weak var xrayPelvisView: NSButton!
    @IBOutlet weak var xrayFemurView: NSButton!
    @IBOutlet weak var xrayTibFibView: NSButton!
    @IBOutlet weak var xrayAnkleView: NSButton!
    @IBOutlet weak var xrayFootView: NSButton!
    @IBOutlet weak var xrayElbowView: NSButton!
    @IBOutlet weak var xrayWristView: NSButton!
    @IBOutlet weak var xrayHandView: NSButton!
    @IBOutlet weak var xrayMyeloView: NSButton!
    @IBOutlet weak var xrayMyeloTextView: NSTextField!
    @IBOutlet weak var xrayGIView: NSButton!
    @IBOutlet weak var xrayBariumView: NSButton!
    @IBOutlet weak var xraySwallowView: NSButton!
    @IBOutlet weak var xrayGastroView: NSButton!
    
    @IBOutlet weak var radView: NSTextField!

    //Create a struct to hold the result of the takeXRAYProcess function in a variable available to the AppDelegate module
    struct XRAYVars {
        static var xrayOrderList = [String]()
        static var xrayStateInt = Int()
    }
    
    @IBAction func takeXRAYProcess(sender: AnyObject) {
        if radView.stringValue != "" {
        XRAYVars.xrayOrderList.append(radView.stringValue)
        }
		
		let xrayVarList1 = [xrayChestView, xrayRibView, xrayAbView, xrayCSpineView, xrayTSpineView, xrayLSSpineView, xrayShoulderView, xrayKneeView, xrayHipView, xrayPelvisView, xrayFemurView]
		let xrayVerbiageList1 = ["Xray - Chest PA&Lat","Xray - Rib series","Xray - Abdomen Flat & Upright","Xray - C spine series","Xray - T spine series","Xray - LS spine series","Xray - Shoulder series","Xray - Knee series with Standing film","Xray - Hip","Xray - Pelvis","Xray - Femur"]
		let xrayVarList2 = [xrayTibFibView, xrayAnkleView, xrayFootView, xrayElbowView, xrayWristView, xrayHandView, xrayMyeloView, xrayGIView, xrayBariumView, xraySwallowView, xrayGastroView]
		let xrayVerbiageList2 = ["Xray - Tib Fib","Xray - Ankle","Xray - Foot","Xray - Elbow","Xray - Wrist","Xray - Hand", "Xray - Plain Myelogram - \(xrayMyeloTextView.stringValue)","Xray - Upper GI","Xray - Barium Swallow","Xray - Swallow Function Study","Xray - Gastrogaffin Enema"]
		
		for var i = 0; i < xrayVarList1.count; i++ {
			if (xrayVarList1[i].state == NSOnState) {
				XRAYVars.xrayOrderList.append(xrayVerbiageList1[i])
			}
		}
		for var i = 0; i < xrayVarList2.count; i++ {
			if (xrayVarList2[i].state == NSOnState) {
				XRAYVars.xrayOrderList.append(xrayVerbiageList2[i])
			}
		}
		
        radView.stringValue = XRAYVars.xrayOrderList.joinWithSeparator(", ")
        winXRAY.orderOut(self)
    }
    
    func clearXRAYCheckBoxes(){
        xrayChestView.state = NSOffState
        xrayRibView.state = NSOffState
        xrayAbView.state = NSOffState
        xrayCSpineView.state = NSOffState
        xrayTSpineView.state = NSOffState
        xrayLSSpineView.state = NSOffState
        xrayShoulderView.state = NSOffState
        xrayKneeView.state = NSOffState
        xrayHipView.state = NSOffState
        xrayPelvisView.state = NSOffState
        xrayFemurView.state = NSOffState
        xrayTibFibView.state = NSOffState
        xrayAnkleView.state = NSOffState
        xrayFootView.state = NSOffState
        xrayElbowView.state = NSOffState
        xrayWristView.state = NSOffState
        xrayHandView.state = NSOffState
        xrayMyeloView.state = NSOffState
        xrayMyeloTextView.stringValue = ""
        xrayGIView.state = NSOffState
        xrayBariumView.state = NSOffState
        xraySwallowView.state = NSOffState
        xrayGastroView.state = NSOffState
        
        XRAYVars.xrayOrderList = []
    }
    
    func windowDidBecomeKey(notification: NSNotification) {
            if XRAYVars.xrayStateInt == 1 {
            clearXRAYCheckBoxes()
            }
            XRAYVars.xrayStateInt = 0
    }
    
    
}

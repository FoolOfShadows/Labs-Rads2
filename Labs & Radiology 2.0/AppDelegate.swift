//
//  AppDelegate.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 1/30/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

import Cocoa
import Darwin


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    //Windows
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var winMAM: NSWindow!
    @IBOutlet weak var winXRAY: NSWindow!
    @IBOutlet weak var winMRI: NSWindow!
    @IBOutlet weak var winCT: NSWindow!
    @IBOutlet weak var winUSND: NSWindow!
    @IBOutlet weak var winNUC: NSWindow!
    @IBOutlet weak var winCardio: NSWindow!
    @IBOutlet weak var winREF: NSWindow!
	@IBOutlet weak var winPrint: NSWindow!
    

    //Lab Controllers
	@IBOutlet weak var bmpView: NSComboBox!
    @IBOutlet weak var cmpView: NSComboBox!
    @IBOutlet weak var cbcView: NSComboBox!
    @IBOutlet weak var tshView: NSComboBox!
    @IBOutlet weak var ft4view: NSComboBox!
    @IBOutlet weak var ft3View: NSComboBox!
    @IBOutlet weak var vitDView: NSComboBox!
    @IBOutlet weak var urACView: NSComboBox!
    @IBOutlet weak var cpkView: NSComboBox!
    @IBOutlet weak var esrView: NSComboBox!
    @IBOutlet weak var crpView: NSComboBox!
    @IBOutlet weak var rfView: NSComboBox!
    @IBOutlet weak var fpsaView: NSComboBox!
    @IBOutlet weak var hsvView: NSComboBox!
    @IBOutlet weak var rprView: NSComboBox!
    @IBOutlet weak var clamView: NSComboBox!
    @IBOutlet weak var lpdView: NSComboBox!
    @IBOutlet weak var psaView: NSComboBox!
    @IBOutlet weak var udipView: NSComboBox!
    @IBOutlet weak var ucxView: NSComboBox!
    @IBOutlet weak var udsView: NSComboBox!
    @IBOutlet weak var ucgView: NSComboBox!
    @IBOutlet weak var pttView: NSComboBox!
    @IBOutlet weak var fshView: NSComboBox!
    @IBOutlet weak var tstView: NSComboBox!
    @IBOutlet weak var anaView: NSComboBox!
    @IBOutlet weak var b12View: NSComboBox!
    @IBOutlet weak var hpylView: NSComboBox!
    @IBOutlet weak var papView: NSComboBox!
    @IBOutlet weak var hivView: NSComboBox!
    @IBOutlet weak var gonView: NSComboBox!
    @IBOutlet weak var lpdnmrView: NSComboBox!
    @IBOutlet weak var hba1cView: NSComboBox!
    @IBOutlet weak var umalbView: NSComboBox!
    @IBOutlet weak var uamicView: NSComboBox!
    @IBOutlet weak var mudsView: NSComboBox!
    @IBOutlet weak var uprcrView: NSComboBox!
    @IBOutlet weak var ptinrView: NSComboBox!
    @IBOutlet weak var hrmpnlView: NSComboBox!
    @IBOutlet weak var ftstView: NSComboBox!
    @IBOutlet weak var anapnlView: NSComboBox!
    @IBOutlet weak var anemiapnlView: NSComboBox!
    @IBOutlet weak var cortisolView: NSComboBox!
    @IBOutlet weak var stoolView: NSComboBox!
    @IBOutlet weak var cheppnlView: NSComboBox!
    @IBOutlet weak var aheppnlView: NSComboBox!
    @IBOutlet weak var other1View: NSComboBox!
    @IBOutlet weak var other2View: NSComboBox!
    @IBOutlet weak var other1TextView: NSTextField!
    @IBOutlet weak var other2TextView: NSTextField!
    
    @IBOutlet weak var reviewedView: NSButton!
    @IBOutlet weak var fastingView: NSButton!
    @IBOutlet weak var nextLabDueView: NSMatrix!
    
    @IBOutlet weak var radView: NSTextField!
    @IBOutlet weak var refView: NSTextField!
    
    //Order Prep window controllers
    @IBOutlet weak var winOrderPrep: NSWindow!
    @IBOutlet weak var ptNameView: NSTextField!
    @IBOutlet weak var ptDOBView: NSTextField!
    @IBOutlet weak var currentDateView: NSTextField!
    @IBOutlet weak var mcPrimaryView: NSMatrix!
    
	@IBOutlet var textToPrint: NSTextView!
	
	
	
    //Process Labs etc to the clipboard for pasting in the note
    

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        clearForm()
    }
    

    @IBAction func takeProcessForNote(sender: AnyObject) {
        //Set the section vars to empty strings to make it easier to test them for values later
        var returnedLabList = ""
        var returnedRadiology = ""
        var returnedReferrals = ""
        
        //Call function to process controllers and return string to var
        returnedLabList = processLabOrders()
        
        //get rad info
        if radView.stringValue != "" {
            returnedRadiology = "Tests ordered: " + radView.stringValue + "\n"
        }
        //get ref info
        if refView.stringValue != "" {
            returnedReferrals = "Referrals made: " + refView.stringValue + "\n"
        }
        //Concatenate the values into a single var
        let finalValues = returnedLabList + returnedRadiology + returnedReferrals
        
        //Push the final results to the system clipboard
        let pasteBoard = NSPasteboard.generalPasteboard()
        pasteBoard.clearContents()
        pasteBoard.setString(finalValues, forType: NSPasteboardTypeString)
        
        //println(finalValues)
    }
    
    @IBAction func takePrintSave(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        let currentDate = dateFormatter.stringFromDate(NSDate())
        winOrderPrep.makeKeyAndOrderFront(self)
        ptNameView.stringValue = ""
        ptDOBView.stringValue = ""
        currentDateView.stringValue = currentDate
        mcPrimaryView.selectCellAtRow(0, column: 0)
    }
	
	//Cancel Note Printing Window
	@IBAction func cancelTakePrintSaveWindow(sender: AnyObject) {
		winPrint.orderOut(self)
	}
	
	@IBAction func printTakePrintSaveWindow(sender: AnyObject) {
		winPrint.orderOut(self)
	}
	
    
    @IBAction func takeProcessForPrint(sender: AnyObject) {
        var returnedLabList = ""
		var returnedLabsForNote = ""
        
        let patientName = ptNameView.stringValue
		var patientDOB = ""
		var mcPrimary = ""
		var addOn = ""
		
		if nextLabDueView.stringValue == "Add On" {
		patientDOB = "DOB:  \(ptDOBView.stringValue)" + "\n\n" + "- ADD ON LAB -"
		} else {
		patientDOB = "DOB:  \(ptDOBView.stringValue)"
		}
		
		if mcPrimaryView.selectedCell()!.tag == 1 {
			mcPrimary = "YES"
		} else if mcPrimaryView.selectedCell()!.tag == 0 {
			mcPrimary = "NO"
		}
		
		if nextLabDueView.selectedTag() == 4 {
			addOn = "— ADD ON LAB —\n\n"
		}
		
        returnedLabList = processLabOrdersForPrint()
		returnedLabsForNote = processLabOrders()
        
        let headerInfo = ("Whelchel Primary Care Medicine" + "\n" + "401 East Pinecrest, Marshall, TX  75670" + "\n" + "CPL Client #: 36686" + "\n" + "Phone: 903-935-7101     Fax: 903-935-7043")
		
		let patientInfo = ("NAME:  \(patientName)" + "\t\t" + "M/C PRIMARY:  \(mcPrimary)"
							+ "\n"
							+ "\(patientDOB)" + "\n\n"
							+ addOn
							+ "DATE ORDERED:  \(currentDateView.stringValue)")
		let headerLabels = ("TEST" + "\t" + " - " + "\t" + "DX CODE")
		
		let labOrderOutputText = "\(headerInfo)" + "\n\n"
									+ "\(patientInfo)" + "\n\n"
									+ "\(headerLabels)" + "\n"
									+ "\(returnedLabList)" + "\n\n\n\n"
									+ "Dawn Whelchel, MD" + "\n\n\n\n"
									+ "\(returnedLabsForNote)"
		
        winOrderPrep.orderOut(self)
		winPrint.makeKeyAndOrderFront(self)
		self.textToPrint.string = labOrderOutputText		
        print(labOrderOutputText)
		
    }
	
//	@IBAction func takeProcessForSave(sender: AnyObject) {
//	}
	
	//Close the order prep window to cancel processing for saving or print
	@IBAction func takeCancelProcessing(sender: AnyObject) {
		winOrderPrep.orderOut(self)
	}
	
    //Call Clear function
    @IBAction func takeClear(sender: AnyObject) {
        clearForm()
    }
	
    //Preset lab selectors
    @IBAction func take90DayLab(sender: AnyObject) {
        cmpView.selectItemAtIndex(1)
        cbcView.selectItemAtIndex(1)
        tshView.selectItemAtIndex(1)
        lpdView.selectItemAtIndex(1)
    }
    
    @IBAction func takeDMLab(sender: AnyObject) {
        cmpView.selectItemAtIndex(1)
        cbcView.selectItemAtIndex(1)
        tshView.selectItemAtIndex(1)
        hba1cView.selectItemAtIndex(1)
        umalbView.selectItemAtIndex(1)
    }
    
    @IBAction func takeThyLab(sender: AnyObject) {
        tshView.selectItemAtIndex(1)
        ft4view.selectItemAtIndex(1)
        ft3View.selectItemAtIndex(1)
    }
    
    @IBAction func takeRheumLab(sender: AnyObject) {
        urACView.selectItemAtIndex(1)
        cpkView.selectItemAtIndex(1)
        esrView.selectItemAtIndex(1)
        crpView.selectItemAtIndex(1)
        rfView.selectItemAtIndex(1)
        anaView.selectItemAtIndex(1)
    }
    
    @IBAction func takeSTDPanel(sender: AnyObject) {
        hsvView.selectItemAtIndex(1)
		rprView.selectItemAtIndex(1)
		hivView.selectItemAtIndex(1)
		cheppnlView.selectItemAtIndex(1)
    }
	
    //Set all form controllers to an ON state for testing
    @IBAction func takeSelectAll(sender: AnyObject) {
        //have all controllers switched to a valid on state for testing
    }
	
    //Open the subwindows to order radiology
    @IBAction func takeXRAY(sender: AnyObject) {
        XRAYHandler.XRAYVars.xrayStateInt = 1
        winXRAY.makeKeyAndOrderFront(self)
    }
    
    @IBAction func takeMRI(sender: AnyObject) {
        MRIHandler.MRIVars.mriStateInt = 1
        winMRI.makeKeyAndOrderFront(self)
    }
    
    @IBAction func takeCT(sender: AnyObject) {
        CTHandler.CTVars.ctStateInt = 1
        winCT.makeKeyAndOrderFront(self)
    }
    
    @IBAction func takeUSND(sender: AnyObject) {
        USNDHandler.USNDVars.usndStateInt = 1
        winUSND.makeKeyAndOrderFront(self)
    }
    
    @IBAction func takeNUC(sender: AnyObject) {
        NUCHandler.NUCVars.nucStateInt = 1
        winNUC.makeKeyAndOrderFront(self)
    }
    
    @IBAction func takeCardio(sender: AnyObject) {
        CardioHandler.CardioVars.cardioStateInt = 1
        winCardio.makeKeyAndOrderFront(self)
    }
	
    @IBAction func takeMAM(sender: AnyObject) {
        MAMHandler.MAMVars.mamStateInt = 1
        winMAM.makeKeyAndOrderFront(self)
    }
    
    @IBAction func takeREF(sender: AnyObject) {
        REFHandler.REFVars.refStateInt = 1
        winREF.makeKeyAndOrderFront(self)
    }
	
	//Set form controllers to default state
    func clearForm () {
        bmpView.removeAllItems()
        bmpView.addItemsWithObjectValues(["", "v58.69", "v70.0", "401.1", "401.9", "250.00", "250.02", "585.9"])
        bmpView.selectItemAtIndex(0)
        cmpView.removeAllItems()
        cmpView.addItemsWithObjectValues(["", "v58.69", "v70.0", "401.1", "401.9", "250.00", "585.9", "789.00"])
        cmpView.selectItemAtIndex(0)
        cbcView.removeAllItems()
        cbcView.addItemsWithObjectValues(["", "v58.69", "v70.0", "281.9", "281.0", "281.1", "280.9", "780.79", "496"])
        cbcView.selectItemAtIndex(0)
        tshView.removeAllItems()
        tshView.addItemsWithObjectValues(["", "v58.69", "v70.0", "244.9", "780.79"])
        tshView.selectItemAtIndex(0)
        ft4view.removeAllItems()
        ft4view.addItemsWithObjectValues(["", "v58.69", "v70.0", "244.9", "780.79"])
        ft4view.selectItemAtIndex(0)
        ft3View.removeAllItems()
        ft3View.addItemsWithObjectValues(["", "v58.69", "v70.0", "244.9", "780.79"])
        ft3View.selectItemAtIndex(0)
        vitDView.removeAllItems()
        vitDView.addItemsWithObjectValues(["", "v58.69", "v70.0", "268.9", "733.00", "733.90", "269.9"])
        vitDView.selectItemAtIndex(0)
        urACView.removeAllItems()
        urACView.addItemsWithObjectValues(["", "v58.69", "v70.0", "274.00", "274.9", "719.49"])
        urACView.selectItemAtIndex(0)
        cpkView.removeAllItems()
        cpkView.addItemsWithObjectValues(["", "v58.69", "v70.0", "729.1"])
        cpkView.selectItemAtIndex(0)
        esrView.removeAllItems()
        esrView.addItemsWithObjectValues(["", "v58.69", "v70.0", "719.49", "729.1", "784.0"])
        esrView.selectItemAtIndex(0)
        crpView.removeAllItems()
        crpView.addItemsWithObjectValues(["", "v58.69", "v70.0", "719.49", "729.1"])
        crpView.selectItemAtIndex(0)
        rfView.removeAllItems()
        rfView.addItemsWithObjectValues(["", "v58.69", "v70.0", "719.49", "714.0"])
        rfView.selectItemAtIndex(0)
        fpsaView.removeAllItems()
        fpsaView.addItemsWithObjectValues(["", "v58.69", "v70.0", "719.49", "714.0"])
        fpsaView.selectItemAtIndex(0)
        hsvView.removeAllItems()
        hsvView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        hsvView.selectItemAtIndex(0)
        rprView.removeAllItems()
        rprView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        rprView.selectItemAtIndex(0)
        clamView.removeAllItems()
        clamView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        clamView.selectItemAtIndex(0)
        lpdView.removeAllItems()
        lpdView.addItemsWithObjectValues(["", "v58.69", "v70.0", "272.4", "272.2", "272.0", "250.00", "250.02"])
        lpdView.selectItemAtIndex(0)
        psaView.removeAllItems()
        psaView.addItemsWithObjectValues(["", "v58.69", "v70.0", "v76.44", "600.00", "600.01", "185"])
        psaView.selectItemAtIndex(0)
        udipView.removeAllItems()
        udipView.addItemsWithObjectValues(["", "v58.69", "v70.0", "788.41", "788.63", "788.1", "788.31", "788.43", "599.0", "599.71", "599.72"])
        udipView.selectItemAtIndex(0)
        ucxView.removeAllItems()
        ucxView.addItemsWithObjectValues(["", "v58.69", "v70.0", "599.0"])
        ucxView.selectItemAtIndex(0)
        udsView.removeAllItems()
        udsView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        udsView.selectItemAtIndex(0)
        ucgView.removeAllItems()
        ucgView.addItemsWithObjectValues(["", "v58.69", "v70.0", "625.9"])
        ucgView.selectItemAtIndex(0)
        pttView.removeAllItems()
        pttView.addItemsWithObjectValues(["", "v58.69", "v70.0", "782.7", "v72.84", "451.2", "428.0", "427.3", "435.9"])
        pttView.selectItemAtIndex(0)
        fshView.removeAllItems()
        fshView.addItemsWithObjectValues(["", "v58.69", "v70.0", "627.2", "627.0", "627.1", "627.4", "628.0", "256.4", "257.2"])
        fshView.selectItemAtIndex(0)
        tstView.removeAllItems()
        tstView.addItemsWithObjectValues(["", "v58.69", "v70.0", "257.2"])
        tstView.selectItemAtIndex(0)
        anaView.removeAllItems()
        anaView.addItemsWithObjectValues(["", "v58.69", "v70.0", "719.49", "729.1"])
        anaView.selectItemAtIndex(0)
        anemiapnlView.removeAllItems()
        anemiapnlView.addItemsWithObjectValues(["", "v58.69", "v70.0", "281.9", "281.0", "281.1", "280.9"])
        anemiapnlView.selectItemAtIndex(0)
        b12View.removeAllItems()
        b12View.addItemsWithObjectValues(["", "v58.69", "v70.0", "281.9", "281.0", "281.1", "280.9", "529.0", "781.2"])
        b12View.selectItemAtIndex(0)
        hpylView.removeAllItems()
        hpylView.addItemsWithObjectValues(["", "v58.69", "v70.0", "530.81"])
        hpylView.selectItemAtIndex(0)
        papView.removeAllItems()
        papView.addItemsWithObjectValues(["", "v58.69", "v70.0", "530.81"])
        papView.selectItemAtIndex(0)
        hivView.removeAllItems()
        hivView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        hivView.selectItemAtIndex(0)
        gonView.removeAllItems()
        gonView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        gonView.selectItemAtIndex(0)
        lpdnmrView.removeAllItems()
        lpdnmrView.addItemsWithObjectValues(["", "v58.69", "v70.0", "272.4", "272.2", "272.0", "250.00", "250.02"])
        lpdnmrView.selectItemAtIndex(0)
        hba1cView.removeAllItems()
        hba1cView.addItemsWithObjectValues(["", "v58.69", "v70.0", "250.00", "250.02", "250.01", "250.03", "790.29"])
        hba1cView.selectItemAtIndex(0)
        umalbView.removeAllItems()
        umalbView.addItemsWithObjectValues(["", "v58.69", "v70.0", "250.00", "250.02", "250.01", "250.03", "401.1", "401.9", "585.9"])
        umalbView.selectItemAtIndex(0)
        uamicView.removeAllItems()
        uamicView.addItemsWithObjectValues(["", "v58.69", "v70.0", "599.71", "599.72"])
        uamicView.selectItemAtIndex(0)
        mudsView.removeAllItems()
        mudsView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        mudsView.selectItemAtIndex(0)
        uprcrView.removeAllItems()
        uprcrView.addItemsWithObjectValues(["", "v58.69", "v70.0", "585.9", "791.0", "250.00", "401.1", "401.9"])
        uprcrView.selectItemAtIndex(0)
        ptinrView.removeAllItems()
        ptinrView.addItemsWithObjectValues(["", "v58.69", "v70.0", "v58.61", "782.7", "v72.84"])
        ptinrView.selectItemAtIndex(0)
        hrmpnlView.removeAllItems()
        hrmpnlView.addItemsWithObjectValues(["", "v58.69", "v70.0", "627.2", "627.0", "627.1", "627.4", "628.0", "256.4", "257.2"])
        hrmpnlView.selectItemAtIndex(0)
        ftstView.removeAllItems()
        ftstView.addItemsWithObjectValues(["", "v58.69", "v70.0", "257.2"])
        ftstView.selectItemAtIndex(0)
        anapnlView.removeAllItems()
        anapnlView.addItemsWithObjectValues(["", "v58.69", "v70.0", "719.49", "729.1", "714.9", "710.0"])
        anapnlView.selectItemAtIndex(0)
        cortisolView.removeAllItems()
        cortisolView.addItemsWithObjectValues(["", "v58.69", "v70.0", "780.79", "783.1", "783.21"])
        cortisolView.selectItemAtIndex(0)
        stoolView.removeAllItems()
        stoolView.addItemsWithObjectValues(["", "v58.69", "v70.0", "780.79", "783.1", "783.21"])
        stoolView.selectItemAtIndex(0)
        cheppnlView.removeAllItems()
        cheppnlView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        cheppnlView.selectItemAtIndex(0)
        aheppnlView.removeAllItems()
        aheppnlView.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        aheppnlView.selectItemAtIndex(0)
        other1View.removeAllItems()
        other1View.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        other1View.selectItemAtIndex(0)
        other2View.removeAllItems()
        other2View.addItemsWithObjectValues(["", "v58.69", "v70.0"])
        other2View.selectItemAtIndex(0)
        other1TextView.stringValue = ""
        other2TextView.stringValue = ""
        reviewedView.state = NSOffState
        fastingView.state = NSOffState
        
        radView.stringValue = ""
        refView.stringValue = ""
		textToPrint.string = ""
        
        
    }
	
	//Process the controllers for labs for saving to PTVN (without the dx codes)
    func processLabOrders() -> String {
        var listToReturn = ""
		var labReviewed = ""
		var nextLab = ""
		var nextLabDue = ""
        
        //Process the labs themselves
        //var basicLabInfo = [String]()
        
        if reviewedView.state == NSOnState {
            labReviewed = "Lab results reviewed with patient during visit.\n"
        }
        
        //Code for "Next Lab" from matrix here
		switch nextLabDueView.selectedTag() {
		case 1:
			nextLab = "today"
		case 2:
			nextLab = "outpatient"
		case 3:
			nextLab = "next visit"
		default:
			nextLab = ""
			
		}
		if nextLab != "" {
			if fastingView.state == NSOnState {
				nextLabDue = "Fasting lab tests to be done \(nextLab).\n"
			} else {
				nextLabDue = "Lab tests to be done \(nextLab).\n"
			}
		}
        
        //Process the actual lab controllers
        var labList = [String]()
		let labVarList1 = [bmpView, cmpView, cbcView, tshView, ft4view, ft3View, vitDView, urACView, cpkView, esrView, crpView, rfView, fpsaView]
		let labVarList2 = [hsvView, rprView, clamView, lpdView, psaView, udipView, ucxView, udsView, ucgView, pttView, fshView, tstView, anaView]
		let labVarList3 = [b12View, hpylView, papView, hivView, gonView, lpdnmrView, hba1cView, umalbView, uamicView, mudsView, uprcrView]
		let labVarList4 = [ptinrView, hrmpnlView, ftstView, anapnlView, anemiapnlView, cortisolView, stoolView, cheppnlView, aheppnlView, other1View, other2View]
        let labVerbiageList1 = ["BMP", "CMP", "CBC", "TSH", "Free T4", "Free T3", "Vitamin D", "Uric Acid", "CPK", "ESR", "CRP", "RF", "Free PSA"]
		let labVerbiageList2 = ["HSV1/HSV2", "RPR", "Clamydia", "Lipids", "PSA", "Urine dip", "Urine Culture", "UDS", "UCG", "PTT", "FSH", "Testosterone", "ANA"]
		let labVerbiageList3 = ["Vitamin B12", "H Pylori", "PAP Smear", "HIV", "Gonorhea", "NMR Lipids", "HbA1c", "Urine Microalbumin", "Urine Micro Analysis", "m UDS", "Urine Protein/Creatinine"]
		let labVerbiageList4 = ["PT/INR", "Hormone Panel (FSH, LH, Progesterone, Prolactin, Estradiol, Testosterone)", "Free Testosterone", "ANA Panel (SSA/SSB, SCL/70, Centromere AB, Jo-1 Antibody, RA, ANA, C3, C4, DNA AB DS, Thyroid Peroxidase AB)", "Anemia Panel (CBC, Ferritin, Folic Acid, Iron/TIBC, LDH, Retic, B12)", "Cortisol", "Stool studies", "Comprehensive hepatitis panel", "Acute hepatitis panel", other1TextView.stringValue, other2TextView.stringValue]
		
		for var i = 0; i < labVarList1.count; i++ {
			if (!labVarList1[i].stringValue.isEmpty) {
				labList.append(labVerbiageList1[i])
			}
		}
		for var i = 0; i < labVarList2.count; i++ {
			if (!labVarList2[i].stringValue.isEmpty) {
				labList.append(labVerbiageList2[i])
			}
		}
		for var i = 0; i < labVarList3.count; i++ {
			if (!labVarList3[i].stringValue.isEmpty) {
				labList.append(labVerbiageList3[i])
			}
		}
		for var i = 0; i < labVarList4.count; i++ {
			if (!labVarList4[i].stringValue.isEmpty) {
				labList.append(labVerbiageList4[i])
			}
		}
		
		
        //get final lab order results as a string
        if !labList.isEmpty {
            listToReturn = labReviewed + nextLabDue + "Labs ordered: " + labList.joinWithSeparator(", ") + "\n"
        }
        
        return listToReturn
        
    }

	//Process the controllers for labs for saving to file or printing (with the dx codes)
    func processLabOrdersForPrint() -> String {
        var listToReturn = ""
        
        //Process the labs themselves
        var basicLabInfo = [String]()
        
        if reviewedView.state == NSOnState {
            basicLabInfo.append("Lab results reviewed with patient during visit.")
        }
        
        //Code for "Next Lab" from matrix here
		
        
        //Process the actual lab controllers
        var labList = [String]()
		let labVarList1 = [bmpView, cmpView, cbcView, tshView, ft4view, ft3View, vitDView, urACView, cpkView, esrView, crpView, rfView, fpsaView]
		let labVerbiageList1 = ["Basic Metabolic Panel (BMP) - \(bmpView.stringValue)", "Complete Metabolic Panel (CMP) - \(cmpView.stringValue)", "Complete Blood Count with Differential (CBC) - \(cbcView.stringValue)", "Thyroid Stimulating Hormone High Sensitivity (TSH) - \(tshView.stringValue)", "Free Thyroxine Level (T4F) - \(ft4view.stringValue)", "Free Triiodothyronine Level (T3F) - \(ft3View.stringValue)", "Vitamin D Total (25 Hydroxy) - \(vitDView.stringValue)", "Uric Acid - \(urACView.stringValue)", "Creatine Kinase (CPK) - \(cpkView.stringValue)", "Erythrocyte Sedimentation Rate (ESR) - \(esrView.stringValue)", "C-Reactive Protien (CRP) - \(crpView.stringValue)", "Rheumatoid Factor (RF) - \(rfView.stringValue)", "Free Prostate Specific Antigen (FPSA) - \(fpsaView.stringValue)"]
		let labVarList2 = [hsvView, rprView, clamView, lpdView, psaView, ucxView, udsView, ucgView, pttView, fshView, tstView, anaView]
		let labVerbiageList2 = ["HSV1/HSV2 - \(hsvView.stringValue)", "RPR - \(rprView.stringValue)", "Clamydia - \(clamView.stringValue)", "Lipid Panel - \(lpdView.stringValue)", "Prostate Specific Antigen (PSA) - \(psaView.stringValue)", "Urine Culture & Sensitivities - \(ucxView.stringValue)", "Urine Drug Screen (UDS) - \(udsView.stringValue)", "UCG - \(ucgView.stringValue)", "Partial Thromboplastin Time (PTT) - \(pttView.stringValue)", "Follicle Stimulating Hormone (FSH) - \(fshView.stringValue)", "Total Testosterone - \(tstView.stringValue)", "Antinuclear Anibody Titer & Pattern (ANA) - \(anaView.stringValue)"]
		let labVarList3 = [b12View, hpylView, papView, hivView, gonView, lpdnmrView, hba1cView, umalbView, uamicView, uprcrView]
		let labVerbiageList3 = ["Cyanocobalamin Level (Vitamin B12) - \(b12View.stringValue)", "Helicobacter Pylori Antibody Panel (H Pylori) - \(hpylView.stringValue)", "Papanicolaou Smear (PAP) - \(papView.stringValue)", "HIV - \(hivView.stringValue)", "Gonorhea - \(gonView.stringValue)", "NMR Lipid Panel - \(lpdnmrView.stringValue)", "Hemoglobin A1c (HbA1c) - \(hba1cView.stringValue)", "Urine Microalbumin - \(umalbView.stringValue)", "Urinalysis w/microanalysis - \(uamicView.stringValue)", "Urine Protein/Creatinine Ratio - \(uprcrView.stringValue)"]
		let labVarList4 = [ptinrView, hrmpnlView, ftstView, anapnlView, anemiapnlView, cortisolView, stoolView, cheppnlView, aheppnlView, other1View, other2View]
		let labVerbiageList4 = ["Protime w/International Normalizing Ration (PT/INR) - \(ptinrView.stringValue)", "Hormone Panel (Follicle Stimulating Hormone, Luteinizing Hormone, Progesterone, Prolactin, Estradiol, Testosterone) - \(hrmpnlView.stringValue)", "Free Testosterone - \(ftstView.stringValue)", "ANA Panel (SSA/SSB, SCL/70, Centromere AB, Jo-1 Antibody, RA, ANA, C3, C4, DNA AB DS, Thyroid Peroxidase AB) - \(anapnlView.stringValue)", "Anemia Panel (CBC, Ferritin, Folic Acid, Iron/TIBC, LDH, Retic, B12) - \(anemiapnlView.stringValue)", "Cortisol Level - \(cortisolView.stringValue)", "Stool Studies (Stool Culture, Ova & Parasites, C Diff Ag/Toxin, Fecal WBC) - \(stoolView.stringValue)", "Comprehensive hepatitis panel - \(cheppnlView.stringValue)", "Acute hepatitis panel - \(aheppnlView.stringValue)", "\(other1TextView.stringValue) - \(other1View.stringValue)", "\(other2TextView.stringValue) - \(other2View.stringValue)"]
		
		for var i = 0; i < labVarList1.count; i++ {
			if (!labVarList1[i].stringValue.isEmpty) {
				labList.append(labVerbiageList1[i])
			}
		}
		for var i = 0; i < labVarList2.count; i++ {
			if (!labVarList2[i].stringValue.isEmpty) {
				labList.append(labVerbiageList2[i])
			}
		}
		for var i = 0; i < labVarList3.count; i++ {
			if (!labVarList3[i].stringValue.isEmpty) {
				labList.append(labVerbiageList3[i])
			}
		}
		for var i = 0; i < labVarList4.count; i++ {
			if (!labVarList4[i].stringValue.isEmpty) {
				labList.append(labVerbiageList4[i])
			}
		}

		
        //get final lab order results as a string
        if !labList.isEmpty {
            listToReturn = labList.joinWithSeparator("\n")
        }
		
        return listToReturn

    }
	
	//Automatically quite the program when the last window is closed
	func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
		return true
	}
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}


//
//  REFHandler.swift
//  Labs & Radiology 2.0
//
//  Created by Fool on 2/26/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

//Need to import Cocoa instead of Foundation in order to get access to the needed delegates
import Cocoa

//Create a class with the delegates needed to connect to windows and controllers and receive notifications
//From the window this class is handling
class REFHandler : NSObject, NSApplicationDelegate, NSWindowDelegate {
//Create outlet for the window this class will be the delegate of
    @IBOutlet weak var winREF: NSWindow!
    
    @IBOutlet weak var refView: NSTextField!
	
	//Medical Specialties
	@IBOutlet weak var refAllergistView: NSButton!
	@IBOutlet weak var refCardioView: NSButton!
	@IBOutlet weak var refChiropractorView: NSButton!
	@IBOutlet weak var refDentistView: NSButton!
	@IBOutlet weak var refDermView: NSButton!
	@IBOutlet weak var refEndoView: NSButton!
	@IBOutlet weak var refGastroView: NSButton!
	@IBOutlet weak var refImmunologyView: NSButton!
	@IBOutlet weak var refInfectiousDisView: NSButton!
	@IBOutlet weak var refNephroView: NSButton!
	@IBOutlet weak var refNeuroView: NSButton!
	@IBOutlet weak var refHemoView: NSButton!
	@IBOutlet weak var refOncRadiationView: NSButton!
	@IBOutlet weak var refOptometryView: NSButton!
	@IBOutlet weak var refRehabView: NSButton!
	@IBOutlet weak var refPsychiatristView: NSButton!
	@IBOutlet weak var refPulmView: NSButton!
	@IBOutlet weak var refRheumView: NSButton!
	
	
	
	//Surgical Specialties
	@IBOutlet weak var refBariatricView: NSButton!
	@IBOutlet weak var refCardioSurgView: NSButton!
	@IBOutlet weak var refColorectalSurgView: NSButton!
	@IBOutlet weak var refENTView: NSButton!
	@IBOutlet weak var refSurgeryView: NSButton!
	@IBOutlet weak var refGynoView: NSButton!
	@IBOutlet weak var refOncGynocologyView: NSButton!
	@IBOutlet weak var refNeuroSurgeryView: NSButton!
	@IBOutlet weak var refObstetricianView: NSButton!
	@IBOutlet weak var refOphthoView: NSButton!
	@IBOutlet weak var refOralSurgeonView: NSButton!
	@IBOutlet weak var refOrthoView: NSButton!
	@IBOutlet weak var refPainManagementView: NSButton!
	@IBOutlet weak var refPodView: NSButton!
	@IBOutlet weak var refUrologyView: NSButton!
	
	//Therapy-Ancillary
	@IBOutlet weak var refCounselorView: NSButton!
	@IBOutlet weak var refDMEdCounselor: NSButton!
	@IBOutlet weak var refHomeHealthView: NSButton!
	@IBOutlet weak var refLymphedemaView: NSButton!
	@IBOutlet weak var refNutritionistView: NSButton!
	@IBOutlet weak var refPsychologistView: NSButton!
	@IBOutlet weak var refSocialWorkerView: NSButton!
    @IBOutlet weak var refOTView: NSButton!
	@IBOutlet weak var refPTView: NSButton!
	@IBOutlet weak var refSpeechView: NSButton!
	@IBOutlet weak var refWoundClinicView: NSButton!
	
	
    
    //Create a struct to hold variables available to the AppDelegate module
    struct REFVars {
        //Create an array variable to hold the results of this window in
        static var refOrderList = [String]()
        //Create an integer variable to hold this window's refresh status
        static var refStateInt = Int()
    }
    
    
    @IBAction func takeREFProcess(sender: AnyObject) {
        //Check to see if there is already a value in the Radiology text box from a different
        //window, and if there is append it to the array which will be collecting the values
        //from processing this window.
        if refView.stringValue != "" {
            REFVars.refOrderList.append(refView.stringValue)
        }
        //Create a dictionary of the controllers being processed and the values attached to them
		let refVarListMedical = [refAllergistView, refCardioView, refChiropractorView, refDentistView, refDermView, refEndoView, refGastroView, 	refImmunologyView, refInfectiousDisView, refNephroView, refNeuroView, refHemoView, refOncRadiationView, refOptometryView, refRehabView, refPsychiatristView, refPulmView, refRheumView]
		let refVerbiageMedical = ["Allergist", "Cardiologist", "Chiropractor", "Dentist", "Dermatologist", "Endocrinologist", "Gastroenterologist", "Immunologist", "Infectious Disease", "Nephrologist", "Neurologist", "Oncologist/Hematologist", "Radiation Oncologist", "Optometrist", "Physical Medicine and Rehab", "Psychiatrist", "Pulmonologist", "Rhuematologist"]
		let refMedical = processLists(refVarListMedical, stringArray: refVerbiageMedical)
		REFVars.refOrderList += refMedical
		
		
		let refVarListSurgical = [refBariatricView, refCardioSurgView, refColorectalSurgView, refENTView, refSurgeryView, refGynoView, refOncGynocologyView, refNeuroSurgeryView, refObstetricianView, refOphthoView, refOralSurgeonView, refOrthoView, refPainManagementView, refPodView, refUrologyView]
		let refVarVerbiageSurgical = ["Bariatric surgeon", "Cardiac surgeon", "Colorectal surgeon", "ENT/Otolaryngology", "General surgeon", "Gynecologist", "Gynecologic Oncology", "Neurosurgeon", "Obstetrician", "Ophthalmology", "Oral surgeon", "Orthopedic", "Pain Management", "Podiatrist", "Urologist"]
		let refSurgical = processLists(refVarListSurgical, stringArray: refVarVerbiageSurgical)
		REFVars.refOrderList += refSurgical
		
		let refVarListTherapy = [refCounselorView, refDMEdCounselor, refHomeHealthView, refLymphedemaView, refNutritionistView, refPsychologistView, refSocialWorkerView, refOTView, refPTView, refSpeechView, refWoundClinicView]
		let refVerbiageTherapy = ["Counselor", "Diabetic Education", "Home Health", "Lymphedema clinic", "Nutritionist", "Psychologist", "Social worker", "Occupaitonal therapy", "Physical therapy", "Speech therapy", "Wound clinic"]
		let refTherapy = processLists(refVarListTherapy, stringArray: refVerbiageTherapy)
		REFVars.refOrderList += refTherapy

        //Set the Radioloty text box to the collected array as a comma delimited string
        refView.stringValue = REFVars.refOrderList.joinWithSeparator(", ")
        //Close the window controlled by this class/handler
        winREF.orderOut(self)
    }
    
    func clearREFCheckBoxes(){
		//Medical Specialties
		refAllergistView.state = NSOffState
		refCardioView.state = NSOffState
		refChiropractorView.state = NSOffState
		refDentistView.state = NSOffState
		refDermView.state = NSOffState
		refEndoView.state = NSOffState
		refGastroView.state = NSOffState
		refImmunologyView.state = NSOffState
		refInfectiousDisView.state = NSOffState
		refNephroView.state = NSOffState
		refNeuroView.state = NSOffState
		refHemoView.state = NSOffState
		refOncRadiationView.state = NSOffState
		refOptometryView.state = NSOffState
		refRehabView.state = NSOffState
		refPsychiatristView.state = NSOffState
		refPulmView.state = NSOffState
		refRheumView.state = NSOffState
		
		//Surgical Specialties
		refBariatricView.state = NSOffState
		refCardioSurgView.state = NSOffState
		refColorectalSurgView.state = NSOffState
		refENTView.state = NSOffState
		refSurgeryView.state = NSOffState
		refGynoView.state = NSOffState
		refOncGynocologyView.state = NSOffState
		refNeuroSurgeryView.state = NSOffState
		refObstetricianView.state = NSOffState
		refOphthoView.state = NSOffState
		refOralSurgeonView.state = NSOffState
		refOrthoView.state = NSOffState
		refPainManagementView.state = NSOffState
		refPodView.state = NSOffState
		refUrologyView.state = NSOffState
		
		//Therapy-Ancillary
		refCounselorView.state = NSOffState
		refDMEdCounselor.state = NSOffState
		refLymphedemaView.state = NSOffState
		refNutritionistView.state = NSOffState
		refPsychologistView.state = NSOffState
		refSocialWorkerView.state = NSOffState
		refOTView.state = NSOffState
		refPTView.state = NSOffState
		refSpeechView.state = NSOffState
		refWoundClinicView.state = NSOffState
        
        REFVars.refOrderList = []
    }
    
    func windowDidBecomeKey(notification: NSNotification) {
            if REFVars.refStateInt == 1 {
            clearREFCheckBoxes()
            }
            REFVars.refStateInt = 0
    }
    
    
}

//
//  FourthViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class GenerateWorkout_OverviewVC: UIViewController {
    
    
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var partsText: UILabel!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var buttonGenerateWorkout: UIButton!
    
    var answerObject: Answers? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for supporting multiple screens
        typeText.adjustsFontSizeToFitWidth = true
        partsText.adjustsFontSizeToFitWidth = true
        timeText.adjustsFontSizeToFitWidth = true
        buttonGenerateWorkout.titleLabel?.adjustsFontSizeToFitWidth = true
        
        title = "Overview"
        fillLabels()

        //Rounded buttons
        buttonGenerateWorkout.layer.cornerRadius = 10
    }
    
    //Called by previous screen in prepare segue
    func setAnswerObject(object: Answers){
        answerObject = object
    }
    
    func fillLabels() {
        if answerObject != nil {
            typeText.text! += answerObject!.getWorkoutType()
            timeText.text! += String(answerObject!.getMinutes())
            timeText.text! += " minutes"
            for text:String in answerObject!.getMuscleGroups(){
                partsText.text! += text
                partsText.text! += ", "
            }
        }else{
            print("Error: Did not receive an answerObject from thirdVC")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fifthVC: GenerateWorkout_ExercisesVC = segue.destination as! GenerateWorkout_ExercisesVC
        fifthVC.setAnswerObject(object: answerObject!)
    }
}

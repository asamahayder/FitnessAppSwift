//
//  ViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 13/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit



class GenerateWorkout_TypeVC: UIViewController {
    
    @IBOutlet weak var buttonStrengthTraining: UIButton!
    @IBOutlet weak var buttonBodyBuilding: UIButton!
    @IBOutlet weak var labelQuestion: UILabel!
    var answerObject = Answers()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for supporting multiple screens:
        buttonStrengthTraining.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonBodyBuilding.titleLabel?.adjustsFontSizeToFitWidth = true
        labelQuestion.adjustsFontSizeToFitWidth = true
        
        title = "Workout Type"
        
        //rounded buttons
        buttonBodyBuilding.layer.cornerRadius = 10
        buttonStrengthTraining.layer.cornerRadius = 10
    }
    
    @IBAction func goToNextScreen(_ sender: Any) {
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    @IBAction func chooseBodyBuilding(_ sender: Any) {
        answerObject.setWorkoutType(type: "bodybuilding")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    @IBAction func chooseStrength(_ sender: Any) {
        answerObject.setWorkoutType(type: "Strength")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg1"{
            let secondVC: GenerateWorkoutBodypartVC = segue.destination as! GenerateWorkoutBodypartVC
            secondVC.setAnswerObject(object: answerObject)
        }
    }
    
}




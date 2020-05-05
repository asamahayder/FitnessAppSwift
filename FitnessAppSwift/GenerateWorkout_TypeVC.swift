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
    var answerObject = Answers()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Workout Type"
        
        //rounded buttons
        buttonBodyBuilding.layer.cornerRadius = 10
        buttonStrengthTraining.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // We can reset stuff in here
    }
    
    @IBAction func goToNextScreen(_ sender: Any) {
        print("hey")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    @IBAction func chooseBodyBuilding(_ sender: Any) {
        answerObject.setWorkoutType(type: "bodybuilding")
        print("bodybuilding was choosen")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    @IBAction func chooseStrength(_ sender: Any) {
        answerObject.setWorkoutType(type: "Strength")
        print("Strength training was choosen")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg1"{
            let secondVC: GenerateWorkoutBodypartVC = segue.destination as! GenerateWorkoutBodypartVC
            secondVC.setAnswerObject(object: answerObject)
        }
    }
    
    
    
    
}




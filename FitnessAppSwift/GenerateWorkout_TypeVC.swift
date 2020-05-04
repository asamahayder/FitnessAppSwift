//
//  ViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 13/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

let startWorkoutKey = "startWorkoutNow"

class GenerateWorkout_TypeVC: UIViewController {
    
    var workout : [Exercise] = []
    var workoutType : String = " "
    
    @IBOutlet weak var buttonStrengthTraining: UIButton!
    @IBOutlet weak var buttonBodyBuilding: UIButton!
    var answerObject = Answers()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(GenerateWorkout_TypeVC.goToWorkoutScreen(_: )), name: .workoutNotification, object: nil)
    }
    
    @objc func goToWorkoutScreen(_ notification: NSNotification) {
        
        if let data = notification.userInfo as? [String : Any]{
            workout = data["workout"]! as! [Exercise]
            workoutType = data["workoutType"]! as! String
        }
        
        
        performSegue(withIdentifier: "startWorkout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
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
        }else if segue.identifier == "startWorkout"{
            let workoutVC: WorkoutVC = segue.destination as! WorkoutVC
            workoutVC.setParams(workout: workout, type: workoutType)
        }
    }
    
}

extension Notification.Name{
    static let workoutNotification = Notification.Name(rawValue: startWorkoutKey)
    
}


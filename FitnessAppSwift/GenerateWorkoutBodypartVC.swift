//
//  SecondViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 13/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class GenerateWorkoutBodypartVC: UIViewController {
    
    
    @IBOutlet weak var chestButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var legsButton: UIButton!
    @IBOutlet weak var armsButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var chosenGroupsCount = 0
    var chosenMuscleGroups: [String] = []
    var answerObject:Answers? = nil
    
    
    var chestAlreadyChosen = false
    var backAlreadyChosen = false
    var armsAlreadyChosen = false
    var legsAlreadyChosen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Muscle Groups"
        
        //rounded buttons
        chestButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        legsButton.layer.cornerRadius = 10
        armsButton.layer.cornerRadius = 10
        doneButton.layer.cornerRadius = 10
    }
    
    func setAnswerObject(object:Answers) {
        answerObject = object
    }
    
    func removeFromMuscleGroups (group: String){
        for (i, currentGroup) in chosenMuscleGroups.enumerated(){
            if currentGroup == group{
                chosenMuscleGroups.remove(at: i)
            }
        }
    }
    
    @IBAction func chestChosen(_ sender: Any) {
        if chestAlreadyChosen{
            removeFromMuscleGroups(group: "chest")
            chestButton.backgroundColor = UIColor.orange
            chosenGroupsCount -= 1
            chestAlreadyChosen = false
            return
        }
        if chosenGroupsCount >= 2 {
            return
        }
        chosenMuscleGroups.append("chest")
        chestAlreadyChosen = true
        chestButton.backgroundColor = UIColor.green
        chosenGroupsCount += 1
    }
    
    
    @IBAction func backChosen(_ sender: Any) {
        if backAlreadyChosen{
            removeFromMuscleGroups(group: "back")
            backButton.backgroundColor = UIColor.orange
            chosenGroupsCount -= 1
            backAlreadyChosen = false
            return
        }
        if chosenGroupsCount >= 2 {
            return
        }
        chosenMuscleGroups.append("back")
        backAlreadyChosen = true
        backButton.backgroundColor = UIColor.green
        chosenGroupsCount += 1
    }
    
    
    @IBAction func armsChosen(_ sender: Any) {
        if armsAlreadyChosen{
            removeFromMuscleGroups(group: "arms")
            armsButton.backgroundColor = UIColor.orange
            chosenGroupsCount -= 1
            armsAlreadyChosen = false
            return
        }
        if chosenGroupsCount >= 2{
            return
        }
        chosenMuscleGroups.append("arms")
        armsAlreadyChosen = true
        armsButton.backgroundColor = UIColor.green
        chosenGroupsCount += 1
    }
    
    @IBAction func legsChosen(_ sender: Any) {
        if legsAlreadyChosen{
            removeFromMuscleGroups(group: "legs")
            legsButton.backgroundColor = UIColor.orange
            chosenGroupsCount -= 1
            legsAlreadyChosen = false
            return
        }
        if chosenGroupsCount >= 2{
            return
        }
        chosenMuscleGroups.append("legs")
        legsAlreadyChosen = true
        legsButton.backgroundColor = UIColor.green
        chosenGroupsCount += 1
    }
    
    
    @IBAction func done(_ sender: Any) {
        if answerObject != nil{
            answerObject!.setMuscleGroups(listOfMuscleGroups: chosenMuscleGroups)
            performSegue(withIdentifier: "seg2", sender: self)
        }else{
            print("Error: Did not receive an answerObject from the first screen!")
        }
        
        for item in chosenMuscleGroups{
            print(item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let thirdVC: GenerateWorkout_TimeVC = segue.destination as! GenerateWorkout_TimeVC
        thirdVC.setAnswerObject(object: answerObject!)
    }
    
    
}

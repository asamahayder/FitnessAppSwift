//
//  SecondViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 13/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
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
    }
    
    func setAnswerObject(object:Answers) {
        answerObject = object
    }
    
    func removeFromMuscleGroups (group: String){
        for i in 0..<chosenMuscleGroups.count{
            if chosenMuscleGroups[i] == group {
                chosenMuscleGroups.remove(at: i)
            }
        }
    }
    
    @IBAction func chestChosen(_ sender: Any) {
        if chestAlreadyChosen{
            removeFromMuscleGroups(group: "chest")
        }
        if chosenGroupsCount >= 2 || chestAlreadyChosen {
            return
        }
        chosenMuscleGroups.append("chest")
        chestAlreadyChosen = true
        chestButton.backgroundColor = UIColor.green
        chosenGroupsCount += 1
    }
    
    
    @IBAction func backChosen(_ sender: Any) {
        if chosenGroupsCount >= 2 || backAlreadyChosen {
            return
        }
        chosenMuscleGroups.append("back")
        backAlreadyChosen = true
        backButton.backgroundColor = UIColor.green
        chosenGroupsCount += 1
    }
    
    
    @IBAction func armsChosen(_ sender: Any) {
        if chosenGroupsCount >= 2 || armsAlreadyChosen{
            return
        }
        chosenMuscleGroups.append("arms")
        armsAlreadyChosen = true
        armsButton.backgroundColor = UIColor.green
        chosenGroupsCount += 1
    }
    
    @IBAction func legsChosen(_ sender: Any) {
        if chosenGroupsCount >= 2 || legsAlreadyChosen{
            return
        }
        chosenMuscleGroups.append("legs")
        legsAlreadyChosen = true
        legsButton.backgroundColor = UIColor.green
        chosenGroupsCount += 1
    }
    
    
    @IBAction func done(_ sender: Any) {
        for item in chosenMuscleGroups{
            print(item)
        }
    }
    
    
}

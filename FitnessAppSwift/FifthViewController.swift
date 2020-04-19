//
//  FifthViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {
    
    var answarObject: Answers? = nil
    var database = DatabaseObject()
    lazy var exerciseList = database.getExerciseList()
    var searchQuery:[Exercise] = [Exercise]()
    var currentTime: Int = 0
    
    var workout: [Exercise] = [Exercise]()
    
    @IBOutlet weak var lable: UILabel!
    var message: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lable.text = message
    }
    
    func setAnswerObject(object: Answers) {
        answarObject = object
    }
    
    func generateWorkout() {
        searchForBodyParts() //This filters the database by finding exercises that mach chosen bodyparts
        fillWorkout() //This goes through the result of searchForBodyParts() and keeps adding until desired time is reached.
        
        /*for exercise in workout{
            print(exercise.exerciseName)
        }*/
    }
    
    func searchForBodyParts() {
        for exercise in exerciseList{
            for bodyPart in (answarObject?.getMuscleGroups())!{
                if exercise.exerciseBPart == bodyPart {
                    searchQuery.append(exercise)
                }
            }
        }
    }
    
    func fillWorkout() {
        let lowerBound:Int = 0
        let higherBound:Int = searchQuery.count-1
        repeat{
            //randomized implementation
            let intRandom = Int.random(in: lowerBound...higherBound)
            if searchQuery[intRandom].getIsFlagged() == false{
                workout.append(searchQuery[intRandom])
                currentTime += searchQuery[intRandom].exerciseTime
                searchQuery[intRandom].setIsFlagged(bool: true)
            }
        }while (currentTime < (answarObject?.getMinutes())!)
    }
    
}

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
        var lowerBound:Int = 0
        var higherBound:Int = searchQuery.count-1
        repeat{
            //randomized implementation
            var intRandom = Int.random(in: lowerBound...higherBound)
            if !(searchQuery[intRandom].isFlagged){
                
            }
            
            //Not a randomized implementation
            for exercise in searchQuery{
                workout.append(exercise)
                currentTime += exercise.exerciseTime
            }
        }while (currentTime < (answarObject?.getMinutes())!)
    }
    

    
    
    
    
    
}

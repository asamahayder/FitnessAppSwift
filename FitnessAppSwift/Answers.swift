//
//  Answers.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 14/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import Foundation

//Instances of this works as a carrier of data in the generate-workout flow.
//Each screen receives the object, add an answer, and sends it to the next.
class Answers{
    
    var workoutType: String?
    var muscleGroups: [String]?
    var minutes: Int?
    var difficulty: Int?
    
    init() {
        
    }
    
    func setWorkoutType(type: String){
        workoutType = type
    }
    
    func getWorkoutType() -> String {
        return workoutType!
    }
    
    func setMuscleGroups(listOfMuscleGroups:[String]) {
        muscleGroups = listOfMuscleGroups
    }
    
    func getMuscleGroups() -> [String] {
        return muscleGroups!
    }
    
    func setMinutes(minutes: Int) {
        self.minutes = minutes
    }
    
    func getMinutes() -> Int{
        return minutes!
    }
    
    func setDifficulty(difficulty: Int) {
        self.difficulty = difficulty
    }
    
    func getDifficulty() -> Int {
        return difficulty!
    }
    
    
    
}

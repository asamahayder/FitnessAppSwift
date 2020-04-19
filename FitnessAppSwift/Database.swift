//
//  Database.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import Foundation
class Database {
    
    var exerciseList = [Exercise]()
    
    func fillList()   {
        exerciseList.append(Exercise(exerciseName: "pushups", exerciseTime: 5, exercisePic: "no pic yet", exerciseDisc: "go down to the floor in a plank position. Slowly move your body up and down by extending and relaxing your arms. ", exerciseBPart: "chest"))
        
        }
    
    init() {
        fillList()
        for item in exerciseList{
            print(item.exerciseName)
        }
    }
   
}

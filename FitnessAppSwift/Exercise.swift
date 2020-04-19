//
//  Exercise.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import Foundation
class Exercise {
    
    var exerciseName: String = ""
    var exerciseTime: Int = 0
    var exercisePic: String = ""
    var exerciseDisc: String = ""
    var exerciseBPart: String = ""
    
    init(exerciseName: String, exerciseTime: Int, exercisePic: String, exerciseDisc: String, exerciseBPart: String) {
        self.exerciseName = exerciseName
        self.exerciseTime = exerciseTime
        self.exercisePic = exercisePic
        self.exerciseDisc = exerciseDisc
        self.exerciseBPart = exerciseBPart
    }
    
}

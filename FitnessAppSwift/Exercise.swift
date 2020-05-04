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
    var exerciseVidID: String = ""
    var exerciseDisc: String = ""
    var exerciseBPart: String = ""
    var isFlagged: Bool = false
    
    init(exerciseName: String, exerciseTime: Int, exerciseVidID: String, exerciseDisc: String, exerciseBPart: String) {
        self.exerciseName = exerciseName
        self.exerciseTime = exerciseTime
        self.exerciseVidID = exerciseVidID
        self.exerciseDisc = exerciseDisc
        self.exerciseBPart = exerciseBPart
    }
    
    func getIsFlagged() -> Bool {
        return isFlagged
    }
    
    func setIsFlagged(bool: Bool) {
        isFlagged = bool
    }
    
}

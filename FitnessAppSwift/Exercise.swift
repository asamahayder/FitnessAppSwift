//
//  Exercise.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import Foundation
class Exercise : Codable, Comparable{
    
    var exerciseName: String = ""
    var exerciseTime: Int = 0
    var exerciseVidID: String = ""
    var exerciseDisc: String = ""
    var exerciseBPart: String = ""
    var exerciseBPartCode: Int = 0
    var isFlagged: Bool = false
    
    init(exerciseName: String, exerciseTime: Int, exerciseVidID: String, exerciseDisc: String, exerciseBPart: String) {
        self.exerciseName = exerciseName
        self.exerciseTime = exerciseTime
        self.exerciseVidID = exerciseVidID
        self.exerciseDisc = exerciseDisc
        self.exerciseBPart = exerciseBPart
        settingBPartCode()
    }
    
    func settingBPartCode(){
        switch exerciseBPart{
        case "chest": exerciseBPartCode = 0
        case "legs": exerciseBPartCode = 1
        case "arms": exerciseBPartCode = 2
        case "back": exerciseBPartCode = 3
        default: exerciseBPartCode = 100
        }
    }
    
    static func <(exercise1: Exercise, exercise2: Exercise) -> Bool {
        return exercise1.exerciseBPartCode < exercise2.exerciseBPartCode
    }
    
    static func ==(exercise1: Exercise, exercise2: Exercise) -> Bool {
        return exercise1.exerciseBPartCode == exercise2.exerciseBPartCode
    }
    
    func getIsFlagged() -> Bool {
        return isFlagged
    }
    
    func setIsFlagged(bool: Bool) {
        isFlagged = bool
    }
    
}

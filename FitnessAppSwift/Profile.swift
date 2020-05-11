//
//  Profile.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 05/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import Foundation

//This code is inspired by apples own tutorial on persisting data: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html

//It is prepared for saving into user defaults.

class Profile: NSObject, NSCoding{
    
    var currentLVL:String = "0"
    var currentEXP: String = "0"
    var reachedLVL1: String = "false"
    var reachedLVL3: String = "false"
    var reachedLVL6: String = "false"
    var completed1Workout: String = "false"
    var completed2Workouts: String = "false"
    var completed4Workouts: String = "false"
    var completedWorkoutCount: String = "0"
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("profile")
    
    //MARK: Types
    
    struct PropertyKey {
        static let currentLVL = "currentLVL"
        static let currentEXP = "currentEXP"
        static let reachedLVL1 = "reachedLVL1"
        static let reachedLVL3 = "reachedLVL3"
        static let reachedLVL6 = "reachedLVL6"
        static let completed1Workout = "completed1Workout"
        static let completed2Workouts = "completed3Workouts"
        static let completed4Workouts = "completed4Workouts"
        static let completedWorkoutCount = "completedWorkoutCount"
    }
    
    //MARK: Initialization
    init?(currentLVL: String, currentEXP: String, reachedLVL1: String, reachedLVL3: String, reachedLVL6: String, completed1Workout: String, completed2Workouts: String, completed4Workouts: String, completedWorkoutCount: String){
        self.currentLVL = currentLVL
        self.currentEXP = currentEXP
        self.reachedLVL1 = reachedLVL1
        self.reachedLVL3 = reachedLVL3
        self.reachedLVL6 = reachedLVL6
        self.completed1Workout = completed1Workout
        self.completed2Workouts = completed2Workouts
        self.completed4Workouts = completed4Workouts
        self.completedWorkoutCount = completedWorkoutCount
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(currentLVL, forKey: PropertyKey.currentLVL)
        aCoder.encode(currentEXP, forKey: PropertyKey.currentEXP)
        aCoder.encode(reachedLVL1, forKey: PropertyKey.reachedLVL1)
        aCoder.encode(reachedLVL3, forKey: PropertyKey.reachedLVL3)
        aCoder.encode(reachedLVL6, forKey: PropertyKey.reachedLVL6)
        aCoder.encode(completed1Workout, forKey: PropertyKey.completed1Workout)
        aCoder.encode(completed2Workouts, forKey: PropertyKey.completed2Workouts)
        aCoder.encode(completed4Workouts, forKey: PropertyKey.completed4Workouts)
        aCoder.encode(completedWorkoutCount, forKey: PropertyKey.completedWorkoutCount)
        
        
    }
    
    required convenience init?(coder aCoder: NSCoder) {
        
        let currentLVL = aCoder.decodeObject(forKey: PropertyKey.currentLVL)as? String
        
        let currentEXP = aCoder.decodeObject(forKey: PropertyKey.currentEXP)as? String
        
        let reachedLVL1 = aCoder.decodeObject(forKey: PropertyKey.reachedLVL1)as? String
        
        let reachedLVL3 = aCoder.decodeObject(forKey: PropertyKey.reachedLVL3)as? String
        
        let reachedLVL6 = aCoder.decodeObject(forKey: PropertyKey.reachedLVL6)as? String
        
        let completed1Workout = aCoder.decodeObject(forKey: PropertyKey.completed1Workout)as? String
        
        let completed2Workouts = aCoder.decodeObject(forKey: PropertyKey.completed2Workouts)as? String
        
        let completed4Workouts = aCoder.decodeObject(forKey: PropertyKey.completed4Workouts)as? String
        
        let completedWorkoutCount = aCoder.decodeObject(forKey: PropertyKey.completedWorkoutCount)as? String
        
        self.init(currentLVL: currentLVL!, currentEXP: currentEXP!, reachedLVL1: reachedLVL1!, reachedLVL3: reachedLVL3!, reachedLVL6: reachedLVL6!, completed1Workout: completed1Workout!, completed2Workouts: completed2Workouts!, completed4Workouts: completed4Workouts!, completedWorkoutCount: completedWorkoutCount!)
        
    }
    
    
}

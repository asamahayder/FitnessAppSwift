//
//  Workout.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 05/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import Foundation

//This code is inspired by apples own tutorial on persisting data: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html


class Workout: NSObject, NSCoding{
    
    var workoutExercises: String = ""
    var workoutTime = ""
    var workoutBodyParts: [String] = []
    var workoutType: String = ""
    var date: String = ""
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("workout")
    
    //MARK: Types
    
    struct PropertyKey {
        static let workoutType = "workoutType"
        static let date = "date"
        static let workoutTime = "workoutTime"
        static let workoutBodyParts = "workoutBodyParts"
        static let workoutExercises = "workoutExercises"
    }
    
    //MARK: Initialization
    init?(workoutType: String, date: String, workoutTime: String, workoutBodyParts: [String], workoutExercises: String){
        self.workoutType = workoutType
        self.date = date
        self.workoutTime = workoutTime
        self.workoutBodyParts = workoutBodyParts
        self.workoutExercises = workoutExercises
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(workoutType, forKey: PropertyKey.workoutType)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(workoutTime, forKey: PropertyKey.workoutTime)
        aCoder.encode(workoutBodyParts, forKey: PropertyKey.workoutBodyParts)
        aCoder.encode(workoutExercises, forKey: PropertyKey.workoutExercises)
        
    }
    
    required convenience init?(coder aCoder: NSCoder) {
        
        let date = aCoder.decodeObject(forKey: PropertyKey.date)as? String
        
        let workoutType = aCoder.decodeObject(forKey: PropertyKey.workoutType)as? String
        
        let workoutTime = aCoder.decodeObject(forKey: PropertyKey.workoutTime)as? String
        
        let workoutBodyParts = aCoder.decodeObject(forKey: PropertyKey.workoutBodyParts)as? [String]
        
        let workoutExercises = aCoder.decodeObject(forKey: PropertyKey.workoutExercises)as? String
        
        self.init(workoutType: workoutType!, date: date!, workoutTime: workoutTime!, workoutBodyParts: workoutBodyParts!, workoutExercises: workoutExercises!)
        
    }
    
    
}

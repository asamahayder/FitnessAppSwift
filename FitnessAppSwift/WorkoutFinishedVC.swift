//
//  WorkoutFinishedVC.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 06/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class WorkoutFinishedVC: UIViewController {
    
    var workout: [Exercise] = []
    var workoutInJSON: String = ""
    var workoutList: [Workout] = []
    var workoutType: String = ""
    var workoutTime: Int = 0
    var workoutBodyParts: [String] = []
    var profile:Profile?
    var hasReachedNewLVL: Bool = false
    var hasNewAchievement: Bool = false
    
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var labelNewLevel: UILabel!
    @IBOutlet weak var labelNewAchievements: UILabel!
    @IBOutlet weak var EXPProgressBar: UIProgressView!
    @IBOutlet weak var labelEXPGained: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonContinue.layer.cornerRadius = 10
        
        //loading previous workouts from disc
        let workoutListFromMemory = loadWorkoutList()
        if workoutListFromMemory != nil {
            workoutList = loadWorkoutList()!
            print("SUCCESSFULLY loaded workoutList from memory")
        }else{
            print("could NOT retrieve workoutList from disk")
        }
        
        //loading profile from disc
        let profileFromMemory = loadProfile()
        if profileFromMemory != nil{
            profile = profileFromMemory!
            print("SUCCESSFULLY loaded profile from memory")
            print("CurrentEXP: \(profile!.currentEXP)")
        }else{
            print("could not retrieve profile from disk")
        }
        
        
        // converting workout to json for saving into userdefaults.

        let jsonEncoder = JSONEncoder()
        
        let jsonData = try? jsonEncoder.encode(workout)
        
        if jsonData != nil{
            workoutInJSON = String(data: jsonData!, encoding: String.Encoding.utf8)!
        }
        
        addToWorkoutList()
        modifyPofile()
        saveWorkoutList()
        saveProfile()
    }
    
    //Adding the finished workout to the previous workouts
    func addToWorkoutList(){
        let date = getCurrentDateAsString()
        let workoutTimeAsString = String(workoutTime)
        let workoutObject = Workout(workoutType: workoutType, date: date, workoutTime: workoutTimeAsString, workoutBodyParts: workoutBodyParts, workoutExercises : workoutInJSON)
        workoutList.append(workoutObject!)
        
    }
    
    //Updating user info like level and experience points
    func modifyPofile(){
        if profile != nil {
            var completedWorkoutCount: Int = Int(profile!.completedWorkoutCount)!
            var currentEXP: Int = Int(profile!.currentEXP)!
            var currentLVL: Int = Int(profile!.currentLVL)!
            let EXPGained = workoutTime * 5
            currentEXP += EXPGained
            labelEXPGained.text = "EXP + \(EXPGained)"
            completedWorkoutCount += 1
            profile!.completedWorkoutCount = String(completedWorkoutCount)
            
            //Checking if an achievement has been reached
            if completedWorkoutCount == 1{
                hasNewAchievement = true
                profile!.completed1Workout = "true"
            }
            if completedWorkoutCount == 2 {
                profile!.completed2Workouts = "true"
                hasNewAchievement = true
            }
            if completedWorkoutCount == 4 {
                profile!.completed4Workouts = "true"
                hasNewAchievement = true
            }
            
            //Increasing levels
            while currentEXP >= 300 {
                hasReachedNewLVL = true
                currentLVL += 1
                currentEXP -= 300
                labelNewLevel.text = "New Level: \(currentLVL)"
                
                //Checking for new achievements
                if currentLVL >= 1 {
                    profile!.reachedLVL1 = "true"
                    hasNewAchievement = true
                }
                if currentLVL >= 3 {
                    profile!.reachedLVL3 = "true"
                    hasNewAchievement = true
                }
                if currentLVL >= 6 {
                    profile!.reachedLVL6 = "true"
                    hasNewAchievement = true
                }
            }
            profile!.currentLVL = String(currentLVL)
            profile!.currentEXP = String(currentEXP)
            
            
            if hasNewAchievement {
                labelNewAchievements.text = "You have some new achievements!"
            }
            
            EXPProgressBar.setProgress(Float(currentEXP)/300.0, animated: true)
        }
    }
    
    //Fetching the current data
    func getCurrentDateAsString() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate: String = dateFormatter.string(from: date)
        return formattedDate
    }
    
    //This is called by the previous view controller
    func setParams(workout: [Exercise], workoutType: String, workoutTime: Int, workoutBodyParts: [String]){
        self.workout = workout
        self.workoutType = workoutType
        self.workoutTime = workoutTime
        self.workoutBodyParts = workoutBodyParts
    }
    
    //Saving the now updated previous workouts to the userDefaults
    func saveWorkoutList(){
        let savedSuccessfully = NSKeyedArchiver.archiveRootObject(workoutList, toFile: Workout.ArchiveURL.path)
        
        if savedSuccessfully {
           print("saved successfully")
        }else{
            print("Did not save successfully!")
        }
    }
    
    //Saving the now updated user profile
    func saveProfile(){
        let savedSuccessfully = NSKeyedArchiver.archiveRootObject(profile!, toFile: Profile.ArchiveURL.path)
        
        if savedSuccessfully {
           print("saved successfully")
        }else{
            print("Did not save successfully!")
        }
        
    }
    
    //Loading previous workouts from user defaults.
    func loadWorkoutList() -> [Workout]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Workout.ArchiveURL.path) as? [Workout]
    }
    
    //Loading previous workouts from user defaults.
    func loadProfile() -> Profile?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Profile.ArchiveURL.path) as? Profile
    }
    
    //Hiding the backbutton
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    //Unhiding the backbutton
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated:true)
    }
    
    @IBAction func onContinueClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

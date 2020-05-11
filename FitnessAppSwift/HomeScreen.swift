//
//  HomeScreen.swift
//  
//
//  Created by Thaer Almalla on 05/05/2020.
//

import UIKit

let startWorkoutKey = "startWorkoutNow"

class HomeScreen: UIViewController {
    
    var workout : [Exercise] = []
    var workoutType: String = ""
    var workoutTime: Int = 0
    var workoutBodyParts: [String] = []
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var buttonGenerateWorkout: UIButton!
    @IBOutlet weak var buttonCustomWorkout: UIButton!
    @IBOutlet weak var buttonProfile: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for supporting multiple screens
        buttonGenerateWorkout.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonCustomWorkout.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonProfile.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //Checking if this is the first launch of the app
        if defaults.bool(forKey: "First Launch") == false {
            //First Launch
            print("This is the first launch")
            createAndSaveProfile()
            defaults.set(true, forKey: "First Launch")
        }
        
        createObservers()

        // rounded buttons
        buttonGenerateWorkout.layer.cornerRadius = 10
        buttonCustomWorkout.layer.cornerRadius = 10
        buttonProfile.layer.cornerRadius = 10
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createAndSaveProfile(){
        //Only runs at first launch
        let profile:Profile = Profile(currentLVL: "0", currentEXP: "0", reachedLVL1: "false", reachedLVL3: "false", reachedLVL6: "false", completed1Workout: "false", completed2Workouts: "false", completed4Workouts: "false", completedWorkoutCount: "0")!
        
        let savedSuccessfully = NSKeyedArchiver.archiveRootObject(profile, toFile: Profile.ArchiveURL.path)
        
        if savedSuccessfully {
           print("profile created and saved successfully")
        }else{
            print("Did not save profile successfully!")
        }
        
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeScreen.goToWorkoutScreen(_: )), name: .workoutNotification, object: nil)
    }
    
    @objc func goToWorkoutScreen(_ notification: NSNotification) {
        
        if let data = notification.userInfo as? [String : Any]{
            workout = data["workout"]! as! [Exercise]
            workoutType = data["workoutType"]! as! String
            workoutTime = data["workoutTime"]! as! Int
            workoutBodyParts = data["workoutBodyParts"]! as! [String]
            
        }
        
        performSegue(withIdentifier: "startWorkout", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startWorkout"{
            let workoutVC: WorkoutVC = segue.destination as! WorkoutVC
            workoutVC.setParams(workout: workout, workoutType: workoutType, workoutTime: workoutTime, workoutBodyParts: workoutBodyParts)
        }
    }
    
    @IBAction func goToGenerateWorkout(_ sender: Any) {
        performSegue(withIdentifier: "generateWorkout", sender: self)
    }
    
    @IBAction func onCustomWorkoutClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToCustomWorkout", sender: self)
    }
    
    

}

extension Notification.Name{
    static let workoutNotification = Notification.Name(rawValue: startWorkoutKey)
    
}

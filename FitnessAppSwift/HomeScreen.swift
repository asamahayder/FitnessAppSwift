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
        
        //Checking if this is the first launch of the app by reading a value in userDefaults.
        if defaults.bool(forKey: "First Launch") == false {
            //First Launch
            createAndSaveProfile()
            defaults.set(true, forKey: "First Launch")
        }
        
        //For the notification-observer pattern
        createObservers()

        // rounded buttons
        buttonGenerateWorkout.layer.cornerRadius = 10
        buttonCustomWorkout.layer.cornerRadius = 10
        buttonProfile.layer.cornerRadius = 10
    }
    
    //deinitializing observers when not needed any more
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //Creates a profile on the first launch of the app
    func createAndSaveProfile(){
        //Only runs at first launch
        let profile:Profile = Profile(currentLVL: "0", currentEXP: "0", reachedLVL1: "false", reachedLVL3: "false", reachedLVL6: "false", completed1Workout: "false", completed2Workouts: "false", completed4Workouts: "false", completedWorkoutCount: "0")!
        
        //Deprecated method, should be updated to the new version to avoid having problems in new IOS. But for now the current IOS's are backwards compatible.
        let savedSuccessfully = NSKeyedArchiver.archiveRootObject(profile, toFile: Profile.ArchiveURL.path)
        
        if savedSuccessfully {
           print("profile created and saved successfully")
        }else{
            print("Did not save profile successfully!")
        }
        
    }
    
    //Creating the observers that will listen for any notifications. This is used to receive data from any view controller in the app. It usually receives a generated workout and sends it to the workout view controller.
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeScreen.goToWorkoutScreen(_: )), name: .workoutNotification, object: nil)
    }
    
    //This is run if an observer receieves a workout to start
    @objc func goToWorkoutScreen(_ notification: NSNotification) {
        
        if let data = notification.userInfo as? [String : Any]{
            workout = data["workout"]! as! [Exercise]
            workoutType = data["workoutType"]! as! String
            workoutTime = data["workoutTime"]! as! Int
            workoutBodyParts = data["workoutBodyParts"]! as! [String]
            
        }
        
        performSegue(withIdentifier: "startWorkout", sender: self)
    }
    
    //Preparing data to send via the segue.
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

//Putting key name here to avoid having to type it manually.
extension Notification.Name{
    static let workoutNotification = Notification.Name(rawValue: startWorkoutKey)
    
}

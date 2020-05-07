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
    
    
    
    
    
    @IBOutlet weak var buttonGenerateWorkout: UIButton!
    @IBOutlet weak var buttonCustomWorkout: UIButton!
    @IBOutlet weak var buttonProfile: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()

        // rounded buttons
        buttonGenerateWorkout.layer.cornerRadius = 10
        buttonCustomWorkout.layer.cornerRadius = 10
        buttonProfile.layer.cornerRadius = 10
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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

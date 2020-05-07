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
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonContinue.layer.cornerRadius = 10
        
        let workoutListFromMemory = loadWorkoutList()
        if workoutListFromMemory != nil {
            workoutList = loadWorkoutList()!
        }else{
            print("could not retrieve workoutList from disk")
        }
        
        //for testing purposes
        for workout in workoutList{
            print("the workout type is: \(workout.workoutType) the date is: \(workout.date) and the time to complete is: \(workout.workoutTime)")
            for bodyPart in workout.workoutBodyParts{
                print("Here is one of it's bodyparts: \(bodyPart)")
            }
            
            
            //trying to decode workout
            struct FailableDecodable<Base : Decodable> : Decodable {

                let base: Base?

                init(from decoder: Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    self.base = try? container.decode(Base.self)
                }
            }
            
            let jsonDecoder = JSONDecoder()
            
            let exercises = try! jsonDecoder.decode([FailableDecodable<Exercise>].self, from: workout.workoutExercises.data(using: .utf8)!)
            
            for exercise in exercises{
                if exercise.base != nil{
                    print("Here is one of the exercises: \(String(describing: exercise.base!.exerciseName))")
                }
                
            }
            
            //print(workout.workoutExercises)
            
            print("########")
        }
        
        // converting workout to json

        let jsonEncoder = JSONEncoder()
        
        let jsonData = try? jsonEncoder.encode(workout)
        
        if jsonData != nil{
            workoutInJSON = String(data: jsonData!, encoding: String.Encoding.utf8)!
        }
        
        addToWorkoutList()
        
        saveWorkoutList()
        
    }
    
    func addToWorkoutList(){
        let date = getCurrentDateAsString()
        let workoutTimeAsString = String(workoutTime)
        let workoutObject = Workout(workoutType: workoutType, date: date, workoutTime: workoutTimeAsString, workoutBodyParts: workoutBodyParts, workoutExercises : workoutInJSON)
        workoutList.append(workoutObject!)
        
    }
    
    func getCurrentDateAsString() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate: String = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func setParams(workout: [Exercise], workoutType: String, workoutTime: Int, workoutBodyParts: [String]){
        self.workout = workout
        self.workoutType = workoutType
        self.workoutTime = workoutTime
        self.workoutBodyParts = workoutBodyParts
        
        print("*************Testing if previous view stops sending at chest")
        for bodypart in workoutBodyParts{
            print(bodypart)
        }
    }
    
    func saveWorkoutList(){
        let savedSuccessfully = NSKeyedArchiver.archiveRootObject(workoutList, toFile: Workout.ArchiveURL.path)
        
        if savedSuccessfully {
           print("saved successfully")
        }else{
            print("Did not save successfully!")
        }
        
    }
    
    func loadWorkoutList() -> [Workout]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Workout.ArchiveURL.path) as? [Workout]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated:true)
    }
    
    
    
    @IBAction func onContinueClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    


}

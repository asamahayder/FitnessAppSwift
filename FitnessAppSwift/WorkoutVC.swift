//
//  TestViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 02/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

//This view contains a youtube player which is supported by a 3. party library.

class WorkoutVC: UIViewController {

    var workout:[Exercise] = []
    var workoutType: String = ""
    var workoutTime: Int = 0
    var workoutBodyParts: [String] = []
    var workoutSets = " "
    var workoutReps = " "
    var currentExercise = 0
    @IBOutlet weak var ExerciseDescriptionView: UIView!
    @IBOutlet weak var videoPlayer: WKYTPlayerView! //The youtube view
    
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var exerciseTime: UILabel!
    @IBOutlet weak var exerciseSets: UILabel!
    @IBOutlet weak var exerciseReps: UILabel!
    @IBOutlet weak var exercisePart: UILabel!
    @IBOutlet weak var exerciseDesc: UILabel!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ExerciseDescriptionView.layoutMargins = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
        exerciseDesc.sizeToFit()
        
        ExerciseDescriptionView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        ExerciseDescriptionView.layer.cornerRadius = 10
        buttonBack.layer.cornerRadius = 10
        buttonNext.layer.cornerRadius = 10
        
        if workoutType == "bodybuilding" {
            workoutSets = "4"
            workoutReps = "8-12"
        }else{
            workoutSets = "6"
            workoutReps = "4-6"
        }
        
        loadExercise(exercise: workout[currentExercise])
    }
    
    func loadExercise(exercise: Exercise) {
        //Changing the back and next buttons to reflect which exercise it is.
        if currentExercise == 0 {
            buttonBack.tintColor = UIColor.white
            buttonBack.backgroundColor = UIColor.red
            buttonBack.setTitle("Exit", for: .normal)
        }else{
            buttonBack.tintColor = UIColor.white
            buttonBack.backgroundColor = UIColor.systemBlue
            buttonBack.setTitle("Back", for: .normal)
        }
        
        if currentExercise == workout.count-1 {
            buttonNext.setTitle("Finish", for: .normal)
            buttonNext.backgroundColor = UIColor.green
        }else{
            buttonNext.setTitle("Next", for: .normal)
            buttonNext.backgroundColor = UIColor.systemBlue
            buttonNext.tintColor = UIColor.white
        }
        
        //Loading the video from a video ID
        videoPlayer.load(withVideoId: exercise.exerciseVidID)
        
        exerciseTitle.text = exercise.exerciseName
        exerciseTime.text = String(exercise.exerciseTime) + " min"
        exerciseReps.text = workoutReps + " reps"
        exerciseSets.text = workoutSets + " sets"
        exercisePart.text = exercise.exerciseBPart
        exerciseDesc.text = exercise.exerciseDisc
    }
    
    //Called from previous screen.
    func setParams(workout: [Exercise], workoutType: String, workoutTime: Int, workoutBodyParts: [String]) {
        self.workout = workout
        self.workoutType = workoutType
        self.workoutTime = workoutTime
        self.workoutBodyParts = workoutBodyParts
    }
    
    func finishWorkout()  {
        //Displaying an alert to make sure the user wants to continue
        let alert = UIAlertController(title: "Continue?", message: "Do you want to finish the workout?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            self.performSegue(withIdentifier: "goToFinishWorkout", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func exitWorkout() {
        //Displaying an alert to make the user wants to quit
        let alert = UIAlertController(title: "Exit?", message: "Do you want to exit the workout? The workout won't be saved or receive points", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
        return
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
        self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func loadNextExercise(_ sender: Any) {
        if currentExercise != workout.count-1 {
            currentExercise += 1
            loadExercise(exercise: workout[currentExercise])
        }else if currentExercise == workout.count-1{
            finishWorkout()
        }
    }
    
    @IBAction func loadPreviousExercise(_ sender: Any) {
        if currentExercise != 0 {
            currentExercise -= 1
            loadExercise(exercise: workout[currentExercise])
        }else{
            exitWorkout()
        }
    }
    
    //Hiding the back button in the navigation bar to force user to use next and back buttons.
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated:true)
    }
    
    //Sending data to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinishWorkout"{
            let secondVC: WorkoutFinishedVC = segue.destination as! WorkoutFinishedVC
            secondVC.setParams(workout: workout, workoutType: workoutType, workoutTime: workoutTime, workoutBodyParts: workoutBodyParts)
        }
    }
    
}



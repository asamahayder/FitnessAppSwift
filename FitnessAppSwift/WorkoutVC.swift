//
//  TestViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 02/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class WorkoutVC: UIViewController {
    
    var workout:[Exercise] = []
    var workoutType = " "
    var workoutSets = " "
    var workoutReps = " "
    var currentExercise = 0
    @IBOutlet weak var ExerciseDescriptionView: UIView!
    @IBOutlet weak var videoPlayer: WKYTPlayerView!
    
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
        
        ExerciseDescriptionView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        ExerciseDescriptionView.layer.cornerRadius = 10
        buttonBack.layer.cornerRadius = 10
        buttonNext.layer.cornerRadius = 10
        
        if workoutType == "bodybuilding" {
            workoutSets = "6"
            workoutReps = "4-6"
        }else{
            workoutSets = "4"
            workoutReps = "8-12"
        }
        
        loadExercise(exercise: workout[currentExercise])
        
        print("here are all the exercises brought to this view:####################")
        for exercise in workout{
            print(exercise.exerciseName)
        }
    }
    
    func loadExercise(exercise: Exercise) {
        if currentExercise == 0 {
            buttonBack.tintColor = UIColor.lightGray
            buttonBack.backgroundColor = UIColor.darkGray
        }else{
            buttonBack.tintColor = UIColor.white
            buttonBack.backgroundColor = UIColor.systemBlue
        }
        
        if currentExercise == workout.count-1 {
            buttonNext.setTitle("Finish", for: .normal)
            buttonNext.backgroundColor = UIColor.green
        }else{
            buttonNext.setTitle("Next", for: .normal)
            buttonNext.backgroundColor = UIColor.systemBlue
            buttonNext.tintColor = UIColor.white
        }
        
        videoPlayer.load(withVideoId: exercise.exerciseVidID)
        exerciseTitle.text = exercise.exerciseName
        exerciseTime.text = String(exercise.exerciseTime) + " min"
        exerciseReps.text = workoutReps + " reps"
        exerciseSets.text = workoutSets + " sets"
        exercisePart.text = exercise.exerciseBPart
        exerciseDesc.text = exercise.exerciseDisc
    }
    
    
    func setParams(workout: [Exercise], type: String) {
        self.workout = workout
        self.workoutType = type
    }
    
    func finishWorkout()  {
        //finish the workout
        //save the workout
        //Give EXP to trainer. Calculated as minutes trained x a constant
        //Check if reached new level and increase if yes.
        //Check if new title and show new title if yes
        //Maybe make phone rumble and put on some nice effects like firework
        //The person can have different titles based on his level. So rookie if level 1 and master at level 100 etc.
        //Check for new Achievements
        //All of this happens on a new screen that is shown modally. A user can then press continue to return.
        print("Finish the workout")
    }
    
    
    @IBAction func loadNextExercise(_ sender: Any) {
        if currentExercise != workout.count-1 {
            currentExercise += 1
            loadExercise(exercise: workout[currentExercise])
        }else if currentExercise == workout.count{
            finishWorkout()
        }
    }
    
    @IBAction func loadPreviousExercise(_ sender: Any) {
        if currentExercise != 0 {
            currentExercise -= 1
            loadExercise(exercise: workout[currentExercise])
        }
    }
    
    
    
    
}

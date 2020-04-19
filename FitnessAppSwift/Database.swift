//
//  Database.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import Foundation
class Database {
    
    var exerciseList = [Exercise]()
    
    func fillList()   {
        exerciseList.append(Exercise(exerciseName: "pushups", exerciseTime: 5, exercisePic: "no pic yet", exerciseDisc: "go down to the floor in a plank position. Slowly move your body up and down by extending and relaxing your arms. ", exerciseBPart: "chest"))
        
        exerciseList.append(Exercise(exerciseName: "Pullups", exerciseTime: 10, exercisePic: "no pic", exerciseDisc: "Jump up and grab a bar. Then proceed to pull yourself up in a slow and controlled manner. Make sure that your chin reaches the bar.", exerciseBPart: "back"))
        
        exerciseList.append(Exercise(exerciseName: "Deadlift", exerciseTime: 15, exercisePic: "no pic", exerciseDisc: "Stand with feet less than shoulder width. Bend down and grab the bar and pull up by extending your hips.", exerciseBPart: "back"))
        
        exerciseList.append(Exercise(exerciseName: "Squats", exerciseTime: 10, exercisePic: "no pic", exerciseDisc: "Place the bar behind the neck and on your traps. Then squat down as if sitting on a chair. Make sure that your knees stay behind toes.", exerciseBPart: "legs"))
        
        exerciseList.append(Exercise(exerciseName: "Biceps Dumbbell Curls", exerciseTime: 5, exercisePic: "no pic", exerciseDisc: "Grab er dumbbell and extend and contract the elbows slowy. Avoid swinging for maximum gains", exerciseBPart: "arms"))
        
        exerciseList.append(Exercise(exerciseName: "Hammer curls", exerciseTime: 5, exercisePic: "no pic", exerciseDisc: "Grab a dumbbell and stand with relaxed arms and palms facing the body. Then contract and extend the albow joint in a slow and controlled manner", exerciseBPart: "arms"))
        
        exerciseList.append(Exercise(exerciseName: "Concentration curls", exerciseTime: 5, exercisePic: "no pic", exerciseDisc: "Grab a single dumbbell and sit down on a bench. Place elbow on your thigh and extend arms.", exerciseBPart: "arms"))
        
        exerciseList.append(Exercise(exerciseName: "overhead Extensions", exerciseTime: 7, exercisePic: "no pic", exerciseDisc: "Grab a single dumbbell and sit on a bench. Lift dumbbell behind the neck and extend the elbow joint", exerciseBPart: "arms"))
        
        exerciseList.append(Exercise(exerciseName: "overhead cable extention", exerciseTime: 11, exercisePic: "no pic", exerciseDisc: "Stand with back towards the cable machine equipped with the rope. Bend slightly forwards and extend the elbow join above and behind the neck", exerciseBPart: "arms"))
        
        
        }
    
    init() {
        fillList()
        for item in exerciseList{
            print(item.exerciseName)
        }
    }
   
}

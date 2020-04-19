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
    
    init() {
        fillList()
        for item in exerciseList{
            print(item.exerciseName)
        }
    }
    
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
        
        exerciseList.append(Exercise(exerciseName: "tricep rope extention", exerciseTime: 11, exercisePic: "no pic", exerciseDisc: "Stand with back towards the cable machine equipped with the rope. Bend slightly forwards and extend the elbow join above and behind the neck", exerciseBPart: "arms"))
        
        exerciseList.append(Exercise(exerciseName: "Dumbbell Bench Press", exerciseTime: 10, exercisePic: "no pic", exerciseDisc: "Set up a bench at an incline of 30-45° and sit with your feet flat on the floor and your back on the bench. Lift the dumbbells to chest height with your palms facing forwards. Breathe out and push the dumbbells up until your arms are fully extended, using your pecs to power the movement. Don't let the dumbbells touch.", exerciseBPart: "chest"))
        
        exerciseList.append(Exercise(exerciseName: "Dumbbell Flyes", exerciseTime: 10, exercisePic: "no pic", exerciseDisc: "Lie flat on your back on a flat incline bench. Lift arms up above the head so they’re extended but not locked out.Inhale and slowly lower dumbbells in an arc motion until they’re in line with the chest. Your arms will be extended to the sides but not locked out. Don’t drop your arms lower than your shoulders.", exerciseBPart: "chest"))
        
        exerciseList.append(Exercise(exerciseName: "Wide-Grip Barbell Bench Press", exerciseTime: 12, exercisePic: "no pic", exerciseDisc: "Lie back on a flat bench holding a barbell with an overhand grip, hands set wider than your shoulders. From the starting position, breathe in and lower the bar slowly. Push the bar back to the starting position explosively as you breathe out. Focus on pushing the bar using your chest muscles.", exerciseBPart: "chest"))
        
        exerciseList.append(Exercise(exerciseName: "Incline Dumbbell Press Reverse-Grip", exerciseTime: 9, exercisePic: "no pic", exerciseDisc: "lllllll", exerciseBPart: "chest"))
        
        exerciseList.append(Exercise(exerciseName: "Incline Dumbbell Press Reverse-Grip", exerciseTime: 10, exercisePic: "no pic", exerciseDisc: "With the dumbbells at shoulder height, rotate your palms so that they face forward", exerciseBPart: "arms"))
        
        exerciseList.append(Exercise(exerciseName: "Deadlift", exerciseTime: 12, exercisePic: "no pic", exerciseDisc: "Stand with your mid-foot under the barbell. Bend over and grab the bar with a shoulder-width grip....", exerciseBPart: "back"))
        
        exerciseList.append(Exercise(exerciseName: "Atlas Stone Trainer", exerciseTime: 9, exercisePic: "no pic", exerciseDisc: "squat down and graå the stone with both hands, and use your legs and back to lift the stone up on the edge", exerciseBPart: "back"))
        
        exerciseList.append(Exercise(exerciseName: "standing lounges", exerciseTime: 9, exercisePic: "no pic", exerciseDisc: "stand straight on both leg. Squat down by having on of the legs go forward while the other stays in place and bends in 90 degrees. remember to have a straight back.", exerciseBPart: "legs"))
        
        exerciseList.append(Exercise(exerciseName: "walking lounges", exerciseTime: 12, exercisePic: "no pic", exerciseDisc: "Stand straight on both legs. Squat down by having one of the legs go forward. the other leg stays in place and bends in 90 degrees. The you stand up, by pulling the leg behind up and thereby taking a step forward.", exerciseBPart: "legs"))
        
        exerciseList.append(Exercise(exerciseName: "cable press", exerciseTime: 9, exercisePic: "no pic", exerciseDisc: "sit down with back against the pads and pull the two cables together with slightly bend arms. focus on having the chest muscles doing the work.", exerciseBPart: "chest"))
        
        }
   
}

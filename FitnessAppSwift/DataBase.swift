//
//  DatabaseObject.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import Foundation
class DataBase{
    var exerciseList = [Exercise]()
    
    init() {
        fillList()
        for item in exerciseList{
            print(item.exerciseName)
        }
    }
    
    func fillList()   {
    exerciseList.append(Exercise(exerciseName: "pushups", exerciseTime: 5, exerciseVidID: "IODxDxX7oi4", exerciseDisc: "go down to the floor in a plank position. Slowly move your body up and down by extending and relaxing your arms. ", exerciseBPart: "chest"))
    
    exerciseList.append(Exercise(exerciseName: "Pullups", exerciseTime: 10, exerciseVidID: "eGo4IYlbE5g", exerciseDisc: "Jump up and grab a bar. Then proceed to pull yourself up in a slow and controlled manner. Make sure that your chin reaches the bar.", exerciseBPart: "back"))
    
    exerciseList.append(Exercise(exerciseName: "Deadlift", exerciseTime: 15, exerciseVidID: "ytGaGIn3SjE", exerciseDisc: "Stand with feet less than shoulder width. Bend down and grab the bar and pull up by extending your hips.", exerciseBPart: "back"))
    
    exerciseList.append(Exercise(exerciseName: "Squats", exerciseTime: 10, exerciseVidID: "U3HlEF_E9fo", exerciseDisc: "Place the bar behind the neck and on your traps. Then squat down as if sitting on a chair. Make sure that your knees stay behind toes.", exerciseBPart: "legs"))
    
    exerciseList.append(Exercise(exerciseName: "Biceps Curls", exerciseTime: 5, exerciseVidID: "ykJmrZ5v0Oo", exerciseDisc: "Grab er dumbbell and extend and contract the elbows slowy. Avoid swinging for maximum gains.", exerciseBPart: "arms"))
    
    exerciseList.append(Exercise(exerciseName: "Hammer curls", exerciseTime: 5, exerciseVidID: "zC3nLlEvin4", exerciseDisc: "Grab a dumbbell and stand with relaxed arms and palms facing the body. Then contract and extend the albow joint in a slow and controlled manner.", exerciseBPart: "arms"))
    
    exerciseList.append(Exercise(exerciseName: "Concentration curls", exerciseTime: 5, exerciseVidID: "0AUGkch3tzc", exerciseDisc: "Grab a single dumbbell and sit down on a bench. Place elbow on your thigh and extend arms.", exerciseBPart: "arms"))
    
    exerciseList.append(Exercise(exerciseName: "overhead Extensions", exerciseTime: 7, exerciseVidID: "YbX7Wd8jQ-Q", exerciseDisc: "Grab a single dumbbell and sit on a bench. Lift dumbbell behind the neck and extend the elbow joint.", exerciseBPart: "arms"))
    
    exerciseList.append(Exercise(exerciseName: "overhead cable extention", exerciseTime: 11, exerciseVidID: "XTerYx0kwQ8", exerciseDisc: "Stand with back towards the cable machine equipped with the rope. Bend slightly forwards and extend the elbow join above and behind the neck.", exerciseBPart: "arms"))
    
    exerciseList.append(Exercise(exerciseName: "tricep rope extention", exerciseTime: 11, exerciseVidID: "PwOwL4B6iw4", exerciseDisc: "Stand with back towards the cable machine equipped with the rope. Bend slightly forwards and extend the elbow join above and behind the neck.", exerciseBPart: "arms"))
    
    exerciseList.append(Exercise(exerciseName: "Dumbbell Bench Press", exerciseTime: 10, exerciseVidID: "Y_7aHqXeCfQ", exerciseDisc: "Set up a bench at an incline of 30-45° and sit with your back on the bench. Lift the dumbbells to chest height with your palms facing forwards. Push the dumbbells up until your arms are fully extended, using your pecs to power the movement.", exerciseBPart: "chest"))
    
    exerciseList.append(Exercise(exerciseName: "Dumbbell Flyes", exerciseTime: 10, exerciseVidID: "eozdVDA78K0", exerciseDisc: "Lie on a flat incline bench. Lift arms up above the head so they’re extended but not locked out. Slowly lower dumbbells in an arc motion until they’re in line with the chest. Don’t drop your arms lower than your shoulders.", exerciseBPart: "chest"))
    
    exerciseList.append(Exercise(exerciseName: "Barbell Bench Press", exerciseTime: 12, exerciseVidID: "gRVjAtPip0Y", exerciseDisc: "Lie back on a flat bench holding a barbell with an overhand grip, hands set wider than your shoulders. From the starting position, lower the bar slowly. Push the bar back to the starting position explosively as you breathe out. Focus on pushing the bar using your chest muscles.", exerciseBPart: "chest"))
    
    exerciseList.append(Exercise(exerciseName: "Incline Dumbbell Press", exerciseTime: 9, exerciseVidID:  "hChjZQhX1Ls", exerciseDisc: "Lay down on an inlcined bench with two dumbbells. Lift the dumbbells up with an angle that puts the dumbbells above the upper pecs. Squeeze at the top and repeat.", exerciseBPart: "chest"))
    
    exerciseList.append(Exercise(exerciseName: "Incline cable flys", exerciseTime: 10, exerciseVidID:  "GtHNC-5GtR0", exerciseDisc: "Get to an inclined bench between two cable machines. Lay down with the cables in the hands and do a fly movement, lifting the cables up and touching above the chest.", exerciseBPart: "chest"))
    
    exerciseList.append(Exercise(exerciseName: "Bent over rows", exerciseTime: 12, exerciseVidID:  "kBWAon7ItDw", exerciseDisc: "Stand with your feet at shoulder width. Bend down as if sitting down and grab the bar. Lift up to the sternum while squeezing the glutes and abs. Repeat until you reach the specified number of reps.", exerciseBPart: "back"))
    
    exerciseList.append(Exercise(exerciseName: "Atlas Stone Trainer", exerciseTime: 9, exerciseVidID:  "go0WMsBSN6w", exerciseDisc: "squat down and grap the stone with both hands, and use your legs and back to lift the stone up on the edge.", exerciseBPart: "back"))
    
    exerciseList.append(Exercise(exerciseName: "standing lounges", exerciseTime: 9, exerciseVidID:  "QOVaHwm-Q6U", exerciseDisc: "stand straight on both leg. Squat down by having on of the legs go forward while the other stays in place and bends in 90 degrees. remember to have a straight back.", exerciseBPart: "legs"))
    
    exerciseList.append(Exercise(exerciseName: "walking lounges", exerciseTime: 12, exerciseVidID:  "D7KaRcUTQeE", exerciseDisc: "Stand straight on both legs. Squat down by having one of the legs go forward. the other leg stays in place and bends in 90 degrees. The you stand up, by pulling the leg behind up and thereby taking a step forward.", exerciseBPart: "legs"))
    
    exerciseList.append(Exercise(exerciseName: "cable press", exerciseTime: 9, exerciseVidID:  "taI4XduLpTk", exerciseDisc: "sit down with back against the pads and pull the two cables together with slightly bend arms. focus on having the chest muscles doing the work.", exerciseBPart: "chest"))
    
    }
    
    func getExerciseList() -> [Exercise] {
        return exerciseList
    }
}

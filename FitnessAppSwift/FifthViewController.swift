//
//  FifthViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    var answarObject: Answers? = nil
    var database = DatabaseObject()
    lazy var exerciseList = database.getExerciseList()
    var searchQuery:[Exercise] = [Exercise]()
    var currentTime: Int = 0
    
    var workout: [Exercise] = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateWorkout()
        addToStackView()
    }
    
    func setAnswerObject(object: Answers) {
        answarObject = object
    }
    
    func generateWorkout() {
        searchForBodyParts() //This filters the database by finding exercises that mach chosen bodyparts
        fillWorkout() //This goes through the result of searchForBodyParts() and keeps adding until desired time is reached.
    }
    
    func searchForBodyParts() {
        for exercise in exerciseList{
            for bodyPart in (answarObject?.getMuscleGroups())!{
                if exercise.exerciseBPart == bodyPart {
                    searchQuery.append(exercise)
                }
            }
        }
    }
    
    func fillWorkout() {
        let lowerBound:Int = 0
        let higherBound:Int = searchQuery.count-1
        repeat{
            //randomized implementation
            let intRandom = Int.random(in: lowerBound...higherBound)
            if searchQuery[intRandom].getIsFlagged() == false{
                workout.append(searchQuery[intRandom])
                currentTime += searchQuery[intRandom].exerciseTime
                searchQuery[intRandom].setIsFlagged(bool: true)
            }
        }while (currentTime < (answarObject?.getMinutes())!)
    }
    
    func addToStackView()  {
        for exercise in workout{
            let label = UILabel()
            label.text = exercise.exerciseName
            label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            label.heightAnchor.constraint(equalToConstant: 50).isActive = true
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
            stackView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}

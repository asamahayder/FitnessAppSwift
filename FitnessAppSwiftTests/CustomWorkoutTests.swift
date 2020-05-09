//
//  GenereatedWorkoutTest.swift
//  FitnessAppSwiftTests
//
//  Created by Asama Hayder on 09/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import XCTest
@testable import FitnessAppSwift

class CustomWorkoutTests: XCTestCase {
        
    var answerObject: Answers!
    var generateWorkoutView: GenerateWorkout_ExercisesVC!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        answerObject = Answers()
        generateWorkoutView = GenerateWorkout_ExercisesVC()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        answerObject = nil
        generateWorkoutView = nil
    }
    
    func testIfTheAnswerObjectFetchesTheCorrectExerciseBodyParts(){
        var bodyPartsAreMatching: Bool = true
        
        answerObject.setMinutes(minutes: 60)
        answerObject.setMuscleGroups(listOfMuscleGroups: ["chest", "legs"])
        generateWorkoutView.answerObject = answerObject
        generateWorkoutView.viewDidLoad()
        
        for exercise in generateWorkoutView.workout{
            if !answerObject.getMuscleGroups().contains(exercise.exerciseBPart) {
                bodyPartsAreMatching = false
            }
        }
        
        XCTAssert(bodyPartsAreMatching)
    }
    
    func testIfAnswerObjectGeneratesWorkoutWithCorrectTime(){
        var totalWorkoutTime = 0
        answerObject.setMinutes(minutes: 60)
        answerObject.setMuscleGroups(listOfMuscleGroups: ["chest", "legs"])
        generateWorkoutView.answerObject = answerObject
        generateWorkoutView.viewDidLoad()
        
        for exercise in generateWorkoutView.workout{
            totalWorkoutTime += exercise.exerciseTime
        }
        
        XCTAssert(totalWorkoutTime >= answerObject.getMinutes())
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

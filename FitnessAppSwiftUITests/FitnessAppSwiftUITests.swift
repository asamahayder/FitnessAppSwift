//
//  FitnessAppSwiftUITests.swift
//  FitnessAppSwiftUITests
//
//  Created by Asama Hayder on 10/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import XCTest

class FitnessAppSwiftUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        
        //This lets the app know that we are running a ui test and will reset it's state
        app.launchArguments.append("--uitesting")
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTheGenerateWorkoutUIFlow() {
        //Testing if we reach the workout view when going through the generate-workout flow.
        
        // UI tests must launch the application that they test.
        app.launch()
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Generate Workout"]/*[[".buttons[\"Generate Workout\"].staticTexts[\"Generate Workout\"]",".staticTexts[\"Generate Workout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["bodybuilding"].tap()
        app.buttons["legs"].tap()
        app.buttons["done"].tap()
        app.buttons["30 Min"].tap()
        app.buttons["Generate workout"].tap()
        app.buttons["startWorkout"].tap()
        XCTAssert(app.buttons["backButton"].exists)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

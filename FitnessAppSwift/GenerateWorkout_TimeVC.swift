//
//  ThirdViewController.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 14/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class GenerateWorkout_TimeVC: UIViewController {
    
    var answerObject:Answers? = nil
    var chosenTime: Int = 0
    
    @IBOutlet weak var button30Min: UIButton!
    @IBOutlet weak var button45Min: UIButton!
    @IBOutlet weak var button60Min: UIButton!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         title = "Time"
        
        //Rounded buttons
        button30Min.layer.cornerRadius = 10
        button45Min.layer.cornerRadius = 10
        button60Min.layer.cornerRadius = 10
    }
    
    @IBAction func Min30(_ sender: Any) {
        chosenTime = 30
        setAnswerObjectTime(time: chosenTime)
        
    }
    
    @IBAction func Min45(_ sender: Any) {
        chosenTime = 45
        setAnswerObjectTime(time: chosenTime)
        
    }
    @IBAction func MIn60(_ sender: Any) {
        chosenTime = 60
        setAnswerObjectTime(time: chosenTime)
    
    }
    
    func setAnswerObjectTime(time: Int) {
        if answerObject != nil{
            answerObject!.setMinutes(minutes: time)
            performSegue(withIdentifier: "seg3", sender: self)
        }else{
            print("Error: Did not receive an answerObject from the secondViewController")
        }
    }
    
    func setAnswerObject(object: Answers){
        answerObject = object
    }
    
    //Here we set some data in the next screen before we go to it.
    //it's an easy way of sending data between two neighbor view controllers.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fourthVC: GenerateWorkout_OverviewVC = segue.destination as! GenerateWorkout_OverviewVC
        fourthVC.setAnswerObject(object: answerObject!)
    }

} 

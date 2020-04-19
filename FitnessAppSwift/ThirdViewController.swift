//
//  ThirdViewController.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 14/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var answerObject:Answers? = nil
    var chosenTime: Int = 0
    

    override func viewDidLoad() {
         super.viewDidLoad()

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
        print("Chosen time is: \(time)")
    }
    
    func setAnswerObject(object: Answers){
        answerObject = object
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fourthVC: FourthViewController = segue.destination as! FourthViewController
        fourthVC.setAnswerObject(object: answerObject!)
    }

} 

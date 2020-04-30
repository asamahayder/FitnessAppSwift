//
//  FourthViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var partsText: UILabel!
    @IBOutlet weak var timeText: UILabel!
    
    var answerObject: Answers? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Overview"
        fillLabels()

        // Do any additional setup after loading the view.
    }
    
    func setAnswerObject(object: Answers){
        answerObject = object
    }
    
    func fillLabels() {
        if answerObject != nil {
            typeText.text! += answerObject!.getWorkoutType()
            timeText.text! += String(answerObject!.getMinutes())
            timeText.text! += " minutes"
            for text:String in answerObject!.getMuscleGroups(){
                partsText.text! += text
                partsText.text! += ", "
            }
        }else{
            print("Error: Did not receive an answerObject from thirdVC")
        }
    }
    
    
    @IBAction func generateWorkout(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fifthVC: FifthViewController = segue.destination as! FifthViewController
        fifthVC.setAnswerObject(object: answerObject!)
    }
    
    
}

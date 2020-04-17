//
//  ViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 13/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
var answerObject = Answers()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("first comit")
        print("Hola Asama")
    }
    
    @IBAction func goToNextScreen(_ sender: Any) {
        print("hey")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    @IBAction func chooseBodyBuilding(_ sender: Any) {
        answerObject.setWorkoutType(type: "bodybuilding")
        print("bodybuilding was choosen")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    @IBAction func chooseStrength(_ sender: Any) {
        answerObject.setWorkoutType(type: "Strength")
        print("Strength training was choosen")
        performSegue(withIdentifier: "seg1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: SecondViewController = segue.destination as! SecondViewController
        secondVC.setAnswerObject(object: answerObject)
    }
    
}


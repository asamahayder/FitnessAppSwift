//
//  ThirdViewController.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 14/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    func setAnswerObject(object: Answers){
        answerObject = object
    }
    
    
    var answerObject:Answers? = nil
    

    override func viewDidLoad() {
         super.viewDidLoad()

         self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1)
    }
    
       
    
    @IBAction func Min30(_ sender: Any) {
        
        
    }
    
    @IBAction func Min45(_ sender: Any) {
        
        
    }
    @IBAction func MIn60(_ sender: Any) {
        
        
    }
   
    
}

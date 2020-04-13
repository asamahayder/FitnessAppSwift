//
//  ViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 13/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC: SecondViewController = segue.destination as! SecondViewController
        destVC.dataFromFirst = "ayyyyy whatsup my man"
    }
    
}


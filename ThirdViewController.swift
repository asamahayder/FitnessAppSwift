//
//  ThirdViewController.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 14/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1)
    }
    
    @IBAction func goToHomeScreen(_ sender: Any) {
        
        performSegue(withIdentifier: "seg3", sender: self)
    }
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToFourth(_ sender: Any) {
        performSegue(withIdentifier: "seg4", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} 
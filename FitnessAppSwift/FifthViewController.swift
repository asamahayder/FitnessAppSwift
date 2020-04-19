//
//  FifthViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {
    
    var answarObject: Answers? = nil
    let database: Database = Database()
    
    @IBOutlet weak var lable: UILabel!
    var message: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lable.text = message
    }
    
    func setAnswerObject(object: Answers) {
        answarObject = object
    }
    
    
    
}

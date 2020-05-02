//
//  FifthViewController.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 19/04/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

//some of the code regarding the tableView was inspired by the tutorial from:
//https://blog.usejournal.com/easy-tableview-setup-tutorial-swift-4-ad48ec4cbd45

import UIKit



class FifthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var answarObject: Answers? = nil
    var database = DatabaseObject()
    lazy var exerciseList = database.getExerciseList()
    var searchQuery:[Exercise] = [Exercise]()
    var workout: [Exercise] = [Exercise]()
    var currentTime: Int = 0
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = UIColor.green
        return table
    }()
    let startWorkoutButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.green
        button.layer.cornerRadius = 10
        button.setTitle("Start Workout", for: .normal)
        button.addTarget(self, action: #selector(startWorkoutButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        button.contentEdgeInsets = UIEdgeInsets(top: 30,left: 30,bottom: 30,right: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 5
        button.layer.masksToBounds = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Exercises"
        generateWorkout()
        createTable()
        setupButton()
    }
    
    func setupButton(){
        self.view.addSubview(startWorkoutButton)
        NSLayoutConstraint.activate([
            startWorkoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            startWorkoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
    }
    
    @objc func startWorkoutButtonPressed(sender: UIButton!){
        //start workout
        
        self.navigationController?.popToRootViewController(animated: true)//Reseting the navigation hierarchi
        //This is a part of a Notification-Observer pattern that makes it possible to send data from one screen to the other.
        let key = Notification.Name(rawValue: startWorkoutKey)
        NotificationCenter.default.post(name: key, object: nil)
        
    }
    
    func setAnswerObject(object: Answers) {
        answarObject = object
    }
    
    func generateWorkout() {
        searchForBodyParts() //This filters the database by finding exercises that mach chosen bodyparts
        fillWorkout() //This goes through the result of searchForBodyParts() and keeps adding until desired time is reached.
    }
    
    func searchForBodyParts() {
        for exercise in exerciseList{
            for bodyPart in (answarObject?.getMuscleGroups())!{
                if exercise.exerciseBPart == bodyPart {
                    searchQuery.append(exercise)
                }
            }
        }
    }
    
    func fillWorkout() {
        let lowerBound:Int = 0
        let higherBound:Int = searchQuery.count-1
        repeat{
            //randomized implementation
            let intRandom = Int.random(in: lowerBound...higherBound)
            if searchQuery[intRandom].getIsFlagged() == false{
                workout.append(searchQuery[intRandom])
                currentTime += searchQuery[intRandom].exerciseTime
                searchQuery[intRandom].setIsFlagged(bool: true)
            }
        }while (currentTime < (answarObject?.getMinutes())!)
    }
    
    func addToStackView()  {
        
        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0

        for exercise in workout{
            
            //Text Label
            let textLabel = UILabel()
            textLabel.backgroundColor = UIColor.yellow
            textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            textLabel.text  = exercise.exerciseName
            textLabel.textAlignment = .center
            
            stackView.addArrangedSubview(textLabel)
            
            //let label = UILabel()
            //label.text = exercise.exerciseName
            //label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            //label.heightAnchor.constraint(equalToConstant: 50).isActive = true
            //label.textAlignment = .center
            //stackView.addSubview(label)
            //stackView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
    }
    
    func createTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableCell.self, forCellReuseIdentifier: "cellID")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    
    //The following two functions and class is directly taken from the tutorial
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return workout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableCell
        cell.backgroundColor = UIColor.white
        cell.exerciseName.text = workout[indexPath.row].exerciseName
        cell.exerciseTime.text = String(workout[indexPath.row].exerciseTime)
        cell.exerciseTime.text! += " min"
        
        var numberOfReps = 0
        if answarObject?.workoutType == "bodybuilding" {
            numberOfReps = 8
        }else{
            numberOfReps = 6
        }
        cell.exerciseReps.text = String(numberOfReps)
        cell.exerciseReps.text! += " reps"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    class TableCell: UITableViewCell {
        
        let cellView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.orange
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let exerciseName: UILabel = {
           let label = UILabel()
            label.text = "workoutName"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let exerciseTime: UILabel = {
           let label = UILabel()
            label.text = "workoutTime"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = NSTextAlignment.right
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.sizeToFit()
            return label
        }()
        
        let exerciseReps:UILabel = {
            let label = UILabel()
            label.text = "exerciseReps"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = NSTextAlignment.right
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.sizeToFit()
            return label
        }()
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
        }
        
        func setupView(){
            addSubview(cellView)
            cellView.addSubview(exerciseName)
            cellView.addSubview(exerciseTime)
            cellView.addSubview(exerciseReps)
            self.selectionStyle = .none
            
            NSLayoutConstraint.activate([
                cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
            
            exerciseName.heightAnchor.constraint(equalToConstant: 200).isActive = true
            exerciseName.widthAnchor.constraint(equalToConstant: 200).isActive = true
            exerciseName.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
            exerciseName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
            
            exerciseTime.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5).isActive = true
            exerciseTime.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
            
            exerciseReps.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
            exerciseReps.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
        }

        
        required init?(coder aDecoder: NSCoder){
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
}

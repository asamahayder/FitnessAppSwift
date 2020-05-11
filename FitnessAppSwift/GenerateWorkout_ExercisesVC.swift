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

class GenerateWorkout_ExercisesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var answerObject: Answers? = nil
    var database = DataBase()
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
        button.backgroundColor = UIColor.systemBlue
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
        button.accessibilityLabel = "startWorkout"
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
        //Reseting the navigation hierarchi, which means we are returning to the starting screen of the navigation controller
        self.navigationController?.popToRootViewController(animated: true)
        
        //This is a part of a Notification-Observer pattern that makes it possible to send data from one screen to the other.
        let key = Notification.Name(rawValue: startWorkoutKey)
        
        //here we prepare the data to send with the notification
        let data : [String: Any] = ["workout" : workout, "workoutType" : answerObject!.getWorkoutType(), "workoutTime" : answerObject!.getMinutes(), "workoutBodyParts" : answerObject!.getMuscleGroups()]
        
        //here we are posting (sending) the notification to all observer with the same key
        NotificationCenter.default.post(name: key, object: nil, userInfo: data)
        
    }
    
    //Is called by previous screen in prepare segue
    func setAnswerObject(object: Answers) {
        answerObject = object
    }
    
    
    func generateWorkout() {
        searchForBodyParts() //This filters the database by finding exercises that mach chosen bodyparts
        fillWorkout() //This goes through the result of searchForBodyParts() and keeps adding until desired time is reached.
    }
    
    func searchForBodyParts() {
        for exercise in exerciseList{
            for bodyPart in (answerObject?.getMuscleGroups())!{
                if exercise.exerciseBPart == bodyPart {
                    searchQuery.append(exercise)
                }
            }
        }
    }
    
    func fillWorkout() {
        let lowerBound:Int = 0
        let higherBound:Int = searchQuery.count-1
        var numberOfExerciseTaken = 0
        repeat{
            //randomized implementation
            let intRandom = Int.random(in: lowerBound...higherBound)
            if searchQuery[intRandom].getIsFlagged() == false{
                numberOfExerciseTaken += 1
                workout.append(searchQuery[intRandom])
                currentTime += searchQuery[intRandom].exerciseTime
                searchQuery[intRandom].setIsFlagged(bool: true)
            }
        }while (currentTime < (answerObject?.getMinutes())! && numberOfExerciseTaken < searchQuery.count) //Keep adding until time limit reached or no more exercises.
        calculateActualWorkoutTime()
    }
    
    //Often the exercises generated does not match the exact time chosen.
    //Here we calculate the actual total time of the generated exercises.
    func calculateActualWorkoutTime(){
        var actualTime = 0
        for exercise in workout{
            actualTime += exercise.exerciseTime
        }
        answerObject?.setMinutes(minutes: actualTime)
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return workout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableCell
        cell.backgroundColor = UIColor.white
        cell.exerciseName.text = workout[indexPath.row].exerciseName
        cell.exerciseTime.text = String(workout[indexPath.row].exerciseTime)
        cell.exerciseTime.text! += " min"
        
        //Here we change the number of reps to relfect the chosen workout type
        var numberOfReps = "0"
        if answerObject?.workoutType == "bodybuilding" {
            numberOfReps = "8-12"
        }else{
            numberOfReps = "4-6"
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

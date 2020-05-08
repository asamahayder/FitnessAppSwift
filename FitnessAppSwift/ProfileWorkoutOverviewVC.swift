//
//  ProfileWorkoutOverviewVC.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 08/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class ProfileWorkoutOverviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workoutDate: String = ""
    var workoutType: String = ""
    var workoutTime: String = ""
    var workoutBodyParts: [String] = []
    var exerciseList: [Exercise] = []
    var workout: Workout?
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var workoutInfoContainer: UIView!
    
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
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if workout != nil {
            decodeWorkoutExercises()
            workoutDate = workout!.date
            workoutType = workout!.workoutType
            workoutTime = workout!.workoutTime
        }
        
        labelDate.text = workoutDate
        labelType.text = workoutType
        labelTime.text = workoutTime + " min"
        
        createTable()
        determineBodyParts(list: exerciseList)
        setupButton()
        
        
    }
    
    func determineBodyParts(list: [Exercise]){
        
        var chestAdded = false
        var legsAdded = false
        var backAdded = false
        var armsAdded = false
        
        for exercise in list{
            if exercise.exerciseBPart == "chest" && !chestAdded{
                workoutBodyParts.append("chest")
                chestAdded = true
            }else if exercise.exerciseBPart == "back" && !backAdded {
                workoutBodyParts.append("back")
                backAdded = true
            }else if exercise.exerciseBPart == "legs" && !legsAdded {
                workoutBodyParts.append("legs")
                legsAdded = true
            }else if exercise.exerciseBPart == "arms" && !armsAdded {
                workoutBodyParts.append("arms")
                armsAdded = true
            }
            
            if chestAdded && backAdded && legsAdded && armsAdded{
                break
            }
            
        }
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
        
        //here we prepare the data to send with the notification
        let data : [String: Any] = ["workout" : exerciseList, "workoutType" : workoutType, "workoutTime" : Int(workoutTime)!, "workoutBodyParts" : workoutBodyParts]
        
        //here we are posting (sending) the notification to all observer with the same key
        NotificationCenter.default.post(name: key, object: nil, userInfo: data)
        
    }
    
    func addToStackView(){
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        
        for exercise in exerciseList{
            
            //Text Label
            let textLabel = UILabel()
            textLabel.backgroundColor = UIColor.yellow
            textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            textLabel.text  = exercise.exerciseName
            textLabel.textAlignment = .center
            
            stackView.addArrangedSubview(textLabel)
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
            tableView.topAnchor.constraint(equalTo: workoutInfoContainer.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableCell
        cell.backgroundColor = UIColor.white
        cell.exerciseName.text = exerciseList[indexPath.row].exerciseName
        cell.exerciseTime.text = String(exerciseList[indexPath.row].exerciseTime)
        cell.exerciseTime.text! += " min"
        
        var numberOfReps = "0"
        if workoutType == "bodybuilding" {
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
    
    /*func setParams(workoutDate: String, workoutType: String, workoutTime: String, exerciseList: [Exercise]){
        self.workoutDate = workoutDate
        self.workoutType = workoutType
        self.workoutTime = workoutTime
        self.exerciseList = exerciseList
    }*/
    
    func setWorkout(workout: Workout){
        self.workout = workout
    }
    
    func decodeWorkoutExercises(){
        //trying to decode workout
        struct FailableDecodable<Base : Decodable> : Decodable {

            let base: Base?

            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                self.base = try? container.decode(Base.self)
            }
        }
        
        let jsonDecoder = JSONDecoder()
        
        let exerciseList = try! jsonDecoder.decode([FailableDecodable<Exercise>].self, from: workout!.workoutExercises.data(using: .utf8)!)
        
        //creating normal exercise objects to add to list
        for exercise in exerciseList{
            var exerciseName: String = ""
            var exerciseTime: Int = 0
            var exerciseVideoID:String = ""
            var exerciseDesc: String = ""
            var exerciseBPart: String = ""
            
            if exercise.base != nil{
                exerciseName = exercise.base!.exerciseName
                exerciseTime = Int(exercise.base!.exerciseTime)
                exerciseVideoID = exercise.base!.exerciseVidID
                exerciseDesc = exercise.base!.exerciseDisc
                exerciseBPart = exercise.base!.exerciseBPart
                print("Here is one of the exercises: \(String(describing: exercise.base!.exerciseName))")
            }
            
            let exerciseObject: Exercise = Exercise(exerciseName: exerciseName, exerciseTime: exerciseTime, exerciseVidID: exerciseVideoID, exerciseDisc: exerciseDesc, exerciseBPart: exerciseBPart)
            
            self.exerciseList.append(exerciseObject)
            
        }
    }
    
}

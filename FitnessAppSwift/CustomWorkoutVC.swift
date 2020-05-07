//
//  CustomWorkoutVC.swift
//  FitnessAppSwift
//
//  Created by Asama Hayder on 07/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class CustomWorkoutVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var database = DataBase()
    lazy var exerciseList = database.getExerciseList()
    lazy var sortedExerciseList: [Exercise] = []
    var selectedExercises: [Exercise] = []
    var currentTotalTime = 0
    var currentTotalNumberOfExercises = 0
    var workoutType: String = ""
    var workoutBodyParts: [String] = []
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var totalExercisesLabel: UILabel!
    @IBOutlet weak var totalMinutesLabel: UILabel!
    @IBOutlet weak var startWorkoutButton: UIButton!
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = UIColor.green
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Styling button
        startWorkoutButton.layer.cornerRadius = 10
        startWorkoutButton.layer.borderColor = UIColor.systemBlue.cgColor
        startWorkoutButton.layer.borderWidth = 5
        
        //styling infoView
        infoView.layer.cornerRadius = 10
        
        
        sortedExerciseList = exerciseList.sorted()
        createTable()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onStartWorkoutClicked(_ sender: Any) {
        
        //returning if no exercises selected
        if selectedExercises.count == 0 {
            return
        }
        
        //Determining which bodyparts are present in the selection
        determineBodyParts(list: selectedExercises)
        let alert = UIAlertController(title: "Choose workout type", message: "This wil affect the number of reps", preferredStyle: .actionSheet)
        
        //an alert where you choose what type of training you want
        alert.addAction(UIAlertAction(title: "Bodybuilding", style: .default, handler: { _ in
        print("Bodybuilding was chosen")
            self.workoutType = "bodybuilding"
            self.sendDataAndGoToWorkout()
        }))
        
        alert.addAction(UIAlertAction(title: "Strength", style: .default, handler: { _ in
        print("Strength was chosen")
            self.workoutType = "strength"
            self.sendDataAndGoToWorkout()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendDataAndGoToWorkout(){
        self.navigationController?.popToRootViewController(animated: true)//Reseting the navigation hierarchi
        //This is a part of a Notification-Observer pattern that makes it possible to send data from one screen to the other.
        let key = Notification.Name(rawValue: startWorkoutKey)
        
        //here we prepare the data to send with the notification
        let data : [String: Any] = ["workout" : selectedExercises, "workoutType" : workoutType, "workoutTime" : currentTotalTime, "workoutBodyParts" : workoutBodyParts]
        
        //here we are posting (sending) the notification to all observer with the same key
        NotificationCenter.default.post(name: key, object: nil, userInfo: data)
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
                break
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
    
    func addToStackView(){
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        
        for exercise in sortedExerciseList{
            
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
        
        tableView.allowsMultipleSelection = true
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: infoView.topAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return sortedExerciseList.count
    }
    
    /*func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath) == nil {
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! TableCell
        
        if cell.isSelected{
            cell.cellView.backgroundColor = UIColor.init(red: CGFloat(41/255.0), green: CGFloat(150/255.0), blue: CGFloat(66/255.0), alpha: CGFloat(1.0))
        }else{
            cell.cellView.backgroundColor = UIColor.orange
        }
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableCell
        cell.backgroundColor = UIColor.white
        cell.exerciseName.text = sortedExerciseList[indexPath.row].exerciseName
        cell.exerciseTime.text = String(sortedExerciseList[indexPath.row].exerciseTime)
        cell.exerciseTime.text! += " min"
        
        cell.exerciseBodyPart.text = sortedExerciseList[indexPath.row].exerciseBPart
        
        let selectedBackgroundColor = UIView()
        selectedBackgroundColor.backgroundColor = UIColor.init(red: CGFloat(171/255.0), green: CGFloat(255/255.0), blue: CGFloat(181/255.0), alpha: CGFloat(1.0))
        cell.selectedBackgroundView = selectedBackgroundColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell selected
        startWorkoutButton.layer.borderColor = UIColor.white.cgColor
        startWorkoutButton.setTitleColor(UIColor.white, for: .normal)
        
        //let cell = tableView.cellForRow(at: indexPath) as! TableCell
        selectedExercises.append(sortedExerciseList[indexPath.row])
        currentTotalTime += sortedExerciseList[indexPath.row].exerciseTime
        currentTotalNumberOfExercises += 1
        totalMinutesLabel.text = String(currentTotalTime)
        totalExercisesLabel.text = String(currentTotalNumberOfExercises)
        //cell.cellView.backgroundColor = UIColor.init(red: CGFloat(41/255.0), green: CGFloat(150/255.0), blue: CGFloat(66/255.0), alpha: CGFloat(1.0))

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //cell deselected
        
        //let cell = tableView.cellForRow(at: indexPath) as! TableCell
        for i in 0...selectedExercises.count-1{
           if selectedExercises[i].exerciseName == sortedExerciseList[indexPath.row].exerciseName {
                currentTotalTime -= sortedExerciseList[indexPath.row].exerciseTime
                selectedExercises.remove(at: i)
                break
                
            }
        }
        currentTotalNumberOfExercises -= 1
        totalMinutesLabel.text = String(currentTotalTime)
        totalExercisesLabel.text = String(currentTotalNumberOfExercises)
        
        //cell.cellView.backgroundColor = UIColor.orange
        
        if selectedExercises.isEmpty {
            print("selection is now empty")
            startWorkoutButton.layer.borderColor = UIColor.systemBlue.cgColor
            startWorkoutButton.setTitleColor(UIColor.systemBlue, for: .normal)
        }
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
        
        let exerciseBodyPart:UILabel = {
            let label = UILabel()
            label.text = "bodyPart"
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
            
            cellView.addSubview(exerciseBodyPart)
            
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
            
            exerciseBodyPart.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
            exerciseBodyPart.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
        }

        
        required init?(coder aDecoder: NSCoder){
            fatalError("init(coder:) has not been implemented")
        }
        
    }

}

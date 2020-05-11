//
//  Profile.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 05/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

//some of the code regarding the tableView was inspired by the tutorial from:
//https://blog.usejournal.com/easy-tableview-setup-tutorial-swift-4-ad48ec4cbd45
class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workoutList: [Workout] = []
    var selectedWorkout: Workout?
    var profile: Profile?
    
    @IBOutlet weak var pointStatusLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var previousWorkoutLabelContainer: UIView!
    
    
    @IBOutlet weak var buttonCompleted1Workout: UIButton!
    @IBOutlet weak var buttonCompleted2Workouts: UIButton!
    @IBOutlet weak var buttonCompleted4Workouts: UIButton!
    @IBOutlet weak var buttonReachedLevel1: UIButton!
    @IBOutlet weak var buttonReachedLevel3: UIButton!
    @IBOutlet weak var buttonReachedLevel6: UIButton!
   
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = UIColor.green
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loading previous workouts from disc
        let workoutListFromMemory = loadWorkoutList()
        if workoutListFromMemory != nil {
            workoutList = loadWorkoutList()!
        }else{
            print("could not retrieve workoutList from disk")
        }
        
        //loading profile from disc
        let profileFromMemory = loadProfile()
        if profileFromMemory != nil {
            profile = profileFromMemory!
        }
        
        handleFillingProfileInfo()
        handleAchievementPictures()
        createTable()
        
    }
    
    
    //The following 6 functions are for each achievement. Each functions starts an alert that includes info about how to get the achievement.
    @IBAction func onCompleted1WorkoutClicked(_ sender: Any) {
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        alertTitle = "Complete 1 Workout"
        if profile!.completed1Workout == "true" {
            alertMessage = "You already have this achievement. Total completed workouts are: \(profile!.completedWorkoutCount)"
        }else{
            alertMessage = "You do not have this achievement. Total completed workouts are: \(profile!.completedWorkoutCount)"
        }
        
        onImagePressed(alertTitle: alertTitle, alertMessage: alertMessage)
    }
    
    
    @IBAction func onCompleted2WorkoutsClicked(_ sender: Any) {
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        alertTitle = "Complete 2 Workouts"
        if profile!.completed2Workouts == "true" {
            alertMessage = "You already have this achievement. Total completed workouts are: \(profile!.completedWorkoutCount)"
        }else{
            alertMessage = "You do not have this achievement. Total completed workouts are: \(profile!.completedWorkoutCount)"
        }
        
        onImagePressed(alertTitle: alertTitle, alertMessage: alertMessage)
        
    }
    
    
    @IBAction func onCompleted4WorkoutsClicked(_ sender: Any) {
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        alertTitle = "Complete 4 Workouts"
        if profile!.completed4Workouts == "true" {
            alertMessage = "You already have this achievement. Total completed workouts are: \(profile!.completedWorkoutCount)"
        }else{
            alertMessage = "You do not have this achievement. Total completed workouts are: \(profile!.completedWorkoutCount)"
        }
        
        onImagePressed(alertTitle: alertTitle, alertMessage: alertMessage)
        
    }
    
    @IBAction func onReachedLevel1Clicked(_ sender: Any) {
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        alertTitle = "Reach level 1"
        if profile!.reachedLVL1 == "true" {
            alertMessage = "You already have this achievement. Your level is: \(profile!.currentLVL)"
        }else{
            alertMessage = "You do not have this achievement. Your level is: \(profile!.currentLVL)"
        }
        
        onImagePressed(alertTitle: alertTitle, alertMessage: alertMessage)
        
    }
    
    
    @IBAction func onReachedLevel3Clicked(_ sender: Any) {
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        alertTitle = "Reach level 3"
        if profile!.reachedLVL3 == "true" {
            alertMessage = "You already have this achievement. Your level is: \(profile!.currentLVL)"
        }else{
            alertMessage = "You do not have this achievement. Your level is: \(profile!.currentLVL)"
        }
        
        onImagePressed(alertTitle: alertTitle, alertMessage: alertMessage)
        
    }
    
    
    @IBAction func onReachedLevel6Clicked(_ sender: Any) {
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        alertTitle = "Reach level 6"
        if profile!.reachedLVL6 == "true" {
            alertMessage = "You already have this achievement. Your level is: \(profile!.currentLVL)"
        }else{
            alertMessage = "You do not have this achievement. Your level is: \(profile!.currentLVL)"
        }
        
        onImagePressed(alertTitle: alertTitle, alertMessage: alertMessage)
        
    }
    
    //This is where the actual allert is created and presented
    func onImagePressed(alertTitle: String, alertMessage:String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //Showing the completed achievement pictures if completed
    func handleAchievementPictures(){
        if profile!.completed1Workout == "true" {
            buttonCompleted1Workout.setBackgroundImage(UIImage(named:"Completed1WorkoutImage"), for: .normal)
        }
        if profile!.completed2Workouts == "true" {
            buttonCompleted2Workouts.setBackgroundImage(UIImage(named:"Completed2WorkoutsImage"), for: .normal)
        }
        if profile!.completed4Workouts == "true" {
            buttonCompleted4Workouts.setBackgroundImage(UIImage(named:"Completed4WorkoutsImage"), for: .normal)
        }
        if profile!.reachedLVL1 == "true" {
            buttonReachedLevel1.setBackgroundImage(UIImage(named:"ReachedLevel1Image"), for: .normal)
        }
        if profile!.reachedLVL3 == "true" {
            buttonReachedLevel3.setBackgroundImage(UIImage(named:"ReachedLevel3Image"), for: .normal)
        }
        if profile!.reachedLVL6 == "true" {
            buttonReachedLevel6.setBackgroundImage(UIImage(named:"ReachedLevel6Image"), for: .normal)
        }
    }
    
    //The following 2 functions are used to save and load from userDefaults
    //They are deprecated and should be updated in the future.
    func loadWorkoutList() -> [Workout]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Workout.ArchiveURL.path) as? [Workout]
    }
    
    func loadProfile() -> Profile?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Profile.ArchiveURL.path) as? Profile
    }
    
    func handleFillingProfileInfo() {
        levelLabel.text = profile!.currentLVL
        pointStatusLabel.text = profile!.currentEXP + "/300"
        let progressValue: Float = Float(profile!.currentEXP)!/300.0
        progressBar.setProgress(progressValue, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWorkoutOverview" && selectedWorkout != nil{
            let workoutOverviewVC: ProfileWorkoutOverviewVC = segue.destination as! ProfileWorkoutOverviewVC
            workoutOverviewVC.setWorkout(workout: selectedWorkout!)
        }
    }
    
    func createTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableCell.self, forCellReuseIdentifier: "cellID")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: previousWorkoutLabelContainer.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return workoutList.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableCell
        cell.backgroundColor = UIColor.white
        cell.workoutDate.text = workoutList[indexPath.row].date
        cell.workoutTime.text = workoutList[indexPath.row].workoutTime + " minutes"
        cell.workoutType.text = workoutList[indexPath.row].workoutType
        
        var bodypartsString: String = ""
        for bodypart in workoutList[indexPath.row].workoutBodyParts{
            bodypartsString += bodypart
            bodypartsString += ", "
        }
        cell.workoutBodyParts.text = bodypartsString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell selected
        selectedWorkout = workoutList[indexPath.row]
        performSegue(withIdentifier: "goToWorkoutOverview", sender: self)
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
        
        let workoutDate: UILabel = {
           let label = UILabel()
            label.text = "00-00-00"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 25)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let workoutTime: UILabel = {
           let label = UILabel()
            label.text = "0"
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = NSTextAlignment.right
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.sizeToFit()
            return label
        }()
        
        let workoutBodyParts:UILabel = {
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
        
        let workoutType:UILabel = {
            let label = UILabel()
            label.text = "bodybuilding"
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
            cellView.addSubview(workoutDate)
            cellView.addSubview(workoutTime)
            cellView.addSubview(workoutBodyParts)
            cellView.addSubview(workoutType)
            
            NSLayoutConstraint.activate([
                cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
            
            workoutDate.heightAnchor.constraint(equalToConstant: 200).isActive = true
            workoutDate.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
            workoutDate.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
            
            workoutTime.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
            workoutTime.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
            
            workoutBodyParts.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5).isActive = true
            workoutBodyParts.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
            
            workoutType.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
            workoutType.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
            
            
        }

        required init?(coder aDecoder: NSCoder){
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}
    
    
    
    
    



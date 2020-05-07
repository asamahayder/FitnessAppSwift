//
//  Profile.swift
//  FitnessAppSwift
//
//  Created by Thaer Almalla on 05/05/2020.
//  Copyright © 2020 Asama Hayder. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workoutList: [Workout] = []
    
    @IBOutlet weak var pointStatusLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var previousWorkoutLabelContainer: UIView!
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = UIColor.green
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loading workoutList
        let workoutListFromMemory = loadWorkoutList()
        if workoutListFromMemory != nil {
            workoutList = loadWorkoutList()!
        }else{
            print("could not retrieve workoutList from disk")
        }
        
        for workout in workoutList{
            print("workout 1")
            for bodypart in workout.workoutBodyParts{
                print(bodypart)
            }
            print("##############")
        }
        
        createTable()
        
    }
    
    func addToStackView(){
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        
        for workout in workoutList{
            
            //Text Label
            let textLabel = UILabel()
            textLabel.backgroundColor = UIColor.yellow
            textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            textLabel.text  = workout.date
            textLabel.textAlignment = .center
            
            stackView.addArrangedSubview(textLabel)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
    }
    
    
    func loadWorkoutList() -> [Workout]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Workout.ArchiveURL.path) as? [Workout]
    }
    
    func createTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableCell.self, forCellReuseIdentifier: "cellID")
        view.addSubview(tableView)
        
        tableView.allowsMultipleSelection = true
        
        
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

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //cell deselected
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
            //workoutDate.widthAnchor.constraint(equalToConstant: 200).isActive = true
            workoutDate.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
            workoutDate.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
            /*workoutDate.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true*/
            
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
    
    
    
    
    



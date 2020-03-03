//
//  AlarmDetailTableViewController.swift
//  myAlarm
//
//  Created by Chris Gottfredson on 3/2/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    
    //MARK: - Properties
    
    var alarmIsOn: Bool = true
    var alarm: Alarm? {
        didSet {
            alarmIsOn = alarm?.enabled ?? true
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    //MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super .viewWillAppear(animated)
//        updateViews()
//    }
    
    //MARK: - Actions
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn = !alarmIsOn
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameLabel.text, !name.isEmpty else {return}
         let date = datePicker.date
        if let alarm = alarm {
            AlarmController.shared.updateAlarm(alarm: alarm, fireDate: date, name: name, enabled: alarmIsOn)
        } else {
            AlarmController.shared.addAlarm(fireDate: date, name: name, enabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let alarm = alarm else {return}
        datePicker.date = alarm.fireDate
        nameLabel.text = alarm.name
        navigationItem.title = alarm.name
        if alarmIsOn {
            enableButton.setTitle("Turn Off", for: .normal)
            enableButton.setTitleColor(.black, for: .normal)
            enableButton.backgroundColor = .green
            } else {
            enableButton.setTitle("Turn On", for: .normal)
            enableButton.setTitleColor(.white, for: .normal)
            enableButton.backgroundColor = .red
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}

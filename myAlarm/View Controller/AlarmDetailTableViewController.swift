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
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    var alarmIsOn: Bool = true
    
    //MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    
    @IBAction func enableButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameLabel.text, !name.isEmpty, let enabled = enableButton?.isEnabled else {return}
         let date = datePicker.date
        if let alarm = alarm {
            AlarmController.shared.updateAlarm(alarm: alarm, fireDate: date, name: name, enabled: enabled)
        } else {
            AlarmController.shared.addAlarm(fireDate: date, name: name, enabled: enabled)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let alarm = alarm else {return}
        datePicker.date = alarm.fireDate
        nameLabel.text = alarm.name
        enableButton.isEnabled = alarm.enabled
        if alarm.enabled {
            enableButton.titleLabel?.text = "On"
            enableButton.tintColor = .black
            enableButton.backgroundColor = .green
        } else {
        enableButton.titleLabel?.text = "Off"
            enableButton.tintColor = .white
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

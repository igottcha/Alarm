//
//  SwitchTableViewCell.swift
//  myAlarm
//
//  Created by Chris Gottfredson on 3/2/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func alarmSwitchTapped(for cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: - Properties
    
    var alarm: Alarm? {
        didSet {
//            guard alarm != nil else {return}
            updateViews(with: alarm!)
        }
    }
    weak var delegate: SwitchTableViewCellDelegate?
    
    //MARK: - Actions
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.alarmSwitchTapped(for: self)
    }
    
    //MARK: - Lifecycle
   
    //MARK: - Helper Functions
    
    func updateViews(with alarm: Alarm){
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
    }
}

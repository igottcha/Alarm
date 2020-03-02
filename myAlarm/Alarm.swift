//
//  Alarm.swift
//  myAlarm
//
//  Created by Chris Gottfredson on 3/2/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation

class Alarm: Codable {
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    let uuid: String
    var fireTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: fireDate)
    }
    
    init(fireDate: Date, name: String, enabled: Bool,uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return  lhs.fireDate == rhs.fireDate &&
                lhs.name == rhs.name &&
                lhs.enabled == rhs.enabled &&
                lhs.uuid == rhs.uuid
    }
}


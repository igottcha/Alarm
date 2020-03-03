//
//  AlarmController.swift
//  myAlarm
//
//  Created by Chris Gottfredson on 3/2/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    var mockAlarms: [Alarm] = {
        let alarm1 = Alarm(fireDate: Date(), name: "Wake up", enabled: true)
        let alarm2 = Alarm(fireDate: Date(), name: "Bedtime", enabled: true)
        let alarm3 = Alarm(fireDate: Date(), name: "Call Mom", enabled: true)
    
    return [alarm1, alarm2, alarm3]
    } ()
        
    init() {
        self.alarms = self.mockAlarms
        loadFromPersistentStorage()
    }
    
    static func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    //MARK: - CRUD functions
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(alarm)
        saveToPersistentStorage()
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        saveToPersistentStorage()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
        saveToPersistentStorage()
    }
    
    //MARK: - Persistence
    
    private static func fileURL() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = path[0]
        let fileName = "myAlarms.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    
   private func saveToPersistentStorage() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(alarms)
            try data.write(to: AlarmController.fileURL())
        } catch let error {
            print("\(error.localizedDescription) -> \(error)")
        }
    }
    
   func loadFromPersistentStorage() -> [Alarm] {
        let decoder = JSONDecoder()
        do {
            let data = try Data.init(contentsOf: AlarmController.fileURL())
            let alarms = try decoder.decode([Alarm].self, from: data)
            self.alarms = alarms
        } catch let error {
        print("\(error.localizedDescription) -> \(error)")
        }
    return alarms
    }
}

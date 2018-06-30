//
//  DataManager.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import Foundation

class DataManager {
    let docDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    lazy var archiveURL = docDirectory.appendingPathComponent("users.json")
    
    var users:[User] = []
    
    init() {
        self.users = getUsers()
    }
    
    func getUsers() -> [User] {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: archiveURL)
            let users = try decoder.decode([User].self, from: data)
            return users
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveUsers() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(users)
            try data.write(to: self.archiveURL)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

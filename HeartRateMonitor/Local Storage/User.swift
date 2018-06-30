//
//  User.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import Foundation

struct User {
    var name:String
    var devices:[String]
}

extension User:Codable {
    enum CodingKeys:String, CodingKey {
        case name
        case devices
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        devices = try container.decode([String].self, forKey: .devices)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(devices, forKey: .devices)
    }
}

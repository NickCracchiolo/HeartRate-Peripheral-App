//
//  DeviceInfoService.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 7/1/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import CoreBluetooth

struct DeviceInfoService {
    static let serialNumber = CBUUID(string: "2A25")
    static let manufacturer = CBUUID(string: "2A29")
    static let modelNumber = CBUUID(string: "2A24")
    
    static func string(fromCharacteristic c:CBCharacteristic) -> String? {
        guard let data = c.value else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

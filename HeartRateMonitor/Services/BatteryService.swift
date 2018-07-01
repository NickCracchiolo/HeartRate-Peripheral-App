//
//  BatteryService.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 7/1/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import CoreBluetooth

struct BatteryService {
    /// Returns the peripheral's battery level as a percent from 0% to 100%
    static func batteryLevel(fromCharacteristic c: CBCharacteristic) -> Int {
        guard let data = c.value, let byte = data.first else {
            return -1
        }
        return Int(byte)
    }
}

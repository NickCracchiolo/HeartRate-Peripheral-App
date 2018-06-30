//
//  BluetoothUUID.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import CoreBluetooth

struct BluetoothUUID {
    static let hrService = CBUUID(string: "0x180D")
    static let batteryService = CBUUID(string: "0x180F")
    static let heartRate = CBUUID(string: "2A37")
    static let bodyLoc = CBUUID(string: "2A38")
    static let batteryLevel = CBUUID(string: "2A19")
}

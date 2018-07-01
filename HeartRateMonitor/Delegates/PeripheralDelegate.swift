//
//  PeripheralDelegate.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import CoreBluetooth
import UIKit

extension PeripheralViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            print("\(peripheral.name ?? "") has no services")
            return
        }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print(service)
        for c in service.characteristics ?? [] {
            print("     \(c)")
            if (c.uuid == BluetoothUUID.heartRate) {
                peripheral.setNotifyValue(true, for: c)
            } else if (c.uuid == BluetoothUUID.bodyLoc) {
                peripheral.readValue(for: c)
            } else if (c.uuid == BluetoothUUID.batteryLevel) {
                //peripheral.readValue(for: c)
                peripheral.setNotifyValue(true, for: c)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case BluetoothUUID.heartRate:
            let hr = HeartRateService.heartRate(fromCharacteristic: characteristic)
            let connected = HeartRateService.sensorContactStatus(fromCharacteristic: characteristic)
            if connected == .detected {
                self.heartRateLabel.text = "\(hr)"
            } else {
                self.heartRateLabel.text = "---"
            }
        case BluetoothUUID.bodyLoc:
            let loc = HeartRateService.bodyLocation(fromCharacteristic: characteristic)
            self.connectionLabel.text = "Monitor is connected to the \(loc.description())"
        case BluetoothUUID.batteryLevel:
            let battery = BatteryService.batteryLevel(fromCharacteristic: characteristic)
            print("Battery Level: \(battery)")
            self.batteryLabel.text = "\(battery)%"
        default:
            break
        }
    }

}

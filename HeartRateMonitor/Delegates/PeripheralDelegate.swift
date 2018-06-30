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
    
    /// Returns the Heart Rate from the Sensor as an Int
    func heartRate(fromCharacteristic c:CBCharacteristic) -> Int {
        guard let data = c.value else { return -1 }
        let bytes = [UInt8](data)
        
        let format = bytes[0] & 0x01  
        
        switch format {
        // Heart Rate is an 8 bit number
        case 0:
            return Int(bytes[1])
        // Heart Rate is a 16 bit numebr
        default:
            return Int((bytes[1] << 8) & bytes[2])
        }
    }
    
    /// Parses the Sensor Contactr Status if the HR Monitor supports it
    func sensorContactStatus(fromCharacteristic c:CBCharacteristic) -> ContactStatus {
        guard let data = c.value else { return .notSupported }
        let bytes = [UInt8](data)
        
        let format = bytes[0] & 0x02
        
        switch format {
        case 2:
            return .notDetected
        case 3:
            return .detected
        default:
            return .notSupported
        }
    }
    
    /// Returns a String Description of the sensors body location
    func bodyLocation(fromCharacteristic c: CBCharacteristic) -> BodyLocation {
        guard let data = c.value, let byte = data.first else {
            return .unknown
        }
        switch byte {
        case 0:
            return .other
        case 1:
            return .chest
        case 2:
            return .wrist
        case 3:
            return .finger
        case 4:
            return .hand
        case 5:
            return .ear
        case 6:
            return .foot
        default:
            return .reserved
        }
    }
    
    // MARK: CBPeripheralDelegate
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            print("\(peripheral.name ?? "") has no services")
            return
        }
        for service in services {
            peripheral.discoverCharacteristics(characteristics, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print(service)
        for c in service.characteristics ?? [] {
            print("     \(c)")
            if (c.uuid == BluetoothUUID.heartRate) {
                peripheral.setNotifyValue(true, for: c)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case BluetoothUUID.heartRate:
            let hr = heartRate(fromCharacteristic: characteristic)
           self.heartRateLabel.text = "\(hr)"
        case BluetoothUUID.bodyLoc:
            let loc = bodyLocation(fromCharacteristic: characteristic)
            print(loc)
        default:
            break
        }
    }

}

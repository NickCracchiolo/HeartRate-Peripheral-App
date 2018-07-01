//
//  HeartRateService.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 7/1/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import CoreBluetooth

struct HeartRateService {
    /// Returns the Heart Rate from the Sensor as an Int
    static func heartRate(fromCharacteristic c:CBCharacteristic) -> Int {
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
    
    /// Parses the Sensor Contact Status if the HR Monitor supports it
    static func sensorContactStatus(fromCharacteristic c:CBCharacteristic) -> ContactStatus {
        guard let data = c.value else { return .notSupported }
        let bytes = [UInt8](data)
        
        let format = (bytes[0] & 0x06) >> 1
        
        switch format {
        case 2:
            return .notDetected
        case 3:
            return .detected
        default:
            return .notSupported
        }
    }
    
    /// Parses the Energy Expended information in kilo joule's
    static func energyExpended(fromCharacteristic c:CBCharacteristic) -> Int {
        guard let data = c.value else { return -1 }
        let bytes = [UInt8](data)
        
        let format = (bytes[0] & 0x08) >> 3
        
        switch format {
        case 1:
            return Int((bytes[3] << 8) & bytes[4])
        default:
            return -1
        }
    }
    
    /// Parses the RR time interval in seconds
    static func rr(fromCharacteristic c:CBCharacteristic) -> Int {
        guard let data = c.value else { return -1 }
        let bytes = [UInt8](data)
        
        let format = (bytes[0] & 0x10) >> 4
        
        switch format {
        case 1:
            return Int((bytes[5] << 8) & bytes[6])
        default:
            return -1
        }
    }
    
    /// Returns a String Description of the sensors body location
    static func bodyLocation(fromCharacteristic c: CBCharacteristic) -> BodyLocation {
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
}

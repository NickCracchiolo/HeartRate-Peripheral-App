//
//  BluetooothDelegate.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import CoreBluetooth

extension ViewController: CBCentralManagerDelegate {
    var peripherals:[CBPeripheral] {
        return Array(self.perifSet)
    }
    
    func connectToPeripheral(atIndex index:Int) {
        self.centralManager.connect(peripherals[index], options: nil)
    }
    
    // MARK: CBCentralManagerDelegate Functions
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("Central State is Unknown")
        case .resetting:
            print("Central State is Resetting")
        case .unsupported:
            print("Central State is Unsupported")
        case .unauthorized:
            print("Central State is Unauthorized")
        case .poweredOff:
            print("Central State is Powered Off")
        case .poweredOn:
            print("Central State is Powered On")
            central.scanForPeripherals(withServices: services)
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        perifSet.insert(peripheral)
        self.tableView.reloadData()
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from \(peripheral)")
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "")")
        self.connectedToPeripheral()
    }
}

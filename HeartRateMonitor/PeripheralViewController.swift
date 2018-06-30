//
//  PeripheralViewController.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import UIKit
import CoreBluetooth

class PeripheralViewController: UIViewController {
    @IBOutlet weak var heartRateLabel: UILabel!
    
    let characteristics:[CBUUID] = [BluetoothUUID.heartRate, BluetoothUUID.bodyLoc]
    var peripheral:CBPeripheral!
    var hr:Int = -1
    var loc:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
}

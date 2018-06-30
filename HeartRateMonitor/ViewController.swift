//
//  ViewController.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var centralManager:CBCentralManager!
    let services = [BluetoothUUID.hrService]
    var perifSet = Set<CBPeripheral>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "selectedPeripheralSegue") {
            if let vc = segue.destination as? PeripheralViewController,
               let index = self.tableView.indexPathForSelectedRow {
                vc.peripheral = self.peripherals[index.row]
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateTableView() {
        self.tableView.reloadData()
    }
    
    @objc func connectedToPeripheral() {
        self.performSegue(withIdentifier: "selectedPeripheralSegue", sender: nil)
    }
    
    @IBAction func rescan(_ sender: UIBarButtonItem) {
        self.centralManager.scanForPeripherals(withServices: services, options: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.connectToPeripheral(atIndex: indexPath.row)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peripherals.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peripheralCell") as! PeripheralCell
        cell.nameLabel.text = self.peripherals[indexPath.row].name
        return cell
    }
}

//
//  Notifications.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import Foundation

struct Notifications {
    static let newPeripheral = Notification.Name.init("NewPeripheral_Notif")
    static let connected = Notification.Name.init("Connected_Notif")
    static let hrUpdate = Notification.Name.init("HeartRateUpdated_Notif")
    static let bodyLocUpdate = Notification.Name.init("BodyLocUpdate_Notif")
}

//
//  BodyLocation.swift
//  HeartRateMonitor
//
//  Created by Nick Cracchiolo on 6/29/18.
//  Copyright © 2018 Nick Cracchiolo. All rights reserved.
//

import Foundation

enum BodyLocation {
    case unknown
    case other
    case chest
    case wrist
    case finger
    case hand
    case ear
    case foot
    case reserved
    
    func description() -> String {
        switch self {
        case .unknown:
            return "Unknown"
        case .other:
            return "Other"
        case .chest:
            return "Chest"
        case .wrist:
            return "Wrist"
        case .finger:
            return "Finger"
        case .hand:
            return "Hand"
        case .ear:
            return "Ear Lobe"
        case .foot:
            return "Foot"
        case .reserved:
            return "Reserved for future use"
        }
    }
}

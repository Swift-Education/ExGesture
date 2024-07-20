//
//  Gesture.swift
//  ExGesture
//
//  Created by 강동영 on 7/19/24.
//

import Foundation

enum Gesture: CaseIterable {
    case tap
    case pinch
    case rotation
    case swipe
    case pan
    case longPress
    
    var title: String {
        switch self {
        case .tap:
            "tap"
        case .pinch:
            "pinch"
        case .rotation:
            "rotation"
        case .swipe:
            "swipe"
        case .pan:
            "pan"
        case .longPress:
            "longPress"
        }
    }
}

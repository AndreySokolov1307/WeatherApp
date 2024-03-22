//
//  WeekDay.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

enum WeekDay: Int {
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    case sunday = 1
    
    var titleColor: UIColor {
        switch self {
        case .monday, .tuesday, .wednesday, .thursday, .friday:
            return .black
        case .saturday, .sunday:
            return .red
        }
    }
}

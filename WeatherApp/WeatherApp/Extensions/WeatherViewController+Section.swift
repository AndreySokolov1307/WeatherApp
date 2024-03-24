//
//  WeatherViewController+Section.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 23.03.2024.
//

import Foundation

extension WeatherViewController {
    enum Section: CaseIterable {
        case main
        case hourly
        case detail
        case sevenDays
        
        static func getSections(isLoading: Bool) -> [Section] {
            if isLoading {
                return [.main, .hourly]
            } else {
                return allCases
            }
        }
    }
}

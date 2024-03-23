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
        case detail
        case sevenDays
        
        static func getSections(isLoading: Bool) -> [Section] {
            var sections = allCases
            if isLoading {
                sections.removeLast()
                return sections
            } else {
                return sections
            }
        }
    }
}

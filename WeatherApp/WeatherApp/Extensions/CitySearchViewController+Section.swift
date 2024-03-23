//
//  CitySearchViewController+Section.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 23.03.2024.
//

import Foundation

extension CitySearchViewController {
    enum Section: String, CaseIterable {
        case location, searchResult
        
        static func getSections(searchTerm: String?, isSearchResultsEmpty: Bool) -> [Section] {
            if let searchTerm = searchTerm,
               isSearchResultsEmpty,
               searchTerm.count > Constants.numbers.maxSearchTermForSections {
                return []
            } else {
                return allCases
            }
        }
    }
}

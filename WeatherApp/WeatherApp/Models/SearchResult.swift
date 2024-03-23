//
//  SearchLocation.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let subtitle: String
    
    var description: String {
        return title + Constants.strings.space + subtitle
    }
}

//
//  CustomDateFormatter.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import Foundation

class CustomDateFormatter {
    static let shared = CustomDateFormatter()
    
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.timeZone = .current
       return formatter
    }()
    
    func weekDayNumber(from string: String) -> Int {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            let weekDay = Calendar.current.component(.weekday, from: date)
            return weekDay
        } else {
            return 2
        }
    }
    
    func dayOfTheWeek(from string: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            let weekDay = Calendar.current.component(.weekday, from: date)
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        } else {
            return "День недели"
        }
    }
    
    func formattedString(from string: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            dateFormatter.dateFormat = "MMMM d"
            return dateFormatter.string(from: date)
        } else {
            return "Месяц число"
        }
    }
}



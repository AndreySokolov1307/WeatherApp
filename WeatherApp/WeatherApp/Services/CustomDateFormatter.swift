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
        dateFormatter.dateFormat = Constants.strings.standartDateFormat
        if let date = dateFormatter.date(from: string) {
            let weekDay = Calendar.current.component(.weekday, from: date)
            return weekDay
        } else {
            return Constants.numbers.weekDayError
        }
    }
    
    func dayOfTheWeek(from string: String) -> String {
        dateFormatter.dateFormat = Constants.strings.standartDateFormat
        if let date = dateFormatter.date(from: string) {
            let weekDay = Calendar.current.component(.weekday, from: date)
            dateFormatter.dateFormat = Constants.strings.dayDateFormat
            return dateFormatter.string(from: date)
        } else {
            return Constants.strings.dayError
        }
    }
    
    func formattedString(from string: String) -> String {
        dateFormatter.dateFormat = Constants.strings.standartDateFormat
        if let date = dateFormatter.date(from: string) {
            dateFormatter.dateFormat = Constants.strings.monthDayDateFormat
            return dateFormatter.string(from: date)
        } else {
            return Constants.strings.monthError
        }
    }
}



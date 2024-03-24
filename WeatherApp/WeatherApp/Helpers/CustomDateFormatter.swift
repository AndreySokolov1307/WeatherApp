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
    
    func dateWithTime(from string: String) -> Date {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return dateFormatter.date(from: string) ?? Date()
    }
    
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
            dateFormatter.dateFormat = Constants.strings.dayDateFormat
            return dateFormatter.string(from: date)
        } else {
            return Constants.strings.dayError
        }
    }
    
    func time(from string: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        if let date = dateFormatter.date(from: string) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        } else {
            return "-"
        }
    }
    
    func time(from date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
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



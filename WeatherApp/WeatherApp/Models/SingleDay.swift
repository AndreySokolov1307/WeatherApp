//
//  SingleDay.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit

struct SingleDay {
    let date: String
    let weatherCode: Int
    let temperaturesMax: Double
    let temperaturesMin: Double
    
    var dayOfTheWeekString: String {
        CustomDateFormatter.shared.dayOfTheWeek(from: date)
    }
    
    var dateString: String {
        CustomDateFormatter.shared.formattedString(from: date)
    }
    
    var maxRemperatureString: String {
        WeatherFormatter.shared.temperatureString(from: temperaturesMax)
    }
    
    var minTemperatureString: String {
        WeatherFormatter.shared.temperatureString(from: temperaturesMin)
    }
    
    var weatherImage: UIImage? {
        WeatherFormatter.shared.weatherCodeImage(from: weatherCode, isDay: nil)
    }
    
    var titleColor: UIColor? {
        WeekDay(rawValue: CustomDateFormatter.shared.weekDayNumber(from: date))?.titleColor
    }
}


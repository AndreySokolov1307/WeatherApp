//
//  TwelveHoursFormatter.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 24.03.2024.
//

import UIKit

struct TwelveHoursWeatherFormatter {
    let currentTime: String
    let hours: [String]
    let temperatures: [Double]
    let weatherCodes: [Int]
    let isDay: [Int]
    private let lastIndex = 36
    
    private func getFirstIndex() -> Int {
        let currentTime = CustomDateFormatter.shared.dateWithTime(from: currentTime)
        let index = hours.firstIndex(where: { hour in
            CustomDateFormatter.shared.dateWithTime(from: hour) > currentTime
        }) ?? 0
        return index
    }
    
    func hoursFormatted() -> [String] {
        let firstIndex = getFirstIndex()
        let cropped = hours[firstIndex...lastIndex]
        let stringHours = cropped.map { CustomDateFormatter.shared.time(from: $0)}
        return stringHours
    }
    
    func temperaturesFormatted() -> [String] {
        let firstIndex = getFirstIndex()
        let cropped = temperatures[firstIndex...lastIndex]
        let temperatures = cropped.map { WeatherFormatter.shared.temperatureString(from: $0) }
        return temperatures
    }
    
    func weatherCodesImagesFormatted() -> [UIImage?] {
        let firstIndex = getFirstIndex()
        let croppedWeatherCodes = weatherCodes[firstIndex...lastIndex]
        let croppedIsDay = isDay[firstIndex...lastIndex]
        var weatherCodesImages = [UIImage?]()
        
        for (weatherCode, isDay) in zip(croppedWeatherCodes, croppedIsDay) {
            weatherCodesImages.append(WeatherFormatter.shared.weatherCodeImage(from: weatherCode, isDay: isDay))
        }
        return weatherCodesImages
    }
}

//
//  WeatherFormatter.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class WeatherFormatter {
    static let shared = WeatherFormatter()
    
    private let formatter:  MeasurementFormatter = {
       let formatter = MeasurementFormatter()
        formatter.unitOptions = .temperatureWithoutUnit
        formatter.unitStyle = .short
        return formatter
    }()
    
    func temperatureString(from temperature: Double) -> String {
        let roundedTemperature = temperature.rounded(.toNearestOrEven)
        let measurment = Measurement(value: roundedTemperature, unit: UnitTemperature.celsius)
        return formatter.string(from: measurment)
    }
    
    func windInfoString(direction: Int, speed: Double) -> String {
        let value = Int(Double(direction) / 22.5 + 0.5)
        let directions = ["C", "С-СВ", "СВ", "В-СВ", "В", "В-ЮВ", "ЮВ", "Ю-ЮВ", "Ю", "Ю-ЮЗ", "ЮЗ", "З-ЮЗ", "З", "З-СЗ", "СЗ", "С-СЗ"]
        let windDirection = directions[value % 16]
        let roundedSpeed = Int(speed.rounded(.toNearestOrEven))
        let string = "\(roundedSpeed) м/с \(windDirection)"
        return string
    }
    
    func humidityString(_ humidity: Int) -> String {
      return "\(humidity)%"
    }
    
    func pressureString(_ pressure: Double) -> String {
        let mmHg = pressure * 0.7500638
        let roundedPressure = Int(mmHg.rounded(.toNearestOrEven))
        return "\(roundedPressure) мм рт.ст."
    }
    
    func weatherCodeString(from weatherCode: Int) -> String {
        if let myWeatherCode = WeatherCode(rawValue: weatherCode) {
            return myWeatherCode.title
        } else {
            return "Вот это погода!"
        }
    }
    
    func weatherCodeImage(from weatherCode: Int) -> UIImage? {
        let myWeatherCode = WeatherCode(rawValue: weatherCode)
        let image = myWeatherCode?.image
        return image
    }
}

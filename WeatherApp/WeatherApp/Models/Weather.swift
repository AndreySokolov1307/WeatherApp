//
//  Weather.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

struct Weaher: Codable, Hashable {
    let current: CurrentWeather
    let daily: DailyWeather
}

struct CurrentWeather: Codable, Hashable {
    let temperature: Double
    let relativeHumidity: Int
    let apparentTemperature: Double
    let weatherCode: Int
    let surfacePressure: Double
    let windSpeed: Double
    let windDirection: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case relativeHumidity = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case weatherCode = "weather_code"
        case surfacePressure = "surface_pressure"
        case windSpeed = "wind_speed_10m"
        case windDirection = "wind_direction_10m"
    }
    
    var temperatureString: String {
        return WeatherFormatter.shared.temperatureString(from: temperature)
    }
    
    var apparentTemperatureString: String {
        return WeatherFormatter.shared.temperatureString(from: apparentTemperature)
    }
    
    var weatherCodeString: String {
        return WeatherFormatter.shared.weatherCodeString(from: weatherCode)
    }
    
    var windInfoString: String {
        return WeatherFormatter.shared.windInfoString(from: windDirection, speed: windSpeed)
    }
    
    var humidityString: String {
        return WeatherFormatter.shared.humidityString(from: relativeHumidity)
    }
    
    var pressureString: String {
        return WeatherFormatter.shared.pressureString(from: surfacePressure)
    }
    
    var weatherImage: UIImage? {
        return WeatherFormatter.shared.weatherCodeImage(from: weatherCode)
    }
}

struct DailyWeather: Codable, Hashable {
    let dates: [String]
    let weatherCodes: [Int]
    let temperaturesMax, temperaturesMin, uvIndexes: [Double]

    enum CodingKeys: String, CodingKey {
        case dates = "time"
        case weatherCodes = "weather_code"
        case temperaturesMax = "temperature_2m_max"
        case temperaturesMin = "temperature_2m_min"
        case uvIndexes = "uv_index_max"
    }
    
    var uvIndexString: String {
        if let uvIndex = uvIndexes.first {
            let roudedIndex = Int(uvIndex.rounded(.toNearestOrEven))
            return String(roudedIndex)
        } else {
            return Constants.strings.uvIndexErrorTitle
        }
    }
}


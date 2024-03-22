//
//  WeatherFormatter.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import Foundation

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
}

fileprivate enum WeatherCode: Int {
    case clearSky = 0
    case mainlyClear = 1
    case partlyCloudy = 2
    case overcast = 3
    case fog = 45
    case rimeFog = 48
    case lightDrizzle = 51
    case moderateDrizzle = 53
    case denseDrizzle = 55
    case lightfreezingDrizzle = 56
    case denseFreezingDrizzle = 57
    case slightRain = 61
    case moderateRain = 63
    case heavyRain = 65
    case lightFreezingRain = 66
    case heavyFreezingRain = 67
    case slightSnowFall = 71
    case moderateSnowFall = 73
    case heavySnowFall = 75
    case snowGrains = 77
    case slightRainShower = 80
    case moderateRainShower = 81
    case violentRainShower = 82
    case slightSnowShower = 85
    case heavySnowShower = 86
    case thunderstorm = 95
    case thunderstormWithSlightHail = 96
    case thunderstormWithHeavyHail = 99
    
    var title: String {
        switch self {
        case .clearSky:
            return "Ясно"
        case .mainlyClear:
            return "В основном ясно"
        case .partlyCloudy:
            return "Переменная облачность"
        case .overcast:
            return "Пасмурно"
        case .fog:
            return "Туман"
        case .rimeFog:
            return "Иней, туман"
        case .lightDrizzle:
            return "Легкая морось"
        case .moderateDrizzle:
            return "Морось"
        case .denseDrizzle:
            return "Сильная морось"
        case .lightfreezingDrizzle:
            return "Ледяная морось"
        case .denseFreezingDrizzle:
            return "Сильная ледяная морось"
        case .slightRain:
            return "Небольшой дождь"
        case .moderateRain:
            return "Дождь"
        case .heavyRain:
            return "Сильный Дождь"
        case .lightFreezingRain:
            return "Небольшой ледяной дождь"
        case .heavyFreezingRain:
            return "Сильный ледяной дождь"
        case .slightSnowFall:
            return "Небольшой снегопад"
        case .moderateSnowFall:
            return "Снегопад"
        case .heavySnowFall:
            return "Сильный снегопад"
        case .snowGrains:
            return "Град"
        case .slightRainShower:
            return "Небольшой ливень"
        case .moderateRainShower:
            return "Ливень"
        case .violentRainShower:
            return "Сильный ливень"
        case .slightSnowShower:
            return "Небольшая метель"
        case .heavySnowShower:
            return "Сильная метель"
        case .thunderstorm:
            return "Гроза"
        case .thunderstormWithSlightHail:
            return "Гроза с небольшим градом"
        case .thunderstormWithHeavyHail:
            return "Гроза с сильным градом"
        }
    }
}


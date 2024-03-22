//
//  WeatherCode.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit

enum WeatherCode: Int {
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
    
    var image: UIImage? {
        var config = ImageConfig.size
        var image: UIImage?
        
        switch self {
        case .clearSky, .mainlyClear:
            config = config.applying(ImageConfig.yellow)
            image = UIImage(systemName: "sun.max.fill", withConfiguration: config)
            return image
        case .partlyCloudy:
            config = config.applying(ImageConfig.greyYellow)
            image = UIImage(systemName: "cloud.sun.fill",withConfiguration: config)
            return image
        case .overcast:
            config = config.applying(ImageConfig.grey)
            image = UIImage(systemName: "cloud.fill", withConfiguration: config)
            return image
        case .fog, .rimeFog:
            config = config.applying(ImageConfig.greyLightgray)
            image = UIImage(systemName: "cloud.fog.fill", withConfiguration: config)
            return image
        case .lightDrizzle, .moderateDrizzle, .denseDrizzle:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "cloud.drizzle.fill", withConfiguration: config)
            return image
        case .lightfreezingDrizzle, .denseFreezingDrizzle, .lightFreezingRain, .heavyFreezingRain:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "cloud.sleet.fill", withConfiguration: config)
            return image
        case .slightRain, .moderateRain:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "cloud.rain.fill", withConfiguration: config)
            return image
        case .heavyRain, .slightRainShower, .moderateRainShower, .violentRainShower:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "cloud.heavyrain.fill", withConfiguration: config)
            return image
        case .slightSnowFall, .moderateSnowFall, .heavySnowFall:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "cloud.snow.fill", withConfiguration: config)
            return image
        case .snowGrains:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "cloud.hail.fill", withConfiguration: config)
            return image
        case .slightSnowShower:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "wind.snow", withConfiguration: config)
            return image
        case .heavySnowShower:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "wind.snow", withConfiguration: config)
            return image
        case .thunderstorm:
            config = config.applying(ImageConfig.greyYellow)
            image = UIImage(systemName: "cloud.bolt.fill", withConfiguration: config)
            return image
        case .thunderstormWithSlightHail, .thunderstormWithHeavyHail:
            config = config.applying(ImageConfig.greyBlue)
            image = UIImage(systemName: "cloud.bolt.rain.fill", withConfiguration: config)
            return image
        }
    }
}

fileprivate enum ImageConfig {
    static let size = UIImage.SymbolConfiguration.init(pointSize: 24)
    static let yellow = UIImage.SymbolConfiguration(paletteColors: [.systemYellow])
    static let grey = UIImage.SymbolConfiguration(paletteColors: [.systemGray3])
    static let greyBlue = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, Constants.colors.lightBlue2!])
    static let greyYellow = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, .systemYellow])
    static let greyLightgray = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, .systemGray5])
}

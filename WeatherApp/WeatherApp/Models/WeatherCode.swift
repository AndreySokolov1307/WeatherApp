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
            return Constants.strings.clearSky
        case .mainlyClear:
            return Constants.strings.mainlyClear
        case .partlyCloudy:
            return Constants.strings.partlyCloudy
        case .overcast:
            return Constants.strings.overcast
        case .fog:
            return Constants.strings.fog
        case .rimeFog:
            return Constants.strings.rimeFog
        case .lightDrizzle:
            return Constants.strings.lightDrizzle
        case .moderateDrizzle:
            return Constants.strings.moderateDrizzle
        case .denseDrizzle:
            return Constants.strings.denseDrizzle
        case .lightfreezingDrizzle:
            return Constants.strings.lightfreezingDrizzle
        case .denseFreezingDrizzle:
            return Constants.strings.denseFreezingDrizzle
        case .slightRain:
            return Constants.strings.slightRain
        case .moderateRain:
            return Constants.strings.moderateRain
        case .heavyRain:
            return Constants.strings.heavyRain
        case .lightFreezingRain:
            return Constants.strings.lightFreezingRain
        case .heavyFreezingRain:
            return Constants.strings.heavyFreezingRain
        case .slightSnowFall:
            return Constants.strings.slightSnowFall
        case .moderateSnowFall:
            return Constants.strings.moderateSnowFall
        case .heavySnowFall:
            return Constants.strings.heavySnowFall
        case .snowGrains:
            return Constants.strings.snowGrains
        case .slightRainShower:
            return Constants.strings.slightRainShower
        case .moderateRainShower:
            return Constants.strings.moderateRainShower
        case .violentRainShower:
            return Constants.strings.moderateRainShower
        case .slightSnowShower:
            return Constants.strings.slightSnowShower
        case .heavySnowShower:
            return Constants.strings.heavySnowShower
        case .thunderstorm:
            return Constants.strings.thunderstorm
        case .thunderstormWithSlightHail:
            return Constants.strings.thunderstormWithSlightHail
        case .thunderstormWithHeavyHail:
            return Constants.strings.thunderstormWithHeavyHail
        }
    }
    
    var image: UIImage? {
        var image: UIImage?
        
        switch self {
        case .clearSky, .mainlyClear:
            image = Constants.images.sun?.withConfiguration(ImageConfig.yellow)
            return image
        case .partlyCloudy:
            image = Constants.images.cloudSun?.withConfiguration(ImageConfig.greyYellow)
            return image
        case .overcast:
            image = Constants.images.cloud?.withConfiguration(ImageConfig.grey)
            return image
        case .fog, .rimeFog:
            image = Constants.images.fog?.withConfiguration(ImageConfig.greyLightgray)
            return image
        case .lightDrizzle, .slightRain:
            image = Constants.images.lightDrizzle?.withConfiguration(ImageConfig.greyYellowBlue)
            return image
        case .moderateDrizzle, .denseDrizzle:
            image = Constants.images.drizzle?.withConfiguration(ImageConfig.greyBlue)
            return image
        case .lightfreezingDrizzle, .denseFreezingDrizzle, .lightFreezingRain, .heavyFreezingRain:
            image = Constants.images.sleet?.withConfiguration(ImageConfig.greyBlue)
            return image
        case .moderateRain:
            image = Constants.images.rain?.withConfiguration(ImageConfig.greyBlue)
            return image
        case .heavyRain, .slightRainShower, .moderateRainShower, .violentRainShower:
            image = Constants.images.heavyRain?.withConfiguration(ImageConfig.greyBlue)
            return image
        case .slightSnowFall, .moderateSnowFall, .heavySnowFall:
            image = Constants.images.snow?.withConfiguration(ImageConfig.greyBlue)
            return image
        case .snowGrains:
            image = Constants.images.hail?.withConfiguration(ImageConfig.greyBlue)
            return image
        case .slightSnowShower:
            image = Constants.images.windSnow?.withConfiguration(ImageConfig.greyBlue)
            return image
        case .heavySnowShower:
            image = Constants.images.windSnow?.withConfiguration(ImageConfig.greyBlue)
            return image
        case .thunderstorm:
            image = Constants.images.thunderstorm?.withConfiguration(ImageConfig.greyYellow)
            return image
        case .thunderstormWithSlightHail, .thunderstormWithHeavyHail:
            image = Constants.images.thunderstormRain?.withConfiguration(ImageConfig.greyBlue)
            return image
        }
    }
    
    var nightImage: UIImage? {
       var nightImage: UIImage?
        
        switch self {
        case .clearSky, .mainlyClear:
            nightImage = Constants.images.moon?.withConfiguration(ImageConfig.purple)
            return  nightImage
        case .partlyCloudy:
            nightImage = Constants.images.cloudMoon?.withConfiguration(ImageConfig.greyPurple)
            return  nightImage
        case .lightDrizzle, .slightRain:
            nightImage = Constants.images.cloudMoonRain?.withConfiguration(ImageConfig.greyPurpleBlue)
            return  nightImage
        default:
            return  image
        }
    }
}



//
//  Constants.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit
import CoreLocation

enum Constants {
    
    //MARK: - Strings
    
    enum strings {
        static let uvIndexErrorTitle = "Ой, куда-то пропал"
        static let clearSky = "Ясно"
        static let mainlyClear = "В основном ясно"
        static let partlyCloudy = "Переменная облачность"
        static let overcast = "Пасмурно"
        static let fog = "Туман"
        static let rimeFog = "Иней, туман"
        static let lightDrizzle = "Легкая морось"
        static let moderateDrizzle = "Морось"
        static let denseDrizzle = "Сильная морось"
        static let lightfreezingDrizzle = "Ледяная морось"
        static let denseFreezingDrizzle = "Сильная ледяная морось"
        static let slightRain = "Небольшой дождь"
        static let moderateRain = "Дождь"
        static let heavyRain = "Сильный Дождь"
        static let lightFreezingRain = "Небольшой ледяной дождь"
        static let heavyFreezingRain = "Сильный ледяной дождь"
        static let slightSnowFall = "Небольшой снегопад"
        static let moderateSnowFall = "Снегопад"
        static let heavySnowFall = "Сильный снегопад"
        static let snowGrains = "Град"
        static let slightRainShower = "Небольшой ливень"
        static let moderateRainShower = "Ливень"
        static let violentRainShower = "Сильный ливень"
        static let slightSnowShower = "Небольшая метель"
        static let heavySnowShower = "Сильная метель"
        static let thunderstorm = "Гроза"
        static let thunderstormWithSlightHail = "Гроза с небольшим градом"
        static let thunderstormWithHeavyHail = "Гроза с сильным градом"
        static let space = " "
        static let doneButtonTitle = "Выбрать"
        static let haveSeenDeniedAlertKey = "haveSeenDeniedAlert"
        static let error = "Ошибка"
        static let restrictedMessage = "Доступ к местоположению ограничен родительским контролем"
        static let deniedMessage = "Доступ к местоположению запрещен. Пожалуйста разрешите это в настройках"
        static let detailHeaderTitle = "Сейчас"
        static let sevenDaysHeaderTitle = "Прогноз на 7 дней"
        static let citySearchTitle = "Регион"
        static let apparentTemperature = "Ощущается как"
        static let windTitle = "Ветер"
        static let humidityTitle = "Влажность"
        static let pressureTitle = "Давление"
        static let uvIndexTitle = "УФ индекс"
        static let mainCellReuseIdentifier = "MainCell"
        static let detailCellReuseIdentifier = "DetailCell"
        static let dailyCellReuseIdentifier = "DailyCell"
        static let userLocationCellReuseIdentifier = "UserLocationCell"
        static let userLocationCellTitle = "Моя локация"
        static let userLocationCellInfo = "Получи точный прогноз по локации"
        static let locationSearchCellReuseIdentifier = "LocationSearchCell"
        static let loadingDetailCellReuseIdentifier = "LoadingDetailCell"
        static let loadingMainCellReuseIdentifier = "LoadingMainCell"
        static let baseURLString = "https://api.open-meteo.com/v1/forecast"
        static let baseQuery: [String : String] = [
            "current" : "temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,is_day",
            "daily" : "weather_code,temperature_2m_max,temperature_2m_min,uv_index_max",
            "timezone" : "auto",
            "hourly" : "temperature_2m,weather_code,is_day"
        ]
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let empty = ""
        static let directions = ["C", "С-СВ", "СВ", "В-СВ", "В", "В-ЮВ", "ЮВ", "Ю-ЮВ", "Ю", "Ю-ЮЗ", "ЮЗ", "З-ЮЗ", "З", "З-СЗ", "СЗ", "С-СЗ"]
        static let weatherCodeError = "Вот это погода!"
        static let standartDateFormat = "yyyy-MM-dd"
        static let dayDateFormat = "EEEE"
        static let dayError = "День недели"
        static let dayMonthDateFormat = "d MMMM"
        static let monthDayDateFormat = "MMMM d"
        static let monthError = "Месяц число"
        static let searchResultsFile = "searchResults"
        static let searchResultsPathComponents = "search_results"
        static let searcResultsPathExtension = "plist"
        static let collectionViewHeaderReuseIdentifier = "HeaderIdentifier"
        static let collectionViewSectionBackgroundKindIdentifier = "SectionBackgroundView"
        static let cityNotFoundTitle = "Город не найден"
        static let errorViewTitle = "Упс, что-то пошло не так"
        static let errorViewSubtitle = "Постараемся быстро все исправить"
        static let tryAgainButtonTitle = "Попробовать снова"
        static let ok = "OK"
        static let locationServicesDisabled = "Включите службы определения метопоожения в настройках"
        static let hourlyCellReuseIdentifier = "HourlyCell"
        static let loadingHourlyCellReuseIdentifier = "LoadingHourlyCell"
        static let dateWithTimeFormat = "yyyy-MM-dd'T'HH:mm"
        static let timeFormat = "HH:mm"
        static let line = "-"
        static let englishLocaleIdentifier = "en"
    }
    
    //MARK: - Layout
    
    enum layout {
        static let sympolConfiguretionPointSize: CGFloat = 24
        static let mainSectionItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        static let mainSectionItemContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        static let mainSectionGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        static let mainSectionGroupItemsCount = 1
        static let mainSectionContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16)
        static let mainSectionBackgroundContentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        static let detailSectionItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        static let detailSectionItemBottomContentInset: CGFloat = 8
        static let detailSectionGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        static let detailSectionGroupItemsCount = 1
        static let detailSectionContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16)
        static let detailSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) ,
                                                                    heightDimension: .absolute(40))
        static let detailSectionBackgroundContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        static let sevenDaysSectionItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                     heightDimension: .fractionalHeight(1.0))
        static let sevenDaysSectionGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                      heightDimension: .absolute(60.0))
        static let sevenDaysSectionGroupItemsCount = 1
        static let sevenDaysSectionContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16)
        static let sevenDaysSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) ,
                                                                       heightDimension: .absolute(40))
        static let hourlySectionItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        static let hourlySectionGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.17), heightDimension: .fractionalHeight(0.15))
        static let hourlySectionContentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 18, trailing: 8)
        static let hourlySectionBackgroundBottomInset: CGFloat = 8
        static let doneButtonCornerRadius: CGFloat = 12
        static let lineViewHeight: CGFloat = 0.5
        static let lineViewBottom: CGFloat = -12
        static let doneButtonHeight: CGFloat = 44
        static let doneButtolLeading: CGFloat = 16
        static let doneButtonTrailing: CGFloat = -16
        static let doneButtonBottom: CGFloat = -12
        static let numberOfItemsMainSection = 1
        static let numberOfItemsDetailSection = 1
        static let zeroItems = 0
        static let numberOfRowsLocationSection = 1
        static let heightForTableViewRow: CGFloat = 60
        static let detailCellVStackSpacing: CGFloat = 8
        static let dailyCellVStackSpacing: CGFloat = 4
        static let dailyCellHStackSpacing: CGFloat = 24
        static let dailyCellMinTempLabelWidth: CGFloat = 35
        static let dailyCellMaxTempLabelWidth: CGFloat = 35
        static let userLocationCellDetailInfoviewLeading: CGFloat = 24
        static let userLocationCellDetailInfoviewTrailing: CGFloat = -24
        static let locationSearchCellVStackSpacing: CGFloat = 2
        static let locationSearchCellVStackLeading: CGFloat = 24
        static let locationSearchCellVStackTrailing: CGFloat = -8
        static let locationSearchCellSelectionImageViewTrailing: CGFloat = -24
        static let locationSearchCellSelectionImageViewSide: CGFloat = 24
        static let loadingDetailCellVStackSpacing: CGFloat = 8
        static let loadingMainCellVStackSpacing: CGFloat = 24
        static let loadingMainCellImageViewSide: CGFloat = 82
        static let symbolConfiguretionPointSizeMax: CGFloat = 82
        static let detailInfoViewVStackSpacing: CGFloat = 2
        static let detailInfoViewImageViewSide: CGFloat = 24
        static let detailInfoViewVStackLeading: CGFloat = 16
        static let sectionBackgroundViewCornerRadius: CGFloat = 16
        static let sectionBackgroundViewShadowRadius: CGFloat = 6
        static let sectionBackgrondViewShadowOffset = CGSize(width: 0, height: 0)
        static let sectionBackgrondViewShadowOpacity: Float = 0.2
        static let navBarHStackSpacing: CGFloat = 4
        static let navBarHStackCustomSpacing: CGFloat = 6
        static let navBarHStackSideMultiplier: CGFloat = 1
        static let navBarWeatherImageViewSide: CGFloat = 24
        static let navBarChevronImageViewSide: CGFloat = 18
        static let cityNotFoundLabelCenterY: CGFloat = -200
        static let loadingDetailViewTitleCornerRadius: CGFloat = 8
        static let loadingDetailViewSubtitleCornerRaduis: CGFloat = 6
        static let loadingDetailViewTitleHeight: CGFloat = 16
        static let loadingDetailViewTitleWidth: CGFloat = 144
        static let loadingDetailViewTitleCenterY: CGFloat = -16
        static let loadingDetailViewSubtitleHeight: CGFloat = 12
        static let loadingDetailViewSubtitleWidth: CGFloat = 80
        static let loadingDetailViewSubtitleCenterY: CGFloat = 12
        static let errorViewVStackSpacing: CGFloat = 12
        static let errorViewVStackCustomSpacing: CGFloat = 8
        static let errorViewImageViewSide: CGFloat = 56
        static let numberOfItemsHourlySection = 12
        static let loadingHourlyCellCircleViewSide: CGFloat = 34
        static let loadingHourlyCellTitleViewWidth: CGFloat = 24
        static let loadingHourlyCellTitleViewHeight: CGFloat = 16
        static let loadingHourlyCellSubtitleViewWidth: CGFloat = 24
        static let loadingHourlyCellSubtitleViewHeight: CGFloat = 16
        static let loadingHourlyCellSubtitleViewCornerRadius: CGFloat = 2
        static let loadingHourlyCellTitleViewCornerRadius: CGFloat = 2
        static let loadingHourlyCellCircleViewCornerRadius: CGFloat = 17
        
    }
    
    //MARK: - Numbers
    
    enum numbers {
        static let maxTextCount = 2
        static let maxSearchTermForSections = 1
        static let maxSearchTextCount = 2
        static let userLocationCellAnimationDuration: Double = 0.5
        static let userLocationCellAnimationDelay: Double = 0
        static let locationCellTitleLabelNumberOfLines = 1
        static let locationCellInfoLabelNumberOfLines = 1
        static let locationSearchCellAnimationDuration: Double = 0.5
        static let locationSearchCellAnimationDelay: Double = 0
        static let statusCode200 = 200
        static let pressureCoef = 0.7500638
        static let weekDayError = 2
        static let isDay = 1
        static let maxNumberOfSearchResults = 5
        static let twelveHourWeatherFormatterLastIndex = 36
        static let zeroIndex = 0
    }
    
    //MARK: - Colors
    
    enum colors {
        static let lightBlue = UIColor(named: "lightBlue")
        static let lightBlue2 = UIColor(named: "lightBlue2")
        static let lightGray = UIColor(named: "lightGray")
        static let gray = UIColor(named: "gray")
        static let purple = UIColor(named: "purple")
    }
    
    //MARK: - Images
    
    enum images {
        static let sun = UIImage(systemName: "sun.max.fill")
        static let cloudSun = UIImage(systemName: "cloud.sun.fill")
        static let cloud = UIImage(systemName: "cloud.fill")
        static let fog = UIImage(systemName: "cloud.fog.fill")
        static let lightDrizzle = UIImage(systemName: "cloud.sun.rain.fill")
        static let drizzle = UIImage(systemName: "cloud.drizzle.fill")
        static let sleet = UIImage(systemName: "cloud.sleet.fill")
        static let rain = UIImage(systemName: "cloud.rain.fill")
        static let heavyRain = UIImage(systemName: "cloud.heavyrain.fill")
        static let snow = UIImage(systemName: "cloud.snow.fill")
        static let hail = UIImage(systemName: "cloud.hail.fill")
        static let windSnow = UIImage(systemName: "wind.snow")
        static let thunderstorm = UIImage(systemName: "cloud.bolt.fill")
        static let thunderstormRain =  UIImage(systemName: "cloud.bolt.rain.fill")
        static let close = UIImage(named: "close")
        static let wind = UIImage(systemName: "wind")
        static let humidity = UIImage(systemName: "humidity")
        static let barometer = UIImage(systemName: "barometer")
        static let sunMax = UIImage(systemName: "sun.max")
        static let location = UIImage(systemName: "location")
        static let selected = UIImage(systemName: "checkmark.circle.fill")
        static let chevronDown = UIImage(systemName: "chevron.down")
        static let exclamationmarkTriangle = UIImage(systemName: "exclamationmark.triangle.fill")
        static let moon = UIImage(systemName: "moon.fill")
        static let cloudMoon = UIImage(systemName: "cloud.moon.fill")
        static let cloudMoonRain = UIImage(systemName: "cloud.moon.rain.fill")
    }
    
    //MARK: - Loaction
    
    enum location {
        static let moscowLocation = CLLocation(latitude: 55.7512, longitude: 37.6156)
        static let moscowLatitude: Double = 55.7512
        static let moscowLongitude: Double = 37.6156
    }
    
    //MARK: - Fonts
    
    enum fonts {
        static let detailHeader =  UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let sevenDaysHeader = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let mainCellTemperatureLabel = UIFont.systemFont(ofSize: 70, weight: .semibold)
        static let mainCellWeatherCodeLabel = UIFont.systemFont(ofSize: 18, weight: .light)
        static let mainCellApparentTemperatureLabel = UIFont.systemFont(ofSize: 18, weight: .light)
        static let dailyCellDayOfTheWeekLabel = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let dailyCellDateLabel = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let dailyCellMinTempLabel = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let dailyCellMaxTempLabel = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let userLocationCellTitleLabel = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let userLocationCellInfoLabel = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let locationCellTitleLabel = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let locationCellInfoLabel = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let detailInfoViewTitle = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let deyailInfoViewInfo = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let navBarTitle = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let cityNotFoundLabel = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let errorViewTitle = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let errorViewSubTitle =  UIFont.systemFont(ofSize: 16, weight: .regular)
        static let tryAgainButton =  UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let hourlyCellTemperatureLabel = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let hourlyCellTimeLabel = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
}

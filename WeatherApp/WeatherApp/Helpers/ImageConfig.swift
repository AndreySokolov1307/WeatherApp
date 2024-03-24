//
//  ImageConfig.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 23.03.2024.
//

import UIKit

enum ImageConfig {
    static let size = UIImage.SymbolConfiguration.init(pointSize: Constants.layout.sympolConfiguretionPointSize)
    static let sizeMax = UIImage.SymbolConfiguration(pointSize: Constants.layout.symbolConfiguretionPointSizeMax)
    static let yellow = UIImage.SymbolConfiguration(paletteColors: [.systemYellow]).applying(size)
    static let grey = UIImage.SymbolConfiguration(paletteColors: [.systemGray3]).applying(size)
    static let greyBlue = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, Constants.colors.lightBlue2!]).applying(size)
    static let greyYellow = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, .systemYellow]).applying(size)
    static let greyLightgray = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, .systemGray5]).applying(size)
    static let purpleYellow = UIImage.SymbolConfiguration(paletteColors: [.purple, .systemYellow]).applying(size)
    static let purple = UIImage.SymbolConfiguration(paletteColors: [Constants.colors.purple!]).applying(size)
    static let greyPurple = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, Constants.colors.purple!]).applying(size)
    static let greyYellowBlue = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, .systemYellow, Constants.colors.lightBlue2!]).applying(size)
    static let greyPurpleBlue = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, Constants.colors.purple!, Constants.colors.lightBlue2!]).applying(size)
}

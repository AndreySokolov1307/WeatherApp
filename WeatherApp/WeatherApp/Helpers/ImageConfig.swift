//
//  ImageConfig.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 23.03.2024.
//

import UIKit

enum ImageConfig {
    static let size = UIImage.SymbolConfiguration.init(pointSize: Constants.layout.sympolConfiguretionPointSize)
    static let sizeMax = UIImage.SymbolConfiguration(pointSize: Constants.layout.sympolConfiguretionPointSizeMax)
    static let yellow = UIImage.SymbolConfiguration(paletteColors: [.systemYellow]).applying(size)
    static let grey = UIImage.SymbolConfiguration(paletteColors: [.systemGray3]).applying(size)
    static let greyBlue = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, Constants.colors.lightBlue2!]).applying(size)
    static let greyYellow = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, .systemYellow]).applying(size)
    static let greyLightgray = UIImage.SymbolConfiguration(paletteColors: [.systemGray3, .systemGray5]).applying(size)
}

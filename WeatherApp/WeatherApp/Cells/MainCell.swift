//
//  MainCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class MainCell: UICollectionViewCell {
    static let reuseIdentifier = "MainCell"
    
    @UseAutolayout private var vStack: UIStackView  = .style {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    let temperatureLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 70, weight: .semibold)
    }
    
    let weatherCodeLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .light)
        $0.textColor = Constants.colors.gray
    }
    
    let apparentTemperatureLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .light)
        $0.textColor = Constants.colors.gray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(vStack)
        vStack.addArrangedSubview(temperatureLabel)
        vStack.addArrangedSubview(weatherCodeLabel)
        vStack.addArrangedSubview(apparentTemperatureLabel)
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configure(with currentWeather: CurrentWeather) {
        temperatureLabel.text = currentWeather.temperatureString
        apparentTemperatureLabel.text = "Ощущается как \(currentWeather.apparentTemperatureString)"
        weatherCodeLabel.text = currentWeather.weatherCodeString
    }
}


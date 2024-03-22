//
//  DailyCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class DailyCell: UICollectionViewCell {
    static let reuseIdentifier = "DailyCell"
    
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    @UseAutolayout private var hStack: UIStackView  = .style {
        $0.axis = .horizontal
        $0.spacing = 24
        $0.distribution = .equalCentering
        $0.alignment = .fill
    }
    
    @UseAutolayout var dayOfTheWeekLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    @UseAutolayout var dateLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        $0.textColor = Constants.colors.gray
        
    }
    
    let weatherImageView = UIImageView()
    
    let minTemperatureLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = Constants.colors.gray
        $0.textAlignment = .right
    }
    
    let maxTemperatureLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textAlignment = .right
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
        addSubview(hStack)
        vStack.addArrangedSubview(dayOfTheWeekLabel)
        vStack.addArrangedSubview(dateLabel)
        hStack.addArrangedSubview(weatherImageView)
        hStack.addArrangedSubview(maxTemperatureLabel)
        hStack.addArrangedSubview(minTemperatureLabel)
        weatherImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: 35),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 35),
            
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configure(with singleDay: SingleDay) {
        dayOfTheWeekLabel.text = CustomDateFormatter.shared.dayOfTheWeek(from: singleDay.date)
        dayOfTheWeekLabel.textColor = WeekDay(rawValue: CustomDateFormatter.shared.weekDayNumber(from: singleDay.date))?.titleColor
        dateLabel.text = CustomDateFormatter.shared.formattedString(from: singleDay.date)
        maxTemperatureLabel.text = WeatherFormatter.shared.temperatureString(from: singleDay.temperaturesMax)
        minTemperatureLabel.text =  WeatherFormatter.shared.temperatureString(from: singleDay.temperaturesMin)
        weatherImageView.image = WeatherFormatter.shared.weatherCodeImage(from: singleDay.weatherCode)
    }
}

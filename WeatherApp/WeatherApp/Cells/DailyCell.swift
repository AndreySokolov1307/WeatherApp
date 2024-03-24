//
//  DailyCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class DailyCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.strings.dailyCellReuseIdentifier
    
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.spacing = Constants.layout.dailyCellVStackSpacing
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    @UseAutolayout private var hStack: UIStackView  = .style {
        $0.axis = .horizontal
        $0.spacing = Constants.layout.dailyCellHStackSpacing
        $0.distribution = .equalCentering
        $0.alignment = .fill
    }
    
    @UseAutolayout var dayOfTheWeekLabel: UILabel = .style {
        $0.font = Constants.fonts.dailyCellDayOfTheWeekLabel
    }
    
    @UseAutolayout var dateLabel: UILabel = .style {
        $0.font = Constants.fonts.dailyCellDateLabel
        $0.textColor = Constants.colors.gray
        
    }
    
    let weatherImageView = UIImageView()
    
    let minTemperatureLabel: UILabel = .style {
        $0.font = Constants.fonts.dailyCellMinTempLabel
        $0.textColor = Constants.colors.gray
        $0.textAlignment = .right
    }
    
    let maxTemperatureLabel: UILabel = .style {
        $0.font = Constants.fonts.dailyCellMaxTempLabel
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
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: Constants.layout.dailyCellMinTempLabelWidth),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: Constants.layout.dailyCellMaxTempLabelWidth),
            
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configure(with singleDay: SingleDay) {
        dayOfTheWeekLabel.text = singleDay.dayOfTheWeekString
        dayOfTheWeekLabel.textColor = singleDay.titleColor
        dateLabel.text = singleDay.dateString
        maxTemperatureLabel.text = singleDay.maxRemperatureString
        minTemperatureLabel.text =  singleDay.minTemperatureString
        weatherImageView.image = singleDay.weatherImage
    }
}

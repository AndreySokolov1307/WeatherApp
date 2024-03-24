//
//  HourlyCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 24.03.2024.
//

import UIKit

class HourlyCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.strings.hourlyCellReuseIdentifier
    
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    let timeLabel: UILabel = .style {
        $0.font = Constants.fonts.hourlyCellTimeLabel
    }
    
    let imageView: UIImageView = .style {  
        $0.contentMode = .scaleAspectFit
    }
    
    let temperatureLabel: UILabel = .style {
        $0.font = Constants.fonts.hourlyCellTemperatureLabel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(time: String?, image: UIImage?, temperature: String?) {
        timeLabel.text = time
        imageView.image = image
        temperatureLabel.text = temperature
    }
    
    private func configureCell() {
        addSubview(vStack)
        vStack.addArrangedSubview(timeLabel)
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

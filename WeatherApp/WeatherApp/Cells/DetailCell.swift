//
//  DetailCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class DetailCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.strings.detailCellReuseIdentifier
    
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.spacing = Constants.layout.detailCellVStackSpacing
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    let windInfoView: DetailInfoView = .style {
        $0.titleLabel.text = Constants.strings.windTitle
        $0.imageView.image = Constants.images.wind
    }
    
    let humidityInfoView: DetailInfoView = .style {
        $0.titleLabel.text = Constants.strings.humidityTitle
        $0.imageView.image = Constants.images.humidity
    }
    
    let pressureInfoView: DetailInfoView = .style {
        $0.titleLabel.text = Constants.strings.pressureTitle
        $0.imageView.image = Constants.images.barometer
    }
    
    let uvIndexInfoView: DetailInfoView = .style {
        $0.titleLabel.text = Constants.strings.uvIndexTitle
        $0.imageView.image = Constants.images.sunMax
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
        vStack.addArrangedSubview(windInfoView)
        vStack.addArrangedSubview(humidityInfoView)
        vStack.addArrangedSubview(pressureInfoView)
        vStack.addArrangedSubview(uvIndexInfoView)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configure(with weather: Weaher) {
        windInfoView.infoLabel.text = weather.current.windInfoString
        humidityInfoView.infoLabel.text = weather.current.humidityString
        pressureInfoView.infoLabel.text = weather.current.pressureString
        uvIndexInfoView.infoLabel.text = weather.daily.uvIndexString
    }
}

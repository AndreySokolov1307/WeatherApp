//
//  CityNotFoundView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

class CityNotFoundView: UIView {
    
    @UseAutolayout private var label: UILabel = .style {
        $0.text = Constants.strings.cityNotFoundTitle
        $0.font = Constants.fonts.cityNotFoundLabel
        $0.textColor = Constants.colors.gray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.layout.cityNotFoundLabelCenterY),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

//
//  CityNotFoundView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

class CityNotFoundView: UIView {
    
    @UseAutolayout private var label: UILabel = .style {
        $0.text = "Город не найден"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .systemGray
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
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

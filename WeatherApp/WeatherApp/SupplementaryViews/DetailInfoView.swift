//
//  DetailWeatherInfoView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class DetailInfoView: UIView {
    
    @UseAutolayout var imageView: UIImageView = .style {
        $0.tintColor = .black
    }
    
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.spacing = 2
        $0.alignment = .leading
        $0.distribution = .fillProportionally
    }
    
    let titleLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = Constants.colors.gray
    }
    
    let infoLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(imageView)
        addSubview(vStack)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            vStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

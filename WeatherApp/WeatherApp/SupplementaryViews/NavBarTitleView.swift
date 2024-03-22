//
//  NavBarTitleView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit
import CoreLocation

class NavBarTitleView : UIView {
    
    let titleLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    @UseAutolayout private var chevronImageView: UIImageView = .style {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = .systemGray
        $0.isHidden = true
    }
    
    @UseAutolayout var weatherImageView = UIImageView()
    
    @UseAutolayout private var hStack: UIStackView = .style {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with location: CLLocation, weather: Weaher?) async throws {
        titleLabel.text = try await LocationFormatter.shared.cityName(location: location)
        weatherImageView.image = weather?.current.weatherImage
        chevronImageView.isHidden = false
    }
    
    private func configureView() {
        addSubview(hStack)
        hStack.addArrangedSubview(weatherImageView)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(chevronImageView)
        hStack.setCustomSpacing(6, after: weatherImageView)
        weatherImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            hStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            hStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            
            weatherImageView.widthAnchor.constraint(equalToConstant: 24),
            weatherImageView.widthAnchor.constraint(equalToConstant: 24),
            
            chevronImageView.heightAnchor.constraint(equalToConstant: 16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 16),
        ])
    }
}

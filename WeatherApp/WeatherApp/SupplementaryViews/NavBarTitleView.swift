//
//  NavBarTitleView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit
import CoreLocation

final class NavBarTitleView : UIView {
    
    let titleLabel: UILabel = .style {
        $0.font = Constants.fonts.navBarTitle
    }
    
    @UseAutolayout private var chevronImageView: UIImageView = .style {
        $0.image = Constants.images.chevronDown
        $0.tintColor = .systemGray
        $0.isHidden = true
    }
    
    @UseAutolayout var weatherImageView = UIImageView()
    
    @UseAutolayout private var hStack: UIStackView = .style {
        $0.axis = .horizontal
        $0.spacing = Constants.layout.navBarHStackSpacing
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
    
    func configure(with location: CLLocation, weather: Weather?) async throws {
        titleLabel.text = try await LocationFormatter.shared.cityName(location: location)
        weatherImageView.image = weather?.current.weatherImage
        chevronImageView.isHidden = false
    }
    
    private func configureView() {
        addSubview(hStack)
        hStack.addArrangedSubview(weatherImageView)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(chevronImageView)
        hStack.setCustomSpacing(Constants.layout.navBarHStackCustomSpacing, after: weatherImageView)
        weatherImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            hStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.layout.navBarHStackSideMultiplier),
            hStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.layout.navBarHStackSideMultiplier),
            
            weatherImageView.widthAnchor.constraint(equalToConstant: Constants.layout.navBarWeatherImageViewSide),
            weatherImageView.widthAnchor.constraint(equalToConstant: Constants.layout.navBarWeatherImageViewSide),
            
            chevronImageView.heightAnchor.constraint(equalToConstant: Constants.layout.navBarChevronImageViewSide),
            chevronImageView.widthAnchor.constraint(equalToConstant: Constants.layout.navBarChevronImageViewSide),
        ])
    }
}

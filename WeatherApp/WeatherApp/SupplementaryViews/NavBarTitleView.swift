//
//  NavBarTitleView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

class NavBarTitleView : UIView {
    
    let titleLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    @UseAutolayout private var imageView: UIImageView = .style {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = .systemGray
    }
    
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
    
    private func configureView() {
        addSubview(hStack)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            hStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            hStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            
            imageView.heightAnchor.constraint(equalToConstant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 16),
        ])
    }
}

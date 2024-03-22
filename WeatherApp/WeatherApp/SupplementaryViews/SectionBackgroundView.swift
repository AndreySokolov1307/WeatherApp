//
//  SectionBackgroundView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {
    static let kindIdenifier = "SectionBackgroundView"
    
    @UseAutolayout var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        addSubview(imageView)
        imageView.image = Constants.images.rain
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func didMoveToSuperview() {
   
    }
}

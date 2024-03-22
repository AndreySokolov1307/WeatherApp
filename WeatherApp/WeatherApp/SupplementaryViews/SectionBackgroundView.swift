//
//  SectionBackgroundView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {
    static let kindIdenifier = "SectionBackgroundView"
    
    override func didMoveToSuperview() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
}

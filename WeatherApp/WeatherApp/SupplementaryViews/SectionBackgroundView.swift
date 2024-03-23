//
//  SectionBackgroundView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {
    static let kindIdenifier = Constants.strings.collectionViewSectionBackgroundKindIdentifier
    
    override func didMoveToSuperview() {
        backgroundColor = .white
        layer.cornerRadius = Constants.layout.sectionBackgroundViewCornerRadius
        layer.shadowRadius = Constants.layout.sectionBackgroundViewCornerRadius
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = Constants.layout.sectionBackgrondViewShadowOffset
        layer.shadowOpacity = Constants.layout.sectionBackgrondViewShadowOpacity
        layer.masksToBounds = false
    }
}

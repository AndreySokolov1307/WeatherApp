//
//  LoadingDetailCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit
class LoadingDetailCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.strings.loadingDetailCellReuseIdentifier
    
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.spacing = Constants.layout.loadingDetailCellVStackSpacing
        $0.alignment = .leading
        $0.distribution = .fillEqually
    }
    
    private let loadingViewOne = LoadingDetailView()
    private let loadingViewTwo = LoadingDetailView()
    private let loadingViewThree = LoadingDetailView()
    private let loadingViewFour = LoadingDetailView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(vStack)
        vStack.addArrangedSubview(loadingViewOne)
        vStack.addArrangedSubview(loadingViewTwo)
        vStack.addArrangedSubview(loadingViewThree)
        vStack.addArrangedSubview(loadingViewFour)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

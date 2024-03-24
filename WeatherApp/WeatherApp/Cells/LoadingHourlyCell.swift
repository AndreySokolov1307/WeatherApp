//
//  LoadingHourlyCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 24.03.2024.
//

import UIKit

class LoadingHourlyCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.strings.loadingHourlyCellReuseIdentifier
    
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    @UseAutolayout private var titleView: UIView = .style {
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = Constants.layout.loadingHourlyCellTitleViewCornerRadius
        $0.layer.masksToBounds = true
    }
    
    @UseAutolayout private var cirleView: UIView = .style {
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = Constants.layout.loadingHourlyCellCircleViewCornerRadius
    }
    
    @UseAutolayout private var subtitleView: UILabel = .style {
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = Constants.layout.loadingHourlyCellSubtitleViewCornerRadius
        $0.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureCell() {
        addSubview(vStack)
        vStack.addArrangedSubview(titleView)
        vStack.addArrangedSubview(cirleView)
        vStack.addArrangedSubview(subtitleView)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cirleView.heightAnchor.constraint(equalToConstant: Constants.layout.loadingHourlyCellCircleViewSide),
            cirleView.widthAnchor.constraint(equalToConstant: Constants.layout.loadingHourlyCellCircleViewSide),
            
            titleView.widthAnchor.constraint(equalToConstant: Constants.layout.loadingHourlyCellTitleViewWidth),
            titleView.heightAnchor.constraint(equalToConstant: Constants.layout.loadingHourlyCellTitleViewHeight),
            
            subtitleView.widthAnchor.constraint(equalToConstant: Constants.layout.loadingHourlyCellSubtitleViewWidth),
            subtitleView.heightAnchor.constraint(equalToConstant: Constants.layout.loadingHourlyCellSubtitleViewHeight),
        ])
    }
}

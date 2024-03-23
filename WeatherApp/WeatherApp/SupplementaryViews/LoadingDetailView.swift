//
//  LoadingDetailView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit

class LoadingDetailView: UIView {
    
    @UseAutolayout private var titleView: UIView = .style {
        $0.layer.cornerRadius = Constants.layout.loadingDetailViewTitleCornerRadius
        $0.backgroundColor = .systemGray5
        $0.layer.masksToBounds = true
    }
    
    @UseAutolayout private var subtitleView: UIView = .style {
        $0.layer.cornerRadius = Constants.layout.loadingDetailViewSubtitleCornerRaduis
        $0.backgroundColor = .systemGray5
        $0.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(titleView)
        addSubview(subtitleView)
        
        NSLayoutConstraint.activate([
            titleView.heightAnchor.constraint(equalToConstant: Constants.layout.loadingDetailViewTitleHeight),
            titleView.widthAnchor.constraint(equalToConstant: Constants.layout.loadingDetailViewTitleWidth),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.layout.loadingDetailViewTitleCenterY),
            
            subtitleView.heightAnchor.constraint(equalToConstant: Constants.layout.loadingDetailViewSubtitleHeight),
            subtitleView.widthAnchor.constraint(equalToConstant: Constants.layout.loadingDetailViewSubtitleWidth),
            subtitleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.layout.loadingDetailViewSubtitleCenterY),
        ])
    }
}

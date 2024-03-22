//
//  LoadingDetailView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit

class LoadingDetailView: UIView {
    
    @UseAutolayout private var titleView: UIView = .style {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .systemGray5
        $0.layer.masksToBounds = true
    }
    
    @UseAutolayout private var subtitleView: UIView = .style {
        $0.layer.cornerRadius = 6
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
            titleView.heightAnchor.constraint(equalToConstant: 16),
            titleView.widthAnchor.constraint(equalToConstant: 144),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -16),
            
            subtitleView.heightAnchor.constraint(equalToConstant: 12),
            subtitleView.widthAnchor.constraint(equalToConstant: 80),
            subtitleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12),
        ])
    }
}

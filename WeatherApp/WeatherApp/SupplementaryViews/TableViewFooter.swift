//
//  TableViewFooter.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

class TableViewFooter: UIView {
    
    @UseAutolayout var doneButton: UIButton = .style {
        $0.setTitle("Выбрать", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 24),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            doneButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -12),
        ])
    }
}

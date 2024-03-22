//
//  UserLocationCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

class UserLocationCell: UITableViewCell {
    static let reuseIdentifier = "UserLocationCell"
    
    @UseAutolayout private var detailInfoView: DetailInfoView = .style {
        $0.imageView.image = UIImage(systemName: "location")
        $0.imageView.tintColor = .systemBlue
        $0.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.titleLabel.textColor = .black
        $0.titleLabel.text = "Моя локация"
        $0.infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.infoLabel.textColor = .systemGray
        $0.infoLabel.text = "Получи точный прогноз по локации"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateSelectedBackgroundView() {
        selectedBackgroundView?.backgroundColor = .systemGray5
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.selectedBackgroundView?.backgroundColor = .white
        }
    }
    
    private func configureCell() {
        addSubview(detailInfoView)
        let selectedView = UIView()
        selectedBackgroundView = selectedView
        
        NSLayoutConstraint.activate([
            detailInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            detailInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            detailInfoView.topAnchor.constraint(equalTo: topAnchor),
            detailInfoView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}


//
//  LocationSearchCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

class LocationSearchCell: UITableViewCell {
    static let reuseIdentifier = "LocationSearchCell"
    
    @UseAutolayout var seletionImageView: UIImageView = .style {
        $0.tintColor = .systemBlue
    }
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.spacing = 2
        $0.alignment = .leading
        $0.distribution = .fillProportionally
    }
    
    let titleLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.numberOfLines = 1
    }
    
    let infoLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .systemGray
        $0.numberOfLines = 1
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toSelectedState() {
        seletionImageView.image = UIImage(systemName: "checkmark.circle.fill")
    }
    
    func toNormalState() {
        seletionImageView.image = nil
    }
    
    func animateSelectedBackgroundView() {
        selectedBackgroundView?.backgroundColor = .systemGray5
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.selectedBackgroundView?.backgroundColor = .white
        }
    }
    
    private func configureCell() {
        addSubview(vStack)
        addSubview(seletionImageView)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(infoLabel)
        let selectedView = UIView()
        selectedBackgroundView = selectedView
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStack.trailingAnchor.constraint(equalTo: seletionImageView.leadingAnchor, constant: -8),
            
            seletionImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            seletionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            seletionImageView.heightAnchor.constraint(equalToConstant: 24),
            seletionImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}

//
//  UserLocationCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

final class UserLocationCell: UITableViewCell {
    static let reuseIdentifier = Constants.strings.userLocationCellReuseIdentifier
    
    @UseAutolayout private var detailInfoView: DetailInfoView = .style {
        $0.imageView.image = Constants.images.location
        $0.imageView.tintColor = Constants.colors.lightBlue
        $0.titleLabel.font = Constants.fonts.userLocationCellTitleLabel
        $0.titleLabel.textColor = .black
        $0.titleLabel.text = Constants.strings.userLocationCellTitle
        $0.infoLabel.font = Constants.fonts.userLocationCellInfoLabel
        $0.infoLabel.textColor = .systemGray
        $0.infoLabel.text = Constants.strings.userLocationCellInfo
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateSelectedBackgroundView() {
        selectedBackgroundView?.backgroundColor = Constants.colors.lightGray
        UIView.animate(withDuration: Constants.numbers.userLocationCellAnimationDuration, delay: Constants.numbers.userLocationCellAnimationDelay, options: .curveEaseIn) {
            self.selectedBackgroundView?.backgroundColor = .white
        }
    }
    
    private func configureCell() {
        addSubview(detailInfoView)
        let selectedView = UIView()
        selectedBackgroundView = selectedView
        
        NSLayoutConstraint.activate([
            detailInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.layout.userLocationCellDetailInfoviewLeading),
            detailInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.layout.userLocationCellDetailInfoviewTrailing),
            detailInfoView.topAnchor.constraint(equalTo: topAnchor),
            detailInfoView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}


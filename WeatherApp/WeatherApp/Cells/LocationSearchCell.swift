//
//  LocationSearchCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

class LocationSearchCell: UITableViewCell {
    static let reuseIdentifier = Constants.strings.locationSearchCellReuseIdentifier
    
    @UseAutolayout var selectionImageView: UIImageView = .style {
        $0.tintColor = Constants.colors.lightBlue2
    }
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.spacing = Constants.layout.locationSearchCellVStackSpacing
        $0.alignment = .leading
        $0.distribution = .fillProportionally
    }
    
    let titleLabel: UILabel = .style {
        $0.font = Constants.fonts.locationCellTitleLabel
        $0.numberOfLines = Constants.numbers.locationCellTitleLabelNumberOfLines
    }
    
    let infoLabel: UILabel = .style {
        $0.font = Constants.fonts.locationCellInfoLabel
        $0.textColor = .systemGray
        $0.numberOfLines = Constants.numbers.locationCellInfoLabelNumberOfLines
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toSelectedState() {
        let image = Constants.images.selected?.withConfiguration(ImageConfig.size)
        selectionImageView.image = image
    }
    
    func toNormalState() {
        selectionImageView.image = nil
    }
    
    func animateSelectedBackgroundView() {
        selectedBackgroundView?.backgroundColor = .systemGray5
        UIView.animate(withDuration: Constants.numbers.locationSearchCellAnimationDuration, delay: Constants.numbers.locationSearchCellAnimationDelay, options: .curveEaseIn) {
            self.selectedBackgroundView?.backgroundColor = .white
        }
    }
    
    private func configureCell() {
        addSubview(vStack)
        addSubview(selectionImageView)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(infoLabel)
        let selectedView = UIView()
        selectedBackgroundView = selectedView
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.layout.locationSearchCellVStackLeading),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStack.trailingAnchor.constraint(equalTo: selectionImageView.leadingAnchor, constant: Constants.layout.locationSearchCellVStackTrailing),
            
            selectionImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.layout.locationSearchCellSelectionImageViewTrailing),
            selectionImageView.heightAnchor.constraint(equalToConstant: Constants.layout.locationSearchCellSelectionImageViewSide),
            selectionImageView.widthAnchor.constraint(equalToConstant: Constants.layout.locationSearchCellSelectionImageViewSide),
        ])
    }
}

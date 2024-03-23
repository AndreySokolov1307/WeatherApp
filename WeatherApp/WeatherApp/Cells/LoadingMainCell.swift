//
//  LoadingMainCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit

class LoadingMainCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.strings.loadingMainCellReuseIdentifier
    
    @UseAutolayout private var vStack: UIStackView  = .style {
        $0.axis = .vertical
        $0.spacing = Constants.layout.loadingMainCellVStackSpacing
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    @UseAutolayout private var imageView: UIImageView = .style {
        $0.tintColor = .systemGray
    }
    
    private let titleLabel: UILabel = .style {
        $0.text = Constants.strings.loadingMainCellTitle
        $0.textColor = .systemGray
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
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(titleLabel)
        let image = Constants.images.sunMax?.withConfiguration(ImageConfig.sizeMax)
        imageView.image = image
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Constants.layout.loadingMainCellImageViewSide),
            imageView.widthAnchor.constraint(equalToConstant: Constants.layout.loadingMainCellImageViewSide),
            
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

//
//  LoadingMainCell.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit

class LoadingMainCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.strings.loadingMainCellReuseIdentifier
        
    @UseAutolayout private var imageView: UIImageView = .style {
        $0.tintColor = .systemGray5
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(imageView)
        let image = Constants.images.sunMax?.withConfiguration(ImageConfig.sizeMax)
        imageView.image = image
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Constants.layout.loadingMainCellImageViewSide),
            imageView.widthAnchor.constraint(equalToConstant: Constants.layout.loadingMainCellImageViewSide),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

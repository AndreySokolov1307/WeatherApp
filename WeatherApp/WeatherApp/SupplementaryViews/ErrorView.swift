//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 23.03.2024.
//
import UIKit

class ErrorView: UIView {
    
    @UseAutolayout var imageView: UIImageView = .style {
        $0.image = Constants.images.exclamationmarkTriangle
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Constants.colors.lightBlue2
    }
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = Constants.layout.errorViewVStackSpacing
    }
    
    let titleLabel: UILabel = .style {
        $0.text = Constants.strings.errorViewTitle
        $0.font = Constants.fonts.errorViewTitle
        $0.textColor = Constants.colors.gray
    }
    
    let subtitleLabel: UILabel = .style {
        $0.text = Constants.strings.errorViewSubtitle
        $0.font = Constants.fonts.errorViewSubTitle
        $0.textColor = Constants.colors.gray
    }
    
    let tryAgainButton: UIButton = .style {
        $0.setTitle(Constants.strings.tryAgainButtonTitle, for: .normal)
        $0.titleLabel?.font = Constants.fonts.tryAgainButton
        $0.setTitleColor(Constants.colors.lightBlue2, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
        addSubview(vStack)
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)
        vStack.addArrangedSubview(tryAgainButton)
        
        vStack.setCustomSpacing(Constants.layout.errorViewVStackCustomSpacing, after: imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.layout.errorViewImageViewSide),
            imageView.heightAnchor.constraint(equalToConstant: Constants.layout.errorViewImageViewSide),
            
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}


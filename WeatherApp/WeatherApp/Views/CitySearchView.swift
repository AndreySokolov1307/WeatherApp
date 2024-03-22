//
//  CitySearchView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 21.03.2024.
//

import UIKit

class CitySearchView: UIView {
    
    @UseAutolayout var tableView = UITableView()
    
    @UseAutolayout var doneButton: UIButton = .style {
        $0.setTitle("Выбрать", for: .normal)
        $0.backgroundColor = Constants.colors.lightBlue
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    @UseAutolayout private var lineView: UIView = .style {
        $0.backgroundColor = .separator
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
        addSubview(tableView)
        addSubview(doneButton)
        addSubview(lineView)
        tableView.backgroundView = CityNotFoundView()
        tableView.backgroundView?.isHidden = true
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: lineView.topAnchor),
            
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -12),
            
            doneButton.heightAnchor.constraint(equalToConstant: 44),
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
}

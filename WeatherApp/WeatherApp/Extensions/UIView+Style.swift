//
//  UIView+Style.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit
extension UIView {
    static func style<T: UIView>(_  style: @escaping (T) -> Void) -> T {
        let view = T()
        style(view)
        return view
    }
}


//
//  UIViewController+Alert.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 22.03.2024.
//

import UIKit

extension UIViewController {
    func presentConfirmAlert(title: String, message: String) {
        let confirmAlert = UIAlertController(title: title,
                                             message: message,
                                             preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default)
        confirmAlert.addAction(confirmAction)
        self.present(confirmAlert, animated: true)
    }
}

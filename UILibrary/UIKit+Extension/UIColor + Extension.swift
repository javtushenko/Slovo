//
//  UIColor+Extension.swift
//  Slovo
//
//  Created by Николай Явтушенко on 28.06.2022.
//

import Foundation
import UIKit

extension UIColor {

    /// фон приложения
    static let slovoDarkBackground: UIColor = .init(hex: "191725")

    /// серый
    static let slovoGray: UIColor = .init(hex: "D7D7D7")

    /// оранжевый
    static let slovoOrange: UIColor = .init(hex: "FFAA33")

    /// зеленый
    static let slovoGreen: UIColor = .init(hex: "05C46B")

    /// белый
    static let slovoWhite: UIColor = .init(hex: "FFFFFF")

    /// преобразуем код цвета в цвет
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

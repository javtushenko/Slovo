//
//  UIView + Helpers.swift
//  Slovo
//
//  Created by Николай Явтушенко on 12.08.2022.
//

import UIKit

extension UIView {

    /// Закругленные края с радиусом
    open func setCorners(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}

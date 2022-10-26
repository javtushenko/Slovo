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

/// Анимировать появление вью
public func animateShowView(
    _ view: UIView,
    duration: TimeInterval = 0.3,
    options: UIView.AnimationOptions = .transitionCrossDissolve,
    completion: (() -> Void)? = nil
) {
    // предусловие на случай, если вью скрыта в данный момент
    // решает проблему, что анимация идет только через alpha, но логика может быть на isHidden завязана
    if view.isHidden {
        view.alpha = 0
        view.isHidden = false
    }

    UIView.transition(
        with: view,
        duration: duration,
        options: options
    ) {
        view.alpha = 1
    } completion: { _ in
        completion?()
    }
}

/// Анимировать скрытие вью
public func animateHideView(
    _ view: UIView,
    duration: TimeInterval = 0.3,
    options: UIView.AnimationOptions = .transitionCrossDissolve,
    completion: (() -> Void)? = nil
) {
    UIView.transition(
        with: view,
        duration: duration,
        options: options
    ) {
        view.alpha = 0
    } completion: { _ in
        view.isHidden = true
        completion?()
    }
}

//
//  StopPopupRouter.swift
//  Slovo
//
//  Created Николай Явтушенко on 13.08.2022.
//

import UIKit

final class StopPopupRouter: StopPopupRouterProtocol {
    weak var baseViewController: UIViewController?
    weak var popup: PopupViewController?

    init(baseViewController: UIViewController) {
        self.baseViewController = baseViewController
    }
}

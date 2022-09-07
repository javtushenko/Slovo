//
//  TutorialRouter.swift
//  Slovo
//
//  Created Николай Явтушенко on 06.09.2022.
//

import UIKit

final class TutorialRouter: TutorialRouterProtocol {
    weak var baseViewController: UIViewController?
    weak var popup: PopupViewController?
    
    init(baseViewController: UIViewController) {
        self.baseViewController = baseViewController
    }
}

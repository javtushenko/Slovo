//
//  MainGameRouter.swift
//  Slovo
//
//  Created Николай Явтушенко on 22.06.2022.
// 

import UIKit

final class MainGameRouter: MainGameRouterProtocol {
    weak var baseViewController: UIViewController?

    init(baseViewController: UIViewController) {
        self.baseViewController = baseViewController
    }

    /// Открыть попап остановки игры
    func openStopPopup(typePopup: StopType,
                       word: String = "",
                       addValletCount: String = "",
                       delegate: StopPopupViewDelegate) {
        // Достаем опционал
        guard let baseViewController = baseViewController else {
            return
        }
        let popup = StopPopupModuleConfigurator.build(typePopup: typePopup,
                                                      word: word,
                                                      addValltCount: addValletCount,
                                                      delegate: delegate)
        baseViewController.present(
            popup,
            animated: false,
            completion: nil
        )
    }
}

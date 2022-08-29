//
//  MainGameModuleConfigurator.swift
//  Slovo
//
//  Created Николай Явтушенко on 22.06.2022.
//

import UIKit

final class MainGameModuleConfigurator {
    /// Собрать модуль
    class func build() -> UIViewController {
        let view = MainGameViewController()
        let presenter = MainGamePresenter(
            view: view
        )
        let interactor = MainGameInteractor(
            presenter: presenter,
            wordsLoadService: DIContainer.shared.wordsLoadService,
            keyboardManager: DIContainer.shared.keyboardManager,
            valletStorage: DIContainer.shared.valletStorage,
            gameBoardStorage: DIContainer.shared.gameBoardStorage
        )
        let router = MainGameRouter(
            baseViewController: view
        )

        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router

        return view
    }
}

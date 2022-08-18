//
//  StopPopupModuleConfigurator.swift
//  Slovo
//
//  Created Николай Явтушенко on 13.08.2022.
//

import UIKit

final class StopPopupModuleConfigurator {
    /// Собрать модуль
    class func build(typePopup: StopType, word: String) -> UIViewController {
        let view = StopPopupViewController()
        let presenter = StopPopupPresenter(
            view: view,
            typePopup: typePopup,
            word: word
        )
        let interactor = StopPopupInteractor(
            presenter: presenter
        )
        let router = StopPopupRouter(
            baseViewController: view
        )

        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router

        let popup = createPopup()
        popup.setupController(viewController: view)
        view.popup = popup
        router.popup = popup
        return popup
    }

    // Создание попапа для контроллера
    private class func createPopup() -> PopupViewController {
        let popup = PopupViewController()
        popup.modalPresentationStyle = .overFullScreen
        popup.colorForBorderView = UIColor.white
        popup.backGroundAlphaContent = 0.4
        popup.isTongueShowed = false
        popup.isNeedWhiteView = false
        popup.isNeedTopBorderShowed = true
        popup.topOffsetMax = Display.isFormfactorX ? 108 : 80
        return popup
    }
}

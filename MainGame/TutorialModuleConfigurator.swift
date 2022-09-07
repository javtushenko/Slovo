//
//  TutorialModuleConfigurator.swift
//  Slovo
//
//  Created Николай Явтушенко on 06.09.2022.
//

import UIKit

final class TutorialModuleConfigurator {
    /// Собрать модуль
    class func build() -> UIViewController {
        let view = TutorialViewController()
        let presenter = TutorialPresenter(
            view: view
        )
        let interactor = TutorialInteractor(
            presenter: presenter
        )
        let router = TutorialRouter(
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
        popup.colorForBorderView = .red
        popup.bottomView.backgroundColor = .slovoDarkBackground
        popup.topBorderView.backgroundColor = .slovoDarkBackground
        popup.backGroundAlphaContent = 0.4
        popup.isTongueShowed = true
        popup.isNeedWhiteView = false
        popup.isNeedTopBorderShowed = true
        popup.topOffsetMax = Display.isFormfactorX ? 108 : 80
        return popup
    }
}

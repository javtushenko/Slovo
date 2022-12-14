//
//  StopPopupProtocols.swift
//  Slovo
//
//  Created Николай Явтушенко on 13.08.2022.
//

import UIKit

public enum StopType {
    case stopWin
    case stopDefeat
    case stopWrong
}

// MARK: View Delegate -
protocol StopPopupViewDelegate: AnyObject {
    /// Popup закрылся
    func popupHidden(_ popupController: PopupViewController, popupType: StopType)
}

// MARK: View -
protocol StopPopupViewProtocol: AnyObject {
    /// делегат
    var delegate: StopPopupViewDelegate? { get set }
    /// установка вью
    func setup(viewModel: StopPopupViewModel)
}

// MARK: Presenter -
protocol StopPopupViewToPresenterProtocol: AnyObject {
    /// Вью загружено
    func onViewDidLoad()
}

protocol StopPopupInteractorToPresenterProtocol: AnyObject {
}

// MARK: Interactor -
protocol StopPopupInteractorProtocol: AnyObject {
    /// текущее количество бонусов
    var valletCount: Int { get }
    /// запуск
    func start()
}

// MARK: Router -
protocol StopPopupRouterProtocol: AnyObject {

}

//
//  StopPopupProtocols.swift
//  Slovo
//
//  Created Николай Явтушенко on 13.08.2022.
//

import UIKit

public enum StopType {
    case win
    case defeat
    case wrong
}

// MARK: View -
protocol StopPopupViewProtocol: AnyObject {
    // установка вью
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
    /// запуск
    func start()
}

// MARK: Router -
protocol StopPopupRouterProtocol: AnyObject {

}

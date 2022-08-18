//
//  StopPopupInteractor.swift
//  Slovo
//
//  Created Николай Явтушенко on 13.08.2022.
//

import Foundation

final class StopPopupInteractor {
    weak var presenter: StopPopupInteractorToPresenterProtocol?

    init(presenter: StopPopupInteractorToPresenterProtocol) {
        self.presenter = presenter
    }
}

extension StopPopupInteractor: StopPopupInteractorProtocol {
    /// Запуск
    func start() {
    }
}

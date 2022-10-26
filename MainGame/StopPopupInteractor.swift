//
//  StopPopupInteractor.swift
//  Slovo
//
//  Created Николай Явтушенко on 13.08.2022.
//

import Foundation

final class StopPopupInteractor {
    weak var presenter: StopPopupInteractorToPresenterProtocol?

    // сторож кошелька бонусов
    var valetStorage: ValletStorageProtocol

    /// текущее количество бонусов
    var valletCount: Int {
        valetStorage.currentCount
    }

    init(presenter: StopPopupInteractorToPresenterProtocol,
         valetStorage: ValletStorageProtocol) {
        self.presenter = presenter
        self.valetStorage = valetStorage
    }
}

extension StopPopupInteractor: StopPopupInteractorProtocol {
    /// Запуск
    func start() {
    }
}

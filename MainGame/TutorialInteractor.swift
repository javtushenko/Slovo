//
//  TutorialInteractor.swift
//  Slovo
//
//  Created Николай Явтушенко on 06.09.2022.
//

import Foundation

final class TutorialInteractor {
    weak var presenter: TutorialInteractorToPresenterProtocol?
    
    init(presenter: TutorialInteractorToPresenterProtocol) {
        self.presenter = presenter
    }
}

extension TutorialInteractor: TutorialInteractorProtocol {
    /// Запуск
    func start() {
    }
}

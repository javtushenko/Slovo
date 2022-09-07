//
//  TutorialPresenter.swift
//  Slovo
//
//  Created Николай Явтушенко on 06.09.2022.
//

import UIKit

final class TutorialPresenter {
    weak var view: TutorialViewProtocol?
    var interactor: TutorialInteractorProtocol?
    var router: TutorialRouterProtocol?

    init(view: TutorialViewProtocol) {
        self.view = view
    }
}

extension TutorialPresenter: TutorialViewToPresenterProtocol {
    /// Вью загружено
    func onViewDidLoad() {
        interactor?.start()
    }
}

extension TutorialPresenter: TutorialInteractorToPresenterProtocol {
}

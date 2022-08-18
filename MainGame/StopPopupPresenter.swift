//
//  StopPopupPresenter.swift
//  Slovo
//
//  Created Николай Явтушенко on 13.08.2022.
//

import UIKit

final class StopPopupPresenter {
    weak var view: StopPopupViewProtocol?
    var interactor: StopPopupInteractorProtocol?
    var router: StopPopupRouterProtocol?

    var word: String

    var typePopup: StopType

    init(view: StopPopupViewProtocol,
         typePopup: StopType,
         word: String) {
        self.view = view
        self.typePopup = typePopup
        self.word = word
    }

    // создать модель попапа успеха
    func getViewModel(type: StopType) -> StopPopupViewModel {
        switch type {
        case .win:
            return StopPopupViewModel(
                title: "ПОБЕДА! 🥳",
                subtitle: "+N БАЛЛОВ",
                description: "Тебе удалось угадать загаданное слово \nза N попыток",
                popupHeight: 215,
                popupType: .win
            )
        case .defeat:
            return StopPopupViewModel(
                title: "УВЫ, КОНЕЦ.. 🥺",
                subtitle: "ПОВТОРИМ?",
                description: "Смахни сообщение вниз\nи мы загадаем новое слово,\nа ты попробуешь угадать",
                popupHeight: 215,
                popupType: .defeat
            )
        case .wrong:
            return StopPopupViewModel(
                title: "МЫ НЕ ЗНАЕМ",
                subtitle: word.uppercased(),
                description: "Но если ты уверен, и тебе не безразлична судьба нашей игры, ты можешь внести свой вклад и отправить это слово нам на почтовый ящик: email@yandex.ru",
                popupHeight: 215,
                popupType: .wrong
            )
        }
    }
}

extension StopPopupPresenter: StopPopupViewToPresenterProtocol {
    /// Вью загружено
    func onViewDidLoad() {
        interactor?.start()
        view?.setup(viewModel: getViewModel(type: typePopup))
    }
}

extension StopPopupPresenter: StopPopupInteractorToPresenterProtocol {
}

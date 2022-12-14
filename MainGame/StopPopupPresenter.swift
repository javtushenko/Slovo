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
    var addValletCount: String

    var typePopup: StopType

    init(view: StopPopupViewProtocol,
         typePopup: StopType,
         word: String = "",
         addValletCount: String = "") {
        self.view = view
        self.typePopup = typePopup
        self.word = word
        self.addValletCount = addValletCount
    }

    // создать модель попапа успеха
    func getViewModel(type: StopType) -> StopPopupViewModel {
        switch type {
        case .stopWin:
            return StopPopupViewModel(
                title: "ПОБЕДА! 🥳",
                subtitle: "ПОЛУЧЕНО 💎\(addValletCount)",
                titleButton: "НОВАЯ ИГРА",
                popupHeight: 215,
                popupType: .stopWin
            )
        case .stopDefeat:
            return StopPopupViewModel(
                title: "УВЫ, КОНЕЦ.. 🥺",
                subtitle: "ПОВТОРИМ?",
                titleButton: "НОВАЯ ИГРА",
                popupHeight: 215,
                popupType: .stopDefeat
            )
        case .stopWrong:
            return StopPopupViewModel(
                title: "МЫ НЕ ЗНАЕМ",
                subtitle: word.uppercased(),
                titleButton: "ПОДЕЛИТЬСЯ",
                popupHeight: 215,
                popupType: .stopWrong
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

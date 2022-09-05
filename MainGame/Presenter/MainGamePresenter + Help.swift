//
//  MainGamePresenter + Bonus.swift
//  Slovo
//
//  Created by Николай Явтушенко on 22.08.2022.
//

import Foundation

extension MainGamePresenter {
    /// Нажат бонус ЛУПА
    func onTapBonusSearch() {
        view?.showInfoView(viewModel: createBonusModelSearch())
    }
    
    /// Использован бонус ЛУПА
    func onUseHelpSearch() {
        interactor?.showOneOrangeLetter()
        interactor?.minusBonusAtVallet(count: Price.priseSearch)
        view?.updateKeyboard()
    }
    
    /// Нажат бонус БОМБА
    func onTapBonusBomb() {
        view?.showInfoView(viewModel: createBonusModelBomb())
    }
    
    /// Использован бонус БОМБА
    func onUseHelpBomb() {
        interactor?.showThreeDarkGrayLetters()
        interactor?.minusBonusAtVallet(count: Price.priseBoom)
        view?.updateKeyboard()
    }
    
    /// Нажат бонус КНИГА
    func onTapBonusBook() {
        view?.showInfoView(viewModel: createBonusModelBook())
    }
    
    // создать модель бонуса ЛУПЫ
    func createBonusModelSearch() -> InfoContentViewModel {
        InfoContentViewModel(title: "🔎",
                             description: "Подсветить оранжевым\nОДНУ букву на клавиатуре",
                             titleButton: "💎25",
                             isButtonEnable: interactor?.isCanUseHelpSearch() ?? false,
                             mainIdentifier: helpType.search.rawValue,
                             accessibilityInfo: "")
    }
    
    // создать модель бонуса БОМБЫ
    func createBonusModelBomb() -> InfoContentViewModel {
        InfoContentViewModel(title: "💣",
                             description: "Убрать на клавиатуре ТРИ буквы которых точно нет в слове",
                             titleButton: "💎25",
                             isButtonEnable: interactor?.isCanUseHelpBomb() ?? false,
                             mainIdentifier: helpType.bomb.rawValue,
                             accessibilityInfo: "")
    }
    
    // создать модель бонуса КНИГИ
    func createBonusModelBook() -> InfoContentViewModel {
        InfoContentViewModel(title: "📖",
                             description: "Показать значение загаданного слова из словаря",
                             titleButton: "💎90",
                             isButtonEnable: false,
                             mainIdentifier: helpType.book.rawValue,
                             accessibilityInfo: "")
    }
}

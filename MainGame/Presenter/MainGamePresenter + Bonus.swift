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
    
    /// Нажат бонус БОМБА
    func onTapBonusBomb() {
        view?.showInfoView(viewModel: createBonusModelBomb())
    }
    
    /// Нажат бонус КНИГА
    func onTapBonusBook() {
        view?.showInfoView(viewModel: createBonusModelBook())
    }
    
    // создать модель бонуса ЛУПЫ
    func createBonusModelSearch() -> InfoContentViewModel {
        InfoContentViewModel(title: "🔎",
                             description: "Если применить этот бонус, мы выделим оранжевым букву на клавитатуре, которая точно присутствует в загаданом слове",
                             titleButton: "100💎",
                             accessibilityInfo: "")
    }
    
    // создать модель бонуса БОМБЫ
    func createBonusModelBomb() -> InfoContentViewModel {
        InfoContentViewModel(title: "💣",
                             description: "Если применить этот бонус, мы выделим оранжевым букву на клавитатуре, которая точно присутствует в загаданом слове",
                             titleButton: "100💎",
                             accessibilityInfo: "")
    }
    
    // создать модель бонуса КНИГИ
    func createBonusModelBook() -> InfoContentViewModel {
        InfoContentViewModel(title: "📖",
                             description: "Если применить этот бонус, мы выделим оранжевым букву на клавитатуре, которая точно присутствует в загаданом слове",
                             titleButton: "100💎",
                             accessibilityInfo: "")
    }
}

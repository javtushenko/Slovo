//
//  MainGameProtocols.swift
//  Slovo
//
//  Created Николай Явтушенко on 22.06.2022.
//

import UIKit

// MARK: View -
protocol MainGameViewProtocol: AnyObject {
    /// Коллекция с кастомной клавиатурой
    var keyboardVC: KeyboardView { get }
    /// Коллекция с ячейками для ввода
    var boardVC: BoardView { get }
    /// показать вью с информацией о бонусе
    func showInfoView(viewModel: InfoContentViewModel) 
    /// обновить данные на игровом поле
    func updateGuesses()
    /// обновить данные клавиатуры
    func updateKeyboard()
}

// MARK: Presenter -
protocol MainGameViewToPresenterProtocol: AnyObject {
    /// Вью загружено
    func onViewDidLoad()
    /// Нажат бонус ЛУПА
    func onTapBonusSearch()
    /// Нажат бонус БОМБА
    func onTapBonusBomb()
    /// Нажат бонус КНИГА
    func onTapBonusBook()
}

protocol MainGameInteractorToPresenterProtocol: AnyObject {}

// MARK: Interactor -
protocol MainGameInteractorProtocol: AnyObject {
    /// Тукущее загаданное слово
    var currentWord: String { get }
    /// Все слова спарсеные из документа
    var words: [String]? { get set }
    /// запуск
    func start()
    /// получить рандомное слово для загадки
    func getRandomWords() -> [String]
    /// Получить цвет для ячейки клавиатуры
    func getKeyColor(key: Character, gameLetters: [[Key?]]) -> UIColor
}

// MARK: Router -
protocol MainGameRouterProtocol: AnyObject {
    /// Открыть попап остановки игры
    func openStopPopup(typePopup: StopType, word: String, delegate: StopPopupViewDelegate)
}

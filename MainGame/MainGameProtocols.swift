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
    /// запустить прелоудер
    func startPreloader()
    /// остановить прелоудер
    func stopPreloader()
    /// обновить данные на игровом поле
    func updateGuesses()
    /// обновить данные клавиатуры
    func updateKeyboard()
}

// MARK: Presenter -
protocol MainGameViewToPresenterProtocol: AnyObject {
    /// Вью загружено
    func onViewDidLoad()
}

protocol MainGameInteractorToPresenterProtocol: AnyObject {
    /// Когда началась загрузка слов из файла в массив
    func onLoadWordData()
    /// Когда закончилась загрузка слов из файла в массив
    func onDidLoadWordsData()
}

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
    func openStopPopup(typePopup: StopType, word: String)
}

//
//  MainGameInteractor.swift
//  Slovo
//
//  Created Николай Явтушенко on 22.06.2022.
//

import Foundation
import UIKit

final class MainGameInteractor {
    weak var presenter: MainGameInteractorToPresenterProtocol?

    // сервис загрузки допустимых слов
    var wordsLoadService: WordsLoadServiceProtocol
    // менеджер кастомной клавиатуры
    var keyboardManager: KeyboardManagerProtocol

    /// Все слова спарсеные из документа
    var words: [String]?

    /// Текущее загаданное слово
    var currentWord: String {
        getRandomWord()
    }

    init(presenter: MainGameInteractorToPresenterProtocol,
         wordsLoadService: WordsLoadServiceProtocol,
         keyboardManager: KeyboardManagerProtocol) {
        self.presenter = presenter
        self.wordsLoadService = wordsLoadService
        self.keyboardManager = keyboardManager
    }
}

extension MainGameInteractor: MainGameInteractorProtocol {

    /// Запуск
    func start() {
        getWordsData()
    }

    /// Спарсить содержимое документа в массив
    func getWordsData() {
        presenter?.onLoadWordData()
        words = wordsLoadService.loadWords()
    }

    /// Закончился парсинг документа в массив
    /// Спарсить содержимое документа в массив
    func onDidLoadWordsData() {
        presenter?.onDidLoadWordsData()
    }

    /// получить рандомное слово для загадки
    func getRandomWord() -> String {
        let words = wordsLoadService.loadSecretWords()
        guard let word = words.randomElement() else {
            return "слово"
        }
        print("✅ Загадано слово - \(word)")
        return word
    }

    /// получить рандомное слово для загадки
    func getRandomWords() -> [String] {
        wordsLoadService.loadWords()
    }

    /// Получить цвет для ячейки клавиатуры
    func getKeyColor(key: Character, gameLetters: [[Key?]]) -> UIColor {
        keyboardManager.getKeyColor(key: key, gameLetters: gameLetters)
    }
}

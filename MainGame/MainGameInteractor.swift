//
//  MainGameInteractor.swift
//  Slovo
//
//  Created Николай Явтушенко on 22.06.2022.
//

import Foundation
import SwiftyUserDefaults
import UIKit

final class MainGameInteractor {
    weak var presenter: MainGameInteractorToPresenterProtocol?

    // сервис загрузки допустимых слов
    var wordsLoadService: WordsLoadServiceProtocol
    // менеджер кастомной клавиатуры
    var keyboardManager: KeyboardManagerProtocol
    // сторож кошелька бонусов
    var valletStorage: ValletStorageProtocol
    // менеджер игровой доски
    var gameBoardStorage: GameBoardStorage {
        GameBoardStorage.init()
    }
    
    /// текущее количество бонусов
    var valletCount: Int {
        valletStorage.currentCount
    }

    /// Все слова спарсеные из документа
    var words: [String]?

    /// Текущее загаданное слово
    var currentWord: String {
        getRandomWord()
    }

    init(presenter: MainGameInteractorToPresenterProtocol,
         wordsLoadService: WordsLoadServiceProtocol,
         keyboardManager: KeyboardManagerProtocol,
         valletStorage: ValletStorageProtocol
    ) {
        self.presenter = presenter
        self.wordsLoadService = wordsLoadService
        self.keyboardManager = keyboardManager
        self.valletStorage = valletStorage
    }
}

extension MainGameInteractor: MainGameInteractorProtocol {
    /// Запуск
    func start() {
        getWordsData()
    }

    /// Спарсить содержимое документа в массив
    func getWordsData() {
        words = wordsLoadService.loadWords()
    }

    /// Закончился парсинг документа в массив
    /// Спарсить содержимое документа в массив
    func onDidLoadWordsData() {
    }

    /// получить рандомное слово для загадки
    func getRandomWord() -> String {
        // если слово есть в хранилище, тогда вернем его
        if let word = Defaults[key: DefaultsKeys.currentWord] {
            if !word.isEmpty {
                print("✅ Загадано слово из хранилища - \(word)")
                return word
            }
        }
        
        // если нет в хранилище, создадим новое
        let words = wordsLoadService.loadSecretWords()
        guard let word = words.randomElement() else {
            print("❌MainGameInteractor: не взяли рандомное слово, используется запасное")
            Defaults[key: DefaultsKeys.currentWord] = "слово"
            return "слово"
        }
        print("✅ Загадано слово рандомное - \(word)")
        Defaults[key: DefaultsKeys.currentWord] = word
        return word
    }

    /// получить рандомное слово для загадки
    func getRandomWords() -> [String] {
        wordsLoadService.loadWords()
    }

    /// Получить цвет для ячейки клавиатуры
    func getKeyColor(key: Character, gameLetters: [[Key?]]) -> UIColor {
        keyboardManager.getKeyColor(key: key, gameLetters: gameLetters, successRow: gameBoardStorage.getCurrentSuccessRow())
    }
    
    /// Добавить бонусы после победы с попытки
    func addWinBonus(row: Int) {
        let result = 100 - (row * 10)
        valletStorage.addCountVallet(count: result)
    }
}

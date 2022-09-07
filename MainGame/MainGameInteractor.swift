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
    var gameBoardStorage: GameBoardStorageProtocol
    // менеджер серии побед
    var winStreakStorage: WinStreakStorageProtocol
    
    /// текущее количество бонусов
    var valletCount: Int {
        valletStorage.currentCount
    }
    /// текущее количество серии побед
    var winStreakCount: Int {
        winStreakStorage.currentCount
    }
    
    /// текущие буквы на игровой доске
    var gammingLetters: [[Key?]] {
        gameBoardStorage.getLetters()
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
         valletStorage: ValletStorageProtocol,
         gameBoardStorage: GameBoardStorageProtocol,
         winStreakStorage: WinStreakStorageProtocol
    ) {
        self.presenter = presenter
        self.wordsLoadService = wordsLoadService
        self.keyboardManager = keyboardManager
        self.valletStorage = valletStorage
        self.gameBoardStorage = gameBoardStorage
        self.winStreakStorage = winStreakStorage
    }
}

extension MainGameInteractor: MainGameInteractorProtocol {
    /// Запуск
    func start() {
        getWordsData()
        gameBoardStorage.start()
    }
    
    /// Начать новую игру
    func reset() {
        Defaults[key: DefaultsKeys.currentWord] = nil
        Defaults[key: DefaultsKeys.currentWordValue] = nil
        Defaults[key: DefaultsKeys.didUseHelpBook] = false
        gameBoardStorage.clearGame()
        keyboardManager.resetSearchHelpArray()
        keyboardManager.resetBombHelpArray()
    }

    /// Спарсить содержимое документа в массив
    func getWordsData() {
        words = wordsLoadService.loadWords()
    }
    
    /// Была ли победа на данной строке
    func isSuccessWithRow(gamingRow: Int) -> Bool {
        gameBoardStorage.isSuccessWithRow(gamingRow: gamingRow)
    }
    
    /// сохранить букву на доску
    func saveLetter(gamingRow: Int, positionLetter: Int, character: Character) {
        gameBoardStorage.saveLetter(gamingRow: gamingRow, positionLetter: positionLetter, character: character)
    }
    
    /// удалить букву с доски
    func removeLetter(gamingRow: Int, positionLetter: Int) {
        gameBoardStorage.removeLetter(gamingRow: gamingRow, positionLetter: positionLetter)
    }
    
    /// сохранить возможность записи на строку
    func saveIsCanGoNext(gamingRow: Int) {
        gameBoardStorage.saveIsCanGoNext(gamingRow: gamingRow)
    }
    
    /// сохранить успешный переход на строке
    func saveSuccessGoNet(gamingRow: Int) {
        gameBoardStorage.saveSuccessGoNet(gamingRow: gamingRow)
    }
    
    /// есть ли возможность записи на строку
    func isCanGoNext(gamingRow: Int) -> Bool {
        gameBoardStorage.IsCanGoNextWithRow(gamingRow: gamingRow)
    }
    
    /// был ли успешный переход на строке
    func isSuccessGoNet(gamingRow: Int) -> Bool {
        gameBoardStorage.isSuccessWithRow(gamingRow: gamingRow)
    }
    
    /// сохранить возможность удаления на строке
    func saveIsCanDelete(gamingRow: Int) {
        gameBoardStorage.saveIsCanDelete(gamingRow: gamingRow)
    }
    
    /// есть ли возможность записи на строку
    func IsCanDeleteWithRow(gamingRow: Int) -> Bool {
        gameBoardStorage.IsCanDeleteWithRow(gamingRow: gamingRow)
    }
    
    /// изменить цвет ячейки
    func changeColor(at indexPath: IndexPath, color: UIColor) {
        gameBoardStorage.chageColor(at: indexPath, color: color)
    }

    /// добавить одну победу в серию
    func addWinStreak() {
        winStreakStorage.addCountWinStreak(count: 1)
    }
    
    /// сбросить серию побед
    func resetWinStreak() {
        winStreakStorage.resetWinStreak()
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
        Defaults[key: DefaultsKeys.currentWord] = word.key
        Defaults[key: DefaultsKeys.currentWordValue] = word.value
        return word.key
    }

    /// получить рандомное слово для загадки
    func getRandomWords() -> [String] {
        wordsLoadService.loadWords()
    }

    /// Получить цвет для ячейки клавиатуры
    func getKeyColor(key: Character) -> UIColor {
        keyboardManager.getKeyColor(key: key, gameLetters: gammingLetters, successRow: gameBoardStorage.getCurrentSuccessRow())
    }
    
    /// Добавить бонусы после победы с попытки
    func addWinBonus(row: Int) {
        valletStorage.addCountVallet(count: getBonusCount(row: row))
    }
    
    /// Сколько бонусов добавлено за победу
    func getBonusCount(row: Int) -> Int {
        100 - (row * 10)
    }
    
    /// Показать одну оранжевую букву на клавиатуре
    func showOneOrangeLetter() {
        keyboardManager.getSearchLetters(currentWord: currentWord)
    }
    
    /// Можно ли использовать бонус ЛУПА
    func isCanUseHelpSearch() -> Bool {
        keyboardManager.isArraySearchFull(currentWord: currentWord) && valletCount >= Price.priseSearch
    }
    
    /// Показать три серых буквы на клавиатуре
    func showThreeDarkGrayLetters() {
        keyboardManager.getBombLetters(currentWord: currentWord)
    }
    
    /// Можно ли использовать бонус БОМБА
    func isCanUseHelpBomb() -> Bool {
        valletCount >= Price.priseBoom
    }
    
    /// Можно ли использовать бонус КНИГА
    func isCanUseHelpBook() -> Bool {
        valletCount >= Price.priseBook
    }
    
    /// Можно ли использовать бонус КНИГА
    func didCanUseHelpBook() {
        Defaults[key: DefaultsKeys.didUseHelpBook] = true
        minusBonusAtVallet(count: Price.priseBook)
    }
    
    /// Отнять бонусы из кошелька
    func minusBonusAtVallet(count: Int) {
        valletStorage.minusCountVallet(count: count)
        presenter?.onUpdateValletCount()
    }
}

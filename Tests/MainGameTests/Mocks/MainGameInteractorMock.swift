//
//  MainGameInteractorMock.swift
//  Slovo
//
//  Created by Николай Явтушенко on 29.08.2022.
//

import UIKit

class MainGameInteractorMock: MainGameInteractorProtocol { 
    /// Тукущее загаданное слово
    var currentWord: String = "слово"
    /// текущее количество бонусов
    var valletCount: Int = 0
    /// текущее количество серии побед
    var winStreakCount: Int = 0
    /// текущие буквы на игровой доске
    var gammingLetters: [[Key?]] = [[nil]]
    /// Все слова спарсеные из документа
    var words: [String]? = ["слово", "олово", "арбуз"]
    
    /* ДЛЯ ТЕСТОВ */
    var didAddMoneyToVallet: Bool = false
    
    /// запуск
    func start() {}
    /// Начать новую игру
    func reset() {}
    /// получить рандомное слово для загадки
    func getRandomWords() -> [String]  {[]}
    
    /// Получить цвет для ячейки клавиатуры
    func getKeyColor(key: Character) -> UIColor { .red }
    /// Добавить бонусы после победы с попытки
    func addWinBonus(row: Int) {
        didAddMoneyToVallet = true
    }
    /// Была ли победа на данной строке
    func isSuccessWithRow(gamingRow: Int) -> Bool  { true }
    
    /// сохранить букву на доску
    func saveLetter(gamingRow: Int, positionLetter: Int, character: Character)  {}
    /// удалить букву с доски
    func removeLetter(gamingRow: Int, positionLetter: Int)  {}
    /// сохранить возможность записи на строку
    func saveIsCanGoNext(gamingRow: Int)  {}
    /// сохранить успешный переход на строке
    func saveSuccessGoNet(gamingRow: Int)  {}
    /// есть ли возможность записи на строку
    func isCanGoNext(gamingRow: Int) -> Bool  { true }
    /// был ли успешный переход на строке
    func isSuccessGoNet(gamingRow: Int) -> Bool  { true }
    /// сохранить возможность удаления на строке
    func saveIsCanDelete(gamingRow: Int)  { }
    /// есть ли возможность записи на строку
    func IsCanDeleteWithRow(gamingRow: Int) -> Bool  { true }
    /// изменить цвет ячейки
    func changeColor(at indexPath: IndexPath, color: UIColor)  {}
    
    /// добавить одну победу в серию
    func addWinStreak() {}
    /// сбросить серию побед
    func resetWinStreak() {}
    /// Сколько бонусов добавлено за победу
    func getBonusCount(row: Int) -> Int {0}
    
    /// Показать одну оранжевую букву на клавиатуре
    func showOneOrangeLetter() {}
    /// Можно ли использовать бонус ЛУПА
    func isCanUseHelpSearch() -> Bool { true }
    
    /// Отнять бонусы из кошелька
    func minusBonusAtVallet(count: Int) {}
}

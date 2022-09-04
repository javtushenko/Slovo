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
    /// настроить вьюху с кошельком
    func setupValetView(viewModel: BonusViewModel)
    /// Настроить вью с серией побед
    func setupWinStreakView(viewModel: BonusViewModel)
    
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

protocol MainGameInteractorToPresenterProtocol: AnyObject {
    /// обработка поражения
    func onDefeat()
    /// обработка победы
    func onWin(currentRow: Int)
    /// обработка неверного слова
    func onWrongWord(word: String)
}

// MARK: Interactor -
protocol MainGameInteractorProtocol: AnyObject {
    /// Тукущее загаданное слово
    var currentWord: String { get }
    /// текущее количество бонусов
    var valletCount: Int { get }
    /// текущее количество серии побед
    var winStreakCount: Int { get }
    /// текущие буквы на игровой доске
    var gammingLetters: [[Key?]] { get }
    /// Все слова спарсеные из документа
    var words: [String]? { get set }
    
    /// запуск
    func start()
    /// Начать новую игру
    func reset()
    /// получить рандомное слово для загадки
    func getRandomWords() -> [String]
    
    /// Получить цвет для ячейки клавиатуры
    func getKeyColor(key: Character) -> UIColor
    /// Добавить бонусы после победы с попытки
    func addWinBonus(row: Int)
    /// Была ли победа на данной строке
    func isSuccessWithRow(gamingRow: Int) -> Bool
    
    /// сохранить букву на доску
    func saveLetter(gamingRow: Int, positionLetter: Int, character: Character)
    /// удалить букву с доски
    func removeLetter(gamingRow: Int, positionLetter: Int)
    /// сохранить возможность записи на строку
    func saveIsCanGoNext(gamingRow: Int)
    /// сохранить успешный переход на строке
    func saveSuccessGoNet(gamingRow: Int)
    /// есть ли возможность записи на строку
    func isCanGoNext(gamingRow: Int) -> Bool
    /// был ли успешный переход на строке
    func isSuccessGoNet(gamingRow: Int) -> Bool
    /// сохранить возможность удаления на строке
    func saveIsCanDelete(gamingRow: Int)
    /// есть ли возможность записи на строку
    func IsCanDeleteWithRow(gamingRow: Int) -> Bool
    /// изменить цвет ячейки
    func changeColor(at indexPath: IndexPath, color: UIColor)
    
    /// добавить одну победу в серию
    func addWinStreak()
    /// сбросить серию побед
    func resetWinStreak()
    /// Сколько бонусов добавлено за победу
    func getBonusCount(row: Int) -> Int
}

// MARK: Router -
protocol MainGameRouterProtocol: AnyObject {
    /// Открыть попап остановки игры
    func openStopPopup(typePopup: StopType,
                       word: String,
                       addValletCount: String,
                       delegate: StopPopupViewDelegate)
}

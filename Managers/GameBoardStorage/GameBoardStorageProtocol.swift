//
//  GameBoardStorageProtocol.swift
//  Slovo
//
//  Created by Николай Явтушенко on 29.08.2022.
//

import UIKit

protocol GameBoardStorageProtocol {
    /// получить массив букв
    func getLetters() -> [[Key?]]
    /// старт
    mutating func start()
    
    /// изменить цвет буквы
    mutating func chageColor(at indexPath: IndexPath, color: UIColor)
    /// удалить букву
    mutating func removeLetter(gamingRow: Int, positionLetter: Int)
    /// записать букву
    mutating func saveLetter(gamingRow: Int, positionLetter: Int, character: Character)
    
    /// Почистить все хранилище
    mutating func clearGame()
    
    /// записать можно ли перейти к следующей строке в хранилище
    func saveIsCanGoNext(gamingRow: Int)
    /// Получить можно ли перейти к следующей строке из хранилища
    func IsCanGoNextWithRow(gamingRow: Int) -> Bool
    
    /// записать успешный переход в хранилище
    func saveSuccessGoNet(gamingRow: Int)
    /// Получить был ли успешный переход в хранилище
    func isSuccessWithRow(gamingRow: Int) -> Bool
    /// Получить номер последней успешной строки
    func getCurrentSuccessRow() -> Int
    
    /// записать можно ли перейти к следующей строке в хранилище
    func saveIsCanDelete(gamingRow: Int)
    /// Получить можно ли перейти к следующей строке из хранилища
    func IsCanDeleteWithRow(gamingRow: Int) -> Bool
}

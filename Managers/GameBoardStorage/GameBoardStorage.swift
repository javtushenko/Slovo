//
//  LetterStorage.swift
//  Slovo
//
//  Created by Николай Явтушенко on 03.07.2022.
//

import Foundation
import SwiftyUserDefaults
import UIKit

struct GameBoardStorage: GameBoardStorageProtocol {
    static let shared: GameBoardStorageProtocol = GameBoardStorage()
    private init() {}

    // двумерный массив с введенными строками
    var letters: [[GameKey?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 7
    )

    // старт
    public mutating func start() {
        if getLetters()[0][0]?.character == nil {
            fillLettersArray()
        }
    }

    /// получить массив букв
    public func getLetters() -> [[GameKey?]] {
       letters
    }

    /// изменить цвет буквы
    public mutating func chageColor(at indexPath: IndexPath, color: UIColor) {
        let character = letters[indexPath.section][indexPath.row]?.character
        let key: GameKey = .init(character: character ?? " ", backgroundColor: color)
        letters[indexPath.section].remove(at: indexPath.row)
        letters[indexPath.section].insert(key, at: indexPath.row)
    }

    /// удалить букву
    public mutating func removeLetter(gamingRow: Int, positionLetter: Int) {
        guard positionLetter != -1 else {
            return
        }
        let key: GameKey = .init(character: " ", backgroundColor: .slovoGray)
        letters[gamingRow].remove(at: positionLetter)
        letters[gamingRow].insert(key, at: positionLetter)
        removeLetterDefaults(gamingRow: gamingRow, positionLetter: positionLetter)
        saveLetterDefaults(gamingRow: gamingRow, positionLetter: positionLetter, character: " ")
    }

    /// записать букву
    public mutating func saveLetter(gamingRow: Int, positionLetter: Int, character: Character) {
        let key: GameKey = .init(character: character, backgroundColor: .slovoGray)
        letters[gamingRow].remove(at: positionLetter)
        letters[gamingRow].insert(key, at: positionLetter)
        removeLetterDefaults(gamingRow: gamingRow, positionLetter: positionLetter)
        saveLetterDefaults(gamingRow: gamingRow, positionLetter: positionLetter, character: character)
    }

    // почистить все строки в переменной
    mutating func clearGamingRows() {
        letters.removeAll()
        letters = Array(
            repeating: Array(repeating: nil, count: 5),
            count: 7
            )
    }
}

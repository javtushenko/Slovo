//
//  LetterStorage.swift
//  Slovo
//
//  Created by Николай Явтушенко on 03.07.2022.
//

import Foundation
import SwiftyUserDefaults
import UIKit

struct LetterStorage {
    // двумерный массив с введенными строками
    private var letters: [[Key?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 7
    )

    /// получить массив букв
    public mutating func getLetters() -> [[Key?]] {
        // если в переменной есть данные, все окей, вернем её
        if letters[0][0]?.character == nil {
            // далее проходим по каждой игровой строке из хранилища
            // заполняем переменную пока не наткнемся на пустой символ
            for (index, letter) in getGamingRow1().enumerated() {
                guard let stringLetter = letter,
                index < 5
                else { break }
                self.saveLetter(gamingRow: 0, positionLetter: index, character: Character(stringLetter))
            }
            for (index, letter) in getGamingRow2().enumerated() {
                guard let stringLetter = letter,
                index < 5
                else { break }
                self.saveLetter(gamingRow: 1, positionLetter: index, character: Character(stringLetter))
            }
            for (index, letter) in getGamingRow3().enumerated() {
                guard let stringLetter = letter,
                index < 5
                else { break }
                self.saveLetter(gamingRow: 2, positionLetter: index, character: Character(stringLetter))
            }
            for (index, letter) in getGamingRow4().enumerated() {
                guard let stringLetter = letter,
                index < 5
                else { break }
                self.saveLetter(gamingRow: 3, positionLetter: index, character: Character(stringLetter))
            }
            for (index, letter) in getGamingRow5().enumerated() {
                guard let stringLetter = letter,
                index < 5
                else { break }
                self.saveLetter(gamingRow: 4, positionLetter: index, character: Character(stringLetter))
            }
            for (index, letter) in getGamingRow6().enumerated() {
                guard let stringLetter = letter,
                index < 5
                else { break }
                self.saveLetter(gamingRow: 5, positionLetter: index, character: Character(stringLetter))
            }
            return letters
        } else {
            return letters
        }
    }

    /// изменить цвет буквы
    public mutating func chageColor(at indexPath: IndexPath, color: UIColor) {
        let character = letters[indexPath.section][indexPath.row]?.character
        let key: Key = .init(character: character ?? " ", backgroundColor: color)
        letters[indexPath.section].remove(at: indexPath.row)
        letters[indexPath.section].insert(key, at: indexPath.row)
    }

    /// удалить букву
    public mutating func removeLetter(gamingRow: Int, positionLetter: Int) {
        guard positionLetter != -1 else {
            return
        }
        let key: Key = .init(character: " ", backgroundColor: .slovoGray)
        letters[gamingRow].remove(at: positionLetter)
        letters[gamingRow].insert(key, at: positionLetter)
        removeLetterDefaults(gamingRow: gamingRow, positionLetter: positionLetter)
        saveLetterDefaults(gamingRow: gamingRow, positionLetter: positionLetter, character: " ")
    }

    /// записать букву
    public mutating func saveLetter(gamingRow: Int, positionLetter: Int, character: Character) {
        let key: Key = .init(character: character, backgroundColor: .slovoGray)
        letters[gamingRow].remove(at: positionLetter)
        letters[gamingRow].insert(key, at: positionLetter)
        removeLetterDefaults(gamingRow: gamingRow, positionLetter: positionLetter)
        saveLetterDefaults(gamingRow: gamingRow, positionLetter: positionLetter, character: character)
    }
    
    /// Почистить все буквы в массивах
    public mutating func clearGame() {
        clearGamingRowsDefault()
        clearGamingRows()
    }
    
    // записать букву в хранилище
    private func saveLetterDefaults(gamingRow: Int, positionLetter: Int, character: Character) {
        switch gamingRow {
        case 0:
            Defaults[key: DefaultsKeys.gamingRow1].insert(String(character), at: positionLetter)
        case 1:
            Defaults[key: DefaultsKeys.gamingRow2].insert(String(character), at: positionLetter)
        case 2:
            Defaults[key: DefaultsKeys.gamingRow3].insert(String(character), at: positionLetter)
        case 3:
            Defaults[key: DefaultsKeys.gamingRow4].insert(String(character), at: positionLetter)
        case 4:
            Defaults[key: DefaultsKeys.gamingRow5].insert(String(character), at: positionLetter)
        case 5:
            Defaults[key: DefaultsKeys.gamingRow6].insert(String(character), at: positionLetter)
        default:
            break
        }
    }
    
    // удалить букву из хранилища
    private func removeLetterDefaults(gamingRow: Int, positionLetter: Int) {
        switch gamingRow {
        case 0:
            guard Defaults[key: DefaultsKeys.gamingRow1].count > positionLetter else { return }
            Defaults[key: DefaultsKeys.gamingRow1].remove(at: positionLetter)
        case 1:
            guard Defaults[key: DefaultsKeys.gamingRow2].count > positionLetter else { return }
            Defaults[key: DefaultsKeys.gamingRow2].remove(at: positionLetter)
        case 2:
            guard Defaults[key: DefaultsKeys.gamingRow3].count > positionLetter else { return }
            Defaults[key: DefaultsKeys.gamingRow3].remove(at: positionLetter)
        case 3:
            guard Defaults[key: DefaultsKeys.gamingRow4].count > positionLetter else { return }
            Defaults[key: DefaultsKeys.gamingRow4].remove(at: positionLetter)
        case 4:
            guard Defaults[key: DefaultsKeys.gamingRow5].count > positionLetter else { return }
            Defaults[key: DefaultsKeys.gamingRow5].remove(at: positionLetter)
        case 5:
            guard Defaults[key: DefaultsKeys.gamingRow6].count > positionLetter else { return }
            Defaults[key: DefaultsKeys.gamingRow6].remove(at: positionLetter)
        default:
            break
        }
    }
    
    // почистить все строки в переменной
    private mutating func clearGamingRows() {
        letters.removeAll()
        letters = Array(
            repeating: Array(repeating: nil, count: 5),
            count: 7
            )
    }
    
    // почитстить все строки в хранилище
    private func clearGamingRowsDefault() {
        Defaults[key: DefaultsKeys.gamingRow1].removeAll()
        Defaults[key: DefaultsKeys.gamingRow2].removeAll()
        Defaults[key: DefaultsKeys.gamingRow3].removeAll()
        Defaults[key: DefaultsKeys.gamingRow4].removeAll()
        Defaults[key: DefaultsKeys.gamingRow5].removeAll()
        Defaults[key: DefaultsKeys.gamingRow6].removeAll()
    }
    
    // получить массив букв 1 игровой строки из хранилища
    private func getGamingRow1() -> [String?] {
        Defaults[key: DefaultsKeys.gamingRow1]
    }
    
    // получить массив букв 2 игровой строки из хранилища
    private func getGamingRow2() -> [String?] {
        Defaults[key: DefaultsKeys.gamingRow2]
    }
    
    // получить массив букв 3 игровой строки из хранилища
    private func getGamingRow3() -> [String?] {
        Defaults[key: DefaultsKeys.gamingRow3]
    }
    
    // получить массив букв 4 игровой строки из хранилища
    private func getGamingRow4() -> [String?] {
        Defaults[key: DefaultsKeys.gamingRow4]
    }
    
    // получить массив букв 5 игровой строки из хранилища
    private func getGamingRow5() -> [String?] {
        Defaults[key: DefaultsKeys.gamingRow5]
    }
    
    // получить массив букв 6 игровой строки из хранилища
    private func getGamingRow6() -> [String?] {
        Defaults[key: DefaultsKeys.gamingRow6]
    }
}

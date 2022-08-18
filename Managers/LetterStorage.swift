//
//  LetterStorage.swift
//  Slovo
//
//  Created by Николай Явтушенко on 03.07.2022.
//

import Foundation
import UIKit

struct LetterStorage {
    // двумерный массив с введенными строками
    private var letters: [[Key?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 7
    )

    /// получить массив букв
    public func getLetters() -> [[Key?]] {
        letters
    }

    /// изменить цвет буквы
    public mutating func chageColor(at indexPath: IndexPath, color: UIColor) {
        let character = letters[indexPath.section][indexPath.row]?.character
        let key: Key = .init(character: character ?? " ", backgroundColor: color)
        letters[indexPath.section].remove(at: indexPath.row)
        letters[indexPath.section].insert(key, at: indexPath.row)
    }

    /// удалить букву
    public mutating func removeLetter(section: Int, row: Int) {
        guard row != -1 else {
            return
        }
        let key: Key = .init(character: " ", backgroundColor: .slovoGray)
        letters[section].remove(at: row)
        letters[section].insert(key, at: row)
    }

    /// записать букву
    public mutating func saveLetter(section: Int, row: Int, character: Character) {
        let key: Key = .init(character: character, backgroundColor: .slovoGray)
        letters[section].remove(at: row)
        letters[section].insert(key, at: row)
    }
}

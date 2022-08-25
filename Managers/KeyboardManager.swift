//
//  KeyboardManager.swift
//  Slovo
//
//  Created by Николай Явтушенко on 12.08.2022.
//  Отрефакторено 12.08.2022
//

import Foundation
import UIKit

public protocol KeyboardManagerProtocol {
    /// получить цвет кнопки
    func getKeyColor(key: Character, gameLetters: [[Key?]], successRow: Int) -> UIColor
}

class KeyboardManager: KeyboardManagerProtocol {
    static let shared = KeyboardManager()
    private init() {}
    
    /// Бонус бомбы, серые кнопки
    var bombLetters: [Character] = []

    /// получить цвет кнопки
    public func getKeyColor(key: Character, gameLetters: [[Key?]], successRow: Int) -> UIColor {
        // если совпадений не будет, вернем серый
        var currentColor: UIColor = .slovoGray
        // перебираем все строки игрового поля
        for index in 0..<successRow {
            let row = gameLetters[index]
            // вернет зеленый если есть совпадение
            if row.filter({ filtredKey in
                let currentKey = Key(character: key, backgroundColor: .slovoGreen)
                return filtredKey?.character == currentKey.character && filtredKey?.backgroundColor == currentKey.backgroundColor
            }).count != 0 {
                currentColor = .slovoGreen
                break
            }
            // вернет оранжевый если есть совпадение
            if row.filter({ filtredKey in
                let currentKey = Key(character: key, backgroundColor: .slovoOrange)
                return filtredKey?.character == currentKey.character && filtredKey?.backgroundColor == currentKey.backgroundColor
            }).count != 0 {
                currentColor = .slovoOrange
            }
            // вернет темный если есть совпадение
            if row.filter({ filtredKey in
                let currentKey = Key(character: key, backgroundColor: .slovoGray)
                return filtredKey?.character == currentKey.character && filtredKey?.backgroundColor == currentKey.backgroundColor
            }).count != 0 {
                currentColor = .slovoDark
            }
        }
        if key == "+" {
            currentColor = .slovoGreen
        }
        if key == "-" {
            currentColor = .slovoOrange
        }
        return currentColor
    }
}

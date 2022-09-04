//
//  KeyboardManager.swift
//  Slovo
//
//  Created by Николай Явтушенко on 12.08.2022.
//  Отрефакторено 12.08.2022
//

import Foundation
import UIKit
import SwiftyUserDefaults

public protocol KeyboardManagerProtocol {
    /// Подсказка лупа, оранжевые кнопки
    var searchHelpLetters: String { get }
    /// получить цвет кнопки
    func getKeyColor(key: Character, gameLetters: [[Key?]], successRow: Int) -> UIColor
    /// добавить оранжевые кнопки в массив
    func getBombLetters(currentWord: String)
    /// полон ли массив букв подсказки ЛУПА
    func isArraySearchFull(currentWord: String) -> Bool
    /// Очистить буквы с подсказки лупы
    func resetSearchHelpArray()
}

class KeyboardManager: KeyboardManagerProtocol {
    static let shared = KeyboardManager()
    private init() {}
    
    /// Подсказка лупа, оранжевые кнопки
    var searchHelpLetters: String {
        Defaults[key: DefaultsKeys.searchLetterArray]
    }

    /// получить цвет кнопки
    public func getKeyColor(key: Character, gameLetters: [[Key?]], successRow: Int) -> UIColor {
        // если совпадений не будет, вернем серый
        var currentColor: UIColor = .slovoGray
        
        // если буква есть в списке подсказки, вернет оранжевый
        if searchHelpLetters.contains(key) {
            currentColor = .slovoOrange
        }
        
        // перебираем все строки игрового поля
        for index in 0..<successRow {
            let row = gameLetters[index]
            
            // вернет зеленый если есть совпадение
            let greenFilterArray = row.filter({ filtredKey in
                let currentKey = Key(character: key, backgroundColor: .slovoGreen)
                return filtredKey?.character == currentKey.character && filtredKey?.backgroundColor == currentKey.backgroundColor
            })
            if greenFilterArray.count != 0 {
                for letter in greenFilterArray {
                    let currentLetter = letter?.character ?? " "
                    guard !searchHelpLetters.contains(currentLetter) else { break }
                    Defaults[key: DefaultsKeys.searchLetterArray].append(currentLetter)
                }
                currentColor = .slovoGreen
                break
            }
            
            // вернет оранжевый если есть совпадение
            if searchHelpLetters.filter({ filtredKey in
                filtredKey == key
            }).count != 0 {
                currentColor = .slovoOrange
            }
            // вернет оранжевый если есть совпадение
            let orangeFilterArray = row.filter({ filtredKey in
                let currentKey = Key(character: key, backgroundColor: .slovoOrange)
                return filtredKey?.character == currentKey.character && filtredKey?.backgroundColor == currentKey.backgroundColor
            })
            if orangeFilterArray.count != 0 {
                for letter in orangeFilterArray {
                    let currentLetter = letter?.character ?? " "
                    guard !searchHelpLetters.contains(currentLetter) else { break }
                    Defaults[key: DefaultsKeys.searchLetterArray].append(currentLetter)
                }
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
        
        // обработка кнопок управления
        if key == "+" {
            currentColor = .slovoGreen
        }
        if key == "-" {
            currentColor = .slovoOrange
        }
        return currentColor
    }
    
    /// добавить оранжевые кнопки в массив
    func getBombLetters(currentWord: String) {
        var currentWord = String(Set(currentWord))
        let randomIndex: Int = .random(in: 0..<currentWord.count)
        let index = String.Index.init(utf16Offset: randomIndex, in: currentWord)
        let letter = currentWord.remove(at: index)
        guard !searchHelpLetters.contains(letter) else {
            getBombLetters(currentWord: currentWord)
            return
        }
        Defaults[key: DefaultsKeys.searchLetterArray].append(letter)
    }
    
    /// Очистить буквы с подсказки лупы
    func resetSearchHelpArray() {
        Defaults[key: DefaultsKeys.searchLetterArray].removeAll()
    }
    
    /// полон ли массив букв подсказки ЛУПА
    func isArraySearchFull(currentWord: String) -> Bool {
        searchHelpLetters.count < Set(currentWord).count ? true : false
    }
}

extension String {
  subscript (i: Int) -> Character {
    return self[index(startIndex, offsetBy: i)]
  }
}

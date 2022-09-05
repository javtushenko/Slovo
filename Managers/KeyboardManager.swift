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
    func getSearchLetters(currentWord: String)
    /// полон ли массив букв подсказки ЛУПА
    func isArraySearchFull(currentWord: String) -> Bool
    /// Очистить буквы с подсказки лупы
    func resetSearchHelpArray()
    /// Очистить буквы с подсказки бомбы
    func resetBombHelpArray()
    /// добавить темно-серые кнопки в массив
    func getBombLetters(currentWord: String)
}

class KeyboardManager: KeyboardManagerProtocol {
    static let shared = KeyboardManager()
    private init() {}
    
    /// Подсказка лупа, оранжевые кнопки
    var searchHelpLetters: String {
        Defaults[key: DefaultsKeys.searchLetterArray]
    }
    
    /// Подсказка бомба, оранжевые кнопки
    var bombHelpLetters: String {
        Defaults[key: DefaultsKeys.bombLetterArray]
    }

    /// получить цвет кнопки
    public func getKeyColor(key: Character, gameLetters: [[Key?]], successRow: Int) -> UIColor {
        // если совпадений не будет, вернем серый
        var currentColor: UIColor = .slovoGray
        
        // если буква есть в списке подсказки, вернет оранжевый
        if searchHelpLetters.contains(key) {
            currentColor = .slovoOrange
        }
        
        // если буква есть в списке подсказки, вернет серый
        if bombHelpLetters.contains(key) {
            currentColor = .slovoDark
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
                Defaults[key: DefaultsKeys.bombLetterArray].append(key)
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
    
    /// добавить темно-серые кнопки в массив
    func getBombLetters(currentWord: String) {
        // получаем клаву без загаданного слова
        var keyboard = "йцукенгшщзфывапролджэячсмитьбюх"
        for letter in currentWord {
            keyboard = keyboard.replacingOccurrences(of: String(letter), with: "")
        }
        // получаем рандомные буквы
        let randomIndex: Int = .random(in: 0..<keyboard.count)
        let stringIndex = String.Index.init(utf16Offset: randomIndex, in: keyboard)
        var letters = ""
        while letters.count < 3 {
            let letter = keyboard.remove(at: stringIndex)
            if !bombHelpLetters.contains(letter),
               !letters.contains(letter) {
                letters.append(letter)
            }
        }
        Defaults[key: DefaultsKeys.bombLetterArray].append(letters)
    }
    
    /// добавить оранжевые кнопки в массив
    func getSearchLetters(currentWord: String) {
        var currentWord = String(Set(currentWord))
        let randomIndex: Int = .random(in: 0..<currentWord.count)
        let index = String.Index.init(utf16Offset: randomIndex, in: currentWord)
        let letter = currentWord.remove(at: index)
        guard !searchHelpLetters.contains(letter) else {
            getSearchLetters(currentWord: currentWord)
            return
        }
        Defaults[key: DefaultsKeys.searchLetterArray].append(letter)
    }
    
    /// Очистить буквы с подсказки лупы
    func resetSearchHelpArray() {
        Defaults[key: DefaultsKeys.searchLetterArray].removeAll()
    }
    
    /// Очистить буквы с подсказки бомбы
    func resetBombHelpArray() {
        Defaults[key: DefaultsKeys.bombLetterArray].removeAll()
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

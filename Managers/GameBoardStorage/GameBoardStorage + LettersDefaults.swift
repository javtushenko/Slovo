//
//  GameBoardStorage + Letter_Array.swift
//  Slovo
//
//  Created by Николай Явтушенко on 27.08.2022.
//

import Foundation
import SwiftyUserDefaults

extension GameBoardStorage {
    
    /// Почистить все хранилище
    public mutating func clearGame() {
        clearGamingRowsDefault()
        clearGamingRows()
        clearGamingRowSuccessDefault()
        clearIsCanGoNextDefault()
        clearIsCanDeleteDefault()
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
    
    // наполнить массив из хранилища
    mutating func fillLettersArray() {
        for (index, letter) in getGamingRow1().enumerated() {
            guard let stringLetter = letter,
                  stringLetter != " ",
                  index < 5
            else { break }
            let key: Key = .init(character: Character(stringLetter), backgroundColor: .slovoGray)
            letters[0].remove(at: index)
            letters[0].insert(key, at: index)
        }
        for (index, letter) in getGamingRow2().enumerated() {
            guard let stringLetter = letter,
                  stringLetter != " ",
                  index < 5
            else { break }
            let key: Key = .init(character: Character(stringLetter), backgroundColor: .slovoGray)
            letters[1].remove(at: index)
            letters[1].insert(key, at: index)
        }
        for (index, letter) in getGamingRow3().enumerated() {
            guard let stringLetter = letter,
                  stringLetter != " ",
                  index < 5
            else { break }
            let key: Key = .init(character: Character(stringLetter), backgroundColor: .slovoGray)
            letters[2].remove(at: index)
            letters[2].insert(key, at: index)
        }
        for (index, letter) in getGamingRow4().enumerated() {
            guard let stringLetter = letter,
                  stringLetter != " ",
                  index < 5
            else { break }
            let key: Key = .init(character: Character(stringLetter), backgroundColor: .slovoGray)
            letters[3].remove(at: index)
            letters[3].insert(key, at: index)
        }
        for (index, letter) in getGamingRow5().enumerated() {
            guard let stringLetter = letter,
                  stringLetter != " ",
                  index < 5
            else { break }
            let key: Key = .init(character: Character(stringLetter), backgroundColor: .slovoGray)
            letters[4].remove(at: index)
            letters[4].insert(key, at: index)
        }
        for (index, letter) in getGamingRow6().enumerated() {
            guard let stringLetter = letter,
                  stringLetter != " ",
                  index < 5
            else { break }
            let key: Key = .init(character: Character(stringLetter), backgroundColor: .slovoGray)
            letters[5].remove(at: index)
            letters[5].insert(key, at: index)
        }
    }
    
    // записать букву в хранилище
    func saveLetterDefaults(gamingRow: Int, positionLetter: Int, character: Character) {
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
    func removeLetterDefaults(gamingRow: Int, positionLetter: Int) {
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

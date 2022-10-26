//
//  GameBoardStorage + successGoNext.swift
//  Slovo
//
//  Created by Николай Явтушенко on 25.08.2022.
//

import Foundation
import SwiftyUserDefaults

extension GameBoardStorage {
    /// записать успешный переход в хранилище
    public func saveSuccessGoNet(gamingRow: Int) {
        switch gamingRow {
        case 1:
            Defaults[key: DefaultsKeys.haveSuccessRow1] = true
        case 2:
            Defaults[key: DefaultsKeys.haveSuccessRow2] = true
        case 3:
            Defaults[key: DefaultsKeys.haveSuccessRow3] = true
        case 4:
            Defaults[key: DefaultsKeys.haveSuccessRow4] = true
        case 5:
            Defaults[key: DefaultsKeys.haveSuccessRow5] = true
        case 6:
            Defaults[key: DefaultsKeys.haveSuccessRow6] = true
        default:
            return
        }
    }

    /// Получить был ли успешный переход в хранилище
    public func isSuccessWithRow(gamingRow: Int) -> Bool {
        switch gamingRow {
        case 1:
            return Defaults[key: DefaultsKeys.haveSuccessRow1]
        case 2:
            return Defaults[key: DefaultsKeys.haveSuccessRow2]
        case 3:
            return Defaults[key: DefaultsKeys.haveSuccessRow3]
        case 4:
            return Defaults[key: DefaultsKeys.haveSuccessRow4]
        case 5:
            return Defaults[key: DefaultsKeys.haveSuccessRow5]
        case 6:
            return Defaults[key: DefaultsKeys.haveSuccessRow6]
        default:
            return false
        }
    }

    /// Получить номер последней успешной строки
    public func getCurrentSuccessRow() -> Int {
        for index in 1...6 {
            if !isSuccessWithRow(gamingRow: index) {
                return index - 1
            }
        }
        return 0
    }

    // почитстить все строки в хранилище
    func clearGamingRowSuccessDefault() {
        Defaults[key: DefaultsKeys.haveSuccessRow1] = false
        Defaults[key: DefaultsKeys.haveSuccessRow2] = false
        Defaults[key: DefaultsKeys.haveSuccessRow3] = false
        Defaults[key: DefaultsKeys.haveSuccessRow4] = false
        Defaults[key: DefaultsKeys.haveSuccessRow5] = false
        Defaults[key: DefaultsKeys.haveSuccessRow6] = false
    }
}

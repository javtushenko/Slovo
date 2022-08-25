//
//  GameBoardStorage + isCanDelete.swift
//  Slovo
//
//  Created by Николай Явтушенко on 26.08.2022.
//

import Foundation
import SwiftyUserDefaults

extension GameBoardStorage {
    /// записать можно ли перейти к следующей строке в хранилище
    public func saveIsCanDelete(gamingRow: Int) {
        switch gamingRow {
        case 1:
            Defaults[key: DefaultsKeys.isCanDelete1] = false
        case 2:
            Defaults[key: DefaultsKeys.isCanDelete2] = false
        case 3:
            Defaults[key: DefaultsKeys.isCanDelete3] = false
        case 4:
            Defaults[key: DefaultsKeys.isCanDelete4] = false
        case 5:
            Defaults[key: DefaultsKeys.isCanDelete5] = false
        case 6:
            Defaults[key: DefaultsKeys.isCanDelete6] = false
        default:
            return
        }
    }
    
    /// Получить можно ли перейти к следующей строке из хранилища
    public func IsCanDeleteWithRow(gamingRow: Int) -> Bool {
        switch gamingRow {
        case 1:
            return Defaults[key: DefaultsKeys.isCanDelete1]
        case 2:
            return Defaults[key: DefaultsKeys.isCanDelete2]
        case 3:
            return Defaults[key: DefaultsKeys.isCanDelete3]
        case 4:
            return Defaults[key: DefaultsKeys.isCanDelete4]
        case 5:
            return Defaults[key: DefaultsKeys.isCanDelete5]
        case 6:
            return Defaults[key: DefaultsKeys.isCanDelete6]
        default:
            return true
        }
    }
    
    // почитстить все строки в хранилище
    func clearIsCanDeleteDefault() {
        Defaults[key: DefaultsKeys.isCanDelete1] = true
        Defaults[key: DefaultsKeys.isCanDelete2] = true
        Defaults[key: DefaultsKeys.isCanDelete3] = true
        Defaults[key: DefaultsKeys.isCanDelete4] = true
        Defaults[key: DefaultsKeys.isCanDelete5] = true
        Defaults[key: DefaultsKeys.isCanDelete6] = true
    }
}

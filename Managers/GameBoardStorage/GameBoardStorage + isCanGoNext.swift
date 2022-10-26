//
//  GameBoardStorage + isCanGoNext.swift
//  Slovo
//
//  Created by Николай Явтушенко on 25.08.2022.
//

import Foundation
import SwiftyUserDefaults

extension GameBoardStorage {
    /// записать можно ли перейти к следующей строке в хранилище
    public func saveIsCanGoNext(gamingRow: Int) {
        switch gamingRow {
        case 1:
            Defaults[key: DefaultsKeys.isCanGoNext1] = true
        case 2:
            Defaults[key: DefaultsKeys.isCanGoNext2] = true
        case 3:
            Defaults[key: DefaultsKeys.isCanGoNext3] = true
        case 4:
            Defaults[key: DefaultsKeys.isCanGoNext4] = true
        case 5:
            Defaults[key: DefaultsKeys.isCanGoNext5] = true
        case 6:
            Defaults[key: DefaultsKeys.isCanGoNext6] = true
        default:
            return
        }
    }

    /// Получить можно ли перейти к следующей строке из хранилища
    public func isCanGoNextWithRow(gamingRow: Int) -> Bool {
        switch gamingRow {
        case 1:
            return Defaults[key: DefaultsKeys.isCanGoNext1]
        case 2:
            return Defaults[key: DefaultsKeys.isCanGoNext2]
        case 3:
            return Defaults[key: DefaultsKeys.isCanGoNext3]
        case 4:
            return Defaults[key: DefaultsKeys.isCanGoNext4]
        case 5:
            return Defaults[key: DefaultsKeys.isCanGoNext5]
        case 6:
            return Defaults[key: DefaultsKeys.isCanGoNext6]
        default:
            return false
        }
    }

    // почитстить все строки в хранилище
    func clearIsCanGoNextDefault() {
        Defaults[key: DefaultsKeys.isCanGoNext1] = true
        Defaults[key: DefaultsKeys.isCanGoNext2] = false
        Defaults[key: DefaultsKeys.isCanGoNext3] = false
        Defaults[key: DefaultsKeys.isCanGoNext4] = false
        Defaults[key: DefaultsKeys.isCanGoNext5] = false
        Defaults[key: DefaultsKeys.isCanGoNext6] = false
    }
}

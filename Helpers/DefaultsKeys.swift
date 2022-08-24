//
//  DefaultsKeys.swift
//  Slovo
//
//  Created by Николай Явтушенко on 22.08.2022.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    /// массив с буквами на игровой строке 1
    static let gamingRow1 = DefaultsKey<[String]>("gaming_row_1", defaultValue: [])
    /// массив с буквами на игровой строке 2
    static let gamingRow2 = DefaultsKey<[String]>("gaming_row_2", defaultValue: [])
    /// массив с буквами на игровой строке 3
    static let gamingRow3 = DefaultsKey<[String]>("gaming_row_3", defaultValue: [])
    /// массив с буквами на игровой строке 4
    static let gamingRow4 = DefaultsKey<[String]>("gaming_row_4", defaultValue: [])
    /// массив с буквами на игровой строке 5
    static let gamingRow5 = DefaultsKey<[String]>("gaming_row_5", defaultValue: [])
    /// массив с буквами на игровой строке 6
    static let gamingRow6 = DefaultsKey<[String]>("gaming_row_6", defaultValue: [])
}

extension DefaultsKeys {
    /// массив с буквами на игровой строке 1
    static let haveSuccessRow1 = DefaultsKey<[String]>("have_success_row_1", defaultValue: [])
    /// массив с буквами на игровой строке 2
    static let haveSuccessRow2 = DefaultsKey<[String]>("have_success_row_2", defaultValue: [])
    /// массив с буквами на игровой строке 3
    static let haveSuccessRow3 = DefaultsKey<[String]>("have_success_row_3", defaultValue: [])
    /// массив с буквами на игровой строке 4
    static let haveSuccessRow4 = DefaultsKey<[String]>("have_success_row_4", defaultValue: [])
    /// массив с буквами на игровой строке 5
    static let haveSuccessRow5 = DefaultsKey<[String]>("have_success_row_5", defaultValue: [])
    /// массив с буквами на игровой строке 6
    static let haveSuccessRow6 = DefaultsKey<[String]>("have_success_row_6", defaultValue: [])
}


extension DefaultsKeys {
    /// Загаданное слово
    static let currentWord = DefaultsKey<String?>("current_word")
}

extension DefaultsKeys {
    /// Баланс кошелька
    static let vallet = DefaultsKey<Int>("vallet", defaultValue: 0)
}

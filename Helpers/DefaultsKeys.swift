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
    /// Был ли успешный переход на игровой строке 1
    static let haveSuccessRow1 = DefaultsKey<Bool>("have_success_row_1", defaultValue: false)
    /// Был ли успешный переход на игровой строке 2
    static let haveSuccessRow2 = DefaultsKey<Bool>("have_success_row_2", defaultValue: false)
    /// Был ли успешный переход на игровой строке 3
    static let haveSuccessRow3 = DefaultsKey<Bool>("have_success_row_3", defaultValue: false)
    /// Был ли успешный переход на игровой строке 4
    static let haveSuccessRow4 = DefaultsKey<Bool>("have_success_row_4", defaultValue: false)
    /// Был ли успешный переход на игровой строке 5
    static let haveSuccessRow5 = DefaultsKey<Bool>("have_success_row_5", defaultValue: false)
    /// Был ли успешный переход на игровой строке 6
    static let haveSuccessRow6 = DefaultsKey<Bool>("have_success_row_6", defaultValue: false)
}

extension DefaultsKeys {
    /// Был ли успешный переход на игровой строке 1
    static let isCanGoNext1 = DefaultsKey<Bool>("is_can_go_next_1", defaultValue: true)
    /// Был ли успешный переход на игровой строке 2
    static let isCanGoNext2 = DefaultsKey<Bool>("is_can_go_next_2", defaultValue: false)
    /// Был ли успешный переход на игровой строке 3
    static let isCanGoNext3 = DefaultsKey<Bool>("is_can_go_next_3", defaultValue: false)
    /// Был ли успешный переход на игровой строке 4
    static let isCanGoNext4 = DefaultsKey<Bool>("is_can_go_next_4", defaultValue: false)
    /// Был ли успешный переход на игровой строке 5
    static let isCanGoNext5 = DefaultsKey<Bool>("is_can_go_next_5", defaultValue: false)
    /// Был ли успешный переход на игровой строке 6
    static let isCanGoNext6 = DefaultsKey<Bool>("is_can_go_next_6", defaultValue: false)
}

extension DefaultsKeys {
    /// Был ли успешный переход на игровой строке 1
    static let isCanDelete1 = DefaultsKey<Bool>("is_can_delete_1", defaultValue: true)
    /// Был ли успешный переход на игровой строке 2
    static let isCanDelete2 = DefaultsKey<Bool>("is_can_delete_2", defaultValue: true)
    /// Был ли успешный переход на игровой строке 3
    static let isCanDelete3 = DefaultsKey<Bool>("is_can_delete_3", defaultValue: true)
    /// Был ли успешный переход на игровой строке 4
    static let isCanDelete4 = DefaultsKey<Bool>("is_can_delete_4", defaultValue: true)
    /// Был ли успешный переход на игровой строке 5
    static let isCanDelete5 = DefaultsKey<Bool>("is_can_delete_5", defaultValue: true)
    /// Был ли успешный переход на игровой строке 6
    static let isCanDelete6 = DefaultsKey<Bool>("is_can_delete_6", defaultValue: true)
}

extension DefaultsKeys {
    /// Первое ли открытие приложения
    static let isFirstOpenApp = DefaultsKey<Bool>("is_first_open_app", defaultValue: true)
}

extension DefaultsKeys {
    /// Использован ли бонус книга
    static let didUseHelpBook = DefaultsKey<Bool>("did_use_help_book", defaultValue: false)
}

extension DefaultsKeys {
    /// Загаданное слово
    static let currentWord = DefaultsKey<String?>("current_word")
}

extension DefaultsKeys {
    /// Значение загаданного слова
    static let currentWordValue = DefaultsKey<String?>("current_word_value")
}

extension DefaultsKeys {
    /// Баланс кошелька
    static let valletCount = DefaultsKey<Int>("vallet_count", defaultValue: 0)
}

extension DefaultsKeys {
    /// Баланс кошелька
    static let winStreak = DefaultsKey<Int>("win_streak_count", defaultValue: 0)
}

extension DefaultsKeys {
    /// Массив букв из подсказки лупа
    static let searchLetterArray = DefaultsKey<String>("search_letter_array", defaultValue: "")
}

extension DefaultsKeys {
    /// Массив букв из подсказки бомба
    static let bombLetterArray = DefaultsKey<String>("bomb_letter_array", defaultValue: "")
}

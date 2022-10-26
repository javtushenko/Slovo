//
//  DIContainer.swift
//  Slovo
//
//  Created by Николай Явтушенко on 12.08.2022.
//

import Foundation

public final class DIContainer {
    static let shared = DIContainer()
    private init() {}

    /// менеджер кастомной клавиатуры
    var keyboardManager: KeyboardManagerProtocol {
        KeyboardManager.shared
    }

    /// менеджер кошелька бонусов
    var valletStorage: ValletStorageProtocol {
        ValletStorage.shared
    }

    /// сервис загрузки допустимых слов
    var wordsLoadService: WordsLoadServiceProtocol {
        WordsLoadService.shared
    }

    /// сторож кошелька
    var gameBoardStorage: GameBoardStorageProtocol {
        GameBoardStorage.shared
    }

    /// сторож серии побед
    var winStreakStorage: WinStreakStorageProtocol {
        WinStreakStorage.shared
    }
}

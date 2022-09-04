//
//  WinStreakStorage.swift
//  Slovo
//
//  Created by Николай Явтушенко on 04.09.2022.
//

import Foundation
import SwiftyUserDefaults

protocol WinStreakStorageProtocol {
    /// текущее значение кошелька
    var currentCount: Int { get }
    
    /// добавить значение в кошелек
    func addCountWinStreak(count: Int)
    
    /// очистить значение
    func resetWinStreak()
}

class WinStreakStorage: WinStreakStorageProtocol {
    static let shared = WinStreakStorage()
    private init(){}
    
    /// текущее значение кошелька
    var currentCount: Int {
        Defaults[key: DefaultsKeys.winStreak]
    }
    
    /// добавить значение в кошелек
    func addCountWinStreak(count: Int) {
        Defaults[key: DefaultsKeys.winStreak] += count
    }
    
    /// очистить кошелек
    func resetWinStreak() {
        Defaults[key: DefaultsKeys.winStreak] = 0
    }
}

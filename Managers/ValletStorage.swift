//
//  ValletStorage.swift
//  Slovo
//
//  Created by Николай Явтушенко on 27.08.2022.
//

import Foundation
import SwiftyUserDefaults

protocol ValletStorageProtocol {
    /// текущее значение кошелька
    var currentCount: Int { get }
    
    /// добавить значение в кошелек
    func addCountVallet(count: Int)
}

class ValletStorage: ValletStorageProtocol {
    static let shared = ValletStorage()
    private init(){}
    
    /// текущее значение кошелька
    var currentCount: Int {
        Defaults[key: DefaultsKeys.valletCount]
    }
    
    /// добавить значение в кошелек
    func addCountVallet(count: Int) {
        Defaults[key: DefaultsKeys.valletCount] += count
    }
    
    /// вычесть значение из кошелька
    func subtractCountVallet(count: Int) {
        Defaults[key: DefaultsKeys.valletCount] -= count
    }
}

//
//  ValletStorageMock.swift
//  Slovo
//
//  Created by Николай Явтушенко on 29.08.2022.
//

import Foundation

class ValletStorageMock: ValletStorageProtocol {
    /// текущее значение кошелька
    var currentCount: Int = 0
    
    /// добавить значение в кошелек
    func addCountVallet(count: Int) {}
    
    /// очистить кошелек
    func resetCountVallet() {}
}

//
//  ValletTests.swift
//  Slovo
//
//  Created by Николай Явтушенко on 29.08.2022.
//

import XCTest
@testable import Slovo

class ValletTests: XCTestCase {

    override func setUpWithError() throws {
        let valletStorage = DIContainer.shared.valletStorage
        valletStorage.resetCountVallet()
    }

    // проверяем что при победе добавляется нужное количество очков в кошелек
    // проверяется и вызов метода в интеракторе и менеджер
    func testAddMoneyWithVallet() throws {
        let view = MainGameViewController()
        let presenter = MainGamePresenter(view: view)
        let valletStorage = DIContainer.shared.valletStorage
        let interactor = MainGameInteractor(presenter: presenter,
                                            wordsLoadService: DIContainer.shared.wordsLoadService,
                                            keyboardManager: DIContainer.shared.keyboardManager,
                                            valletStorage: valletStorage,
                                            gameBoardStorage: DIContainer.shared.gameBoardStorage)
        presenter.interactor = interactor
        valletStorage.resetCountVallet()
        
        presenter.onWin(currentRow: 1)
        var result = valletStorage.currentCount
        XCTAssertEqual(result,
                       100,
                       "В кошельке ожидалось \(result)")
        
        presenter.onWin(currentRow: 2)
        result = valletStorage.currentCount
        XCTAssertEqual(result,
                       190,
                       "В кошельке ожидалось \(result)")
        
        presenter.onWin(currentRow: 3)
        result = valletStorage.currentCount
        XCTAssertEqual(result,
                       270,
                       "В кошельке ожидалось \(result)")
        
        presenter.onWin(currentRow: 4)
        result = valletStorage.currentCount
        XCTAssertEqual(result,
                       340,
                       "В кошельке ожидалось \(result)")
        
        presenter.onWin(currentRow: 5)
        result = valletStorage.currentCount
        XCTAssertEqual(result,
                       400,
                       "В кошельке ожидалось \(result)")
        
        presenter.onWin(currentRow: 6)
        result = valletStorage.currentCount
        XCTAssertEqual(result,
                       450,
                       "В кошельке ожидалось \(result)")
    }
}

//
//  ValletTests.swift
//  Slovo
//
//  Created by Николай Явтушенко on 29.08.2022.
//

import XCTest
import SwiftyUserDefaults
@testable import Slovo

class ValletTests: XCTestCase {

    // создать окружение
    func createEnvironment() -> (MainGamePresenter, ValletStorageProtocol) {
        let view = MainGameViewController()
        let presenter = MainGamePresenter(view: view)
        let valletStorage = DIContainer.shared.valletStorage
        let interactor = MainGameInteractor(presenter: presenter,
                                            wordsLoadService: DIContainer.shared.wordsLoadService,
                                            keyboardManager: DIContainer.shared.keyboardManager,
                                            valletStorage: valletStorage,
                                            gameBoardStorage: DIContainer.shared.gameBoardStorage,
                                            winStreakStorage: DIContainer.shared.winStreakStorage)
        presenter.interactor = interactor
        return (presenter, valletStorage)
    }

    // проверяем что при победе добавляется нужное количество очков в кошелек
    // проверяется и вызов метода в интеракторе и менеджер
    func testAddMoneyWithVallet() throws {
        let (presenter, valletStorage) = createEnvironment()

        // чистим кошелек
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

    // проверяем что при подсказке ЛУПА отнимается нужное количество бонусов
    // проверяется и вызов метода в интеракторе и менеджер
    func testValletCountWithHelpSearch() throws {
        let (presenter, valletStorage) = createEnvironment()
        KeyboardManager.shared.resetSearchHelpArray()
        let expectationResult = 10
        // чистим кошелек
        valletStorage.resetCountVallet()
        // добавляем ожидаемое значение и стоимость подсказки
        valletStorage.addCountVallet(count: Price.priseSearch + expectationResult)

        presenter.onUseHelpSearch()
        let result = valletStorage.currentCount

        XCTAssertEqual(expectationResult, result, "Ожидалось \(expectationResult), Факт: \(result)")
    }

    // проверяем что при подсказке БОМБА отнимается нужное количество бонусов
    // проверяется и вызов метода в интеракторе и менеджер
    func testValletCountWithHelpBomb() throws {
        let (presenter, valletStorage) = createEnvironment()
        KeyboardManager.shared.resetBombHelpArray()
        let expectationResult = 10
        // чистим кошелек
        valletStorage.resetCountVallet()
        // добавляем ожидаемое значение и стоимость подсказки
        valletStorage.addCountVallet(count: Price.priseBoom + expectationResult)

        presenter.onUseHelpBomb()
        let result = valletStorage.currentCount

        XCTAssertEqual(expectationResult, result, "Ожидалось \(expectationResult), Факт: \(result)")
    }

    // проверяем что при подсказке БОМБА отнимается нужное количество бонусов
    // проверяется и вызов метода в интеракторе и менеджер
    func testValletCountWithHelpBook() throws {
        let (presenter, valletStorage) = createEnvironment()
        let expectationResult = 10
        // чистим кошелек
        valletStorage.resetCountVallet()
        // добавляем ожидаемое значение и стоимость подсказки
        valletStorage.addCountVallet(count: Price.priseBook + expectationResult)

        presenter.onUseHelpBook()
        let result = valletStorage.currentCount

        XCTAssertEqual(expectationResult, result, "Ожидалось \(expectationResult), Факт: \(result)")
    }
}

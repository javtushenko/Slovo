//
//  HelpsTests.swift
//  SlovoTests
//
//  Created by Николай Явтушенко on 21.09.2022.
//

import XCTest
@testable import Slovo

class HelpsTests: XCTestCase {

    // создать окружение
    func createEnvironment() -> (MainGamePresenter, MainGameInteractorMock, KeyboardManagerProtocol) {
        let view = MainGameViewController()
        let presenter = MainGamePresenter(view: view)
        let keyboardManager = DIContainer.shared.keyboardManager
        let interactor = MainGameInteractorMock()
        presenter.interactor = interactor
        return (presenter, interactor, keyboardManager)
    }

    // проверяем логику подсказки ЛУПА
    func testCheckHelpSearch() throws {
        let (_, _, keyboardManager) = createEnvironment()
        keyboardManager.resetSearchHelpArray()
        let currentWord = "арбуз"

        keyboardManager.getSearchLetters(currentWord: currentWord)
        let resultChar = keyboardManager.searchHelpLetters.first ?? " "

        let result = currentWord.contains(resultChar)

        XCTAssertTrue(result, "Массив не содержит букву из загаданного слова")
    }

}

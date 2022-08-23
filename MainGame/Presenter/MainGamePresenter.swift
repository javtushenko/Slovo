//
//  MainGamePresenter.swift
//  Slovo
//
//  Created Николай Явтушенко on 22.06.2022.
//

import UIKit
import SwiftyUserDefaults

final class MainGamePresenter: MainGameViewToPresenterProtocol {
    weak var view: MainGameViewProtocol?
    var interactor: MainGameInteractorProtocol?
    var router: MainGameRouterProtocol?

    var letterStorage = LetterStorage()

    // загаданное слово
    var answer: String

    // можно ли удалить символ у секции
    var isCanBackspaces: [Int: Bool] = [0: true,
                                       1: true,
                                       2: true,
                                       3: true,
                                       4: true,
                                       5: true]

    // можно ли перейти к следующей строке
    var isCanGoNext: [Int: Bool] = [0: true,
                                   1: false,
                                   2: false,
                                   3: false,
                                   4: false,
                                   5: false]

    init(view: MainGameViewProtocol) {
        self.view = view
        self.answer = interactor?.currentWord ?? "слово"
    }
    
    /// Вью загружено
    func onViewDidLoad() {
        interactor?.start()
        answer = interactor?.currentWord ?? "слово"
        view?.keyboardVC.delegate = self
        view?.keyboardVC.datasource = self
        view?.boardVC.datasource = self
        handleOpenAppWithData()
    }
    
    // при открытии приложения с данными
    func handleOpenAppWithData() {
        for row in 0..<4 {
            if isCanGoNextSectionGet(gamingCell: 4, gamingRow: row, allLetters: letterStorage.getLetters()) {
                handlePressEnter(position: 4, section: row, allLetters: letterStorage.getLetters())
            }
        }
    }
    
    // можно ли переходить к следующей секции
    private func isCanGoNextSectionGet(gamingCell: Int, gamingRow: Int, allLetters: [[Key?]]) -> Bool {
        guard let words = interactor?.getRandomWords() else {
            print("❌ Массив слов не загрузился в фильтр ввода")
            return false
        }
        guard gamingRow >= 0 else { return false }
        var lettersInSection = ""
        for index in 0..<5 {
            guard let letter = allLetters[gamingRow][index]?.character else { return false }
            lettersInSection.append(letter)
        }
        guard words.contains(lettersInSection) else {
            handleWrongWord(word: lettersInSection)
            return false }
        print("✅ Массив слов загрузился в фильтр ввода")
        isCanGoNext[gamingRow+1] = true
        return true
    }

    // обработка успешного перехода на следующую строку
    private func handleSuccesTransition(currentRow: Int) {
        // если все ячейки зеленые, показываем попап победы
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            let gamingLetters = strongSelf.letterStorage.getLetters()
            let lettersRow = gamingLetters[currentRow-1]
            let filtredRow = lettersRow.filter({ letter in
                letter?.backgroundColor == .slovoGreen
            })
            if filtredRow.count == 5 {
                strongSelf.handleWin()
            } else if currentRow == 6 {
                strongSelf.handleDefeat()
            }
        }
    }

    // обработка поражения
    private func handleDefeat() {
        router?.openStopPopup(typePopup: .defeat, word: "", delegate: self)
    }

    // обработка победы
    private func handleWin() {
        router?.openStopPopup(typePopup: .win, word: "", delegate: self)
    }
    
    // обработка неверного слова
    private func handleWrongWord(word: String) {
        router?.openStopPopup(typePopup: .wrong, word: word, delegate: self)
    }
}

extension MainGamePresenter: MainGameInteractorToPresenterProtocol {
    /*
     Тут нужен будет рефакторинг
     Протокол не должен быть пустым
     Нужно вынести некоторые методы в интерактор
     */
}

extension MainGamePresenter: KeyboardViewControllerDelegate {
    /// Какую кнопку нажали на клавиаутере
    func keyboardViewController(_ vc: KeyboardView, didTapKey letter: Character) {
        let guesses = letterStorage.getLetters()
        var stop = false
        // перебираем строки игрового поля
        for gamingRow in 0...6 {
            guard (isCanGoNext[gamingRow] ?? false) || (letter == "-") || (letter == "+") else { return }
            // перебираем ячекйки игрового поля
            for gamingCell in 0..<5 {
                if guesses[gamingRow][gamingCell] == nil || guesses[gamingRow][gamingCell]?.character == " " {
                    // если нажали backspace
                    if letter == "-" {
                        handlePressBackspace(gamingRow: gamingRow, gamingCell: gamingCell)
                        return
                    }
                    // если нажали enter
                    if letter == "+" {
                        handlePressEnter(position: 4, section: gamingRow - 1, allLetters: guesses)
                        return
                    }
                    view?.boardVC.isCanChangeColor = false
                    letterStorage.saveLetter(gamingRow: gamingRow, positionLetter: gamingCell, character: letter)
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        view?.updateGuesses()
    }
    
    // обработка нажатого enter
    func handlePressEnter(position: Int, section: Int, allLetters: [[Key?]]) {
        guard isCanGoNextSectionGet(gamingCell: position, gamingRow: section, allLetters: allLetters) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.view?.boardVC.isCanChangeColor = true
            self?.isCanBackspaces[section] = false
            self?.view?.boardVC.currentSection = section + 1
            self?.view?.updateGuesses()
            self?.view?.updateKeyboard()
            self?.handleSuccesTransition(currentRow: section + 1)
        }
    }
    
    // обработка нажатого backspace
    func handlePressBackspace(gamingRow: Int, gamingCell: Int) {
        if gamingRow-1 != -1,
           isCanBackspaces[gamingRow-1] ?? false,
           gamingCell-1 == -1 {
            letterStorage.removeLetter(gamingRow: gamingRow-1, positionLetter: 4)
        }
        letterStorage.removeLetter(gamingRow: gamingRow, positionLetter: gamingCell-1)
        view?.updateGuesses()
    }
}

extension MainGamePresenter: BoardViewControllerDatasource {

    /// получить текущий массив введенных букв
    func getGuesses() -> [[Key?]] {
        let gamingLetters = letterStorage.getLetters()
        return gamingLetters
    }

    /// цвет ячейки с буквами
    func boxColor(at indexPath: IndexPath) {
        let rowIndex = indexPath.section
        let guesses = letterStorage.getLetters()

        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 5 else {
            return
        }

        let indexedAnswer = Array(answer)

        // если нет в слове тогда СЕРЫЙ
        guard let letter = guesses[indexPath.section][indexPath.row]?.character,
              indexedAnswer.contains(letter)
        else {
            letterStorage.chageColor(at: indexPath, color: .slovoGray)
            return
        }

        // если там где надо тогда ЗЕЛЕНЫЙ
        if indexedAnswer[indexPath.row] == letter {
            letterStorage.chageColor(at: indexPath, color: .slovoGreen)
            return
        }

        // если просто есть в слове, ОРАНЖЕВЫЙ
        letterStorage.chageColor(at: indexPath, color: .slovoOrange)
    }
}

extension MainGamePresenter: KeyboardViewDatasource {
    /// получить цвет кнопки
    func boxColor(at key: Character) -> UIColor {
        guard let interactor = interactor else { return .slovoGray }
        return interactor.getKeyColor(
            key: key,
            gameLetters: letterStorage.getLetters()
        )
    }
}

extension MainGamePresenter: StopPopupViewDelegate {
    /// Popup закрылся
    func popupHidden(_ popupController: PopupViewController, popupType: StopType) {
        switch popupType {
        case .win:
            // закрылся победный попап
            return
        case .defeat:
            letterStorage.clearGame()
            view?.updateGuesses()
            view?.updateKeyboard()
            Defaults[key: DefaultsKeys.currentWord] = nil
            answer = interactor?.currentWord ?? "слово"
            return
        case .wrong:
            // закрылся попап ошибки слова
            return
        }
    }
}

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

    // загаданное слово
    var answer: String
    
    // повторное открытие
    var isReOpenApp: Bool = false

    init(view: MainGameViewProtocol) {
        self.view = view
        self.answer = interactor?.currentWord ?? "слово"
    }
    
    /// Вью загружено
    func onViewDidLoad() {
        interactor?.start()
        answer = interactor?.currentWord ?? "слово"
        view?.setupValetView(viewModel: getModelVallet())
        view?.keyboardVC.delegate = self
        view?.keyboardVC.datasource = self
        view?.boardVC.datasource = self
        handleOpenAppWithData()
    }
    
    // получить модель кошелька
    func getModelVallet() -> BonusViewModel {
        var valetString: String {
            guard let valletCount = interactor?.valletCount else {
                print("❌MainGamePresenter: Кошелек без значения")
                return "0"
            }
            if valletCount >= 10000 {
                return "\(valletCount / 1000)К"
            }
            return String(valletCount)
        }
        return BonusViewModel.init(backgroundColor: .slovoGreen, title: valetString)
    }
    
    // при открытии приложения с данными
    func handleOpenAppWithData() {
        guard let interactor = interactor else {
            print("❌MainGamePresenter: нет интерактора")
            return
        }
        for row in 0...5 {
            if interactor.isSuccessWithRow(gamingRow: row + 1) {
                isReOpenApp = true
                handlePressEnter(gamingCell: 4, gamingRow: row, allLetters: interactor.gammingLetters)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isReOpenApp = false
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
            onWrongWord(word: lettersInSection)
            return false }
        print("✅ Массив слов загрузился в фильтр ввода")
        interactor?.saveIsCanGoNext(gamingRow: gamingRow + 2)
        interactor?.saveSuccessGoNet(gamingRow: gamingRow + 1)
        handleSuccesTransition(currentRow: gamingRow + 1)
        return true
    }

    // обработка успешного перехода на следующую строку
    private func handleSuccesTransition(currentRow: Int) {
        // если все ячейки зеленые, показываем попап победы
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let strongSelf = self,
            let gamingLetters = strongSelf.interactor?.gammingLetters else {
                print("❌MainGamePresenter: нет интерактора")
                return
            }
            let lettersRow = gamingLetters[currentRow-1]
            let filtredRow = lettersRow.filter({ letter in
                letter?.backgroundColor == .slovoGreen
            })
            if filtredRow.count == 5 {
                strongSelf.onWin(currentRow: currentRow)
            } else if currentRow == 6 {
                strongSelf.onDefeat()
            }
        }
    }
}

extension MainGamePresenter: MainGameInteractorToPresenterProtocol {
    /// обработка поражения
    func onDefeat() {
        router?.openStopPopup(typePopup: .defeat, word: "", delegate: self)
    }

    /// обработка победы
    func onWin(currentRow: Int) {
        router?.openStopPopup(typePopup: .win, word: "", delegate: self)
        guard !isReOpenApp else {
            print("⚪️ Переоткрытие приложения, бонусы не добавим")
            return }
        interactor?.addWinBonus(row: currentRow - 1)
        view?.setupValetView(viewModel: getModelVallet())
    }
    
    /// обработка неверного слова
    func onWrongWord(word: String) {
        router?.openStopPopup(typePopup: .wrong, word: word, delegate: self)
    }
}

extension MainGamePresenter: KeyboardViewControllerDelegate {
    /// Какую кнопку нажали на клавиаутере
    func keyboardViewController(_ vc: KeyboardView, didTapKey letter: Character) {
        guard let interactor = interactor else {
            print("❌MainGamePresenter: нет интерактора")
            return
        }
        let gamingLetters = interactor.gammingLetters
        var stop = false
        // перебираем строки игрового поля
        for gamingRow in 0...6 {
            guard interactor.isCanGoNext(gamingRow: gamingRow + 1)
                    || (letter == "-")
                    || (letter == "+") else { return }
            // перебираем ячейки игрового поля
            for gamingCell in 0..<5 {
                if gamingLetters[gamingRow][gamingCell] == nil || gamingLetters[gamingRow][gamingCell]?.character == " " {
                    // если нажали backspace
                    if letter == "-" {
                        handlePressBackspace(gamingRow: gamingRow, gamingCell: gamingCell)
                        return
                    }
                    // если нажали enter
                    if letter == "+" {
                        handlePressEnter(gamingCell: 4, gamingRow: gamingRow - 1, allLetters: gamingLetters)
                        return
                    }
                    view?.boardVC.isCanChangeColor = false
                    interactor.saveLetter(gamingRow: gamingRow, positionLetter: gamingCell, character: letter)
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
    func handlePressEnter(gamingCell: Int, gamingRow: Int, allLetters: [[Key?]]) {
        guard let interactor = interactor,
            isCanGoNextSectionGet(gamingCell: gamingCell, gamingRow: gamingRow, allLetters: allLetters) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.view?.boardVC.isCanChangeColor = true
            interactor.saveIsCanDelete(gamingRow: gamingRow + 1)
            self?.view?.boardVC.currentSection = gamingRow + 1
            self?.view?.updateGuesses()
            self?.view?.updateKeyboard()
        }
    }
    
    // обработка нажатого backspace
    func handlePressBackspace(gamingRow: Int, gamingCell: Int) {
        guard let interactor = interactor else {
            print("❌MainGamePresenter: нет интерактора")
            return
        }
        if gamingRow-1 != -1,
           interactor.IsCanDeleteWithRow(gamingRow: gamingRow),
           gamingCell-1 == -1 {
            interactor.removeLetter(gamingRow: gamingRow-1, positionLetter: 4)
            self.view?.updateGuesses()
            return
        }
        interactor.removeLetter(gamingRow: gamingRow, positionLetter: gamingCell-1)
        self.view?.updateGuesses()
    }
}

extension MainGamePresenter: BoardViewControllerDatasource {

    /// получить текущий массив введенных букв
    func getGuesses() -> [[Key?]] {
        guard let interactor = interactor else {
            print("❌MainGamePresenter: нет интерактора")
            return [[nil]]
        }
        let gamingLetters = interactor.gammingLetters
        return gamingLetters
    }

    /// цвет ячейки с буквами
    func boxColor(at indexPath: IndexPath) {
        guard let interactor = interactor else {
            print("❌MainGamePresenter: нет интерактора")
            return
        }
        let rowIndex = indexPath.section
        let guesses = interactor.gammingLetters

        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 5 else {
            return
        }

        let indexedAnswer = Array(answer)

        // если нет в слове тогда СЕРЫЙ
        guard let letter = guesses[indexPath.section][indexPath.row]?.character,
              indexedAnswer.contains(letter)
        else {
            interactor.changeColor(at: indexPath, color: .slovoGray)
            return
        }

        // если там где надо тогда ЗЕЛЕНЫЙ
        if indexedAnswer[indexPath.row] == letter {
            interactor.changeColor(at: indexPath, color: .slovoGreen)
            return
        }

        // если просто есть в слове, ОРАНЖЕВЫЙ
        interactor.changeColor(at: indexPath, color: .slovoOrange)
    }
}

extension MainGamePresenter: KeyboardViewDatasource {
    /// получить цвет кнопки
    func boxColor(at key: Character) -> UIColor {
        guard let interactor = interactor else { return .slovoGray }
        return interactor.getKeyColor(key: key)
    }
}

extension MainGamePresenter: StopPopupViewDelegate {
    /// Popup закрылся
    func popupHidden(_ popupController: PopupViewController, popupType: StopType) {
        switch popupType {
        case .win:
            // закрылся победный попап
            onNewGame()
            return
        case .defeat:
            onNewGame()
            return
        case .wrong:
            // закрылся попап ошибки слова
            return
        }
    }
    
    /// начать новую игру
    func onNewGame() {
        interactor?.reset()
        view?.updateGuesses()
        view?.updateKeyboard()
        Defaults[key: DefaultsKeys.currentWord] = nil
        answer = interactor?.currentWord ?? "слово"
    }
}

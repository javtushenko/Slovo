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

    var gameBoardStorage = GameBoardStorage()

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
        gameBoardStorage.start()
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
        for row in 0...5 {
            if gameBoardStorage.isSuccessWithRow(gamingRow: row + 1) {
                isReOpenApp = true
                handlePressEnter(gamingCell: 4, gamingRow: row, allLetters: gameBoardStorage.getLetters())
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
            handleWrongWord(word: lettersInSection)
            return false }
        print("✅ Массив слов загрузился в фильтр ввода")
        gameBoardStorage.saveIsCanGoNext(gamingRow: gamingRow + 2)
        gameBoardStorage.saveSuccessGoNet(gamingRow: gamingRow + 1)
        handleSuccesTransition(currentRow: gamingRow + 1)
        return true
    }

    // обработка успешного перехода на следующую строку
    private func handleSuccesTransition(currentRow: Int) {
        // если все ячейки зеленые, показываем попап победы
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            let gamingLetters = strongSelf.gameBoardStorage.getLetters()
            let lettersRow = gamingLetters[currentRow-1]
            let filtredRow = lettersRow.filter({ letter in
                letter?.backgroundColor == .slovoGreen
            })
            if filtredRow.count == 5 {
                strongSelf.handleWin(currentRow: currentRow)
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
    private func handleWin(currentRow: Int) {
        router?.openStopPopup(typePopup: .win, word: "", delegate: self)
        guard !isReOpenApp else {
            print("⚪️ Переоткрытие приложения, бонусы не добавим")
            return }
        interactor?.addWinBonus(row: currentRow - 1)
        view?.setupValetView(viewModel: getModelVallet())
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
        let guesses = gameBoardStorage.getLetters()
        var stop = false
        // перебираем строки игрового поля
        for gamingRow in 0...6 {
            guard gameBoardStorage.IsCanGoNextWithRow(gamingRow: gamingRow + 1)
                    || (letter == "-")
                    || (letter == "+") else { return }
            // перебираем ячейки игрового поля
            for gamingCell in 0..<5 {
                if guesses[gamingRow][gamingCell] == nil || guesses[gamingRow][gamingCell]?.character == " " {
                    // если нажали backspace
                    if letter == "-" {
                        handlePressBackspace(gamingRow: gamingRow, gamingCell: gamingCell)
                        return
                    }
                    // если нажали enter
                    if letter == "+" {
                        handlePressEnter(gamingCell: 4, gamingRow: gamingRow - 1, allLetters: guesses)
                        return
                    }
                    view?.boardVC.isCanChangeColor = false
                    gameBoardStorage.saveLetter(gamingRow: gamingRow, positionLetter: gamingCell, character: letter)
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
        guard isCanGoNextSectionGet(gamingCell: gamingCell, gamingRow: gamingRow, allLetters: allLetters) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.view?.boardVC.isCanChangeColor = true
            self?.gameBoardStorage.saveIsCanDelete(gamingRow: gamingRow + 1)
            self?.view?.boardVC.currentSection = gamingRow + 1
            self?.view?.updateGuesses()
            self?.view?.updateKeyboard()
        }
    }
    
    // обработка нажатого backspace
    func handlePressBackspace(gamingRow: Int, gamingCell: Int) {
        if gamingRow-1 != -1,
           self.gameBoardStorage.IsCanDeleteWithRow(gamingRow: gamingRow),
           gamingCell-1 == -1 {
            self.gameBoardStorage.removeLetter(gamingRow: gamingRow-1, positionLetter: 4)
            self.view?.updateGuesses()
            return
        }
        self.gameBoardStorage.removeLetter(gamingRow: gamingRow, positionLetter: gamingCell-1)
        self.view?.updateGuesses()
    }
}

extension MainGamePresenter: BoardViewControllerDatasource {

    /// получить текущий массив введенных букв
    func getGuesses() -> [[Key?]] {
        let gamingLetters = gameBoardStorage.getLetters()
        return gamingLetters
    }

    /// цвет ячейки с буквами
    func boxColor(at indexPath: IndexPath) {
        let rowIndex = indexPath.section
        let guesses = gameBoardStorage.getLetters()

        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 5 else {
            return
        }

        let indexedAnswer = Array(answer)

        // если нет в слове тогда СЕРЫЙ
        guard let letter = guesses[indexPath.section][indexPath.row]?.character,
              indexedAnswer.contains(letter)
        else {
            gameBoardStorage.chageColor(at: indexPath, color: .slovoGray)
            return
        }

        // если там где надо тогда ЗЕЛЕНЫЙ
        if indexedAnswer[indexPath.row] == letter {
            gameBoardStorage.chageColor(at: indexPath, color: .slovoGreen)
            return
        }

        // если просто есть в слове, ОРАНЖЕВЫЙ
        gameBoardStorage.chageColor(at: indexPath, color: .slovoOrange)
    }
}

extension MainGamePresenter: KeyboardViewDatasource {
    /// получить цвет кнопки
    func boxColor(at key: Character) -> UIColor {
        guard let interactor = interactor else { return .slovoGray }
        return interactor.getKeyColor(
            key: key,
            gameLetters: gameBoardStorage.getLetters()
        )
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
        gameBoardStorage.clearGame()
        view?.updateGuesses()
        view?.updateKeyboard()
        Defaults[key: DefaultsKeys.currentWord] = nil
        answer = interactor?.currentWord ?? "слово"
    }
}

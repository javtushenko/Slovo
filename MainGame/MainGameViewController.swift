//
//  MainGameViewController.swift
//  Slovo
//
//  Created Николай Явтушенко on 22.06.2022.
// 

import UIKit

final class MainGameViewController: UIViewController {
	var presenter: MainGameViewToPresenterProtocol?

    /// Коллекция с кастомной клавиатурой
    var keyboardVC = {
        KeyboardView()
    }()

    /// Коллекция с ячейками для ввода
    var boardVC = {
        BoardView()
    }()

    /// первая ячейка с бонусом
    let firstBonus: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()

    /// первая ячейка с бонусом
    let secondBonus: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()

    /// первая ячейка с бонусом
    let thirdBonus: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()

    /// первая ячейка с бонусом
    let valletView: BonusView = {
        let view = BonusView.newAutoLayout()
        return view
    }()

    /// первая ячейка с бонусом
    let profileView: ProfileView = {
        let view = ProfileView.newAutoLayout()
        return view
    }()

    private var isViewHieararchyCreated = false
    private var isConstraintsInstalled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        createViewHierarchyIfNeeded()
        setupConstrainstsIfNeeded()
        setupFirstBonus()
        setupSecondBonus()
        setupThirdBonus()
        setupValetView()
        setupProfileView()
        presenter?.onViewDidLoad()
        view.backgroundColor = .slovoDarkBackground
    }

    // настро первую вьюху с бонусом
    func setupFirstBonus() {
        firstBonus.setup(viewModel: .init(backgroundColor: .slovoGray))
        firstBonus.setCorners(radius: 30)
    }

    // настро вторую вьюху с бонусом
    func setupSecondBonus() {
        secondBonus.setup(viewModel: .init(backgroundColor: .slovoOrange))
        secondBonus.setCorners(radius: 30)
    }

    // настро третью вьюху с бонусом
    func setupThirdBonus() {
        thirdBonus.setup(viewModel: .init(backgroundColor: .slovoGreen))
        thirdBonus.setCorners(radius: 30)
    }

    // настро третью вьюху с бонусом
    func setupValetView() {
        valletView.setup(viewModel: .init(backgroundColor: .slovoGreen))
        valletView.setCorners(radius: 30)
    }

    // настро профиль вьюху с бонусом
    func setupProfileView() {
        profileView.setup(viewModel: .init(backgroundColor: .slovoGreen))
        profileView.setCorners(radius: 30)
        profileView.fireView.setCorners(radius: 30)
    }
}

extension MainGameViewController {
    // Создание иерархии View
    func createViewHierarchyIfNeeded() {
        guard !isViewHieararchyCreated else { return }

        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)

        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)

        view.addSubview(valletView)
        view.addSubview(secondBonus)
        view.addSubview(firstBonus)
        view.addSubview(thirdBonus)
        view.addSubview(profileView)

        isViewHieararchyCreated = true
    }

    // Установка Constraints
    func setupConstrainstsIfNeeded() {
        guard !isConstraintsInstalled else { return }

        keyboardVC.view.autoSetDimension(.height, toSize: 250)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .leading)
        keyboardVC.view.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)

        boardVC.view.autoPinEdge(toSuperviewEdge: .trailing)
        boardVC.view.autoPinEdge(toSuperviewEdge: .leading)
        boardVC.view.autoSetDimension(.height, toSize: 565)
        boardVC.view.autoPinEdge(.bottom, to: .top, of: keyboardVC.collectionView, withOffset: -16)

        secondBonus.autoAlignAxis(toSuperviewAxis: .vertical)
        secondBonus.autoPinEdge(.bottom, to: .top, of: boardVC.view, withOffset: 80)

        firstBonus.autoPinEdge(.bottom, to: .top, of: boardVC.view, withOffset: 80)
        firstBonus.autoPinEdge(.trailing, to: .leading, of: secondBonus, withOffset: -18)

        thirdBonus.autoPinEdge(.bottom, to: .top, of: boardVC.view, withOffset: 80)
        thirdBonus.autoPinEdge(.leading, to: .trailing, of: secondBonus, withOffset: 18)

        valletView.autoPinEdge(.trailing, to: .leading, of: secondBonus, withOffset: -18)
        valletView.autoPinEdge(.bottom, to: .top, of: firstBonus, withOffset: -18)

        profileView.autoPinEdge(.trailing, to: .trailing, of: thirdBonus)
        profileView.autoPinEdge(.bottom, to: .top, of: thirdBonus, withOffset: -18)

        isConstraintsInstalled = true
    }
}

extension MainGameViewController: MainGameViewProtocol {
    /// запустить прелоудер
    func startPreloader() {

    }

    /// остановить прелоудер
    func stopPreloader() {

    }

    /// обновить данные на игровом поле
    func updateGuesses() {
        boardVC.reloadData()
    }

    /// обновить данные клавиатуры
    func updateKeyboard() {
        keyboardVC.reloadData()
    }
}
